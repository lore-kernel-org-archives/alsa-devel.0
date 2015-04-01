From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: omap-hdmi-audio: No not use
 IEC958_AES1_PRO_MODE_NOTID
Date: Wed, 1 Apr 2015 21:29:47 +0100
Message-ID: <20150401202947.GE6023@sirena.org.uk>
References: <1427909757-19483-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1938440173894512656=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 49FF626512B
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 22:29:56 +0200 (CEST)
In-Reply-To: <1427909757-19483-1-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, tomi.valkeinen@ti.com, linux@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org


--===============1938440173894512656==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 01, 2015 at 08:35:57PM +0300, Jyri Sarha wrote:
> No IEC958_AES?_PRO_* macros should be used in HDMI consumer audio mode
> and IEC958_AES1_PRO_MODE_NOTID should be applied to byte 1 when
> applicable. However IEC958_AES1_PRO_MODE_NOTID is defined as 0 so this
> fix does not affect the functionality in any way.

Applied, thanks.

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVHFU6AAoJECTWi3JdVIfQz/oH/RZgMGi95grvAolma7j6SX/B
uoxQpBhLhEMbVWUC+q2tkJemu8JFsu3O79fhyEfqo1pdybkt6TfcPdS3klD5wbbK
kTFf68VpppunVsNicDINOElNwA6KU2vy62qC9TEvJQpUsBXeJD7mTFn/3OX/o888
ZniIt+Y2qZczEzU+tyMfbIXgCcY0mncxtunkbw88aUgBo8gh0rjkQjjQg+6ik2gl
Hc1dKJSLBICyD5fitzpxpFA/P8WZhlZEWsEL7TyBMYnIX2/uJeL4dh99SqzGeWU1
ofgq276bHEYhgYH1gyGocH1v5fPTRn2gMucrLgQr6qefPZsKN4yCmoTocSsQoCU=
=Ogwf
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--

--===============1938440173894512656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1938440173894512656==--
