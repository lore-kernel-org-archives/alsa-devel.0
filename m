From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 4/4] ASoC: rockchip: i2s: fixup clk div
Date: Tue, 13 Jun 2017 21:48:51 +0100
Message-ID: <20170613204851.devutejizfbroeao@sirena.org.uk>
References: <1496998369-30556-1-git-send-email-sugar.zhang@rock-chips.com>
 <1496998369-30556-5-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6543296030933368512=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66FA7266FD1
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 22:49:01 +0200 (CEST)
In-Reply-To: <1496998369-30556-5-git-send-email-sugar.zhang@rock-chips.com>
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
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6543296030933368512==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mj66cy2qqkiq6hav"
Content-Disposition: inline


--mj66cy2qqkiq6hav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2017 at 04:52:49PM +0800, Sugar Zhang wrote:
> we found mclk maybe not precise as required because of PLL,
> but it still can be used and no side effect. for example, if we
> require mclk 11289600, but get 11289598, it doesn't matter.
> so using DIV_ROUND_CLOSEST to fix it.

This is fine but seems to depend on patch 2.

--mj66cy2qqkiq6hav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllAT7IACgkQJNaLcl1U
h9BYtAgAg6doVgDKpLy5DlYemAq0FbOuPB0CXBoMzFYrvRGPOlEVfR2ZyZgbtYKp
IFaTYFg3dC0j3AQahz36ldwkCiTPaJg3GMB7lmhmVdogG/SEvFxvIAUXpCMz/hoA
1gmvfjkDJH0oiFjpG6bGTsNG+ZVKOVsJwHHV+XUSf7eVT4xOO8CpkU4i28NNYRRX
qzdD3pwufCHrSFEWDnya666+WE6akL+pQY58+8Tko+3sfAEQw1o6jciLlkHdcMlu
6wS6QiAtjtXUkVneQGGyrOIBEu8+ZPiX4kNlV5KjbPuwIxpnzBx/+Jh+KmsSsgKE
vqtOjZEJ16dQ7q49BK9PhuNceAL1Cw==
=7ANq
-----END PGP SIGNATURE-----

--mj66cy2qqkiq6hav--

--===============6543296030933368512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6543296030933368512==--
