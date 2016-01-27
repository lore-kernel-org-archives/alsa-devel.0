From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC V2 1/2] ASoC: img: Add binding document for Pistachio audio
 card
Date: Wed, 27 Jan 2016 14:57:56 +0000
Message-ID: <20160127145756.GR6042@sirena.org.uk>
References: <1453818867-16322-1-git-send-email-Damien.Horsley@imgtec.com>
 <1453818867-16322-2-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hw0FrjWlp+qkNlJP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453818867-16322-2-git-send-email-Damien.Horsley@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Damien Horsley <Damien.Horsley@imgtec.com>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, James Hartley <james.hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org


--Hw0FrjWlp+qkNlJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 26, 2016 at 02:34:26PM +0000, Damien Horsley wrote:

> +  - clock-names : Includes the following entries:
> +        "audio_pll"  The audio PLL
> +        "i2s_mclk"   The i2s reference clock
> +                     Also connected to i2s_out_0_mclk output
> +        "dac_mclk"   Dac reference clock. Connected to i2s_dac_clk output

Why are these (especially the dac_mclk and i2s_mclk) properties of the
card and not of the drivers for the respective devices?

> +  - img,mute-gpio : phandle of the mute gpio
> +
> +  - img,hp-det-gpio : phandle of the headphone detect gpio

The DT maintainers would prefer those to be named -gpios.

--Hw0FrjWlp+qkNlJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqNrzAAoJECTWi3JdVIfQbpsH/jKw/QtwOliNYr5NQtlJrxBu
KQVF8I5aNFcap50g9woaci12BZJ+AW2OjvLinCL2Q0eMnUhjotflNrMa1RHVD1Rp
jMZHHYgbm0GT9z/HANpcmoMYeBTT522H4+FxJPCFIHIG8NNQW49Aq7/k0HP98Ipu
0RHIQScb9v+VtB1NE4sEXyNf/5t/7BB8wH2giDV5JZeGQZdCq/ipydZ2qpNphz27
S7rwTR4q/L7AGJMczPkWAU09OYKVXoumF79vie+K4dQKr7F6Iqk8x1YSZYoOEhIS
ci3ThTQhQxtN359Sp298FwFKgXP/H8rAVDexdQf9ienSD7Ab8KPxEODwvTO8L+Q=
=b8A5
-----END PGP SIGNATURE-----

--Hw0FrjWlp+qkNlJP--
