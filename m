From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Skip suspending widgets with
	ignore flag
Date: Mon, 21 Jan 2019 17:51:21 +0000
Message-ID: <20190121175121.GD12679@sirena.org.uk>
References: <20190121144818.23042-1-qq282012236@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5670515825362484585=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 95A4E2667E7
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2019 18:51:24 +0100 (CET)
In-Reply-To: <20190121144818.23042-1-qq282012236@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zhiwei Jiang <qq282012236@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5670515825362484585==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DiL7RhKs8rK9YGuF"
Content-Disposition: inline


--DiL7RhKs8rK9YGuF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 21, 2019 at 10:48:18PM +0800, Zhiwei Jiang wrote:
> For endpoint wigdets which have set the suspend ignore flag, asoc
> shouldn't mark them as dirty when ASoC suspend function is called.

Why not?  It will cost us a bit of time confirming that they should be
kept enabled if they're part of a valid path but it also ensures that
we've reexamined everything which is a bit safer.

--DiL7RhKs8rK9YGuF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxGBpgACgkQJNaLcl1U
h9DkLQf+OKqsK1Zua2jcDdEyreppTKhTWLVu+w9YS/unkWuW/zLRj+Z82nDuK0G+
F5Xr+9jU5VKKjNq3582PUQuG0yj1q7gkSfFCz8Ylv9PWZgXDSUAdhAUpExtIVBcB
EWONC1kQrRiCcf+gMz22SNtdiJsT6SNHEXx11Y7W96OxU6d1IFbvreMcs7RehyHE
3jvLZIVIABBHxpIfVAi3GtGnI9rEZMJZ/Jw53XnuZEOF0hgNSlbqVsxnh6mFdyuL
m7PbcbnyZKlAKX2w4XOsST2b2b7gU8jZA6sW5zaYT/4BsA/fdsYCokfJ7Ahg24x5
z0Eoqw1c+S4AS5jnErevpNM5WXc3Hg==
=MD7S
-----END PGP SIGNATURE-----

--DiL7RhKs8rK9YGuF--

--===============5670515825362484585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5670515825362484585==--
