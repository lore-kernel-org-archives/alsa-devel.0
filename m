From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Noise on snd-hda-intel
Date: Fri, 1 Jul 2011 19:53:08 +0800
Message-ID: <BANLkTikpZZBf=7V9XFQ-Mft3aVc2tGY16w@mail.gmail.com>
References: <4E00F373.6050001@molgaard.org> <4E00F41E.5090303@molgaard.org>
	<1308691120.6844.1.camel@mattotaupa>
	<4E01A8FA.8060709@molgaard.org> <s5hr56m1923.wl%tiwai@suse.de>
	<4E022AA4.5060802@molgaard.org>
	<BANLkTimZHrRz-cjx3kJJziCeqaJtfiF8YA@mail.gmail.com>
	<4E044DCD.4040800@molgaard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E7481039C7
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jul 2011 13:53:09 +0200 (CEST)
Received: by fxh2 with SMTP id 2so3518346fxh.9
	for <alsa-devel@alsa-project.org>; Fri, 01 Jul 2011 04:53:09 -0700 (PDT)
In-Reply-To: <4E044DCD.4040800@molgaard.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

2011/6/24 Sune M=F8lgaard <sune@molgaard.org>:
> Raymond Yau wrote:
>> Does the noise appear when you increase =A0"Front Mic Boost" control
>> from 0dB to 30 dB ?
>>
>> arecord -v -f CD -Dhw:CARD=3DIntel | aplay -v -Dhw:CARD=3DIntel
>
> Those commands give
>
> aplay: main:660: audio open error: Device or resource busy
>
> and thus no sound. I have played around with Front Mic Boost, though -
> it doesn't seem to alter the level of noise.
>

Which asus motherboard are you using ?

Do your computer chassis have a HD compliant front audio panel ?

I cannot find any situation which "Noise" appear in Front Panel HP
only  and does not on rear panel jacks for my ad1988a


I guess you have to check the front panel connector and Front Audio Panel


There are "click" when I change "Beep Playback Volume" and "pop" when
unmute "Beep Playback Switch" in alsamixer on both HP jack and rear
panel jacks of my ad1988

aplay -D pulse --period-time=3D500 48000Hz.wav

Playing one instance of aplay at minimum period time just cause CPU go
up to 20% and the sound is still good

However sound is distorted after you play another instance of aplay at
the same time

aplay -D pulse --period-time=3D500 44100Hz.wav
