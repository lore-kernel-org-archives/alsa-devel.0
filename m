From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: Restore device state after
 reset in runtime resume
Date: Mon, 10 Jun 2013 10:48:26 +0100
Message-ID: <20130610094826.GN31367@sirena.org.uk>
References: <1370619797-17503-1-git-send-email-broonie@linaro.org>
 <20130608053457.GE19153@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3497038261594752166=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AB64026109D
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 11:48:31 +0200 (CEST)
In-Reply-To: <20130608053457.GE19153@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <b42378@freescale.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3497038261594752166==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ozw3xxVKMw8rP4i"
Content-Disposition: inline


--0ozw3xxVKMw8rP4i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 08, 2013 at 01:34:58PM +0800, Nicolin Chen wrote:
> On Fri, Jun 07, 2013 at 04:43:17PM +0100, Mark Brown wrote:

> > +	/* Ensure we have soft control over all registers */
> > +	regmap_update_bits(wm8962->regmap, WM8962_CLOCKING2,
> > +			   WM8962_CLKREG_OVD, WM8962_CLKREG_OVD);

> On our board this works finely, because our board uses GPIO5 as DMIC_DAT
> function which is suggested by WM8962 datasheet in APPLICATIONS chapter,
> so this case need to set CLKREG_OVD bit. But there is another case, the
> original one, also the driver currently considers, that is, GPIO5 actually
> controls SYSCLK source by its input electric level(logical 0 and 1).
> Pls check the note in WM8962 datasheet, MCLK_SRC bit of R8 (Clocking 2).

No, the driver doesn't support the hardware control configurations at=20
all - if you look in the probe function you'll see that this code is
also present there.  Any system which wants to use the hardware control
would need to add platform data to enable this mode, though it's very
unlikely that this wouild happen and systems that wish to use GPIO5 as
an output need this as the value on power on will be indeterminate.

> > +	/* Ensure that the oscillator and PLLs are disabled */
> > +	regmap_update_bits(wm8962->regmap, WM8962_PLL2,
> > +			   WM8962_OSC_ENA | WM8962_PLL2_ENA | WM8962_PLL3_ENA,
> > +			   0);

> Not sure if this is gonna be nice, because I have not seen any other
> place enabling either of these three bits if users need one of them.

Again this is to fix interactions with hardware control modes.  Since
we're coming out of suspend mode where the device may well have been
powered down we can be confident that nothing is actually using the
PLLs.

--0ozw3xxVKMw8rP4i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtaDnAAoJELSic+t+oim9axIP/RfB9brOR12QAidDldkr8LFR
WKk3+2DlN7MqRNSLDJnPZva/q53YSwduwi7+Pw+N4ypp/TB8AWEKHrzJOTWQSQQM
EZHw0xhrQPhsEIvvRJ3kdVQjmA6Vn7GdOToNmMuJUNtpZdkVU3vQpaq8KryLywp4
iUUafobhEDKIWvs1RApiZgUAinkarynuhRIjYNDw41LxXg/pLjc9Y1V91q2P4Onp
yrZ27BLmalmdmrXqUzVvPL1/9/E+sShJzXCgT03lFPy1hjPfvpcHpzYNTSNvbpnw
dtUejNcW6jAoEpkcxBGvqscUgUNAk1BR3DJoSEiYeP/1dvpPZVwbC7dDRs/pTbZT
0XlQsGPHKjIPB5h0KNqLyg/yOxJZ15dzyHfa0XoZcsH4D0XWJyrGaf8hI623K3xR
nhDkcUg83kOx142L4IGAnfWatjzuCc2D2242+DQG34uO0O/mt7PePdsn3OjspsA6
aruJVw00L9g8u7jttd1EA98e27voPBGNl2kBs+rB6Z9fxpKdJHYm6akzybaAM8+l
/1cqbv2A5PFtTk4psrDSodG6ZGbss+ynNRFCkqEOCbTkqpVCiMicn6EYR+ElFLsj
kHvsAqyBs5ucWQUEnf0YzkAfEudqAomGi911D2gnT4kbPlv2L+TEqkeWZfzl5moF
Z3hZeyZaOKSjY9+tvTtM
=9tzG
-----END PGP SIGNATURE-----

--0ozw3xxVKMw8rP4i--

--===============3497038261594752166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3497038261594752166==--
