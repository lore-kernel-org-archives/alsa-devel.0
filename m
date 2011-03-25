From: Kailang <kailang@realtek.com>
Subject: Re: Loud pops from Intel HDA onboard sound,
	may damage speakers (fwd)
Date: Fri, 25 Mar 2011 15:43:55 +0800
Message-ID: <658569FECC4D41BC8CA1A62764C81938@realtek.com.tw>
References: <alpine.DEB.2.00.1103240135291.1780@chris-desktop.fen.aptivate.org><20110324014350.GA8029@localhost><alpine.DEB.2.00.1103240934470.1780@chris-desktop.fen.aptivate.org><s5hhbasvnz9.wl%tiwai@suse.de><alpine.LNX.2.00.1103241205020.13384@top.qwarx.com><s5hpqpgaff6.wl%tiwai@suse.de><alpine.DEB.2.00.1103242239350.2342@chris-desktop.fen.aptivate.org>
	<s5hei5vvg4e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 37EDB24423
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2011 08:44:01 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Chris Wilson <chris@qwirx.com>
Cc: Pshou <pshou@realtek.com>, alsa-devel@alsa-project.org, Wu Fengguang <wfg@linux.intel.com>, dan.d.kogan@intel.com, andy.kopp@intel.com
List-Id: alsa-devel@alsa-project.org


> ALC269 has some workarounds using COEF magic.  Maybe there is a
> similar trick for ALC663.  Kailang, do you know of it?

ALC663 has no this control bits like ALC269.
But it can use EAPD to control it.
The EAPD pull low before suspend.
When the resume back, run the EAPD to pull high first.

I could send the patch for you later.

Kailang

----- Original Message ----- 
From: Takashi Iwai
To: Chris Wilson
Cc: Wu Fengguang ; Pshou ; Kailang ; andy.kopp@intel.com ; 
dan.d.kogan@intel.com ; alsa-devel@alsa-project.org
Sent: Friday, March 25, 2011 3:00 PM
Subject: Re: Loud pops from Intel HDA onboard sound, may damage speakers 
(fwd)


At Thu, 24 Mar 2011 22:41:47 +0000 (GMT),
Chris Wilson wrote:
>
> Hi Takashi and all,
>
> On Thu, 24 Mar 2011, Takashi Iwai wrote:
>
> >>> Does this happen with 2.6.38 kernel, too?
> >>
> >> I have not tried yet, do you have reason to think it may have changed
> >> since 2.6.32?
> >
> > Lots of changes since 2.6.32.  I won't be surprised if any of them hits.
> >
> >> Can I build just the sound driver without replacing the whole kernel?
> >
> > You can try alsa-driver tarball.
>
> Unfortunately, I can confirm that stock 2.6.38 does NOT resolve the pops
> on suspend and resume.

OK, then did you try to set option power_save_controller=0 for
snd-hda-intel?

ALC269 has some workarounds using COEF magic.  Maybe there is a
similar trick for ALC663.  Kailang, do you know of it?


thanks,

Takashi

------Please consider the environment before printing this e-mail. 
