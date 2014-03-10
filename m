From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ak4642: show error if register write fails
Date: Mon, 10 Mar 2014 23:40:38 +0000
Message-ID: <20140310234038.GE28112@sirena.org.uk>
References: <1394475355-7069-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8482616221907385974=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE92B26087B
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 00:40:48 +0100 (CET)
In-Reply-To: <1394475355-7069-1-git-send-email-ben.dooks@codethink.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org, lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org


--===============8482616221907385974==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="33s3DhG5T9STe0CU"
Content-Disposition: inline


--33s3DhG5T9STe0CU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2014 at 06:15:55PM +0000, Ben Dooks wrote:

> +/* wrapper functions to show any errors to updating register values */
> +
> +static inline int ak4642_update_bits(struct snd_soc_codec *codec,
> +				     unsigned int reg,
> +				     unsigned int mask, unsigned int val)
> +{
> +	int ret = snd_soc_update_bits(codec, reg, mask, val);
> +
> +	if (ret < 0) {
> +		pr_info("%s: error %d writing %04x (%08x, mask %08x)\n",
> +			codec->name, ret, reg, mask, val);

Two things here.  One is that this should be a dev_err() and the other
is that if this is worth doing shouldn't it just be in the core - I see
nothing driver specific here?

--33s3DhG5T9STe0CU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHk1yAAoJELSic+t+oim9lJQP/1JcZLcvl6934bQbTY6cJjPZ
6bG2Cvt6d0wYAZOU6XwL7LfhbhDuhBeKkud3eNoS2eBr+SIwH8sVKNHPTlu2sSdc
OaVnEFLwxoUO8lsR8nQ/JfvmY2NT9sqG2EwuP0GsG6Qd6oTVdDTOmY9fdMIEiIO/
AuLMfeT5TIuqJNZq2DdjWV4+sy6rrFtp0fsJtdMzNVn8gs8VUl7Lz8gmOVnrcK3w
PNQ+3T64xa6W5sw1a8omLYHpHRTCzXk9nXs09lGCOSciC6rjCHymQF50EfjCxGek
ATGBDWYQMfBaRhJF5vseYXpvqDliwQcUc2iWEReHwRCTEwM2mBxFVRJnYSZWTbkK
P2k5UJLx/Em79XerobR+E1+p+G1EX+B4OBPAy7SS05gxEHA0BX8PVHIqnPlrpSaT
Bt1ekjtCNA7i8LotXoXvyW+y4fHYmcdfl4yQB4Q365mqCsgM/xLvSemrULMNAJ1A
TlwdR2TeFBMhN9H0P5V4+GL0rUgBZ42g5APfb7ZlzkDpmb5WN7zHb+GCXNocHW5K
dL//do/dCqoDA0L6+0yOOR1Kz4XDuZP14lYuUmfZCw7WiHgMVgK3dNpeFsZ6ERhv
TjPyPl7YDJ/MPin7ySpRiv5Q97keTJTnYK3FpqiKuciWgJAmZmCs/UTvcxMzY+sU
dxgifyxWlPMEaZINvsyn
=1bv6
-----END PGP SIGNATURE-----

--33s3DhG5T9STe0CU--

--===============8482616221907385974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8482616221907385974==--
