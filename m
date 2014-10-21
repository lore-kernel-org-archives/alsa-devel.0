From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: fix rt5677 spi driver build
Date: Tue, 21 Oct 2014 22:28:46 +0100
Message-ID: <20141021212846.GD2344@sirena.org.uk>
References: <1413862213-18449-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1413862213-18449-1-git-send-email-benzh@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Zhang <benzh@chromium.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Anatol Pomozov <anatol@google.com>, flove@realtek.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2014 at 08:30:13PM -0700, Ben Zhang wrote:

> +config SND_SOC_RT5677_SPI
> +	tristate
> +	default SND_SOC_RT5677

Applied, but you also need to add this to SND_SOC_ALL_CODECS for build
coverage.

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJURtAOAAoJECTWi3JdVIfQTtsH/0cFzxjJ5y8V9FhZgPDPwzpB
7Z9YesuFC/EE98UPpXwI1CnMTtbrfyPWfoB9mVRKCOvKH1R1+ZO0bTooXW/JSNiX
RXrTxJ+N14TCzX3ht7vDM3j1OHq4Haci98sp83j2Q5Hc/9PJuCgPXOiYxTgo2P6v
/1RPjIZEAOqwWqa9XLbsXghskcYViBaT5dtK/gOhE6LfucShmA+StRUmvXJTrucJ
5GJjdfl9k2kCtIbni25ukUFu0WYpK8OQ61eSaTJPGYRiInHUY0kvdzba3zGqSD8Z
QtsanZYbQx17o3qoIMtW55wlFsOeVlgQLMNsgQUbpNQLntju/wxf6JZPO5GvZmw=
=jwUC
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
