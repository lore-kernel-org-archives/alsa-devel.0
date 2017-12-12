From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: codecs: tas5720: add TAS5722 TDM
 slot width setting support
Date: Tue, 12 Dec 2017 12:02:32 +0000
Message-ID: <20171212120232.GI16323@sirena.org.uk>
References: <20171211190157.12371-1-afd@ti.com>
 <20171211190157.12371-4-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3125195022080250842=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8674E267751
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 13:02:36 +0100 (CET)
In-Reply-To: <20171211190157.12371-4-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============3125195022080250842==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Content-Disposition: inline


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 11, 2017 at 01:01:57PM -0600, Andrew F. Davis wrote:

> +	/* Configure TDM slot width. This is only applicable to TAS5722. */
> +	if (tas5720->devtype == TAS5722) {
> +		ret = snd_soc_update_bits(codec, TAS5722_DIGITAL_CTRL2_REG,
> +					  TAS5722_TDM_SLOT_16B,
> +					  slot_width == 16 ?
> +					  TAS5722_TDM_SLOT_16B : 0);
> +		if (ret < 0)
> +			goto error_snd_soc_update_bits;
> +	}

Use a switch statement, that way additional variants can be handled more
sensibly.

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlovxVcACgkQJNaLcl1U
h9BFiwf+NTjvX8GnR5vf6yv4h+oyiUSSOVtG36r+wkoh2YeIT9iEnHtd/vhoXbP4
R8idCDMplMYcsz6KBIGi3OL9toKGd5DAvjMF6aUYy65ZRe0rJIgtWswj7f9hu2mT
g/urK6BmMUSv9RvPnLCnKzRo4X4eecxL8I9zpqvzWsvOfa2fxG4Ax1HX4yw0Spdi
+pqVCvFE3DkTNLEVUwX4/dJf4iXpLALmtWz85N3XnSoAr18J/iBbtJVzlUWP+TgM
tL3HTGdcfhi9qFJPFKsVA4XRSu+tn4vvAqb+zRPHIJV3swbGP8ygFttD6qzt2h1G
rOBn/k1P2tGHTFwmrB1e1xlofMf0pA==
=5BiU
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--

--===============3125195022080250842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3125195022080250842==--
