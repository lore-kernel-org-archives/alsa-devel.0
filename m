From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: Add initial
 PCM1862/63/64/65 universal ADC driver
Date: Thu, 30 Nov 2017 16:31:04 +0000
Message-ID: <20171130163104.rw5gjnsqpv2ay2v4@sirena.org.uk>
References: <20171129185015.5304-1-afd@ti.com>
 <20171129185015.5304-2-afd@ti.com>
 <20171130122035.wgj2jpvzx6md5gnl@sirena.org.uk>
 <d4f015ab-3b17-dab8-33ba-4144b7571554@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3271267035815038574=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DA352678AC
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 17:31:10 +0100 (CET)
In-Reply-To: <d4f015ab-3b17-dab8-33ba-4144b7571554@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============3271267035815038574==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hhpf25x2ezw4a3mq"
Content-Disposition: inline


--hhpf25x2ezw4a3mq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 30, 2017 at 09:56:08AM -0600, Andrew F. Davis wrote:
> On 11/30/2017 06:20 AM, Mark Brown wrote:

> > disable them.  Based on what I think the intention is I'd suggest
> > removing the bias level handling and then having probe enable runtime
> > PM with the device flagged as active, letting runtime PM do any
> > disabling if the device is idle.

> I beleive this was meant to be be SIMPLE_DEV_PM_OPS and not
> SET_RUNTIME_PM_OPS. I'll fix this all up for v3.

I was wondering that.

> Just thinking, the sound core sets SND_SOC_BIAS_OFF before suspend
> anyway, right? So the results would be similar just having all the PM
> stuff in the bias level handling for consistency, but I'm open to
> whatever is the preferred way.

It doesn't matter that much, if you do it only in set_bias_level() then
unless you set idle_bias_off there will be no runtime PM which may or
may not be what you want and you'll also not give the user the ability
to control if runtime PM happens via the sysfs files but I'm not
convinced that anyone ever actually does that.  Either approach is fine
really.

--hhpf25x2ezw4a3mq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlogMkcACgkQJNaLcl1U
h9BHmwf+Luk4gRr1oLdetNmJekyv52wtxge+E11z/O8YcyuzVAInY4h1GvxG3qIH
1j7hJrLaiCVSaJrf5eTa0ZKrlitkG7aqu9BD38CGnyu6vG7E5ghmCJFo/mhmKTuY
W1qqpwAsc5lSgrEG+FxvcoW2ibIS2xYqGRvldj5u7ACTrsGplPh6gyrGk21bm9AH
f5ovVGIxdFRaa/ZanNo4aWpvYCLxL8WXisucNPD03QWMA1vd+pEX4z96xkycFhN6
+2CBax6zJRGXS1C2MhzADfSBq245Df1ZG/hR4ACtOdDJT37RKgJarjDRhyAWoJAl
EIdLfw9HcAFTF0qa5fJFmrF8WL+BIQ==
=KYWh
-----END PGP SIGNATURE-----

--hhpf25x2ezw4a3mq--

--===============3271267035815038574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3271267035815038574==--
