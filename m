From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
Date: Tue, 7 Jun 2016 00:50:26 +0100
Message-ID: <20160606235026.GP7510@sirena.org.uk>
References: <1464267742-15312-1-git-send-email-zhengxing@rock-chips.com>
 <20160601144542.GA3835@rob-hp-laptop>
 <5751912C.6080904@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8G1nIWD3RY794FAy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5751912C.6080904@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xing Zheng <zhengxing@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, linux-rockchip@lists.infradead.org, dianders@chromium.org, heiko@sntech.de, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--8G1nIWD3RY794FAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 03, 2016 at 10:16:12PM +0800, Xing Zheng wrote:

> I refered to MTK's mt8173-rt5650-rt5514.txt on upstream, that compatible
> name is "mediatek,mt8173-rt5650-rt5514".
> Because our platform need to support 3 codecs (max98357a / da7219 / rt5514).
> Perhaps, you maybe feel that name is too long? And, could you please tell me
> what names would be better?

> For example: "rk3399-composite-codecs" ?

It should probably be three compatibles, one per CODEC, if the driver
needs to handle each separately.

--8G1nIWD3RY794FAy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVgxBAAoJECTWi3JdVIfQ5igH/jnLX9QnvgwFxKK8BdX/+PAY
1I5XTG+mUzb1nTvkzdDjlJgveR2i3vvKComkPcWheEJvJlydsEwYu7jm9UHhXxf0
osExbR9R9nlflVNRVNfFgalNjR2aZ39Xh2SuQrH/uTpVlNWm/FGn55sAwuSkxj3C
EHTErkoDFWUWlrkxll2q3AN8uax16EUKvwfAnr1tWUzq08zu3OwlRmmX/WUHkt4z
dxCdAE7XAotvNoIYBJ+8NrZEcMkOVS/EQcctMFBgcgJyvfyI+rOT4Ue2APopDEq3
FfqYsARth8gr+TN1NjrqL8uroXa34Xj/IRJo65uVw8txvDkxstnjGVwtASrPzoE=
=Qv6x
-----END PGP SIGNATURE-----

--8G1nIWD3RY794FAy--
