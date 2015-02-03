From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: wm8731: let codec to manage
	clock by itself
Date: Tue, 3 Feb 2015 12:44:41 +0000
Message-ID: <20150203124441.GK21293@sirena.org.uk>
References: <1422934415-24957-1-git-send-email-voice.shen@atmel.com>
 <CAOLZvyE6W8-X2_M+-KQNry2VPwLzwbBLuxr5Z5EdBQo7Skv2RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6897582728964837124=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C710726040E
 for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2015 13:45:09 +0100 (CET)
In-Reply-To: <CAOLZvyE6W8-X2_M+-KQNry2VPwLzwbBLuxr5Z5EdBQo7Skv2RQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Richard Purdie <richard@openedhand.com>, patches@opensource.wolfsonmicro.com, LKML <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org, Manuel Lauss <manuel.lauss@googlemail.com>, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============6897582728964837124==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="py4RQBuvJMmLuKXJ"
Content-Disposition: inline


--py4RQBuvJMmLuKXJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2015 at 08:54:57AM +0100, Manuel Lauss wrote:

> +    wm8731->mclk = devm_clk_get(&spi->dev, "mclk");
> +    if (IS_ERR(wm8731->mclk)) {
> +        wm8731->mclk = NULL;
> +        dev_warn(&spi->dev, "assuming static MCLK\n");
> +    }

This is broken for both deferred probe and in the case where the clock
API genuinely returns a NULL clock.  Other than that it's the kind of
thing that we've done for some other drivers, though it's not good to
have to do this.  Check them for correct behaviour.

The coding style is also not right for the whole patch and there's a
lot of missing error checking.

--py4RQBuvJMmLuKXJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0MK5AAoJECTWi3JdVIfQDKEH/0cfeB7iOzFR3+ko4cwSnoth
59h+3/agB1NnIiuOGG31HOcK0+YiW4hrE0lpz6kpHWXXfYrKXgd0IXChl2zixyBn
3ggVle1R7mnG3xgcq5iRUresTy59O3ShVoNxsse28lBPIOYcPvhZ7GuGuLUukQDJ
K9b3rsrIaTQpLz/BeoVuEBkvCwTjFbHKE63mNjZsEGLDHlweaZ6aiQRhfr+qa6+d
yPZFiRYPm8h8ZU9EYJ50GUmAxp/6IHwoEpKDHPYo7G4Pi+NkZWwKUmG8eA/RDUb1
6M3zdXFmksNIVJ2vs8FOMUsGrgI4VB8QSTus711U00GcmLKMWl1Y3lsUqtv38OQ=
=88LY
-----END PGP SIGNATURE-----

--py4RQBuvJMmLuKXJ--

--===============6897582728964837124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6897582728964837124==--
