From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rockchip-i2s: fix infinite loop in
 rockchip_snd_rxctrl
Date: Wed, 29 Oct 2014 10:17:42 +0000
Message-ID: <20141029101742.GV18557@sirena.org.uk>
References: <1414575951-18015-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x84QfImqOPbNdVFZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1414575951-18015-1-git-send-email-jay.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jianqun <jay.xu@rock-chips.com>
Cc: heiko@sntech.de, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, huangtao@rock-chips.com, cf@rock-chips.com
List-Id: alsa-devel@alsa-project.org


--x84QfImqOPbNdVFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2014 at 05:45:51PM +0800, Jianqun wrote:
> We can get into an infinite loop if the I2S_CLR register fails to
> clear due to a missing break statement, so add that.

Applied, thanks.

--x84QfImqOPbNdVFZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUL7FAAoJECTWi3JdVIfQoMoH/1wW6GG0nRiU3GTNI+EE2LMl
BCGvVVt99F0WXG9SjwF/BL2yQ2258hc4sFdUG+Kqkn8bSK8FS6vr2R9WqNpFyCcC
5KDzEhlUsVC9WYYI33+6UkTGICZKK5e6ozmsl6smsJYY9NjU66bCBbJnGRin2rPx
gPqUNvCiw5RRpGNtxNYn1rttA2INQ1jA9s/xdSc8aAvmzMwfALjM2FDosz6pCFK2
K9YMIB1q3jlr4d5R7/g6HsNfdemya4bV9krmPwxHGGuaDRULdAW7eXS0w+7wBb5c
MMzdpASrxDeVsa63CMHcSTCMlmG34yjugn9mohWuWEoF1ffSQw0dOPPQ/oG3weU=
=WC7P
-----END PGP SIGNATURE-----

--x84QfImqOPbNdVFZ--
