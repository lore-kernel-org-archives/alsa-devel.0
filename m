From: "Fischer, Christian" <fischerc@swissphone.de>
Subject: Re: ASoC: sgtl5000: recording issue at 8 kHz with
	fsl-imx28
Date: Wed, 10 Jan 2018 14:20:36 +0000
Message-ID: <DD64F087E8F0B540A1C9216D6716FFBDF9946A5B@defrsexc01.swissphone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.avectris.ch (mail2.avectris.ch [185.94.144.40])
 by alsa0.perex.cz (Postfix) with ESMTP id EA8FA266DEC
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 15:20:38 +0100 (CET)
Received: from mail2.avectris.ch (localhost [127.0.0.1])
 by mail2.avectris.ch (Mission Control Email Shield,
 5082) with SMTP id 3zGrlB0lMZzbTLT
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 15:20:38 +0100 (MET)
Content-Language: de-DE
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

It's me again.

I just found out that the audio playback is affected by this problem too.
Maybe this can serve as a hint.

Regards,
Christian

-----Urspr=FCngliche Nachricht-----
Von: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-pr=
oject.org] Im Auftrag von Fischer, Christian
Gesendet: Mittwoch, 10. Januar 2018 11:31
An: alsa-devel@alsa-project.org
Cc: 'Takashi Iwai' <tiwai@suse.com>; 'Mark Brown' <broonie@kernel.org>; 'Li=
am Girdwood' <lgirdwood@gmail.com>
Betreff: [alsa-devel] ASoC: sgtl5000: recording issue at 8 kHz with fsl-imx=
28

Hello guys,

trying to record from a SGTL5000 with 8 kHz sampling rate gives a very bad =
audio quality.
All other sampling rates working fine.

Initially posted at NXP forum: https://community.nxp.com/message/975131

Tested with imx28, sgtl5000 and Kernel 4.14.12.

I've attached a recording with 8 kHz, capture-vol was 67, mic-gain 33, AVC-=
off and Capture-ZC off.
Recorded with "arecord -D "hw:0,1" -t wav -f S16_LE -c 2 -r 8000 test.wav".
Sounds like there are missing samples..

The microphone is powered from mic-bias and decoupled with a 100nF capacito=
r.

Can anybody help me?
Thank you guys!
Kind regards,

Christian Fischer
