From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: [PATCH 1/1] Added functionality for E-mu
	0404USB/0202USB/TrackerPre
Date: Sun, 27 Dec 2009 23:04:31 +1100
Message-ID: <ad2655cb0912270404g56ecb3bfwc6fa91a6d02f639f@mail.gmail.com>
References: <794724.87445.qm@web56107.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id C9A0424403
	for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2009 13:04:33 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so2737379fgg.2
	for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2009 04:04:31 -0800 (PST)
In-Reply-To: <794724.87445.qm@web56107.mail.re3.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zerg Cannibal <cnb_zerg@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/12/22 Zerg Cannibal <cnb_zerg@yahoo.com>:
> Added functionality:
> 1) Extension Units support (all XU settings now available at alsamixer, k=
mix, etc):
> =A0- "AnalogueIn soft limiter" switch;
> =A0- "Sample rate" selector (values 0,1,2,3,4,5 corresponds to 44.1 48 ..=
. 192 kHz);
> =A0- "DigitalIn CLK source" selector (internal/external) (**);
> =A0- "DigitalOut format SPDIF/AC3" switch (**);
> (**)E-mu-0404usb only.
>
> 2) Automatic device sample rate adjustment depending on substream sampler=
ate for both capture and playback substream.
>
> Patch is based on Mac OS-X driver (http://sourceforge.net/projects/zaudio=
drivermac/) and successfully tested by Ubuntu community users for 0404usb a=
nd 0202usb.

Further info for set_format_emu_quirk()

The values of XU_CR_SELECTOR_CONTROL can be:
0 =3D 44100
1 =3D 48000
2 =3D 88200
3 =3D 96000
4 =3D 176400
5 =3D 192000


USB_XU_CLOCK_RATE has a number of controls
00: Does nothing.
01: Does nothing
02: Query supported sample rates: Bitmap
03: XU_CR_SELECTOR_CONTROL: as above.

USB_XU_CLOCK_SOURCE has a number of controls:
00: Does nothing
01: Does nothing
02: USB_XU_CLOCK_SOURCE_SELECTOR_CONTROL: =3D 1 for External from
SPDIF-IN, 0 =3D Internal.

USB_XU_DIGITAL_IO has a number of controls:
00: Does nothing
01: Does nothing
02: XU_DIGITAL_IO_SAMPLE_RATE_CONTROL: spdif input sample rate. GET
only. 32bit value.
03: XU_DIGITAL_IO_SYNC_SOURCE_LOCK_STATUS: "Lock indicator". GET only
1=3DLocked. 0=3Dno-lock.
04: Does nothing
05: XU_DIGITAL_IO_OUTPUT_FRAME_FORMAT: 0 =3D undefined, 1 =3D Consumer,
Copyright OFF, 2 =3D Consumer, Copyright ON, 3 =3D Professional.

USB_XU_DEVICE_OPTIONS has a number of controls:
00: Does nothing
01: Does nothing
02: Does nothing
03: XU_DO_SOFT_LIMIT_CONTROL: GET/SET: 1 =3D Soft limit ON, 0 =3D Soft limi=
t OFF.

I have no info regarding 0xe305 or 0xe306.
I have firmware upgrade details and firmware version querying details
and usb speed query details, if one needs them.

The above info might only apply to an older version of the firmware,
so the driver might have to behave differently depending on the
installed firmware version.

Kind Regards

James
