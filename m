From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 7
Date: Tue, 17 Apr 2012 14:33:00 +0100
Message-ID: <CAE-xCyPrBDcKfOt9t4PK05+M95Hv0yanHdwyJ0vcv_NPS-CttA@mail.gmail.com>
References: <1334231475-20980-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 3EC5624524
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Apr 2012 15:33:02 +0200 (CEST)
Received: by vbip1 with SMTP id p1so4331458vbi.38
	for <alsa-devel@alsa-project.org>; Tue, 17 Apr 2012 06:33:01 -0700 (PDT)
In-Reply-To: <1334231475-20980-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

> Here's the 7th iteration of patches that reimplement the streaming logic =
of
> the ALSA USB audio driver.
>
> There were some bugs reportes by Felix and Grant, which have been resolve=
d.
>
> More testing is definitely important, but maybe the code will get a wider
> test coverage when merged to the development tree?
>
>
> Daniel
>
>
> Daniel Mack (6):
> =A0ALSA: snd-usb: add snd_usb_audio-wide mutex
> =A0ALSA: snd-usb: implement new endpoint streaming model
> =A0ALSA: snd-usb: switch over to new endpoint streaming logic
> =A0ALSA: snd-usb: remove old streaming logic
> =A0ALSA: snd-usb: add support for implicit feedback
> =A0ALSA: snd-usb: add some documentation
>
> =A0sound/usb/card.c =A0 =A0 | =A0 10 +-
> =A0sound/usb/card.h =A0 =A0 | =A0 62 ++
> =A0sound/usb/endpoint.c | 1601 ++++++++++++++++++++++++++++--------------=
--------
> =A0sound/usb/endpoint.h | =A0 32 +-
> =A0sound/usb/pcm.c =A0 =A0 =A0| =A0441 ++++++++++++---
> =A0sound/usb/stream.c =A0 | =A0 31 +-
> =A0sound/usb/usbaudio.h | =A0 =A02 +
> =A07 files changed, 1381 insertions(+), 798 deletions(-)
>

Hi Daniel,

Sorry for the delay in testing!

It almost works for me!

Using the EHCI USB Port on my laptop (USB 2):
- The UA-25Ex works perfectly.
- The FTU works perfectly.

Using the XHCI USB Port on my laptop (USB 3):
- The UA-25Ex works perfectly.
- Unfortunately, the FTU isn't recognized and I get this error message in d=
mesg:

[  656.543267] usb 3-1: new high-speed USB device number 8 using xhci_hcd
[  656.556409] usb 3-1: config 1 interface 3 altsetting 0 bulk
endpoint 0x7 has invalid maxpacket 8
[  656.556413] usb 3-1: config 1 interface 3 altsetting 0 bulk
endpoint 0x87 has invalid maxpacket 8
[  656.557650] usb 3-1: ep 0x87 - rounding interval to 32768
microframes, ep desc says 0 microframes
[  656.557869] xhci_hcd 0000:04:00.0: ERROR: unexpected command
completion code 0x11.
[  656.557877] usb 3-1: can't set config #1, error -22

Let me know if there is any other information I can provide you.

Regards,
Aur=E9lien
