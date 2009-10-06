From: manoj.iyer@canonical.com
Subject: Re: [PATCH REALTEK] Added quirk to enable sound on Toshiba NB200
Date: Tue, 6 Oct 2009 17:06:49 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0910061705150.1980@little>
References: <alpine.DEB.2.00.0909230036570.29432@little> <s5h3a6eb46r.wl%tiwai@suse.de> <alpine.DEB.2.00.0909281022500.2112@little> <s5hd45agqoi.wl%tiwai@suse.de> <alpine.DEB.2.00.0909291812030.2426@little> <s5hhbulov3f.wl%tiwai@suse.de>
 <alpine.DEB.2.00.0910010208220.7813@little> <s5h1vlnjzaa.wl%tiwai@suse.de> <s5htyyivrpv.wl%tiwai@suse.de> <alpine.DEB.2.00.0910051912110.8725@little> <s5hljjprs71.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933461AbZJFWHg@vger.kernel.org>
In-Reply-To: <s5hljjprs71.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: manoj.iyer@canonical.com, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Joey Stanford <joey@canonical.com>
List-Id: alsa-devel@alsa-project.org


I can confirm that patch fixes broken mic on HP mini. It is labeled as 
"LineIn".

On Tue, 6 Oct 2009, Takashi Iwai wrote:

> At Mon, 5 Oct 2009 19:13:47 -0500 (CDT),
> manoj.iyer@canonical.com wrote:
>>
>>
>>
>> I am a little puzzled. The patch did not apply cleanly to the karmic
>> source tree, so I had to hand patch it. But, even with the quirk I
>> submitted, the patch you pointed me to killed sound again. Could I have
>> done something wrong?
>
> Try 2.6.32-rc3 kernel at best.  It already includes this fix.
> No reason to stick with the modified kernel just for testing.
>
> (And compiling a kernel won't take time if you set up kconfig properly.
> Even on a recent netbook, it's about 10 minutes.)
>
>
> thanks,
>
> Takashi
>
