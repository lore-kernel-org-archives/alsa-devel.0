From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5677: Add sidetone controls
Date: Wed, 17 Sep 2014 09:58:58 -0700
Message-ID: <20140917165858.GO7960@sirena.org.uk>
References: <1410931739-6088-1-git-send-email-anatol.pomozov@gmail.com>
 <1410931739-6088-2-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5922872073717796584=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 963DE2654B4
 for <alsa-devel@alsa-project.org>; Wed, 17 Sep 2014 18:59:03 +0200 (CEST)
In-Reply-To: <1410931739-6088-2-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5922872073717796584==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hV9LobOkkIdnlvrX"
Content-Disposition: inline


--hV9LobOkkIdnlvrX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 16, 2014 at 10:28:59PM -0700, Anatol Pomozov wrote:

> +	/* Sidetone Control */
> +	SOC_SINGLE("Sidetone Switch", RT5677_SIDETONE_CTRL,
> +		RT5677_ST_EN_SFT, 1, 0),

If this is enabling and disabling a route (as it will be since it's a
sidetone) I would expect to see the route represented in DAPM.

--hV9LobOkkIdnlvrX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGb3SAAoJECTWi3JdVIfQ+LoH/iGbk8g4Bn0R9ng6l1fyRJGm
fg6iWM1lFiXhfW6oq/FoltqxLAMpDeLvahbPxyrppT2Dx94xYboNax4Mb0Nikhex
CvYlyemB9/r3cFOuAlQjhcWV9y0ETZZkgDjLLPaSQso8d21FXhPse3bq01ZXfP0F
XRq1OHHvxkD3JqI3jWjZxg1wS0vcQNVPXjR0FFBBYCYIRyMs6cZzlZ8jn+qdKRmD
7rD5ut3rjCmlGbURCSN7O7oe9wp8882CH7ZNMuOrbgWKKyuXeyeb+3vT4aVBffuR
XoeZXu30Sw30CRpNUfYwpruvuCz6uGeKln0sfflxi7TS7L/jpI9iaEFoqL9MsOg=
=kKd8
-----END PGP SIGNATURE-----

--hV9LobOkkIdnlvrX--

--===============5922872073717796584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5922872073717796584==--
