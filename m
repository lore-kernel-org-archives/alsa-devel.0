From: Dark Shadow <shadowofdarkness@gmail.com>
Subject: Re: Nvidia GTS 250M HDMI audio output
Date: Sun, 4 Apr 2010 06:17:11 -0600
Message-ID: <m2r231dafb51004040517yee2a345di9f7000e96d189b61@mail.gmail.com>
References: <j2v231dafb51004040254g38b97bceu472e625b754fe6d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B381103838
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Apr 2010 14:17:11 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 14so1073068qwa.56
	for <alsa-devel@alsa-project.org>; Sun, 04 Apr 2010 05:17:11 -0700 (PDT)
In-Reply-To: <j2v231dafb51004040254g38b97bceu472e625b754fe6d9@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

oops I clean installed and forgot to upgrade to the newest snapshot
before testing. I am upgrading now and will post new info if I still
have problems.

On Sun, Apr 4, 2010 at 3:54 AM, Dark Shadow <shadowofdarkness@gmail.com> wr=
ote:
> What can I do to help get this working on my laptop. So far it sort of
> shows up in Alsa mixer but with no controls and a strange chip name
> "Nvidia ID d" I am not a programmer but if you tell me any commands I
> will give the output.
>
> Here is the output of alsa-info.sh
> http://www.alsa-project.org/db/?f=3D1f21b5d7ee864d157cbddd3bd93de527f5aa1=
9bf
>
>
>
>
> Alsa the *reg* and *debug* did not exist but *codec* did so here is the o=
utput.
> Here is cat /proc/asound/card1/codec#*
>
> $ cat /proc/asound/card1/codec#*
> Codec: Nvidia ID d
> Address: 0
> Function Id: 0x1
> Vendor Id: 0x10de000d
> Subsystem Id: 0x10de0101
> Revision Id: 0x100100
> No Modem Function Group found
> Default PCM:
> =A0 =A0rates [0x0]:
> =A0 =A0bits [0x0]:
> =A0 =A0formats [0x0]:
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> GPIO: io=3D0, o=3D0, i=3D0, unsolicited=3D0, wake=3D0
> Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
> =A0Converter: stream=3D0, channel=3D0
> =A0Digital:
> =A0Digital category: 0x0
> =A0PCM:
> =A0 =A0rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
> =A0 =A0bits [0xe]: 16 20 24
> =A0 =A0formats [0x5]: PCM AC3
> =A0Unsolicited: tag=3D00, enabled=3D0
> Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
> =A0Pincap 0x09000094: OUT Detect HDMI
> =A0Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
> =A0 =A0Conn =3D Digital, Color =3D Unknown
> =A0 =A0DefAssociation =3D 0x1, Sequence =3D 0x0
> =A0Pin-ctls: 0x00:
> =A0Unsolicited: tag=3D00, enabled=3D0
> =A0Connection: 1
> =A0 =A0 0x04
> Codec: Nvidia ID d
> Address: 1
> Function Id: 0x1
> Vendor Id: 0x10de000d
> Subsystem Id: 0x10de0101
> Revision Id: 0x100100
> No Modem Function Group found
> Default PCM:
> =A0 =A0rates [0x0]:
> =A0 =A0bits [0x0]:
> =A0 =A0formats [0x0]:
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> GPIO: io=3D0, o=3D0, i=3D0, unsolicited=3D0, wake=3D0
> Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
> =A0Converter: stream=3D0, channel=3D0
> =A0Digital:
> =A0Digital category: 0x0
> =A0PCM:
> =A0 =A0rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
> =A0 =A0bits [0xe]: 16 20 24
> =A0 =A0formats [0x5]: PCM AC3
> =A0Unsolicited: tag=3D00, enabled=3D0
> Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
> =A0Pincap 0x09000094: OUT Detect HDMI
> =A0Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
> =A0 =A0Conn =3D Digital, Color =3D Unknown
> =A0 =A0DefAssociation =3D 0x1, Sequence =3D 0x0
> =A0Pin-ctls: 0x00:
> =A0Unsolicited: tag=3D00, enabled=3D0
> =A0Connection: 1
> =A0 =A0 0x04
> Codec: Nvidia ID d
> Address: 2
> Function Id: 0x1
> Vendor Id: 0x10de000d
> Subsystem Id: 0x10de0101
> Revision Id: 0x100100
> No Modem Function Group found
> Default PCM:
> =A0 =A0rates [0x0]:
> =A0 =A0bits [0x0]:
> =A0 =A0formats [0x0]:
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> GPIO: io=3D0, o=3D0, i=3D0, unsolicited=3D0, wake=3D0
> Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
> =A0Converter: stream=3D0, channel=3D0
> =A0Digital:
> =A0Digital category: 0x0
> =A0PCM:
> =A0 =A0rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
> =A0 =A0bits [0xe]: 16 20 24
> =A0 =A0formats [0x5]: PCM AC3
> =A0Unsolicited: tag=3D00, enabled=3D0
> Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
> =A0Pincap 0x09000094: OUT Detect HDMI
> =A0Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
> =A0 =A0Conn =3D Digital, Color =3D Unknown
> =A0 =A0DefAssociation =3D 0x1, Sequence =3D 0x0
> =A0Pin-ctls: 0x00:
> =A0Unsolicited: tag=3D00, enabled=3D0
> =A0Connection: 1
> =A0 =A0 0x04
> Codec: Nvidia ID d
> Address: 3
> Function Id: 0x1
> Vendor Id: 0x10de000d
> Subsystem Id: 0x10de0101
> Revision Id: 0x100100
> No Modem Function Group found
> Default PCM:
> =A0 =A0rates [0x0]:
> =A0 =A0bits [0x0]:
> =A0 =A0formats [0x0]:
> Default Amp-In caps: N/A
> Default Amp-Out caps: N/A
> GPIO: io=3D0, o=3D0, i=3D0, unsolicited=3D0, wake=3D0
> Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
> =A0Converter: stream=3D0, channel=3D0
> =A0Digital:
> =A0Digital category: 0x0
> =A0PCM:
> =A0 =A0rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
> =A0 =A0bits [0xe]: 16 20 24
> =A0 =A0formats [0x5]: PCM AC3
> =A0Unsolicited: tag=3D00, enabled=3D0
> Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
> =A0Pincap 0x09000094: OUT Detect HDMI
> =A0Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
> =A0 =A0Conn =3D Digital, Color =3D Unknown
> =A0 =A0DefAssociation =3D 0x1, Sequence =3D 0x0
> =A0Pin-ctls: 0x00:
> =A0Unsolicited: tag=3D00, enabled=3D0
> =A0Connection: 1
> =A0 =A0 0x04
>
