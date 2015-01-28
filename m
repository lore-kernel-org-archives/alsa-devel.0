From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: set idle_bias_off to false
Date: Wed, 28 Jan 2015 11:35:37 +0000
Message-ID: <20150128113537.GU21293@sirena.org.uk>
References: <1422435597-19330-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6048033528948087010=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D13F52619D7
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 12:35:45 +0100 (CET)
In-Reply-To: <1422435597-19330-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6048033528948087010==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YX3j2TVtVK6AUAU8"
Content-Disposition: inline


--YX3j2TVtVK6AUAU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2015 at 04:59:57PM +0800, Bard Liao wrote:
> We do the power down process at bias level STANDBY. And do nothing
> at bias level OFF. As a result, the register setting is the same
> between bias level STANDBY and OFF. So we don't need to set
> idle_bias_off true.

> -	.idle_bias_off = true,
> +	.idle_bias_off = false,

There is no need to set false explicitly, it's the default.  It also
seems better to keep the flag if it's true, even if we don't actively do
anything at the minute we may in future (either in the framework or in
the driver) so the information seems useful.

--YX3j2TVtVK6AUAU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyMmIAAoJECTWi3JdVIfQWnwH/AiA2oiC1Qzg1Ltoa+wpcWT9
41S14G36I1pYa4i2xR1yW9Z4L4HU+v376qNAseA/4ZiRr+hUEWYLUH7XflNO9yUQ
nIod1DdGZDjB/EoLqZgbMVBuvgqDiw6X+7ksgI8b90Df7WthgiUKBpQWZTSD8/yG
uA7521/mV1Yd0jro3tbgO6Hh/GLiBbRixQVAGu/Y8WG8dtCW5dU2qKxUXhNPBwhp
A+iv4Io3eoZXmuStc4ge5unTjsKA+q3O6omesOEHfytQhR9VijoIcmVpLC0NV8Tn
HGXAa5gPc94uUBkroM+2Iyfh5/UXuNVSkbgCTfd3/YFug+WkZcQzFOAaZuQfhno=
=zIpe
-----END PGP SIGNATURE-----

--YX3j2TVtVK6AUAU8--

--===============6048033528948087010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6048033528948087010==--
