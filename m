From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 1/4] ASoC: rockchip: add rockchip machine
 driver
Date: Thu, 21 May 2015 12:10:28 +0100
Message-ID: <20150521111028.GZ21577@sirena.org.uk>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com>
 <20150512192215.GZ3066@sirena.org.uk>
 <55535035.5070608@rock-chips.com>
 <20150513164250.GB2761@sirena.org.uk>
 <CAEUnVG5+PqhkZ4TBMnfdbUr66-EaLVGDEewJ_=XZnfbvBEn13w@mail.gmail.com>
 <CAEUnVG5nkagx7CZC3t=-oOAyXOBaxxVynBxaGMf0NJpfr9ZVbA@mail.gmail.com>
 <555659DB.9010204@metafoo.de>
 <20150519111602.GG2761@sirena.org.uk>
 <CAEUnVG6QLtV3AXjdPAp5mYDTnmNVsyLfYQmLykeLMd-KgnX+5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1RfOVxRbNnn9f8MI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEUnVG6QLtV3AXjdPAp5mYDTnmNVsyLfYQmLykeLMd-KgnX+5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dylan Reid <dgreid@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, zhengxing <zhengxing@rock-chips.com>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>, Xing Zheng <acgzxing@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-rockchip@lists.infradead.org, Sonny Rao <sonnyrao@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--1RfOVxRbNnn9f8MI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 19, 2015 at 09:37:58AM -0700, Dylan Reid wrote:

> Can the jacks can each be an aux_dev?  The jack driver would create
> the jack at probe time and register it with the card in aux_dev->init.
> cht_bsw_max98090_ti.c is already doing something similar, although all
> contained in the machine driver.

Yes, that's just a CODEC driver registered without any DAIs connected so
it'd just be another CODEC driver.

> Then simple-card can have an optional property to specify aux devs.  A
> GPIO jack device could handle simple switch-based jack detection.

That's useful anyway for external headphone/speaker drivers.

--1RfOVxRbNnn9f8MI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXb0jAAoJECTWi3JdVIfQJUYH+gO3w1Ghdn1mUnB5DC2vOhgx
9uMgzaWOjYWjLQA1oFtQp59OXnD7bYg981hLDLea9QIHvm/rZ/IGyWcG/+SpSbPG
cebVsl3tdyH7aoBawRQHV4Xp/AfXcvg9Vcn18LNm0ADGkuVETSKk1LP5BAgPZCiw
HpCU+ObmTS3qFStJRyE/ah0NnvULI32wJBAWHYaklOK+cHrzi6zatGiipJ4+V0rM
TKHW7WO0Pmj+2vALvgWBwCEcaiOdaDTOngiB5hWiOkg9YmrUCx5zSlRQoI+ldYgm
qRPm3KLA8tws2bDqHB8o9xzBIDIGD6y6zdm6GmFtQes0u9g+plUpmlY7to7WLSI=
=avT0
-----END PGP SIGNATURE-----

--1RfOVxRbNnn9f8MI--
