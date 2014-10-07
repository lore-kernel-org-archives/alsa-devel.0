From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: imx-es8328: Fix missing return
 code in imx_es8328_probe()
Date: Tue, 7 Oct 2014 18:10:41 +0100
Message-ID: <20141007171041.GN4609@sirena.org.uk>
References: <1412698794-25536-1-git-send-email-tiwai@suse.de>
 <1412698794-25536-5-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5693877824767674761=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 457A42605AE
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 19:10:53 +0200 (CEST)
In-Reply-To: <1412698794-25536-5-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5693877824767674761==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6AFz5yWxU/FsGPwt"
Content-Disposition: inline


--6AFz5yWxU/FsGPwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 07, 2014 at 06:19:54PM +0200, Takashi Iwai wrote:
> An error code was forgotten to be passed in the error path of
> imx_es8328_probe().

Applied, thanks.

--6AFz5yWxU/FsGPwt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNB6QAAoJECTWi3JdVIfQT54H+wTwEpVMUY5HogdAT0usu68O
OQ+MbCgTeLsNiTMCgfHhgNZHhxooNI9xt9mOFfzUrDDsXYtMeLo3+f1MjzMKzSrL
j4oTbgunRt78nVGUOWZ6KvtUDZpgGkbVPRl8vd0W2LhM0kNGeOZjh3mKofyMo1PX
KG3zVreXv1BLPS1x37P2P7by/9l1ep05IxadA0rajXe6GSSco32t7GyQmvu0gk4I
xXkaowy32Hqln0LDzSEYD4LvFPd6hfAfynik59WoaxPhVKo0DDNE8FpagxlEqL6e
82PlvaKFuFNN7tliFavkqaE30L1Y3leJxs2OKsTq84G7vwXtCrXAdiNyub+3MUM=
=s4s6
-----END PGP SIGNATURE-----

--6AFz5yWxU/FsGPwt--

--===============5693877824767674761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5693877824767674761==--
