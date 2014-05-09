From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: mc13xxx: Do not use platform data with
 devicetree
Date: Fri, 9 May 2014 15:18:40 +0100
Message-ID: <20140509141840.GZ5767@lee--X1>
References: <1398926883-21778-1-git-send-email-shc_work@mail.ru>
 <20140509113030.GV5767@lee--X1>
 <1399643769.716496780@f345.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399643769.716496780@f345.i.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 09 May 2014, Alexander Shiyan wrote:

> Fri, 9 May 2014 12:30:30 +0100 =D0=BE=D1=82 Lee Jones <lee.jones@lina=
ro.org>:
> > > This patch removes platform data usage for codec and touchscreen
> > > when driver is used with devicetree.
> > > This fixes possible "null pointer dereference" error if DTS uses
> > > "fsl,mc13xxx-uses-codec" or "fsl,mc13xxx-uses-touch" options.
> > >=20
> > > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > > ---
> > >  drivers/mfd/mc13xxx-core.c | 18 ++++++++++--------
> > >  1 file changed, 10 insertions(+), 8 deletions(-)
> >=20
> > Applied, thanks.
>=20
> This patch has been written as a way to separate MFD and ASoC changes=
 of
> the patch: (ASoC: mc13783: Add devicetree support)
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/comm=
it/?id=3D780aaeff96819ca58e0cad830bfbe6eee9aef82c
>=20
> So, it should produce conflict.

Exactly.

Mark,

You need to revert (or remove) the original one and apply:

  "ASoC: mc13783: Add devicetree support"

=2E.. instead.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
