From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] ASoC: simple-card: add support for
	bclk_ratio
Date: Tue, 26 Feb 2019 15:23:52 +0000
Message-ID: <20190226152352.GC7082@sirena.org.uk>
References: <20190225164218.19439-1-TheSven73@gmail.com>
 <877ednbdnz.wl-kuninori.morimoto.gx@renesas.com>
 <20190226091104.xr27vsiayiq3dl2n@shell.armlinux.org.uk>
 <CAGngYiXrGNvwobKy+u8QWWsDowhTE8E7OSpVOOL1Yu9PvH-Z9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8909856785927907936=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4924DF89668
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 16:24:02 +0100 (CET)
In-Reply-To: <CAGngYiXrGNvwobKy+u8QWWsDowhTE8E7OSpVOOL1Yu9PvH-Z9w@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.com>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
List-Id: alsa-devel@alsa-project.org


--===============8909856785927907936==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 26, 2019 at 09:53:22AM -0500, Sven Van Asbroeck wrote:
> On Tue, Feb 26, 2019 at 4:11 AM Russell King - ARM Linux admin

> > If the signal continues toggling, what does it do for the inactive
> > channel - is that just one BCLK period long or does it assume there
> > is still the second channel?  If the former, it means we could end
> > up with bclk_ratios of 17, 25, 33 which imho is unlikely, and
> > would mess up TDA998x's CTS measurement.

> Good point. i2s with a single channel makes no sense.

As with every bad idea you can think of that never stopped anyone making
such hardware.  Mono is usually implemented by either leaving the right
channel idle or playing the same signal on both channels.

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx1WgcACgkQJNaLcl1U
h9Dv4wf+OnHJklXRaMwe4nHhZOwBSmSaRYejc5AWix3gM6VILtplf0GgfYB6HjAp
4eYZQra3vSffWGecDeuDuZTJgIcSZLSygfUpeUiJMTYYXhZPKdreWcmntGYfGnh7
GxGE2aId1/AuHYkRyc5JLpSEsAdeWE7UyUo7OYd3NYJYrWXMZGR3mHVbZOEyTXNT
a177IV9kACNUBox/ce0mwezgW+TonZAhPnxjZbrnVfPKIeYnvh7xvM+JoyTj3s79
aK/fSe47Sbt4aLM7OqXRueaDuM2/Hf3WwnQnIpeIxuf5lROSbsxoN+0WdnYTyxeu
piiagjJ3MLrir8ITtphgQn9IAumHHg==
=Ws74
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--

--===============8909856785927907936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8909856785927907936==--
