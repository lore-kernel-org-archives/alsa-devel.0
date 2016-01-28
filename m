From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC V2 1/2] ASoC: img: Add binding document for Pistachio audio
 card
Date: Fri, 29 Jan 2016 00:25:33 +0100
Message-ID: <20160128232533.GG4130@sirena.org.uk>
References: <1453818867-16322-1-git-send-email-Damien.Horsley@imgtec.com>
 <1453818867-16322-2-git-send-email-Damien.Horsley@imgtec.com>
 <20160127145756.GR6042@sirena.org.uk>
 <56A8DFBC.6070007@imgtec.com>
 <20160127160057.GA25316@sirena.org.uk>
 <56A8FAA5.1000907@imgtec.com>
 <20160127201457.GC25316@sirena.org.uk>
 <56AA2301.9070604@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0qt3EE9wi45a2ZFX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56AA2301.9070604@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Damien Horsley <Damien.Horsley@imgtec.com>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, James Hartley <james.hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org


--0qt3EE9wi45a2ZFX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 28, 2016 at 02:17:37PM +0000, Damien Horsley wrote:

> The i2s out controller also uses i2s_mclk, and calls clk_set_rate in
> hw_params at present. Would creating a set_sysclk callback for the i2s
> out controller, then calling snd_soc_dai_set_sysclk on the cpu dai in
> addition to the codec dais in the card driver be the correct way to
> manage this?

That'd be more normal, yes.

--0qt3EE9wi45a2ZFX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqqNsAAoJECTWi3JdVIfQkr8H/2IxwBlhIPyiHZjH2MIucPbk
nqzHQlIrNYzrw6boLSpLFlLZAkpmZ/U/s+qpcwVloVxZgVY9D/dQICK3CVl23cZS
p3GLC4nr4Cyb68w4NtyYXAFdqt7vGDqbkeU6CBkyS3GdiqIVQihQ2GvPP7EtuiSh
DfoQ4W7Tj/es9tpP2tEHJmc5nUxpu7pG05k/mkQ570yv9gGLcqICsroHNauqB50p
wL/myKOqPRR3YLUx+FE+JMsyDFnN8iOuT63XlZXCBfeGWXMK8fEHQ/1ZWWuk/93x
1m8sCQRzuiA3TLFi6i7ahm4OZpLCvjMP82upRTW+XUnPxsSS+w86/MHgIfUOyeA=
=ua04
-----END PGP SIGNATURE-----

--0qt3EE9wi45a2ZFX--
