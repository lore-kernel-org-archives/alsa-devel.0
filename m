From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Expected behaviour for two mic jacks
Date: Sun, 14 Nov 2010 09:01:27 +0800
Message-ID: <AANLkTikJR7D-4X2ivznG0-RgQDJXA8yx_RHMkc5nBens@mail.gmail.com>
References: <4CDD0DDB.9020509@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 336F2243DB
	for <alsa-devel@alsa-project.org>; Sun, 14 Nov 2010 02:01:28 +0100 (CET)
Received: by ewy2 with SMTP id 2so460230ewy.38
	for <alsa-devel@alsa-project.org>; Sat, 13 Nov 2010 17:01:27 -0800 (PST)
In-Reply-To: <4CDD0DDB.9020509@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/11/12 David Henningsson <david.henningsson@canonical.com>

> Hi,
>
> A while ago I asked for the default/expected behaviour for auto-mute.
> Here's the same question for mics:
>
> If there are two mic jacks, e g one on the front and one on the back, is
> the standard/default behaviour that we should:
>
>
Most desktops have blue jack in in addition to front mic and rear mic, they
may also has other input source CD , Video and , Aux

Only notebooks has internal mic and external mic

For  HDA which support multi stream capturing , the controls are "Input
Source"

otherwise  the control is "Capture Source"

Therefore application is quite easy to know whether the sound card support
multi stream capture



> 1) Show one mic only and add auto-switch functionality, and if so, what
> should determine which mic takes precedence?


It seem that the HDA driver is not able to select the specific input source
for all HDA codec when the driver is loaded

User also should able to save/restore their selected Input source instead of
default mic

For Live CD , "alsactl init" is supposed to select internal mic instead of
external mic for laptop

For desktop there is only front mic and rear mic so user should able to
save/restore the selected input source on a fully installed system



The main problem is those line in playback volume , mic playback volume ,
aux is no longer accessible in gnome-media/kmix because they are not used by
pulseaudio

It become the responsibilty of sound preference to allow user to
change/unmute them since the Line playback volume control is important for
those  user who connected their TV card to the line in

especially CD profile is not implemented by pulseaudio where some user want
to use connect their TV tuner card output to the CD input socket


> 2) Show both mics and let the user choose between them?
>

User should able to use pink jack and  green jack at front panel by one
application and the other application can use pink jack and green jack at
rear panel



>
> 3) Show both mics, two volume control and let the user mix both signals
> together (when possible)?
>
>
I have doubt about the usefullness of mixing mic signal , if you have two
mic and sound card support multi stream capture , allow each mic used by
different application to acheive low latency is better

The main point is pulseaudio does not support more than 2 sources on one
sound card
