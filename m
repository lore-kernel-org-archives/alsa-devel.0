From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] ASoC: wcd934x: add support to
	wcd9340/wcd9341 codec
Date: Wed, 3 Jul 2019 12:52:43 +0100
Message-ID: <20190703115243.GV2793@sirena.org.uk>
References: <20190702080920.22623-1-srinivas.kandagatla@linaro.org>
 <20190702080920.22623-3-srinivas.kandagatla@linaro.org>
 <20190702144411.GP2793@sirena.org.uk>
 <2e2a32dd-3dca-5391-1bfa-ab1c1f420e3a@linaro.org>
 <20190702165753.GQ2793@sirena.org.uk>
 <0a9a994c-5a88-539f-3af0-76754b9b58d1@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3997232494059942947=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D26C9F800E8
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2019 13:52:45 +0200 (CEST)
In-Reply-To: <0a9a994c-5a88-539f-3af0-76754b9b58d1@linaro.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, vkoul@kernel.org, robh+dt@kernel.org, srini@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============3997232494059942947==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VpY0yS1BYpNZumir"
Content-Disposition: inline


--VpY0yS1BYpNZumir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2019 at 09:49:37AM +0100, Srinivas Kandagatla wrote:
> On 02/07/2019 17:57, Mark Brown wrote:

> > This is a driver for a single device, you should be able to
> > instantiate things without requiring binding through DT (and
> > hence support non-DT systems such as those using ACPI).

> My view point atleast from hw side was that Codec is Parent which is
> encompassing these different blocks and bus interface. DT representation
> clearly showed that relationship between the parent and child devices.
> Binding it through DT will make sure that resources are ready before
> they are instantiated.

> All the child devices also have some machine/board specific properties
> and dependency on resources from parent like regmap, clks, and bus.

> In ACPI case, am not 100% sure how these will be represented inline with
> hw representation.

> Are you suggesting to use MFD here?

I'm saying that you should be using a MFD here like all the other
CODECs with multiple functions and that you shouldn't have
compatible strings in DT for the subfunctions since you already
know they'll be there simply from enumerating the chip as a whole
and how exactly they are divided up is a function of how Linux
currently has subsystems, not of the hardware.

> > > This will instantiate all the child devices like pinctrl, SoundWire
> > > Controller and so on.

> > Just create platform devices like normal...

> These are already modeled as platform devices, except the fact that
> these are children of Codec device.

No, you've got them as DT nodes.

--VpY0yS1BYpNZumir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0clwoACgkQJNaLcl1U
h9ASZQf/Wax09z9q+yldgDqXtel9Fw1TmqbiQeU45IngtUaP/G3c4hKXjszf9tIu
D0+ip3V72iegmlnXKInzv+9+sB+l0gQb8g4PYBF4p1HPmXNao/FuZnKhbJSKvEAz
HjwLM80oUApbivHyMNycr48s3Yaix4tC5aeSolBGjGFAMQ++bD2Sblgfbd1M0K1T
YweS+5UStw/IboNQtKyl/TXaCTjjq7wtFUVUIfPZcazxlWBd278nApbuEwAqTbkU
wKvLgwQOaQIkAEMu4okXOUVwognAoNWs2Hfg8vJRTB5NMl4EvkSs55/agXXS0+mW
onDPn2hPaqk8Bj5oR5ymS7NFkR+cGw==
=d0xq
-----END PGP SIGNATURE-----

--VpY0yS1BYpNZumir--

--===============3997232494059942947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3997232494059942947==--
