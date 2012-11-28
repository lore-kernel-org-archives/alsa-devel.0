From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/14] ASoC: wm8962: Use
	devm_regulator_bulk_get
Date: Wed, 28 Nov 2012 17:39:46 +0000
Message-ID: <20121128173946.GU32691@opensource.wolfsonmicro.com>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
 <1353930587-12907-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8152411382025399904=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CF2CB2625DD
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2012 18:39:47 +0100 (CET)
In-Reply-To: <1353930587-12907-3-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============8152411382025399904==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+k4Drb7WGefOwc9B"
Content-Disposition: inline


--+k4Drb7WGefOwc9B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 05:19:35PM +0530, Sachin Kamat wrote:
> devm_regulator_bulk_get() is device managed and makes error
> handling and code cleanup simpler.

Applied, but again *ALWAYS* CC maintainers.

--+k4Drb7WGefOwc9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtkxOAAoJELSic+t+oim9askP/jqljD57APvh4Mm8Lvqg+Jl/
JTsnTLHKrcBlTM8Jf0ephDKQGyS9yzWRjtQz92BFxsMeweG0KgdmolW7oTaBhcoC
PD7ztJhKBevWp8nUT3E/O4NmO+PxNjefvUIMbbeO3BI73A2MElqPXF3R730jc9p9
KM5TlJkmFnJB4oJ9BGRDJWWvLBMzWmE1/UVVHCGxCRMVTjQqQdLd2jNycGZ1NAXC
b39JMGLMDfLRi5MNhr1EcC/H1gs0POayQecKqZI01REAuzlyDkuKezxMCa7I1i5C
xr9mi4GC9p8PxXhd2mXHvrICzy96vpfo8M9ihz4S5UFZPy88o5KgYsn/aw6BNWHv
18vJTzPuVuthETTbycBFRfiqEZ48TTQVFmnZv1vyipoByI1tfhwN+zkO45rewwhf
q5kAve2QOUZbFgL/HDnWFknipSx6yaOZa/nOZgluA9yQEIiczL39iOE9ZGtW3F6A
yCdlhR33eAiteaOEqogJTQT8cvcFLBghOM825K/M3NdL5OTgplNqPu9wpWFKULam
8JuxvufYQJdj8PWuxUb2wtb0nURHcMIhxJOF5Ux0F8tjAbKNEzVh1xyb36fZ9337
OraQao6jBfNcjLeBcMOK0GHH/HF7xhdEdy/hXNqmPzfBY3XNSkshb1p2D2IcgQ7L
9UdOiR4zxfkhlr6oOtPB
=LEzz
-----END PGP SIGNATURE-----

--+k4Drb7WGefOwc9B--

--===============8152411382025399904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8152411382025399904==--
