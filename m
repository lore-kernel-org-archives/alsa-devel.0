From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC V2 1/2] ASoC: img: Add binding document for
 Pistachio audio card
Date: Wed, 27 Jan 2016 20:14:57 +0000
Message-ID: <20160127201457.GC25316@sirena.org.uk>
References: <1453818867-16322-1-git-send-email-Damien.Horsley@imgtec.com>
 <1453818867-16322-2-git-send-email-Damien.Horsley@imgtec.com>
 <20160127145756.GR6042@sirena.org.uk> <56A8DFBC.6070007@imgtec.com>
 <20160127160057.GA25316@sirena.org.uk>
 <56A8FAA5.1000907@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7261331998029054288=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0FF92604AF
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 21:15:13 +0100 (CET)
In-Reply-To: <56A8FAA5.1000907@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Horsley <Damien.Horsley@imgtec.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, James Hartley <james.hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org


--===============7261331998029054288==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 27, 2016 at 05:13:09PM +0000, Damien Horsley wrote:

> audio_pll is referenced exclusively by the card device

That one *may* be plausible.

> i2s_mclk and dac_mclk can also be referenced by other devices. The i2s
> out controller references i2s_mclk, and codec devices can reference
> i2s_mclk/dac_mclk dependent on their system clock requirements

The clock API copes perfectly happily with this.

> without a reference to i2s_mclk and dac_mclk in the card driver, it
> would not be possible to control the divisors and gates for these clocks
> in the following cases:

> Simplistic codecs that do not have drivers

> Codec drivers that do not call clk_set_rate and clk_enable/clk_disable

Nonsense, if there is no driver or the driver doesn't do what you want
then fix that.  Don't bodge things at the wrong abstraction layer, that
just creates problems later on when someone comes along and does things
properly or tries to use the device tree outside of your particular
implementation (eg, when working with a differnet OS).

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqSVBAAoJECTWi3JdVIfQhO4H/i4L7xnQ6tPB/qvLEEWbvDie
mnPpaktnriIdtQpaiIoWQYmXHg/2zBRsN2Bcu3MFiIndniiyUDgnCqGV5LgKpYPh
d0mj/evHzqYMQfdXeOuPxCp2M803v8Cu5nv2QaAmiXYJvkgA07uv0J4CNzXuC/T8
s5q3E+zZ3f7EGO1lxEZWPYuT4PvrqN2synXl3SGzd1ovUfy6pDWatiopc6Ng7N6Z
1FI6vCfw6FioafGYMQHXyQaVBGG2VyS5p/eECoAWPcciu6rTywQl1GqKlaU80U/v
Uhwwf8NQya9zlbokxGshjuCBtFLHauctAC2HRIzwAoUUV0EAEVfedxnBQ77J5HM=
=EGFj
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--

--===============7261331998029054288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7261331998029054288==--
