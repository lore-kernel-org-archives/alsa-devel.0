From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/11] ASoC: SOF: Add driver debug support.
Date: Mon, 23 Jul 2018 20:03:23 +0100
Message-ID: <20180723190323.GK13981@sirena.org.uk>
References: <20180719185335.30912-1-liam.r.girdwood@linux.intel.com>
 <20180719185335.30912-3-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1740394962015355806=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3593C2675FC
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 21:03:24 +0200 (CEST)
In-Reply-To: <20180719185335.30912-3-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1740394962015355806==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ed/6oDxOLijJh8b0"
Content-Disposition: inline


--ed/6oDxOLijJh8b0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 19, 2018 at 07:53:27PM +0100, Liam Girdwood wrote:

> +	/* copy from DSP MMIO */
> +	pm_runtime_get(sdev->dev);
> +	memcpy_fromio(buf,  dfse->buf + pos, size);
> +	pm_runtime_put(sdev->dev);

Doesn't this need to be a _get_sync()?

--ed/6oDxOLijJh8b0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltWJnoACgkQJNaLcl1U
h9C6CQf7BRREO9XXGQhcUGNMPwQEMK7/5yEsqQU6R8bYbATEApBoM7IH/q8vTPBq
6Ko151Zyeve+sA0CuYjh7WuPnyq6BKswmDHFPdHyPc2rWoCUBPt8WzBZjgfE0r0v
QGHxJQiFq9acxNsVio1Hs3/TOx+6DNbDGF+anjOvG1xF+48Dzzzu74F4NdXmzLum
DWntpqHQorqA/8OL6iDupIk2Akptp+YfyIrlzUqYJ7/MDK8mTnE0TFXsE/il9eqT
49Mw1ya5QkYN7Ife42MV88Q4e53Opk4jHI2TQuCyhMqeD2uQy0z8gOFzKj52R05B
CiEHx+PB0iaFRNlmo9GqJFqV9gokvA==
=UwzJ
-----END PGP SIGNATURE-----

--ed/6oDxOLijJh8b0--

--===============1740394962015355806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1740394962015355806==--
