From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V4 3/5] ASoC: tas571x: Add DT binding document
Date: Wed, 6 May 2015 00:01:43 +0100
Message-ID: <20150505230143.GQ15510@sirena.org.uk>
References: <1430864057-3848-1-git-send-email-cernekee@chromium.org>
 <1430864057-3848-4-git-send-email-cernekee@chromium.org>
 <20150505223230.GL15510@sirena.org.uk>
 <CAJzqFtaRd7GN6af=7jZSh01mL04XBFYE5cGfHY9V=p7uKFwf_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oo0YFrdPmwHtbsRF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJzqFtaRd7GN6af=7jZSh01mL04XBFYE5cGfHY9V=p7uKFwf_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--oo0YFrdPmwHtbsRF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 03:56:09PM -0700, Kevin Cernekee wrote:

> Note that the regcache changes were intentionally ordered before the
> tas571x commits, because the regcache changes are needed for the new
> driver to work correctly.  In the for-next branch I see the tas571x
> commits, but not the regcache changes.

That's fine, there's no actual code dependency and the regmap git tree
is separate to the ASoC git tree.  It's not like there's an existing
driver we'd be breaking the bisection for.

--oo0YFrdPmwHtbsRF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVSUvUAAoJELSic+t+oim9xV4P/0CJhgaA9jBugOKHYGEfNuX1
zshMBE6n3VZ5dxtc3V59PTFn/ZZtmSeDbzrapW2/zB3g+WfKQsclsirrtLTcwEYZ
LNd2Mw1E/6pZJegq9vjeUXbi5RAbZlrfv3D6VZwaHQLqP8RUsVENdZGtqpFPqHWp
KQ4SlPOrF1UB3+ohfpbOTNyMziUO67ouC9rP/DmDaiFCppGBjrZmWMSjDadU3TMq
JI09W2ZLnrnZ58lSQWNIVT+b9ugvNZ/Z/6ZVZA7q57XyikVinJzeV0lcgIbOljFN
Ysf1sKvPp1nlqQ2S5MirJ6W9G7xwLAaXvCGymmVgT/SI68d9uKKHo7VDUixsZbY0
XfyspRsMp9e/hqQO6i1z5Q/DT/J43Ji5faiC+DTZ/f3dgcDiPUM8t/qt4f0VxPLg
QDz/I0hULuWt+OP3Uhj3EqJoUjRNBR1aFEvIsJOZgtdVaKNorew2I+I1AD8ZVkZd
Gm+aEXU4S3kRMdMeV97s0QupZUd1iQ4pu8HRa+hjaAax8uNo1HYT2QVaFC3W2bqD
t5s2RdPZqu05VBS4N2OPuWDqlaOp8zKr0MqpC+gvCY/wl+r4IF4L3YiRJ0fjCKqz
/iwxnHi9d5FvGIj6V/1U9Lumcu8Gyaa+QlG2ebzFE/0R4RcRSquur3pT8FsqrA0I
PnL5JgR3B1+xmAMXy8zl
=E7vq
-----END PGP SIGNATURE-----

--oo0YFrdPmwHtbsRF--
