From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-dmic: Correct functional clock
	name
Date: Sat, 27 Oct 2012 23:01:58 +0100
Message-ID: <20121027220155.GJ4564@opensource.wolfsonmicro.com>
References: <1351247588-30500-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7969848106697544208=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 821C826522E
 for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2012 00:02:01 +0200 (CEST)
In-Reply-To: <1351247588-30500-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7969848106697544208==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cEobB2knsyc5ebfU"
Content-Disposition: inline


--cEobB2knsyc5ebfU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 26, 2012 at 12:33:08PM +0200, Peter Ujfalusi wrote:

> Would it be possible to send this patch for 3.7 as a fix?
> The DMIC driver works withoput this patch but we ask for the functional clock
> using the wrong name.

So, this has no practical effect but we should fix it for the next
release...?   I've applied it as a fix but better motivation would help
for things like this.

--cEobB2knsyc5ebfU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjFmyAAoJELSic+t+oim94hgP/12wuS8FzSNvNnC63Dptlbqz
ZGlTpLud3rJzIgTb6jM3begqgZpVaXktC5Kw2up8cJo5KJIsRPAxPntFyugOWxBV
SLb4YzJzjytYfIfpm5Uzg4U7yoFrKHuA7OhsV5KiDoWCVW4m0d6ORsJ54qFcWopo
mA5ML2mGEa44aaAJaSx8S6z/r7QcfLtuxSl+sRBQRke/Zp/EDw2up3VFoZ8Rd5rN
tmGmeptQ/NpHaABc2JN8NcwSLyANuPK+cNBInLkTGEGIvagsFlYMMPcCtW8Q+INv
IfWLUWUwLlxkCrsRzBqVLov1MJAbXl7rk6tqt5mcgVuC4K1rHPxk4JcvLQC1qr6I
AfJBiFlTKiErekqHKhdd6Xvx3V3erNu59+8IpnsTfevcF3SrhUWDB7DGxyNoCJTh
gYvmaVMPbomeNxQyoORNCMvNqdU0TTjYSFMK+sDMpgX4UKmc6Qi1pLgkVSGsYWV3
poHGUIjn60P4XRNOi0yglwOxr1Vp9VUD77Jan7mExT6V6dWuttOFk3lhFDb/+EKI
MuyBDrXbBDUXh22CS0etc1we531ezgjwcxLfFubXPCjFwhLoZsYNzjDgsA3L18cC
kKhajXROzDkCrZRuNdjHVqKtz4w2E8KBX30jU9SPZRLgHz37wylQwc6hi/gQL90I
WP0YJZXhG88QlyqL1O1t
=oogp
-----END PGP SIGNATURE-----

--cEobB2knsyc5ebfU--

--===============7969848106697544208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7969848106697544208==--
