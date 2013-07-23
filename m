From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH v3] ARM: kirkwood: extend the kirkwood i2s
 driver for DT usage
Date: Tue, 23 Jul 2013 17:34:50 +0200
Message-ID: <20130723173450.0d67036b@armhf>
References: <20130723104615.3696f1a9@armhf>
	<20130723123444.GW9858@sirena.org.uk>
	<51EE7E1A.3040301@gmail.com>
	<20130723132016.GC9858@sirena.org.uk>
	<51EE8591.7060005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51EE8591.7060005@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, devicetree-discuss@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 23 Jul 2013 15:30:57 +0200
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> >> again, we mentioned to merge kirkwood-i2s.c and kirkwood-dma.c int=
o
> >> a single file, didn't we? =20
> >
> > That's been discussed several times but nobody's actually done it. =
=20
>=20
> Correct, that is why I repeated that request to Jean-Francois.

Thanks for all your remarks.

I am testing a new version, with mainly:
- "internal" and "external" clocks
- kirkwood-i2s and kirkwood-dma in one module
- no S/PDIF (I have not yet tried i2s with the tda998x)

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
