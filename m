From: Mark Brown <broonie@kernel.org>
Subject: Re: Can we remove the rtd_aux for the aux_devs?
Date: Tue, 22 Dec 2015 23:56:22 +0000
Message-ID: <20151222235622.GD16023@sirena.org.uk>
References: <bb343fe20b14af90f695939d8faae50fae1ba97a.1449036307.git.mengdong.lin@linux.intel.com>
 <20151208185817.GX5727@sirena.org.uk>
 <5667EFCB.3010402@linux.intel.com>
 <20151209203836.GI5727@sirena.org.uk>
 <56694E6A.4090402@linux.intel.com>
 <20151211202208.GS5727@sirena.org.uk>
 <566FC9F6.8050107@linux.intel.com>
 <20151215112324.GX5727@sirena.org.uk>
 <567121DC.5080601@linux.intel.com>
 <5679069E.6070106@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1564108795081129814=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BCE91265D83
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 00:56:29 +0100 (CET)
In-Reply-To: <5679069E.6070106@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1564108795081129814==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
Content-Disposition: inline


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 22, 2015 at 04:15:26PM +0800, Mengdong Lin wrote:
> Revise the subject.

> Could someone clarify if the rtd_aux in struct snd_soc_card is still needed?

> We want to replace the aux_dev by aux_component.

because...?

> If the rtd_aux is no longer needed, we can remove the array and it will
> become easier to handle an aux_dev as a generic component.

We are still using it in the core but nothing outside the core appears
to be using it.

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWeeMmAAoJECTWi3JdVIfQaicH+gJTmB0TzyPBrHTERFpYcESl
6BKpP8akqcpGtwzx80h96FETtBP3cxb63qOARzGdBT/fBzeiV1UEq7pn8RPepsF+
pwNY8VO3xos7MXu66c8VlMt+GOjl5tx2ENSiN2Jwq6HqwBbrk8VfBkw4UHXDhOdK
7OO5dG7m/DYZincSwV/746MfC6tpbkIeMGC/tceDu0s5VUfjqhppRS2KYD97iV1O
ygtiu61umSLrCgriMaFrn8JYr340NTxFVkyeQS2LgRvivDNRnUrY3tnSi2erY9Qt
/o4eKJlxWCacTi37jGK2yg/qTeme+mqhZRs+RGZd1Kg5BHfNJqehdwftOaZKvro=
=4Inh
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--

--===============1564108795081129814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1564108795081129814==--
