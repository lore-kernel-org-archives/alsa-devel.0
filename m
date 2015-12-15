From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: The soc card can have auxiliary
 components
Date: Tue, 15 Dec 2015 11:23:24 +0000
Message-ID: <20151215112324.GX5727@sirena.org.uk>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
 <bb343fe20b14af90f695939d8faae50fae1ba97a.1449036307.git.mengdong.lin@linux.intel.com>
 <20151208185817.GX5727@sirena.org.uk>
 <5667EFCB.3010402@linux.intel.com>
 <20151209203836.GI5727@sirena.org.uk>
 <56694E6A.4090402@linux.intel.com>
 <20151211202208.GS5727@sirena.org.uk>
 <566FC9F6.8050107@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8559612749718940348=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 33F16261A73
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 12:23:32 +0100 (CET)
In-Reply-To: <566FC9F6.8050107@linux.intel.com>
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


--===============8559612749718940348==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vJ/whQCgo58Oj3Wa"
Content-Disposition: inline


--vJ/whQCgo58Oj3Wa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 15, 2015 at 04:06:14PM +0800, Mengdong Lin wrote:

> I still have some basic questions:

> 1. What are the typical usages for aux_dev?
>    For CODEC<->CODEC link or external headset detection chip?

Neither, it's for analogue devices.

> 2. Why we need the rtd array 'rtd_aux' for the aux_devs?
>    If the codec has DAIs and used by a DAI link, the ASoC will create a rtd
> for the link.

There are (or were at the time) assumptions in drivers that there will
be a rtd there so it was easier to provide a stub.

--vJ/whQCgo58Oj3Wa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWb/grAAoJECTWi3JdVIfQHm8H/Rk7Z96HLoIJjDhOi5aWf90b
1+XkxXtElZsfv6c4K3zV9kl6sKj5i569U09Xc2djgX4HpQcmLZLI0np9xMJ7BZy0
21qlTRmGTP+/10N1z4gAX3w4E+s56ssMDswe+UoOvxSBKYOWlgvAUouQs2olvHuy
6sQeO3l2USMR61SkIXsOL5gS/zWF8sqgnyvYXJtlAqGSwlAj81fjyt1oHufr9PMO
A5ZpgjBjqmVAeSsNDKip8ONpYdbdMbVIwRgI2fSjilZS/t0QAhPZt1Gmvo1Sq0Z0
dsbEZL2J5WRkifFMH/zNpVMk7SazJt5sfiTY9NSOjRqvO8j91zqhdkS9ajKo0q4=
=ROtA
-----END PGP SIGNATURE-----

--vJ/whQCgo58Oj3Wa--

--===============8559612749718940348==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8559612749718940348==--
