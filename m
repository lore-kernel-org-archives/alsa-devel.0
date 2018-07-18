From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: AMD: Add an always on fixed 1.8V
 regulator for da7219 VDDIO
Date: Wed, 18 Jul 2018 11:46:15 +0100
Message-ID: <20180718104615.GC5700@sirena.org.uk>
References: <20180718004909.213735-1-djkurtz@chromium.org>
 <20180718004909.213735-3-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0095705609366895711=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6211426720C
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 12:46:41 +0200 (CEST)
In-Reply-To: <20180718004909.213735-3-djkurtz@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Jimmy Cheng-Yi Chiang <cychiang@google.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Dylan Reid <dgreid@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============0095705609366895711==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2018 at 06:49:09PM -0600, Daniel Kurtz wrote:
> From: Akshu Agrawal <akshu.agrawal@amd.com>
>=20
> DA7219's VDDIO for our platform need to be configured for 1.8V.
> Hence we register a fixed 1.8V voltage regulator in the machine driver.
>=20
> Change-Id: I65fd93e1dd37c3e0d38265b4b1492ea53b93afd4

Again, please don't include noise like this in upstream submissions.

> +++ b/sound/soc/amd/Kconfig
> @@ -8,6 +8,7 @@ config SND_SOC_AMD_CZ_DA7219MX98357_MACH
>  	select SND_SOC_DA7219
>  	select SND_SOC_MAX98357A
>  	select SND_SOC_ADAU7002
> +	select REGULATOR
>  	depends on SND_SOC_AMD_ACP && I2C

This seems inappropriate, I'd expect a dependency and if it were to stay
a select it's also not selecting all the bits required to make this do
something useful. =20

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltPGncACgkQJNaLcl1U
h9Ax3wf+OAx7UIiqmrElA100Ap6YDd6dACXNEzEP00mPEvtwj5TWnHpw2556Ty01
9j8kG8q+QMRZg10mcsyKCWcykd7QGGmw4ukfVLBVdeGfCLrACke+Zs7ibfy3wPYp
9RBUzz5zPpTiOWiNGHjIGRtXLlvbvsZ04Q3FGzNuwEsawofbQM9vFiPTWC86VxuG
Zy6nAbqYxr3Uy3PCnc5UpuEjm1szw5z6X1MxGxYySCpolsGs/PThR9hBnA8l3qnX
tmqPE724lwcnC6rmV5lo/NF/qCBmVLVEzK2ZwxKqtMG5bN7PnD2uktz5SK8DFOo6
spMl0f7cU6O64mgRLcReACzmaq//+g==
=79H6
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--

--===============0095705609366895711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0095705609366895711==--
