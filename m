From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 2/5] regmap: Use regcache_mark_dirty() to indicate
 power loss or reset
Date: Wed, 6 May 2015 13:01:57 +0100
Message-ID: <20150506120157.GO22845@sirena.org.uk>
References: <1430864057-3848-1-git-send-email-cernekee@chromium.org>
 <1430864057-3848-3-git-send-email-cernekee@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hyMn90umCa8PZGeI"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430864057-3848-3-git-send-email-cernekee@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: lgirdwood@gmail.com, lars@metafoo.de, dgreid@chromium.org, abrestic@chromium.org, olofj@chromium.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--hyMn90umCa8PZGeI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 03:14:14PM -0700, Kevin Cernekee wrote:
> Existing regmap users call regcache_mark_dirty() as part of the
> suspend/resume sequence, to tell regcache that non-default values need to
> be resynced post-resume.  Add an internal "no_sync_defaults" regmap flag
> to remember this state, so that regcache_sync() can differentiate between
> these two cases:

Applied, thanks.

--hyMn90umCa8PZGeI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSgK0AAoJECTWi3JdVIfQAqkH/2y3hwLyh+0HaVJNVJ7/pH+U
aLY+IVe8Ar8eaqSKi6NNO5T+w0DTF8opBPriGszWKNy+Uwo/ZkXSedE7r1nyluKV
te7WzMICBweVPvuznJPkkdLWPPHORIqhfydt0GYgjlqha3c/u2gxotqQLHKIXZQ+
p2AJ6Zih7TtfEUIntStYrigrX4vc/dIJcV/FP1Fc0gskEtXoQQy6r0m65TonPZTm
PgvcyuJd9HP4MPmX+51u5R07qyVMSZj0JwuEEwdFBVT4qBvDiKyaT0Q1BgRQ91aN
m86HdtkZtyW/7GqB36XKZCL4P6qWtBVTkBIIO94j5Zqij+m0xlVaA5CX7CVWpLc=
=MFvg
-----END PGP SIGNATURE-----

--hyMn90umCa8PZGeI--
