From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [Fwd: [kde] Low maximum volume with pulseaudio on
	kde]
Date: Sun, 19 Jun 2011 10:41:23 +0800
Message-ID: <BANLkTiksXk01a8S1AufzpMP9J1bWSUU+SA@mail.gmail.com>
References: <1308406497.32022.4.camel@segulix>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3B9BB246B0
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Jun 2011 04:41:24 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1771818fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 18 Jun 2011 19:41:24 -0700 (PDT)
In-Reply-To: <1308406497.32022.4.camel@segulix>
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

2011/6/18 S=E9rgio Basto <sergio@serjux.com>:
> -------- Forwarded Message --------
> From: S=E9rgio Basto <sergio@serjux.com>
> Reply-to: kde@mail.kde.org
> To: KDE ML <kde@mail.kde.org>
> Subject: [kde] Low maximum volume with pulseaudio on kde
> Date: Wed, 15 Jun 2011 23:04:26 +0100
>
> Hi, try again,

Which sound card/HDA Codec are you using ?

>
> 1st - edit /etc/pulse/client.conf
> and change
> autospawn =3D no
>
> 2nd - killall pulseaudio
>
> 3rd - run on user env:
> pulseaudio -vvv
>
> lets test with kmix I see on pulseaudio logs at maximum :

which version of kmix/ubuntu are you using ?

AFAIK, the pulseaudio developer rewrorte kmix to use pulse api , and
"new" kmix does not use alsa mixer api any more

>
> D: alsa-sink.c: Requested volume: 0: 100% 1: 100%
> D: alsa-sink.c: Got hardware volume: 0: 100% 1: 100%
> D: alsa-sink.c: Calculated software volume: 0: 100% 1: 100%
> (accurate-enough=3Dyes)
>
> with gnome-control-center -> sound I see on pulseaudio logs at
> maximum :
>
> D: protocol-native.c: Client gnome-control-center changes volume of sink
> alsa_output.pci-0000_00_1b.0.analog-stereo.
> D: alsa-sink.c: Requested volume: 0: 153% 1: 153%
> D: alsa-sink.c: Got hardware volume: 0: 100% 1: 100%
> D: alsa-sink.c: Calculated software volume: 0: 153% 1: 153%
> (accurate-enough=3Dno)
>
> so how I put kmix also control "software volume" since system use pulse-a=
udio ?
>

gnome sound preference already used pulse api and this is why you can
see value over 100%

Those values over 100% are software gain and sound is distorted when
clipping occur

> I read this articles
> http://www.webupd8.org/2009/08/increase-maximum-sound-level-in-ubuntu.html

The example in the above URL is properly wrong  , since PA server does
not use "default" device

> http://alsa.opensrc.org/How_to_use_softvol_to_control_the_master_volume
>

The "More complex example " in the above URL  for SBLive! Platinum
[CT4760P] is also incorrect.

When the application use

1) "hw" , the volume is controlled by "Wave Front" and "Wave Surround"
controls as the sound card pan stereo to front and rear jacks
2) "front", the volume is controlled by "Front Playback Volume"
3) "rear",  the volume is controlled by "Surround Playback Volume"
4) "surround40" the volume is controlled by "Front Playback Volume"
and "Surround Playback Volume"
