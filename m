From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 1/2] ALSA: add snd_card_disconnect_sync()
Date: Wed, 11 Oct 2017 20:22:12 +0900
Message-ID: <4f400024-56df-884c-efc4-8104e86b0b99@sakamocchi.jp>
References: <20171011101618.8736-1-tiwai@suse.de>
 <20171011101618.8736-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 06E262674FC
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 13:22:14 +0200 (CEST)
In-Reply-To: <20171011101618.8736-2-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Oct 11 2017 19:16, Takashi Iwai wrote:
> In case of user unbind ALSA driver during playing back / capturing,
> each driver needs to stop and remove it correctly. One note here is
> that we can't cancel from remove function in such case, because
> unbind operation doesn't check return value from remove function.
> So, we *must* stop and remove in this case.
> 
> For this purpose, we need to sync (= wait) until the all top-level
> operations are canceled at remove function.
> For example, snd_card_free() processes the disconnection procedure at
> first, then waits for the completion. That's how the hot-unplug works
> safely. It's implemented, at least, in the top-level driver removal.
> 
> Now for the lower level driver, we need a similar strategy. Notify to
> the toplevel for hot-unplug (disconnect in ALSA), and sync with the
> stop operation, then continue the rest of its own remove procedure.
> 
> This patch adds snd_card_disconnect_sync(), and driver can use it from
> remove function.
> 
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   include/sound/core.h |  2 ++
>   sound/core/init.c    | 32 ++++++++++++++++++++++++++++++++
>   2 files changed, 34 insertions(+)

I have a question for this patch. If this patch is applied and the 
lower-level driver call this function in its .remove callback, after all 
references to an instance of snd_card by file instances corresponding to 
each of ALSA character devices are released, the lower-level driver must 
explicitly releases the last reference to the instance of snd_card. On 
ALSA SoC part, which context perform this important task? In my opinion, 
this patch easily allows leak of kobject. Do you have any safety?

At least, it's better for us to add enough comments to inform it to 
developers.


Regards

Takashi Sakamoto
