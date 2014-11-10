From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: tlv320aic3x: Add output driver
 pop reduction controls
Date: Mon, 10 Nov 2014 10:51:55 +0000
Message-ID: <20141110105155.GL3815@sirena.org.uk>
References: <1415615253-28919-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0323622245599667383=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 96C4026085B
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 11:53:12 +0100 (CET)
In-Reply-To: <1415615253-28919-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0323622245599667383==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KasUm1oH6X2AfSvU"
Content-Disposition: inline


--KasUm1oH6X2AfSvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 12:27:32PM +0200, Peter Ujfalusi wrote:

> +static const struct soc_enum aic3x_pop_reduction_enum[] = {
> +	SOC_ENUM_SINGLE(HPOUT_POP_REDUCTION, 4, 12, aic3x_poweron_time),
> +	SOC_ENUM_SINGLE(HPOUT_POP_REDUCTION, 2, 4, aic3x_rampup_step),
> +};

> +	/* Pop reduction */
> +	SOC_ENUM("Output Driver Power-On time", aic3x_pop_reduction_enum[0]),
> +	SOC_ENUM("Output Driver Ramp-up step", aic3x_pop_reduction_enum[1]),

Don't add arrays of enums with magic number indexes like this, it's hard
to read and hence error prone.

--KasUm1oH6X2AfSvU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYJjKAAoJECTWi3JdVIfQ5wIH/AyDZaxJTp6nIYbKAZC0ZGuW
A1X0a/FbVHRLmeJqN0MF0QcQ89nZDAzFyRcUXI5g1mshGpneIIuQQjAclsZPROgz
fAxH0UxgX8SRnoHdDw1Cs5vel+CW/h9LNdu03UiJTPOXCbEpdkvdIpe8hgVqsreX
0x+bNqPubMYoCKLME318Osa2GBgFFx+kjAIqN8uVEUL5Zue8MQGhrWMEQLS3r8jC
+iZJH5SXK30cXVbh2r9Q8YRxOBvlpwjRt6zRCnhEV5il7CeIYiNf9kcMmW7m+rEh
faLpEzt2o4WwEF9UGRAIv/wSNTpVhwy0s4pUWsc4JixmNIYfmH+7PoZvvLTBD34=
=AyhM
-----END PGP SIGNATURE-----

--KasUm1oH6X2AfSvU--

--===============0323622245599667383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0323622245599667383==--
