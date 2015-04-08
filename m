From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: max98090: add shutdown callback for max98090
Date: Wed, 8 Apr 2015 18:09:49 +0100
Message-ID: <20150408170949.GD6023@sirena.org.uk>
References: <1428491156-31803-1-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lhTn81PdljI0Ow1Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428491156-31803-1-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Sonny Rao <sonnyrao@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>, Heiko Stuebner <heiko@sntech.de>, zhengxing <zhengxing@rock-chips.com>, "jay.xu" <xjq@rock-chips.com>, devicetree@vger.kernel.org, dianders@chromium.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Dylan Reid <dgreid@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Tushar Behera <tushar.b@samsung.com>
List-Id: alsa-devel@alsa-project.org


--lhTn81PdljI0Ow1Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2015 at 07:05:56PM +0800, Caesar Wang wrote:
> To fix pop noise when shutdown,the pop noise during shutdown
> is the pmic cutoff power of codec without any notice.

Applied, thanks. =20

Please do make an effort to only send patches to relevant people -
sending people patches that aren't relevant to them adds to the volume
of mail they have to handle which can get in the way of things that need
the attention.  For example I'm not sure why the dri-devel list is on
this.

--lhTn81PdljI0Ow1Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJWDcAAoJECTWi3JdVIfQ/koH/0A7PCAJzUFqyXCFJGmSW7rc
RtnFQxwEonURGpx4Tli4P81w4fsuS6bo49/bTIArusBN/dKPDv/RqOIvXjZKb75C
BdGGO/kXGwXyYDRoO2uTQ4+qdbz+o8uA7k8TQ4QjO1MvA+XPENWuxqvA7d4Jm57d
gSD2ZXEiSq4tJSCgwKCISEKMA4NfrqO0NjMCUSHAgEetALqMSvrwrZ9r628v/qkX
nsbSCHgM7vq0rqOaFfoUG/aumgNnQB699vJqqyVflAf0m0tI5QRdKO3zcYZDXPgO
1K0FuwPCvOU6+c2somT7iZ85FhCr1IOroRbOsRiKGT3fIELmoQGnGJfwhJYX6Do=
=dQda
-----END PGP SIGNATURE-----

--lhTn81PdljI0Ow1Z--
