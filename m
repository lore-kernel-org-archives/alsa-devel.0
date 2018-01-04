From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v2 14/15] ASoC: qcom: apq8096: Add
 db820c machine driver
Date: Thu, 4 Jan 2018 12:02:44 +0000
Message-ID: <20180104120244.GE10774@sirena.org.uk>
References: <20171214173402.19074-1-srinivas.kandagatla@linaro.org>
 <20171214173402.19074-15-srinivas.kandagatla@linaro.org>
 <f72f32dd-e248-47c3-23cc-eabe1b85d9ae@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1157706251455896090=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 10E8926782A
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 13:02:47 +0100 (CET)
In-Reply-To: <f72f32dd-e248-47c3-23cc-eabe1b85d9ae@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <david.brown@linaro.org>, Rob Herring <robh+dt@kernel.org>, srinivas.kandagatla@linaro.org, linux-arm-kernel@lists.infradead.org, Andy Gross <andy.gross@linaro.org>, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============1157706251455896090==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sfyO1m2EN8ZOtJL6"
Content-Disposition: inline


--sfyO1m2EN8ZOtJL6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 03, 2018 at 09:20:45AM -0800, Stephen Boyd wrote:
> On 12/14/2017 09:34 AM, srinivas.kandagatla@linaro.org wrote:

> > uThis patch adds support to DB820c machine driver.

> > +	ret = dma_coerce_mask_and_coherent(card->dev, DMA_BIT_MASK(32));

> Why do we need to do this? Can you add some sort of comment in the code
> about why?

And why are we applying DMA restrictions in a machine driver?

--sfyO1m2EN8ZOtJL6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpOF+MACgkQJNaLcl1U
h9DqSAf/TRTXDKdOETvzPNSKGaWNVG2ljRSTEBuPrReetgJ+PI1o30yx4FGcKhyV
MiDyv/O+wn1bkKSZ9o3TpSbz+e1Vwk/ceFEKrNwPxT1iK7Z2gqP0VbrnJ3g7nAjq
l2A2PvlIuZA8gD0F19g8r9dXgTLiuWSxduYY4YZIK4ns9JmSZi+VyfAwL/p2pKE4
EQkGHDmfm9x3vC85U1x2G4Bc+f8LmFWQhc3tbuxeqkZz1S/AK5IDzvpAPG93jCvx
QqaxW6uHYkYhZgqQJxojomPmkzWvT83YrsSbVlsRit1lQE2PQYBuKm+exmkWQJb5
nrZGGyAF1SzKBMfd6IrccOWBQOwwSA==
=5JJo
-----END PGP SIGNATURE-----

--sfyO1m2EN8ZOtJL6--

--===============1157706251455896090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1157706251455896090==--
