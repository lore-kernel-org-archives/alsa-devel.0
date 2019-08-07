From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] soundwire: fix regmap dependencies and
 align with other serial links
Date: Wed, 7 Aug 2019 20:09:17 +0100
Message-ID: <20190807190917.GL4048@sirena.co.uk>
References: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
 <CAJZ5v0g5Hk9JYLvRXfLk5-o=n_RVPKtWD=QONpiimCWyQOFELQ@mail.gmail.com>
 <52a2cb0c-92a6-59d5-72da-832edd6481f3@linux.intel.com>
 <20190807175646.GK4048@sirena.co.uk>
 <5a7473a2-83c0-1a09-0cab-31fcc5b21302@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m+jEI8cDoTn6Mu9E"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5a7473a2-83c0-1a09-0cab-31fcc5b21302@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, jank@cadence.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


--m+jEI8cDoTn6Mu9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2019 at 01:17:20PM -0500, Pierre-Louis Bossart wrote:

> I don't have the knowledge or means to test what I suggested initially for
> the other buses, and the optimization was minimal anyways, so this patch
> takes the path of least resistance and aligns with others.

> if there are no objections it's probably easier to push this patch through
> the SoundWire tree, with the relevant Acks.

Makes sense I think

Acked-by: Mark Brown <broonie@kernel.org>

--m+jEI8cDoTn6Mu9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1LIdwACgkQJNaLcl1U
h9DFBQf+KQtyCfkxOfIv1rEOZ7sfj9ypg/0DsSRjVwhmqS8DoTwcpPwzJlVJFRs1
1Qg9wUYGxMpwhkiYJ66KhJs7Ugtb1XYdGiYzvhjAbxsB9YZ3z1kCK+h91jkMXxS+
4DX6U8/hLEqR4DpwnBYTo91TAJnJi3Bj/xp8qsViOsacjECpiZG11E9FmYTSPUFi
pKgyVB7nWj0kpL7aaEyweJJcSwrF7Fy7/+1KLgpVmewCepH1BooSaJI6ymEEz6+P
RAAKwUwDIksuajG5KVJduJf0BsSTZ2GFLE3pomj8o+OuMMABvnzmwbYofQmWHu2n
0/p+EPuDpS7b+n4obTY1DL0audj1HA==
=Ercr
-----END PGP SIGNATURE-----

--m+jEI8cDoTn6Mu9E--
