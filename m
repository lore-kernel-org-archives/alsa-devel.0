From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: tlv320aic3x: add missing
	registers and bits
Date: Wed, 27 Jun 2012 13:01:31 +0100
Message-ID: <20120627120130.GJ308@opensource.wolfsonmicro.com>
References: <4FEAA303.5020806@aksignal.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3768443989670248163=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DD2E0103F9E
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 14:01:37 +0200 (CEST)
In-Reply-To: <4FEAA303.5020806@aksignal.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Prchal =?utf-8?B?SmnFmcOt?= <jiri.prchal@aksignal.cz>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, sudhakar.raj@ti.com, nsekhar@ti.com, peter.ujfalusi@ti.com, mr.swami.reddy@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3768443989670248163==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8tZVdKiiYitVG083"
Content-Disposition: inline


--8tZVdKiiYitVG083
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 27, 2012 at 08:06:59AM +0200, Prchal Ji=C5=99=C3=AD wrote:
> Second version of patch keeping formatting.
> Adds missing register default values to cache.
> Adds register and bits definitions in header file.

> Changes are for TLV320AIC310x based on data sheet.

I tried to apply it but it doesn't apply, git am says:

error: home/prchal/arm/fw-cdu/linux/linux-3.5-rc3/sound/soc/codecs/tlv320ai=
c3x.c.new: does not exist in index

which is because:

> --- /home/prchal/arm/fw-cdu/linux/linux-3.5-rc3/sound/soc/codecs/tlv320ai=
c3x.c.orig
> +++ /home/prchal/arm/fw-cdu/linux/linux-3.5-rc3/sound/soc/codecs/tlv320ai=
c3x.c.new

Please format the patch as covered in SubmittingPatches, it should be
something that can be applied patch -p1.  Also...

> @@ -122,7 +122,9 @@
>  	0x00, 0x00, 0x00, 0x00,	/* 88 */
>  	0x00, 0x00, 0x00, 0x00,	/* 92 */
>  	0x00, 0x00, 0x00, 0x00,	/* 96 */
> -	0x00, 0x00, 0x02,	/* 100 */
> +	0x00, 0x00, 0x02, 0x00,	/* 100 */
> +	0x00, 0x00, 0x00, 0x00,	/* 104 */
> +	0x00, 0x00,             /* 108 */
>  };

This is a lot clearer, your changelog (and the previous submission)
suggested that there may be some errors in the register default values
since you were talking about missing bits but really all you're doing is
adding new registers which is a bit different to correcting mistakes.

The "missing bits" here are instead just:

> @@ -74,6 +74,8 @@
>  #define HPLCOM_CFG			37
>  /* Right High Power Output control registers */
>  #define HPRCOM_CFG			38
> +/* High Power Output Stage Control Register */
> +#define HPOUT_SC			40
>  /* DAC Output Switching control registers */
>  #define DAC_LINE_MUX			41
>  /* High Power Output Driver Pop Reduction registers */

these new defines in the header.

--8tZVdKiiYitVG083
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6vYUAAoJEBus8iNuMP3dfpoQAIJuaJ3rYVMkjuI81UAc0Z2m
Rncfvq8lbdE0uXdVIUiqRaWsYFbTsOHlVyi526p/8T/EB58avQvIkv9z41wDaCGx
SQzrMKxLlNkgsYssCcuVXyurFRIiCFbaxK88DYl7SpaPoRgsMeHrhMuYQqTud7in
lASBUlxWOC9L2QB/RTFyUZ27+9SAojqGexl+hxIkXncVDPS4j+h7eARUROPjPRkv
Hqsr19ozWgWYZ5VBM7ivHaE35zdE2B+xn08GGawAtpkxsxQjrah9tsb/Frl8boXP
rX9I7R2OiBb6SGT5YsWloim8Zzf0E9xb7evPKj4gHdq+bJdgTMy4usdNGy9Hn8oT
J+V+qM4Ki2j8o9y1zePfmyIs8nIXu8l8hUINcL1cAzhMQ3dIPA2o4SjwSn8U8MtU
GhumSM6WeS5rwE4Pbv5w6o/k/5ZJWUvewP7kpCQaECZmTKiIYt8FxkIcFaoe0wew
RiXprgD1zWa4OkRXLZ8gjnu182WqUHyHoEyPy0cNemUFfMN7Ridf4Msa5+uM3pTV
Afr+E92Emwxly5GYrkXLe47RCzVAsfqjOa0unTu9rnbQd7XezAqqhm6bRff3wnEB
t5IxtuH7SmAOoTO6Rqf0uk7iDPeMTNjwaL/QOqI24ecT9uWJdJKhrrigTSe4/nyw
3Dm4M2zWfSbafjWx9oKQ
=T+eR
-----END PGP SIGNATURE-----

--8tZVdKiiYitVG083--

--===============3768443989670248163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3768443989670248163==--
