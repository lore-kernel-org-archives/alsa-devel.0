From: Glenn Golden <gdg@zplane.com>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
 mute LED non-workingness
Date: Sat, 2 May 2015 10:00:04 -0600
Message-ID: <20150502160003.GA557@huh.zplane.com>
References: <20150425013937.GB550@huh.zplane.com>
 <1429974719.3937109.258484493.7D74FAC6@webmail.messagingengine.com>
 <20150426152012.GE550@huh.zplane.com>
 <s5hvbgiho2o.wl-tiwai@suse.de>
 <CAN8cciZQBRz2Ty3YRt2+3KO9v1BWef-_8FU_d_SsE87mLdgY-w@mail.gmail.com>
 <s5hh9s2gj45.wl-tiwai@suse.de>
 <20150427135859.GI550@huh.zplane.com>
 <s5ha8xt4hsa.wl-tiwai@suse.de>
 <20150428000206.GK550@huh.zplane.com>
 <CAN8ccibSH6je=OpX6vOTG9PzETxikmpuX+7PDgiYNrsG+YavNw@mail.gmail.com>
Reply-To: gdg@zplane.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.indra.com (smtp.indra.com [209.169.0.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 611822614F1
 for <alsa-devel@alsa-project.org>; Sat,  2 May 2015 18:00:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAN8ccibSH6je=OpX6vOTG9PzETxikmpuX+7PDgiYNrsG+YavNw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Alex Hung <alex.hung@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, bruno.mueller@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


Raymond Yau <superquad.vortex2@gmail.com> [2015-05-01 22:22:15 +0800]:
> >
> > Here are the XXX messages:
> >
> >     [   13.722755] sound hdaudioC0D0: XXX hda_fixup_thinkpad_acpi init...
> >     [   13.724366] sound hdaudioC0D0: XXX ok, this is thinkpad
> >     [   13.724373] sound hdaudioC0D0: XXX mute LED NOT WORKING!
> >
> 
> This mean that your thinkpad does not support SSMS interface
> 

Yes, this was confirmed by an experiment later in the PA thread suggested by
Takashi, in which attempted access to the SSMS device yielded ENODEV.

Seems to me the next step then is to try to determine the difference between
the following two possibilities:

   a.  The SSMS interface is truly not available on the T-510.

   b.  There is a bug in thinkpad_acpi (or elsewhere?) which is preventing
       the SSMS interface from being visible, hence leading to ENODEV upon
       attempted access.

Henrique: Can you comment on how best to proceed further here? Let me know if
there's any experiments I can do on my end to narrow this down as either (a)
or (b).

> 
> >     [   13.724374] sound hdaudioC0D0: XXX ok, mic LED is hooked
> >
> 
> This mean that your thinkpad support MMTS interface
> 

Yes, as stated in the original report, there is no issue at all with the
MIC MUTE LED.

> 
> Do T420 support SSMS interface ?
>

Good question. I have no access to T-420. Does anyone know for sure?
