From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Regression for Lenovo X240 sound in 3.18
Date: Sun, 11 Jan 2015 13:12:45 +0800
Message-ID: <CAN8cciZ9=qjScxw_K5dpzX3AM4zWJjfzZwqtPxO5ExMyMwVE7Q@mail.gmail.com>
References: <alpine.LSU.2.11.1412291303200.30351@nerf08.vanv.qr>
 <s5h387xi2yp.wl-tiwai@suse.de>
 <alpine.LSU.2.11.1412301629280.1813@nerf08.vanv.qr>
 <CAN8cciZ9J+VzNX8b4jNue7T1tMyzcQfjyvkRnC8VptuBG++__g@mail.gmail.com>
 <alpine.LSU.2.11.1501101314510.22793@nerf60.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f46.google.com (mail-qa0-f46.google.com
 [209.85.216.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A2F6260488
 for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2015 06:12:46 +0100 (CET)
Received: by mail-qa0-f46.google.com with SMTP id j7so4262827qaq.5
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 21:12:45 -0800 (PST)
In-Reply-To: <alpine.LSU.2.11.1501101314510.22793@nerf60.vanv.qr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jan Engelhardt <jengelh@inai.de>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, mr.bobukas@gmail.com
List-Id: alsa-devel@alsa-project.org

> >
> >If Combo audio connector does not support conventional microphone, this
mean
> >the driver should not create mic jack control for node 0x1a
> >
> >http://support.lenovo.com/us/en/documents/pd029567
> >
> >Connect headphones or a headset that has a 3.5-mm (0.14-inch), 4-pole
plug
> >to the combo audio connector to listen to the sound from the computer.
>
> I do not have any 4-pole (3-rings) equipment to test.
> A conventional 3-pole (2-ring) microphone certainly does not do its job.
>
> Then again, I ditched unpowered microphones (most external ones are).
> The internal mic next to the internal webcam is powered and provides
> better gain.
>
> The Mic control in alsamixer should stay.

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=73bdd597823e2231dc882577dbbaf8df92fe1775

The debug version of driver  message indicate whether the codec can
differentiate headphone , headset (ctia or omtp) or not

http://voices.canonical.com/david.henningsson/2014/03/07/headset-jacks-on-newer-laptops/

http://bazaar.launchpad.net/~unity-settings-daemon-team/unity-settings-daemon/trunk/view/head:/plugins/media-keys/what-did-you-plug-in/pa-backend.c

Headphone Mic Jack - indicates headphone and mic-in mode share the same
jack,  i e, not two separate jacks. Hardware cannot distinguish between a
headphone and a mic.
   Headset Mic Phantom Jack - indicates headset jack where hardware can not
distinguish between headphones and headsets
   Headset Mic Jack - indicates headset jack where hardware can distinguish
between headphones and headsets. There is no use popping up a dialog in
this case, unless we already need to do this for the mic-in mode.

control.14 {
iface CARD
name 'Mic Jack'
value false
comment { access read type BOOLEAN count 1 } }

What is the usage of this jack detect control if conventional mic is not
supported ?
