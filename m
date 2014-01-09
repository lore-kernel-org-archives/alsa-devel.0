From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH -next] ASoC: fsl-ssi: Add missing
 clk_disable_unprepare() on error in fsl_ssi_probe()
Date: Thu, 9 Jan 2014 17:26:16 +0000
Message-ID: <20140109172616.GE12858@sirena.org.uk>
References: <CAPgLHd-wvDcOz1Ne69g3o4b=VS7jaPU5Gu4DBMq_tBCsY0xcew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6895788220663843955=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B61C261AC4
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 18:26:32 +0100 (CET)
In-Reply-To: <CAPgLHd-wvDcOz1Ne69g3o4b=VS7jaPU5Gu4DBMq_tBCsY0xcew@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, timur@tabi.org, yongjun_wei@trendmicro.com.cn, robh+dt@kernel.org, grant.likely@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============6895788220663843955==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OZkY3AIuv2LYvjdk"
Content-Disposition: inline


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 09, 2014 at 10:27:31PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Add the missing clk_disable_unprepare() before return from
> fsl_ssi_probe() in the request irq error handling case.

Applied, thanks.

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSztu1AAoJELSic+t+oim9SboP/2N382yLVNGVIHJpJOstw04+
CYdHYXBLq8W1jBEklDhyppTm5fXSYymPeWrgL7T5cBnF19ODkxvxHrSKal73Bus5
zkk5uuo5ahn3YDsd1/a2OuhWDfD4Xya2/g8osgRaUvjbZbfanFpA+1N0kbNVgq7O
w1uvF4VtuHs2BwYDX3I3KU7UGg7e8z37aw2XqhWk05wdYousZLI4+5JJ4c+giKI3
sfJtyyIib0iSi5oZnIH3leoq9RsTDZS1E3uJvmtWUo5oboUtox0ZHAcEptgc/Icq
q6MjiUdjtETDGHRCTqX3r8NAMpVQm9fq5bCydBy9f3CRrRorRapATA/jvN2J6tGo
ZdxIGvwlnQETa3E/8MlrDQ8dUeEtk/xZmum6fVtDCp7FfQRHoMe+AkWGED99pdY8
GaY2MdlY6iL5ljHwltUlyCbaHb1wa63Xq7XrocSueJKwWKjCnx+zgYZhjoikIfdR
h7nMyTshUZhb/Et57a8jdTHtl3JNpT+MT8EO5d8Ly9oTAk3DsQKbOCUsZNQM6glz
f0j9SbsH+gU8tKqPYnQD2xYMU65otncEY83Lqctrls6Q7OU4NKeoNSRjmb45xYfV
11ZmHmBXkFOy6+Rayii7iH+9KpO7LQ3MCtv4eZ73TrGa3/IeCKIJpqcIihENZYXq
nAZsMLbu1ceVAJM43ZtC
=jglI
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--

--===============6895788220663843955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6895788220663843955==--
