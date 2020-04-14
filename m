Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F86C2BB85
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 19:51:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457CB20771
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 19:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tsvK5EXF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6DqFvTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457CB20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13F71825;
	Tue, 14 Apr 2020 21:50:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13F71825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586893894;
	bh=AaVRnbZybz5vMRXZrxlv2ehOvw55VQ60KvRSyrqRWl0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tsvK5EXFsB5NHe6HjOqdvZxtG4vynl1YNKNf2NyMSv+KeSkTjrJYw0Bb3X8Xo71iv
	 egamqD727slDqX9fZIRp6jbSjalQtRHDn8jgNOhNkx2y5/MytNI+cIAjOBw2RaxclC
	 KPMT0I8EHMKdNE0U4oCp4MbBc+S6RwWI8MyOsZos=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A3C6F80126;
	Tue, 14 Apr 2020 21:50:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 158FAF8013D; Tue, 14 Apr 2020 21:50:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD8A3F800F5
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 21:50:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD8A3F800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="T6DqFvTy"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A7F8B206E9;
 Tue, 14 Apr 2020 19:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586893834;
 bh=AaVRnbZybz5vMRXZrxlv2ehOvw55VQ60KvRSyrqRWl0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T6DqFvTy/pvyT/vTpQRGMizfJxyc3EUOxpiHF8nq8wCYcvaOJRCdXubaojqlSNNQh
 hPmW0t2zAjzkUlwTXdJladshIu1UE1tKx3bVRfCUvqpqsJZltTJPomDV1QLNTQIbyR
 r3Cjah8psl1vMBwD8+TnpWsd6ujezLfHBAHVO0a0=
Date: Tue, 14 Apr 2020 20:50:31 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 02/16] ASoC: pcm512x: use "sclk" string to retrieve
 clock
Message-ID: <20200414195031.GP5412@sirena.org.uk>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
 <20200409195841.18901-3-pierre-louis.bossart@linux.intel.com>
 <20200414174530.GK5412@sirena.org.uk>
 <8ee01a4f-ceb2-d207-7cef-cf766fa670af@linux.intel.com>
 <20200414182728.GM5412@sirena.org.uk>
 <3017b762-7a0c-cee2-06dd-1e96f52eb849@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0UhZIN3Sa23/ILEd"
Content-Disposition: inline
In-Reply-To: <3017b762-7a0c-cee2-06dd-1e96f52eb849@linux.intel.com>
X-Cookie: I've only got 12 cards.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
 linux-gpio@vger.kernel.org, tiwai@suse.de,
 Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Daniel Matuschek <daniel@hifiberry.com>, Hui Wang <hui.wang@canonical.com>,
 Matthias Reichl <hias@horus.com>, Michael Turquette <mturquette@baylibre.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-clk@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--0UhZIN3Sa23/ILEd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 14, 2020 at 02:15:16PM -0500, Pierre-Louis Bossart wrote:
> On 4/14/20 1:27 PM, Mark Brown wrote:

> > Wait, so SCLK is in the *global* namespace and the provider has to
> > register the same name?  That doesn't sound clever.  It might be better
> > to have the board register the connection from the clock provider to the
> > device rather than hard code global namespace strings like this, that
> > sounds like a recipie for misery.

> I believe this change has zero impact on DT platforms.

> The 'sclk' is a fallback here. If you find a clock with the NULL string,
> it's what gets used. Likewise for the clock provider, the 'sclk' is a lookup
> - an alias in other words. The use of the references and phandles should
> work just fine for Device Tree.

It's not just DT platforms that I'm worried about here, it's also ACPI
systems - all it takes is for a system to have a second device and a
name collision could happen, especially with such generic names.  We
tried to avoid doing this for board files for the same reason.

> > It is really sad that nobody involved in producing these systems that
> > don't work with the current limitations in ACPI has been able to make
> > progress on improving ACPI so it can cope with modern hardware and we're
> > having to deal with this stuff.

> I can't disagree but I have to live with what's available to me as an audio
> guy...I had a solution two years ago where I could set the clock directly
> from the machine driver. The recommendation at the time was to use the clk
> framework, but that clk framework is limited for ACPI platforms, so we can
> only use it with these global names.

My understanding is that ACPI just doesn't have clock bindings (or audio
bindings or...) so you're basically using board files here and board
files can definitely do more than we're seeing here.

> We had the same problem on Baytrail/Cherrytrail devices some 4 years ago and
> we had to use an 'mclk' alias. We are going to have the same problem when we
> expose the SSP MCLK, BLCK and FSYNC clocks - and that's also what the
> Skylake driver did - we don't have a solution without global names.

You should be able to register links between devices using the clock
API, or add that functionality if it's not there but AFAIK clkdev still
works.

--0UhZIN3Sa23/ILEd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6WFAYACgkQJNaLcl1U
h9Byqwf9FHKLkxTXEYOkKQknonTH+2/9DiOFIk1jbin5OOzdlJzc682Clt8cCXGO
IN2Se5PIYE0yU5nFwivSioVBRtyxjM1GSmw8B0iz6XdcF4OXa6FxNraCewLYuNoG
+BsgxShrkzMixnTORYbOthcDHX2TsoNNBL3FkWBKvZRiG8BzObkztj+lDpRvgd+f
I1d82Gdo9Hz6yozOskQnQDW0Dh/4uInR/V/cEzjcr+HaWJCD0aWkH+Ead4dYS0MA
GcFLx/t86XUxXyz65R3PUh0exPZbiTCvWQPWlFBXsTTKV8pcN355Qox5zjESiz4+
jaE33TfCTPpUXfwcwJzr0yPkBQiYHQ==
=xvJN
-----END PGP SIGNATURE-----

--0UhZIN3Sa23/ILEd--
