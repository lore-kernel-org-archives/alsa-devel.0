From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 8/8] ALSA: firewire-tascam: deleyed
 registration of sound card
Date: Mon, 25 Apr 2016 19:54:49 +0900
Message-ID: <571DF779.1050908@sakamocchi.jp>
References: <1459381629-24189-1-git-send-email-o-takashi@sakamocchi.jp>
 <1459381629-24189-9-git-send-email-o-takashi@sakamocchi.jp>
 <571CC12C.7090006@sakamocchi.jp> <s5hshyaqdvo.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 43757264F39
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2016 12:54:50 +0200 (CEST)
In-Reply-To: <s5hshyaqdvo.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Apr 25 2016 17:41, Takashi Iwai wrote:
> On Sun, 24 Apr 2016 14:50:52 +0200,
> Takashi Sakamoto wrote:
>>
>> Iwai-san,
>>
>> On Mar 31 2016 08:47, Takashi Sakamoto wrote:
>>> When some tascam units are connected sequentially, userspace
>>> applications are involved at bus-reset state on IEEE 1394 bus. In the
>>> state, any communications can be canceled. Therefore, sound card
>>> registration should be delayed till the bus gets calm.
>>>
>>> This commit achieves it.
>>>
>>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>>> ---
>>>  sound/firewire/tascam/tascam.c | 118 ++++++++++++++++++++++++++++-------------
>>>  sound/firewire/tascam/tascam.h |   2 +
>>>  2 files changed, 84 insertions(+), 36 deletions(-)
>>
>> As of today, this patch is missing in 'for-next' branch of sound.git
>> reporitory[1], Would you please take it again?
> 
> OK, applied now.  It was missing since your cover letter mentioned
> only 7 patches.  Thanks for noticing it.

Oops, indeed. I might have added handy changes to the subject line and
written wrong number...


Thanks

Takashi Sakamoto
