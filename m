Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584BEEB64DA
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Jul 2023 13:22:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D852383A;
	Mon, 10 Jul 2023 15:21:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D852383A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1688995362;
	bh=ruJlO0wimIrsDY1JgPUqCqS7prBe1pSopi+dM4yYAWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RmXQeUwnxIUhdYK3PYx8HtVS0SqTd9NODmotFuEcFRZfJw/7LIbKI9ZfCMtcXvllL
	 /J7NO5HJPYSham/aL+tMOXws8uXkm2SKl8RfCfhSnMJ3i2kEmAJxOliKlzX2uPcy2J
	 R6xbA7wWIfxsqFZh1QkxTTg6uhjnWn5XQfOpsRt8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 38A84F8053B; Mon, 10 Jul 2023 15:21:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ABEFDF80249;
	Mon, 10 Jul 2023 15:21:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DC5CFF80249; Mon, 10 Jul 2023 15:21:20 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 59B6AF800E4
	for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2023 15:21:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59B6AF800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tCUvqCtt
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C621F60DED;
	Mon, 10 Jul 2023 13:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94191C433C7;
	Mon, 10 Jul 2023 13:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688995274;
	bh=ruJlO0wimIrsDY1JgPUqCqS7prBe1pSopi+dM4yYAWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tCUvqCttiPcwuUH6oQaeDTVlt/jVMTKddukpB3Rq2NTAjbzgaXhOs+IbQKiqA2zFS
	 A9RwOziobHTKo8xtAoLCbw9/G5XP7z93lwwcMiVxafq8PiTNYdyOWz2ZmNVbJqaRu3
	 p+o7GErUG6dN3D+2vdmSUok/vpvLEP/d4e2/6uVM8lFbtbK1g1KhHRcJ+YzSNSc8aV
	 vzC9RTasZiyt6DNQvmgXjaDeqvMTkrDbkZFHHHz5OJ3MwZifaBQsXsj96SFX7XFS5/
	 2yl7VTCIzPWHRNx1uEfr8lQDSlw+D72llgC2cC8KCiu81fGygjzL2Umg2d4uKSVdv1
	 5QaNEib99pP6w==
Date: Mon, 10 Jul 2023 14:21:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>,
	Kris Bahnsen <kris@embeddedts.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH v1 4/8] spi: Get rid of old SPI_MASTER_NO_.X and
 SPI_MASTER_MUST_.X
Message-ID: <7aff8759-cfca-47b5-b995-5260e5082c45@sirena.org.uk>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
 <20230710102751.83314-5-andriy.shevchenko@linux.intel.com>
 <1ffd5603-4140-4bf6-bfed-af70a6759bda@sirena.org.uk>
 <ZKvmkAP5ZuT6lGLN@smile.fi.intel.com>
 <ZKvnPXl9H+cQR8Ok@smile.fi.intel.com>
 <353027bf-6d2a-40de-9e18-8553864b343c@sirena.org.uk>
 <ZKv7p96D2B9vYd0J@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bc8mzeK4BJwaYeTa"
Content-Disposition: inline
In-Reply-To: <ZKv7p96D2B9vYd0J@smile.fi.intel.com>
X-Cookie: Do you have lysdexia?
Message-ID-Hash: LGDJ6ADQJ3MFAPT65VKBPC5MANW6FC7T
X-Message-ID-Hash: LGDJ6ADQJ3MFAPT65VKBPC5MANW6FC7T
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LGDJ6ADQJ3MFAPT65VKBPC5MANW6FC7T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--Bc8mzeK4BJwaYeTa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 10, 2023 at 03:37:59PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 10, 2023 at 12:22:59PM +0100, Mark Brown wrote:
> > On Mon, Jul 10, 2023 at 02:10:53PM +0300, Andy Shevchenko wrote:

> > > > > > Convert the users to SPI_CONTROLLER_NO_?X and SPI_CONTROLLER_MUST_.X
> > > > > > and kill the not used anymore definitions.

...

> > > > > > -	controller->flags = SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX;
> > > > > > +	controller->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;

> > What part of the above change is replacing _NO_ with _MUST_?

> None, that's why assuming the split by name should be fine.

That's what the above changelog sounds like it's trying to do (I'm not
sure the change itself makes sense but the first thing I ran into when
reviewing the patch), AFIACT you're missing a "from" in the changelog?

--Bc8mzeK4BJwaYeTa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSsBcAACgkQJNaLcl1U
h9BDYgf/Sarsl9t6SagewIDl2ctlFPl7f++zP6SLId0C0LErq2lPLxZKf8tzzV5x
7mUMpK3rPcygDeYAqOKLncxnrZp/i7yix/98fZtls9IesvOQa29aRYKVSvhKnB6y
dHoZoMBdYj1Rbo/olUcS1xjzzZ0o1VUHkLsp9rjoMW4lcz6Hu3o8GSOq1pbc9lRd
qlCYAjMqjR9K3te5I6FICKKGnIrXm2uxuzSPZl1G7LaN0THUZGZJvcBHjhR2PcJs
K9i9m0gJ9xsQXDOQgLTcXrm8hdSF7yQoRI3TBZ7RXzdWeO3mjNjeHGbVDRr3DMZy
Oici+Ga3mBLzIlFlF51Tg71+BGqcoQ==
=NWL6
-----END PGP SIGNATURE-----

--Bc8mzeK4BJwaYeTa--
