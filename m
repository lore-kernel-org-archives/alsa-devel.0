From: Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [RFC] Moving snd-bt87x and btaudio to drivers/media
Date: Wed, 18 Jan 2006 17:53:20 -0200
Message-ID: <1137614000.28917.40.camel@localhost>
References: <1137590968.32449.46.camel@localhost>
	 <20060118194147.GN19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932520AbWARTxi@vger.kernel.org>
In-Reply-To: <20060118194147.GN19398@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>, alsa devel <alsa-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Johannes Stezenbach <js@linuxtv.org>, Linux and Kernel Video <video4linux-list@redhat.com>, Manu Abraham <abraham.manu@gmail.com>
List-Id: alsa-devel@alsa-project.org

Em Qua, 2006-01-18 =E0s 20:41 +0100, Adrian Bunk escreveu:
> On Wed, Jan 18, 2006 at 11:29:28AM -0200, Mauro Carvalho Chehab wrote=
:
> >...
> > 	This I couldn't found at any Kconfig (but module exists, and also =
an
> > entry at Makefile):
> > sound/oss/Makefile:obj-$(CONFIG_SOUND_BT878)    +=3D btaudio.o
> >...
>=20
> The entry is in sound/oss/Kconfig.
	Ok. I don't know why I didn't saw it :) So, we should also move it to
video Kconfig, with the module, and add a choice for OSS or ALSA, like
we intend to do with saa7134-oss/alsa.
>=20
> > Cheers,=20
> > Mauro.
>=20
> cu
> Adrian
>=20
Cheers,=20
Mauro.
