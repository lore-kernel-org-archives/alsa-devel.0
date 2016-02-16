From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: simple-card: Support for selecting system
 clocks by ID
Date: Tue, 16 Feb 2016 13:42:33 +0000
Message-ID: <20160216134233.GN18327@sirena.org.uk>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
 <1455545495-20292-5-git-send-email-peter.ujfalusi@ti.com>
 <20160215152635.GN18988@sirena.org.uk>
 <56C2F00C.8080809@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qYrsQHciA3Wqs7Iv"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56C2F00C.8080809@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, linux-clk@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>
List-Id: alsa-devel@alsa-project.org


--qYrsQHciA3Wqs7Iv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 16, 2016 at 11:46:52AM +0200, Peter Ujfalusi wrote:

> As for codecs, tlv320aic3106 is also pretty simple device from the outside, it
> can receive it's reference clock via:
> MCLK pin, GPIO2 pin or it can use the BCLK from the bus. Based on the incoming
> frequency it can use it directly or it needs to use the internal PLL to
> generate the cocks.
> It can output generated clock via GPIO1

That already sounds like there is room for configuration and hooking
into a wider clock tree - we've got three different source options and
an output plus a PLL that can presumably take in non-audio rates.

> I don't think it will bring any clarity or features we miss right now if we
> try to move CPU and codec drivers to clk API. IMHO.

You happen to be looking at a particularly simple system but things do
scale up and there's not a clear cutoff point which would allow us to
make a clear distinction between things that might get used in a simple
system and things that might need something more complex.  This seems
particularly important when we're adding things to simple-card, we want
it to be usable with as many different devices as possible.

--qYrsQHciA3Wqs7Iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwydIAAoJECTWi3JdVIfQXAIIAIPmQaUWJVAUbw82rp0vXDYk
/S7WYLF1u9HhJSbwozaC9y8wsBF2k1Xhgepr+aUjEi9eY2A/8s27BSQidnfE2PxM
HDUEWO/wfJHBNqGfYh4+3IWzQ3RZsuxDzDhPRQ+cxhkPWtwv3qxOH2IE8uT3BVcB
MCmzDX/VYmh/W8iXZ/il4dSFlH1PTdm+ihSr9QJR1bTF7Fseg6EzUWjCn13StYnk
zszqF3k7LwXIwrpylS0BkxoMQUDZf9w2Ny8gJ6wkXK4TUq9TECi+6Xgfv+rXD/y6
sZ71fLero+zEvDY3XEtUNimSGH9zP5u2F1asBmJLxm5lWpuIREn+Cl4HZT7m3Bs=
=clV+
-----END PGP SIGNATURE-----

--qYrsQHciA3Wqs7Iv--
