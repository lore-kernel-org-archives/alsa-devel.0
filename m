From: Meelis Roos <mroos@linux.ee>
Subject: Re: [Alsa-devel] Re: How to enable bios-disabled soundcard?
Date: Fri, 19 May 2006 00:39:59 +0300 (EEST)
Message-ID: <Pine.SOC.4.61.0605190039160.27206@math.ut.ee>
References: <Pine.SOC.4.61.0605181650080.4469@math.ut.ee>
 <20060518151520.GA32572@rhlx01.fht-esslingen.de> <s5h3bf72us4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751403AbWERVkR@vger.kernel.org>
In-Reply-To: <s5h3bf72us4.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Andreas Mohr <andi@rhlx01.fht-esslingen.de>, Linux Kernel list <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> The best way to find out is to edit snd_cs4281_probe() and add snd_printk()s
>> at all error paths to find the one which actually fails.
>
> The error EIO comes only from snd_cs4281_chip_init(), and you must
> have a corresponding error message.
>
> There are some fixes in 2.6.17 tree regarding cs4281.  Give it a try.

Yes! Todays 2.6.17-rc4+git works fine with this soundcard. Thanks!

-- 
Meelis Roos (mroos@linux.ee)
