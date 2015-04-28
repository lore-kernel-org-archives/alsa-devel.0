From: Glenn Golden <gdg@zplane.com>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
 mute LED non-workingness
Date: Tue, 28 Apr 2015 04:16:45 -0600
Message-ID: <20150428101645.GM550@huh.zplane.com>
References: <20150425013937.GB550@huh.zplane.com>
 <1429974719.3937109.258484493.7D74FAC6@webmail.messagingengine.com>
 <20150426152012.GE550@huh.zplane.com>
 <s5hvbgiho2o.wl-tiwai@suse.de>
 <CAN8cciZQBRz2Ty3YRt2+3KO9v1BWef-_8FU_d_SsE87mLdgY-w@mail.gmail.com>
 <s5hh9s2gj45.wl-tiwai@suse.de>
 <20150427135859.GI550@huh.zplane.com>
 <s5ha8xt4hsa.wl-tiwai@suse.de>
 <20150428000206.GK550@huh.zplane.com>
 <s5hmw1s3hxh.wl-tiwai@suse.de>
Reply-To: gdg@zplane.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.indra.com (smtp.indra.com [209.169.0.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 96B7D2604AE
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 12:16:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hmw1s3hxh.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Alex Hung <alex.hung@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Raymond Yau <superquad.vortex2@gmail.com>, bruno.mueller@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> [2015-04-28 08:06:50 +0200]:
> 
> It's the call:
> 	led_set_func(TPACPI_LED_MUTE, false)
> and this returns an error.  led_set_func is a function pointer to
> tpacpi_led_set:
> 	led_set_func = symbol_request(tpacpi_led_set);
> 
> So the above indicates that the call in thinkpad_acpi.c failed.
> 
> Could you check what value is returned from
> led_set_func(TPACPI_LED_MUTE, false)?
> 
> My wild guess is that it's -ENODEV.
> 

Yep: 

    [   13.379016] sound hdaudioC0D0: XXX hda_fixup_thinkpad_acpi init...
    [   13.392760] sound hdaudioC0D0: XXX ok, this is thinkpad
    [   13.404553] sound hdaudioC0D0: XXX mute LED NOT WORKING!
    [   13.416106] XXX led_set_func(TPACPI_LED_MUTE, false) returned -19
    [   13.427719] sound hdaudioC0D0: XXX ok, mic LED is hooked


Question: To simplify/speed debugging going forward: Is there some
straightforward way to unload/reload all the relevant sound modules as
an alternative to rebooting?  I came across some 'recipes', but none
looked straightforward; lots of conditionality on the particular subset
of modules being patched/debugged, but alas I've not enough knowledge
to guess at exactly what that subset should be for what we're doing here.)
Thx.
