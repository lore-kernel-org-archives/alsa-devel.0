From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 01/23] soc: qcom dt-bindings: Add APR
	bus bindings
Date: Tue, 24 Apr 2018 16:57:39 +0100
Message-ID: <20180424155739.GC22073@sirena.org.uk>
References: <20180418153157.1960-1-srinivas.kandagatla@linaro.org>
 <20180418153157.1960-2-srinivas.kandagatla@linaro.org>
 <20180424155226.fo6rgdea4kmqqjdy@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0202361661201014031=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EE6C92676AD
 for <alsa-devel@alsa-project.org>; Tue, 24 Apr 2018 17:57:47 +0200 (CEST)
In-Reply-To: <20180424155226.fo6rgdea4kmqqjdy@rob-hp-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, spatakok@qti.qualcomm.com, lgirdwood@gmail.com, tiwai@suse.com, david.brown@linaro.org, srinivas.kandagatla@linaro.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, andy.gross@linaro.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0202361661201014031==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 10:52:26AM -0500, Rob Herring wrote:
> On Wed, Apr 18, 2018 at 04:31:35PM +0100, srinivas.kandagatla@linaro.org =
wrote:
> > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> > This patch add dt bindings for Qualcomm APR (Asynchronous Packet Router)
> > bus driver. This bus is used for communicating with DSP which provides
> > audio and various other services to cpu.

> This should probably go under bindings/sound/ as it is at least mostly=20
> sound related.

AIUI the same interface is used for other DSP functionality - they're
upstreaming audio stuff right now but I believe there should be more to
come.

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrfU/MACgkQJNaLcl1U
h9BC0wf/ZuE09XBVQEqxfEPat5gCr+fdUgRFbyuGvaqFOSgavwg45nQSvL4wSGKg
J+oy/tW2YwfLfjJ6WpzMcjk7eo53iX9Y+aOxNLx7bgvlF/8TbiDtUz3VRZewMpws
5Pr3kvcvh6matkh6P4L3C8j7jw5z5LuL/4j3H3MPD1fH4nihOeabqWEQq8pLVVSI
CPMVxvhoFJdEtYwp8qe72NMchw0oLCwk4wjtTo708zPvqkn+/W/eb/T+eOrA4mkc
UUw9HufLYc1P2rtQ08wJtEXFkqYjzU8zKr5SLigs/l3ECDgsEdcx3OwenWZ8jVD8
gDEoP35iR4QGKRRwyXY+e/Hhnc9SOw==
=WtTX
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--

--===============0202361661201014031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0202361661201014031==--
