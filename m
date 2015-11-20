From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 0/8] ALSA: dice: constrain PCM
 substreams to current sampling transfer frequency
Date: Fri, 20 Nov 2015 20:19:44 +0900
Message-ID: <564F01D0.20603@sakamocchi.jp>
References: <1447579536-4459-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5ha8qbe6pm.wl-tiwai@suse.de> <564D4360.8050503@sakamocchi.jp>
 <s5hziyab8ak.wl-tiwai@suse.de> <564E9D6C.7060408@sakamocchi.jp>
 <s5hy4dt9g5h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 0032D26073C
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 12:19:49 +0100 (CET)
In-Reply-To: <s5hy4dt9g5h.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Nov 20 2015 18:25, Takashi Iwai wrote:
>> As a result of applying this patchset, userspace applications cannot
>> start PCM substreams at sampling rates except for current sampling
>> transfer frequency. Instead, they gain stability to start PCM substreams
>> and to probe Dice-based models.
> 
> Please put this sort of information in the changelog (after some
> digestion).  It's important to know what you're changing by the patch,
> but more importantly why you're changing it.
> 
>> At a glance, it looks the backwards or the regressions.
> 
> Well, it *is* a regression :)
> 
> So, the question is why this driver cannot change the clock stably by
> itself while other way works?  Can't it be implemented in the driver
> itself?

The driver can do it with patch 06-08. The limitation comes from PCM
rules. With patch 01-05, ALSA dice driver has just one PCM rule for
rate/channels at current sampling transfer frequency.


Dice framework gives no ways for drivers to get supported combination
between rate/channels. We cannot change this design, of cource.

Current ALSA dice driver manage to change the state of clock to generate
the supported combinations. But this does not always work well with some
technical reasons. Additionally, this is not preferrable for some users
who set their configurations to actual device in advance because the
state of clock is changed unexpectedly.

This is a reason for patch 01-05.


Thanks

Takashi Sakamoto
