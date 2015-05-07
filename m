From: Glenn Golden <gdg@zplane.com>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
 mute LED non-workingness
Date: Wed, 6 May 2015 18:15:58 -0600
Message-ID: <20150507001557.GH554@huh.zplane.com>
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
Reply-To: gdg@zplane.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.indra.com (smtp.indra.com [209.169.0.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D87AD264F3F
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 02:16:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1430745381.1616962.262389473.6ABEC97F@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Alex Hung <alex.hung@canonical.com>, Raymond Yau <superquad.vortex2@gmail.com>, bruno.mueller@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Henrique de Moraes Holschuh <hmh@hmh.eng.br> [2015-05-04 10:16:21 -0300]:
> 
> Well, your firmware does not have SSMS, at all.  It is not that thinkpad-acpi
> can't find it due to some change in the acpi core, it simply isn't there to
> be found.
> 

OK, thanks for the detective work, Henrique.

In the interest of documenting what's been learned here (at least by me),
what follows is an attempt at a detailed summary/guide to ThinkPad mute key
and mute LED behavior when transitioning from 3.18 to 3.19 kernels. Perhaps
it may be useful to others who are also head-scratching about this issue,
since it involves quite a few moving parts.

It would be great if you could look it over when you have a chance, and
correct or bless it as you see fit. I'll also pass it by the PA folks and then
post the result to both the original PA ML thread and to the ThinkPad ACPI ML
as well (if you want).

Thanks again for your time and assistance on this. (H/T also to David,
Raymond, and Takashi).

Glenn

=============================================================================
For TP models like the T-510 (and others without the SSMS mute LED interface):

 0.  If you want your mute LED to do anything (other than be permanently off)
     you have no choice but to set acpi.software_mute=0 at boot time, which
     reverts to 3.18 behavior.  If you do this, then 1-3 below apply.  If you
     don't care whether your mute LED works, then 4-8 further below apply.

 1.  The embedded controller (EC) fields mute key events directly, and in
     response, toggles both the hardware speaker mute gate and the mute LED
     (if you have one). The kernel is not involved in these actions at all.

 2.  "Mute LED on" means, unequivocally, that the hardware mute gate is 
     clamped, i.e. no sound can emit from the speaker, period.  The hardware
     mute gate has no effect on headphone mute state.

 3.  If you happen to already have the mute key mapped via userspace event
     to do something with the mixer mute state (e.g. via amixer/pactl/pacmd,
     etc.) you should probably disable that mapping in order to avoid
     unintended conflicts and/or mild insanity.


For ThinkPad models having the SSMS interface, the behavior in 3.18 is just as
described in 1-3 above: The EC controls hardware speaker-mute gate and LED.
If you're happy with that behavior, then when transitioning to 3.19 just set
acpi.software_mute=0 at boot time, and you'll still have it.

Otoh, if you would like to have softkey control over mute action via mixer
mute (in contrast to the hardware speaker-mute in 3.18) then don't supply the
acpi.softkey=0 boot option, and the following apply:

 4.  Hardware speaker-mute is completely disabled: The EC does not field mute
     key events, nor does it touch the hardware mute gate control. The HW mute
     gate is permanently unclamped and inaccessible via kernel or userspace.

 5.  The mute key becomes a softkey, and muting must be performed via the
     mixer. The kernel autonomously takes care of synching the mute LED with
     the mixer "Playback Master" mute setting.

 6.  If you want your mute key to do anything, you have to set up an event
     handler to do whatever it is you want it to do.

 7.  If you elect to have the mute key toggle the Playback Master mute via an
     event which invokes pactl/pacmd/amixer/[insert fave mixer control tool]
     then the mute LED will automatically follow the Playback Mute state as
     mentioned above, thus no explicit action is required to make the LED work.
     But! ...

 8.  ...because [Alsa? Pulseaudio?] maintains two independent mixer mute state
     variables -- one for headphone port, one for speaker port -- the semantics
     of both the mute key and the mute LED become less straightforward than
     with the hardware-based mute in 3.18.  Specifically:

       * The mute key (via your userspace mixer control event handler) will
	 toggle whichever port (HPH or SPKR) happens to be active at that time,
	 and will have no effect on the mute state of the other port.

       * The mute LED will likewise follow the mute state of the active port
	 via kernel auto-synch (as described above).

     Taken together, these imply that no unequivocal semantic can be attached
     to "mute LED on", as it was with hardware-based mute: All you can say is
     that if the LED is on, then the active port is muted via the mixer;
     the LED gives no information about the inactive port's mute state.  One
     consequence of this is that the mute LED may (or may not) change state
     simply by the action of inserting or removing the headphone plug.  
=============================================================================
