From: Daniel Mack <zonque@gmail.com>
Subject: Re: M-Audio FTU issues
Date: Thu, 21 Jul 2011 09:55:16 +0200
Message-ID: <CACTFLAPTo2jGftr2G25yyw5Dn6rBv=ayk+y1Ny6JhnYDwF9BPQ@mail.gmail.com>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
	<4E045058.6000405@showlabor.de>
	<BANLkTi=Bj7DFbSFs9p1go-ACzCAtZ=ij6w@mail.gmail.com>
	<4E04B42E.2080906@ladisch.de>
	<BANLkTinurcpMuPe-99GsaxWk+pF-K4Z_7Q@mail.gmail.com>
	<BANLkTik+2+WeOH+rcd83g63pq6asxtLAGQ@mail.gmail.com>
	<BANLkTimz6FPFFmw+-BcmP0jzyy3=gvjcVw@mail.gmail.com>
	<CACckToXFevhAHt_jC9P=ifZ9X0KVT1S7-KQnrcSna_ineeSyZg@mail.gmail.com>
	<BAY155-w40601505DEAEF2C675FB21B64F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EFA91038A4
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jul 2011 09:55:17 +0200 (CEST)
Received: by pvg18 with SMTP id 18so1023601pvg.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Jul 2011 00:55:17 -0700 (PDT)
In-Reply-To: <BAY155-w40601505DEAEF2C675FB21B64F0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Juan Pablo Bouza <jpbouza@hotmail.com>
Cc: gdiffey@gmail.com, tiwai@suse.de, clemens@ladisch.de, alsa-devel@alsa-project.org, linuxaudio@showlabor.de, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 21, 2011 at 7:08 AM, Juan Pablo Bouza <jpbouza@hotmail.com> wro=
te:
> Capture works perfectly fine.
>
> Playback does not work with alsa apps=A0 or with jack.
>
> =A0This is my /proc/asound/cards output
>
> =A00 [SB=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ]: HDA-Intel - HDA ATI SB
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 HDA ATI S=
B at 0xf9ff4000 irq 16
> =A01 [Ultra=A0=A0=A0=A0=A0=A0=A0=A0=A0 ]: USB-Audio - Fast Track Ultra
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 M-Audio F=
ast Track Ultra at usb-0000:00:13.5-1, high
> speed
>
>
> This is what happens when trying to playback a sound file with aplay -D
> plughw:Ultra /media/Edipo/Triangulo/Hadas\ por\ ahora.mp3

aplay is not capable of playing mp3 files. Try a .wav.

Also, note that the patch you tried is preliminary and not intended
for productive use. It might crash your kernel.

We need some conscenus about how to decouple the USB stream from the
ALSA stream internally to finish it.


Daniel
