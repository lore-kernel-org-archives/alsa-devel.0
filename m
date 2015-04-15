From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Remove invalid kfree of devm
	allocated data
Date: Wed, 15 Apr 2015 17:06:41 +0100
Message-ID: <20150415160641.GS6023@sirena.org.uk>
References: <1428906054-17613-1-git-send-email-yao.jin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4154378330096937792=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 983AE26068F
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2015 18:06:48 +0200 (CEST)
In-Reply-To: <1428906054-17613-1-git-send-email-yao.jin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jin Yao <yao.jin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4154378330096937792==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jCFHehOgqNONBRSt"
Content-Disposition: inline


--jCFHehOgqNONBRSt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2015 at 02:20:54PM +0800, Jin Yao wrote:
> kbuild robot reports following warning:
> "sound/soc/intel/haswell/sst-haswell-ipc.c:2204:1-6:
>  WARNING: invalid free of devm_ allocated data"

Appied, thanks.

--jCFHehOgqNONBRSt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVLoyQAAoJECTWi3JdVIfQzrEH/2CKfQBKgf4qi6Crjr5C75l+
QE9EAXo/KqByFOKSnheNfZR9FpdtDzgSd0iVnbO5n51qVEBxcw46w9D/iczdlS2J
IAZpXSB+htKDm2MvjTCdBQ0mKYEVdOQ+YFATxILQ1glbGNjMe2yr7//F68z5VziB
mTYbPS+7hDrUxEpAbzM18IFYgxmyQ+7lv+XicE/MXKSN/poVDTlCFBzYRmj2va66
Cq7iRQLceS34tPzQOADDspuJB0kL9wGuzY/VidtE2Dpr0bVZu2anatWdOWwgx9KU
3KfaYe34XQfhTQmIuVm8vTJ/wEHS3Z28Q4wdXpajrTJd3ET0kbV7zvoqXWQ/WVM=
=axRv
-----END PGP SIGNATURE-----

--jCFHehOgqNONBRSt--

--===============4154378330096937792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4154378330096937792==--
