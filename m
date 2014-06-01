From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cache: Fix possible ZERO_SIZE_PTR
 pointer dereferencing error.
Date: Sun, 1 Jun 2014 20:02:30 +0100
Message-ID: <20140601190230.GN5099@sirena.org.uk>
References: <1400488329-31702-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1310302351782128633=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BBF742608D3
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 21:02:51 +0200 (CEST)
In-Reply-To: <1400488329-31702-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1310302351782128633==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Mqntr8YLmpnm4ZyH"
Content-Disposition: inline


--Mqntr8YLmpnm4ZyH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 19, 2014 at 04:32:09PM +0800, Xiubo Li wrote:
> Since we cannot make sure the 'reg_size' will always be none zero here,
> and then if 'reg_size' equals to zero, the kzalloc() will return ZERO_SIZE_PTR,
> which equals to ((void *)16).

Applied, thanks.

--Mqntr8YLmpnm4ZyH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTi3jCAAoJELSic+t+oim96i8QAI0jxnbsNw9kfrEqGmRUSRat
A6y6ol98ZhaBQhTpnMmnpvDXBXC4+mPVg+zYTJXOKZV4zAdUkdOETfoKoJoVF8s7
bzzfmktir3OBtE/It+qyrMt78l0F9OP/Dj7RRDNDPNsid/ip6eYS427HJqu25wEx
yvIN95Qbr3/j2lJWgjM56t9uaka4PFCrfB7SoAisBz/p2qszQnbHs9fl/N9Q3Eca
36hqtjqNfUf9uD//tG3xSVVOW3191MQrDii15PUBhEZXqoyzneTeIWEh658OB49o
oaXh30DBHh4UwIu2GVjP6mbnruqKUlBYiyIsTLOpnAZtecQyPsbbPY94si8cx9x4
4mm1Q/6SHbHVOz4e/FW61ebaDDPr5FZh67i37GFYuKWeJcuGkVplHI3zg0Vn/6rM
EylHalrTJarHt18Ins4IAHdkJsdxZ5HCh/9vtlbz3A6n/Dyz0xgWBF+tk4caRlRA
+Wcq1mhyvqLPw22Aio031RxzmmCt4OoAKK78JNr6cvQwSQj+adI7WNgWqIQjhI3V
/5JcDFBnocTd+xjljdaiOR5bTzZ4tOxDJ5lilBFMLO8dAIeoQXNmou3oy0FirfsO
SBQJmpdTCEKDyrjqDelFXKYo1VyE7Lo3eNvx8u/z0yD9udNUFlIgMFnRXoY9uG+x
lh2ieF+gK9bZrsB8WC1y
=r/4P
-----END PGP SIGNATURE-----

--Mqntr8YLmpnm4ZyH--

--===============1310302351782128633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1310302351782128633==--
