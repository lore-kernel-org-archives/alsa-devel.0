From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
	mute LED non-workingness
Date: Thu, 7 May 2015 09:03:53 +0800
Message-ID: <CAN8cciZXQFfEYd_vSJ+iZS=xpdGbgrK--zV4He9wbcPLpXL=Tw@mail.gmail.com>
References: <CAN8cciZQBRz2Ty3YRt2+3KO9v1BWef-_8FU_d_SsE87mLdgY-w@mail.gmail.com>
 <s5hh9s2gj45.wl-tiwai@suse.de>
 <20150427135859.GI550@huh.zplane.com>
 <s5ha8xt4hsa.wl-tiwai@suse.de>
 <20150428000206.GK550@huh.zplane.com>
 <CAN8ccibSH6je=OpX6vOTG9PzETxikmpuX+7PDgiYNrsG+YavNw@mail.gmail.com>
 <20150502160003.GA557@huh.zplane.com>
 <1430735828.1027589.262340817.33A79FB3@webmail.messagingengine.com>
 <20150504122604.GA577@huh.zplane.com>
 <1430745381.1616962.262389473.6ABEC97F@webmail.messagingengine.com>
 <20150507001557.GH554@huh.zplane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id AF7A4264F3F
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 03:03:54 +0200 (CEST)
Received: by oift201 with SMTP id t201so21831259oif.3
 for <alsa-devel@alsa-project.org>; Wed, 06 May 2015 18:03:53 -0700 (PDT)
In-Reply-To: <20150507001557.GH554@huh.zplane.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gdg@zplane.com
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Alex Hung <alex.hung@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, bruno.mueller@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> >
> > Well, your firmware does not have SSMS, at all.  It is not that
> thinkpad-acpi
> > can't find it due to some change in the acpi core, it simply isn't there
> to
> > be found.
> >
>
> OK, thanks for the detective work, Henrique.
>
> In the interest of documenting what's been learned here (at least by me),
> what follows is an attempt at a detailed summary/guide to ThinkPad mute key
> and mute LED behavior when transitioning from 3.18 to 3.19 kernels. Perhaps
> it may be useful to others who are also head-scratching about this issue,
> since it involves quite a few moving parts.
>
> It would be great if you could look it over when you have a chance, and
> correct or bless it as you see fit. I'll also pass it by the PA folks and
> then
> post the result to both the original PA ML thread and to the ThinkPad ACPI
> ML
> as well (if you want).
>
>
>
> =============================================================================
> For TP models like the T-510 (and others without the SSMS mute LED
> interface):
>
>  0.  If you want your mute LED to do anything (other than be permanently
> off)
>      you have no choice but to set acpi.software_mute=0 at boot time, which
>      reverts to 3.18 behavior.  If you do this, then 1-3 below apply.  If
> you
>      don't care whether your mute LED works, then 4-8 further below apply.
>
>  1.  The embedded controller (EC) fields mute key events directly, and in
>      response, toggles both the hardware speaker mute gate and the mute LED
>      (if you have one). The kernel is not involved in these actions at all.
>
>  2.  "Mute LED on" means, unequivocally, that the hardware mute gate is
>      clamped, i.e. no sound can emit from the speaker, period.  The
> hardware
>      mute gate has no effect on headphone mute state.
>
>  3.  If you happen to already have the mute key mapped via userspace event
>      to do something with the mixer mute state (e.g. via
> amixer/pactl/pacmd,
>      etc.) you should probably disable that mapping in order to avoid
>      unintended conflicts and/or mild insanity.
>
>
> Do your volume up/down key still work with soft_mute=1 ?

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1450947

It seem that Thinkpad X60 's volume up/down key has no effect

Do thinkpad_acpi need to check whether thinkpad support "HAUM" and "SAUM"
interface before enable software mute ?
