From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: sb: remove needless evaluation in
 implementation for copy callback
Date: Thu, 25 May 2017 00:01:07 +0900
Message-ID: <12415b17-21dc-1b23-85ee-ead930607df4@sakamocchi.jp>
References: <20170523134042.1056-1-o-takashi@sakamocchi.jp>
 <s5h8tlnznqw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id A400B26680F
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 17:01:10 +0200 (CEST)
In-Reply-To: <s5h8tlnznqw.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On May 23 2017 22:49, Takashi Iwai wrote:
> On Tue, 23 May 2017 15:40:42 +0200,
> Takashi Sakamoto wrote:
>>
>> In design of ALSA pcm core, 'struct snd_pcm_ops.copy' is expected to
>> copy PCM frames, according to frame alignment on intermediate buffer for
>> userspace and dedicated buffer for data transmission. In this callback,
>> value of 'channel' argument depends on the frame alignment, which drivers
>> registers to runtime of PCM substream. When target devices can handle
>> non-interleaved buffer, this value has positive value, otherwise negative.
>>
>> ALSA driver for PCM component of EMU8000 chip is programmed with local
>> macro to switch the frame alignment. The 'copy' operation in
>> non-interleaved side has evaluation of the 'channel' argument (actually
>> it's 'voice' argument). This is useless.
>>
>> This commit remove the evaluation.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> Passing -1 to the channel was valid even for non-interleaved access.
> It was meant to apply to all channels.
> 
> The call with channel = -1 itself might have been dropped meanwhile,
> so removing it may be OK now.  But the description is confusing as if
> it were incorrectly implemented.

https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/Documentation/sound/kernel-api/writing-an-alsa-driver.rst#n3598

 > You need to check the channel argument, and if it's -1, copy the
 > whole channels. Otherwise, you have to copy only the specified
 > channel.

Hm. We need to correct this API documentation, because there's no codes 
to pass negative value to the argument for vector buffer operation. I'll 
post my proposal later.


Thanks

Takashi Sakamoto
