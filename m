From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Should we really use POS_FIX_VIACOMBO for AMD/ATI
	chipsets?
Date: Fri, 20 May 2011 16:51:13 +0200
Message-ID: <4DD67FE1.7010106@canonical.com>
References: <4DD66DC4.4060902@canonical.com> <s5hhb8pscw2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 5AB50103880
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 16:51:15 +0200 (CEST)
In-Reply-To: <s5hhb8pscw2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, "Xu,
	Andiry" <Andiry.Xu@amd.com>, 741825@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

On 2011-05-20 15:46, Takashi Iwai wrote:
> At Fri, 20 May 2011 15:33:56 +0200,
> David Henningsson wrote:
>>
>> I'm far from sure, but I could be on to something...
>>
>> Looking at the code for azx_via_get_position, it seems that for
>> recording streams, it accesses a register at position
>> VIA_IN_STREAM0_FIFO_SIZE_OFFSET = 0x90. Looking at the datasheet for
>> SB700, that register is not even present. This does not seem right to me.
>>
>> Could it be that we should use POS_FIX_LPIB by default for AMD/ATI
>> chipsets instead? It seems more reasonable to me.
>> In addition, I looked through some of the commits for quirking to
>> POS_FIX_LPIB and the four I checked were all ATI chipsets.
>>
>> So; I've tried adding:
>> options snd-hda-intel position_fix=1
>> to /etc/modprobe.d/alsa-base.conf
>>
>> ...to my machine with the infamous [1002:4383] controller (and
>> rebooted), and the few times I've tested, recording worked successfully
>> with pulseaudio. So could you please follow this up with testing on your
>> machines to see if we have actually managed to solve this long-standing bug?
>>
>> The only annoying thing is that I didn't realise this earlier :-/
>
> Hmm, I took this as default as it seems fixing the issue on machines,
> indeed.  Actually I had to use this option first for removing
> recording noises on AMD Hudson.  But, maybe I need to double-check
> again after the snoop bit and other workarounds.
>
> The FIFO size might got wrong on AMD.  In that case, the driver
> calculates as if FIFO = 0.  But, it can still help for correcting the
> position via position-buffer vs LPIB comparison.
>
> For the real check, we should put some debug prints on real machines.

Hey, you're faster than I am :-) Ok, so there actually is a FIFO 
register (I read the wrong table). But the position buffer is dead and 
always read as zero.

I did some debug print which is pasted here: http://paste.ubuntu.com/610637/

If LPIB only gives you occasional recording noises, perhaps we need a 
new type of position-fix that adds some margin (e g round down to 
nearest multiple of fifo-size, then subtract one fifo-size or something)?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
