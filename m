From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
Date: Mon, 18 Apr 2016 18:22:03 +0100
Message-ID: <20160418172203.GL3217@sirena.org.uk>
References: <1460983419-7705-1-git-send-email-pc.liao@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M9YpAf2t6OxtMGzg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460983419-7705-1-git-send-email-pc.liao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: PC Liao <pc.liao@mediatek.com>
Cc: tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, koro.chen@mediatek.com
List-Id: alsa-devel@alsa-project.org


--M9YpAf2t6OxtMGzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2016 at 08:43:39PM +0800, PC Liao wrote:

> +Optional properties:
> +- sound-dai: audio codec dai on capture path
> +  <&rt5650 0> : Default setting. Connect rt5650 I2S1 for capture. (dai_name = rt5645-aif1)
> +  <&rt5650 1> : Connect rt5650 I2S2 for capture. (dai_name = rt5645-aif2)

Code-wise this seems fine but it seems like it'd be clearer to call this
capture-dai - this isn't used to select whatr's used for playback, only
for capture.

--M9YpAf2t6OxtMGzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFRe6AAoJECTWi3JdVIfQYDAH/3Rr8ayrnOah6lOydZET4rJg
Bb60VuNadIHr/ImPs8pifCWfR7Mt9WTyVTbYaKy2DnE4So43W1DZMOaomEvPnlAJ
kzd6F6q64u+lQ9eEqUXnYPLoad1t7yrfNqqAZmlhkpg8q6sntPgLPFwkCgy8O6e3
SSh5mjhwy6Uz3uBA25EyNs0ib7vajNKtRPqF2bbsAKVh6D4bN+BIp56X1ltP3eU2
zM+5cwplK+JbUX1TM9h70fTMNFzZWilmW1eMlrS0ejmKGOCU/VcFCIBjF2zGQ43o
04NwzIZ8Xv4k2B0AMnd4OdCE/PIosVtUVBeeOukBGgCrtwH+OZxu3rFK+GL/C+4=
=LyK0
-----END PGP SIGNATURE-----

--M9YpAf2t6OxtMGzg--
