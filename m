From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC V2 1/2] ASoC: img: Add binding document for
 Pistachio audio card
Date: Wed, 27 Jan 2016 16:00:57 +0000
Message-ID: <20160127160057.GA25316@sirena.org.uk>
References: <1453818867-16322-1-git-send-email-Damien.Horsley@imgtec.com>
 <1453818867-16322-2-git-send-email-Damien.Horsley@imgtec.com>
 <20160127145756.GR6042@sirena.org.uk> <56A8DFBC.6070007@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7237846175109445878=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AEF0326044B
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 17:01:14 +0100 (CET)
In-Reply-To: <56A8DFBC.6070007@imgtec.com>
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


--===============7237846175109445878==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 27, 2016 at 03:18:20PM +0000, Damien Horsley wrote:
> On 27/01/16 14:57, Mark Brown wrote:
> > On Tue, Jan 26, 2016 at 02:34:26PM +0000, Damien Horsley wrote:

> >> +  - clock-names : Includes the following entries:
> >> +        "audio_pll"  The audio PLL
> >> +        "i2s_mclk"   The i2s reference clock
> >> +                     Also connected to i2s_out_0_mclk output
> >> +        "dac_mclk"   Dac reference clock. Connected to i2s_dac_clk output

> > Why are these (especially the dac_mclk and i2s_mclk) properties of the
> > card and not of the drivers for the respective devices?

> Due to the shared nature of these clocks. Individual components cannot
> be responsible for controlling these as this could break configurations
> for other components that are sharing the clocks. Only the card driver
> has visibility of all of the components and their requirements.

You're talking about the code that decides what rates to set the clock
at, not where the properties are placed in the DT.

> i2s_mclk and dac_mclk can be used by both the i2s in and i2s out paths
> on some boards

Multiple devices can reference the same clock.

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqOm4AAoJECTWi3JdVIfQStMH/1pQMFbNBmmRLdKIIexwGw74
FPdWYQYtQ/BYN/DtzE+0ifV80/bjBMmqmbHNxLgKr7RFLIStbBqdoc+5o2b0RAZT
+CcXfojVZBGVMKardW3S131cMnKZ99fo9rP/bu7P0DlUK8vY6+1NUVJWxTI/r0Vr
eR4BS5EJO+/zLnmaVmrtUqNteXOgxWevAEwToJzFJ2iax6g+Q5Xcrz54TPUVehN8
O6vnIw8mCOr60sZd9S4Z9idJUI0QV3kBRuJtJRaCoIYItgA2vEbUUxVVgX7gtGdF
douvjqYddw9pnZ0J27/nPSH1LcRERwNMPea52nV9Pwwn+esFQRXQGfU9tJGJZ/4=
=XaOU
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

--===============7237846175109445878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7237846175109445878==--
