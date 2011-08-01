From: Pavel Roskin <proski@gnu.org>
Subject: Re: EeePC 1005PE microphone is "stereo only",
	silent	in mono
Date: Mon, 01 Aug 2011 13:12:29 -0400
Message-ID: <20110801131229.d0smwpen9cw0wg8k-cebfxv@webmail.spamcop.net>
References: <20110731233945.1frwedfvso8c8kck-cebfxv@webmail.spamcop.net>
	<s5hwrex5xd4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from c60.cesmail.net (c60.cesmail.net [216.154.195.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 443062450E
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Aug 2011 19:12:46 +0200 (CEST)
In-Reply-To: <s5hwrex5xd4.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello!

Quoting Takashi Iwai <tiwai@suse.de>:

> At Sun, 31 Jul 2011 23:39:45 -0400,
> Pavel Roskin wrote:

>> My laptop has ALC269, bit it also used the DMIC quirk:
>> SND_PCI_QUIRK(0x1043, 0x83ce, "ASUS P1005HA", ALC269_DMIC),
>
> It might be that ALC269 has a same or similar COEF like ALC271 or
> ALC889.  For ALC271, the following verbs do the mono-mixing of d-mic,
>
> 	{0x20, AC_VERB_SET_COEF_INDEX, 0x0d},
> 	{0x20, AC_VERB_SET_PROC_COEF, 0x4000},
>
> while for ALC889, the following do:
>
> 	{0x20, AC_VERB_SET_COEF_INDEX, 0x0b},
> 	{0x20, AC_VERB_SET_PROC_COEF, 0x0003},
>
> Try the above via hda-verb once whether it has any effect on your
> machine.

I tried both using hda-verb 0.3 but didn't have any effect.  I tied  
playing with hda-verb a little bit.  For COEF_INDEX 0xb, the initial  
value returned by GET_PROC_COEF is 0x5cc0.  The lowest value (after  
writing 0) is 0x5c00.  The highest value (after writing 0xffff) is  
0x5dff.  Writing 0x0003 results in 0x5c03, quite predictably.

For COEF_INDEX 0xd, the initial value is 0xf000.  The range is from 0  
to 0xffc0.  Setting 0x4000 succeeds, 0x4000 is read back.

Maybe I could run some script looking for acoustic feedback?

This gives feedback:

arecord -f cd --channels 2 | aplay -

This gives no feedback (pulse audio is used, output volume is maximal):

arecord -f cd --channels 1 | aplay -

-- 
Regards,
Pavel Roskin
