From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] Documentation: DT bindings:
 rockchip-i2s: add capture and lrck-mode
Date: Wed, 23 Sep 2015 09:20:26 -0700
Message-ID: <20150923162026.GP30445@sirena.org.uk>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
 <1442979683-9441-3-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8114742217671758921=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DF85260423
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 18:21:24 +0200 (CEST)
In-Reply-To: <1442979683-9441-3-git-send-email-sugar.zhang@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8114742217671758921==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jZ6LB7VX2Q2qroxd"
Content-Disposition: inline


--jZ6LB7VX2Q2qroxd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 23, 2015 at 11:41:23AM +0800, Sugar Zhang wrote:

> rockchip,lrck-mode: 0: rxtx separate, 1: tx share, 2: rx share.
> default use 'rxtx separate' mode.

I'm slightly confused about this property - is this covering differences
in the IP deployed on different SoCs or is it covering how the SoC is
wired into the board?  If it's for how the SoC is wired into the board
(ie, Rx and Tx wired together) then this should already be covered by
either the machine driver or the device at the other end of the link.

--jZ6LB7VX2Q2qroxd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWAtFKAAoJECTWi3JdVIfQDQ8H/R2lx+HhPy7PD62lJRDGDLRS
XIM8iOiAieazMDQCkLRhYOHMpVLsEfSSSRCmGdGG1q5HWhFn5p8KjQWDG13hYCmx
9YwRTfk52+2i/EnzpKHdssGz7pzisk3SB+WOuUKPPo5Z6672T8jwtssDeC960AI7
JepwtX63AXbGLKm8goE+Ilx3l0FivrdfXPF53hSXduBSoGEr0Yvzdh4iN1QHh2t5
K4XxU9OrvUf1WOvpOv8V1+7Oq19x5bQA+n2mo+Vr0kwdoOwLsg7jlnpJwUwk3ApW
OEcQ0IIvp03bwccCLf6YtwrILZ11Zjoq5EWahzy94wqLPWYJTEHso/jk+KM9eqY=
=JdgA
-----END PGP SIGNATURE-----

--jZ6LB7VX2Q2qroxd--

--===============8114742217671758921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8114742217671758921==--
