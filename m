From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ak4642: fixup: mute needs +1 step
Date: Thu, 5 Apr 2012 11:10:29 +0100
Message-ID: <20120405101028.GI3129@opensource.wolfsonmicro.com>
References: <87ty0y4rrm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7583790058960284470=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C8B69246C6
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Apr 2012 12:10:33 +0200 (CEST)
In-Reply-To: <87ty0y4rrm.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7583790058960284470==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BghK6+krpKHjj+jk"
Content-Disposition: inline


--BghK6+krpKHjj+jk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 04, 2012 at 11:28:01PM -0700, Kuninori Morimoto wrote:
> ak4642 out_tlv is +12.0dB to -115.0 dB, and it supports mute.
> But current settings didn't care +1 step for mute.
> This patch adds it

Applied, thanks.

--BghK6+krpKHjj+jk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPfW9mAAoJEBus8iNuMP3dU/8P/RXMtvifdAimiq7knTZqYbze
DHLKT30BGHICgRNCU8TqiqmzW+XYrjBSxt7vUGQzgr1FNumFuiA/f2e6Bqm3dkOB
mUFn7EVWpgDPi7P/pzSyZhQ4oIv1v80SmEziI168AJOoxl45qEYuTBTkb1pXJjG8
jjR3DRoQTSsIqsIfE6j7ZYbb9tbSFrp+7iADx/H3va0fyJARsBUqk/A354s4YGPI
N0SEQxAKt72sPAEd3mEOlbhALBMcXlyYUegFKAf1oVQHKe9maXjNrma4Sz6cfPhS
oYeSLvqiOXL+WtywT5LYCUNGxEwlCfAgYhQTCoZaKVUB03ganErsAAnldf+82KPe
FTH5cUq21w3KNOaQOO5DlIdBDULlfFZg9o8fofGtYcEHRygnH8pBsWL5SDkwjjDW
/R9B1Dk8ez09EjmofQy9Wc4vkB4XBMAaYJZDhlnk7+dO1DLh5P9QRHhn+RMRTrvv
I3R/LAHgFiOm3zaRQYJ2uwgCbMIo5SNEpOaufYcAqM3Z6V1VQxf2L33Xmx5eJ7Z4
sqBQdfyQsuJlNTG0FER2rsfJcg9CUxuSYCPfX3jGwkx+Pl9+Rz/oNP1MY43UFue8
TVHiGJWSNrz80CK5fLJeT3JpmiMvI85MtF/PpC3RnHlSw5O86AqmKQTYREi3ZyzW
RV8QJ93xBXPmf/ZzTEc3
=1QQ5
-----END PGP SIGNATURE-----

--BghK6+krpKHjj+jk--

--===============7583790058960284470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7583790058960284470==--
