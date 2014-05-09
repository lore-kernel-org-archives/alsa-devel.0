From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] mfd: mc13xxx: Do not use platform data with
 devicetree
Date: Fri, 9 May 2014 15:36:29 +0100
Message-ID: <20140509143629.GA5767@lee--X1>
References: <1398926883-21778-1-git-send-email-shc_work@mail.ru>
 <20140509113030.GV5767@lee--X1>
 <1399643769.716496780@f345.i.mail.ru>
 <20140509141840.GZ5767@lee--X1>
 <20140509143054.GN12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140509143054.GN12304@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Alexander Shiyan <shc_work@mail.ru>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

> > You need to revert (or remove) the original one and apply:
>=20
> >   "ASoC: mc13783: Add devicetree support"
>=20
> > ... instead.
>=20
> Why not just pull the tag instead?  I haven't looked at the patch but
> don't they need to go in together anyway.

Only functionally.  They are orthogonally buildable apparently.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
