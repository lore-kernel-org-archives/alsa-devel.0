From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/2] ALSA: pcm: Simplify forward/rewind
	codes
Date: Sun, 21 May 2017 14:04:28 +0900
Message-ID: <4e9779dd-0340-bf3a-145a-f412614722e0@sakamocchi.jp>
References: <20170519183100.11758-1-tiwai@suse.de>
 <20170519183100.11758-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id A602F265142
 for <alsa-devel@alsa-project.org>; Sun, 21 May 2017 07:04:31 +0200 (CEST)
In-Reply-To: <20170519183100.11758-2-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

On May 20 2017 03:31, Takashi Iwai wrote:
> Factor out the common codes in snd_pcm_*_forward() and *_rewind()
> functions to simplify the codes.  No functional changes.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   sound/core/pcm_native.c | 118 ++++++++++++++++++++----------------------------
>   1 file changed, 50 insertions(+), 68 deletions(-)

Reviewd-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>


Regards

Takashi Sakamoto
