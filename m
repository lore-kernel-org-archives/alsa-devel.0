From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: Add snd_soc_of_parse_audio_routing()
Date: Sat, 14 Feb 2015 13:31:53 +0900
Message-ID: <20150214043153.GC9110@finisterre.sirena.org.uk>
References: <1423776602-28585-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423776602-28585-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 12, 2015 at 01:30:02PM -0800, Nicolin Chen wrote:

> This patch adds snd_soc_of_parse_audio_routing() to get dapm routes
> via Device Tree. Because snd_soc_of_parse_audio_routing() overrides
> dpam_routes, we use snd_soc_dapm_add_routes() to append the original
> build-in DPCM routes instead of linking them to dpam_routes directly.

It seems better to make the helper function play nicely with existing
DAPM routes in the card rather than have to rearrange things like this.
How about having it just record that it should parse the given property
when the table in the card is being handleed rather than overwrite that?

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU3s+5AAoJECTWi3JdVIfQRpsH/jZddgL/vtCZsrKJCgk538Ah
OyoSnyfFNHYPxevhzNGEvpivJacP7k3EDh0udRw9EZyzo7nKewUdgmDMzvEqet7z
USG4lD4wlKDuLRWiu5rFdna2aGMp55SC9w4J6KSEhEPjwqPG0Lyug2WsXlYaoSXU
eQXBTX8JPMfCfecceqVnxW9WhjDzZgPIpmIyaO2I5JZlMPIfwK2/2AH6Cr+yeuGw
W/xGiRLzhaKYzUnMvTaQqmfyXEvekQcOw/FXTL3xTgJJMWrWXuqkfBxzqu2zPpdn
uSzdhYefqVJMJLErrc3waDbxy7DPwQ8byTpbFuWCkImiYNC+rqOm4t4YjIep+yM=
=zi1W
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--
