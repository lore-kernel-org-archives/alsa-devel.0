From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: PATCH: Fix snd-hda-intel boot hang on ASUS A8N-VM
Date: Fri, 19 Mar 2010 22:26:35 +0300
Message-ID: <4BA3CFEB.1090207@msgid.tls.msk.ru>
References: <4BA011A0.5020302@users.sourceforge.net> <s5hr5njh0z3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hr5njh0z3.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Brian Lindholm <brian_lindholm@users.sourceforge.net>, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 16 Mar 2010 19:17:52 -0400,
> Brian Lindholm wrote:
>> This patch fixes a regression in 2.6.33.x.  Was working in 2.6.32.x.
>>
>>    Symptom:  Hang on boot at "HDA Intel".  Boots only if on-board sound 
>> is disabled or if "snd-hda-intel.enable_msi=0" is appended to boot 
>> parameters.
>>
>>    Machine:  ASUS A8N-VM with Athlon-X2 processor.
[]
> Thanks for the patch.  The issue was already fixed in a different way,
> namely, disable MSI for all Nvidia controller chips.  The fix will be
> included in the next pull request and stable kernel.

Can you provide a bit more information?  I've the same issue at
hand, on an Acer Aspire 9300 notebook, also with nvidia chipset.
So far I disabled snd-hda-intel module loading, but it'd be nice
to actually have sound working on this machine, as well as to
test the patch... ;)

Thanks!

/mjt
