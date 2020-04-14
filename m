Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA759C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:46:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 587062074D
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 17:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sV+qYWpz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3R9ysoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587062074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89751168C;
	Tue, 14 Apr 2020 19:45:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89751168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586886398;
	bh=TcrgRAaCCn5C89p9zkdB+nBvjexBsT4Fl+qQqU3nKsM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sV+qYWpzI8pL+iFUT+8qgrX2SwYa8MD68Ao2GNbSnCjswoFZY05f76UMSUPBFXq3u
	 G2wldpf01uvlg8b2BH86NPWNLpcbsSg6NpFpK+YK8FqUgTncImvG8jemQTOeuCOxrH
	 bnQAcb9qJCYdjwCH876iIHTBzSjCnIf2C2lCzGNo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 176C9F800B9;
	Tue, 14 Apr 2020 19:45:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E1422F8013D; Tue, 14 Apr 2020 19:45:38 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF889F800B9
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2020 19:45:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF889F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="m3R9ysoV"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 145392074D;
 Tue, 14 Apr 2020 17:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586886333;
 bh=TcrgRAaCCn5C89p9zkdB+nBvjexBsT4Fl+qQqU3nKsM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m3R9ysoVEbkDNXoNnHdUSYSWAxPaom9kykXJTjcElSsM3gjBKsU6VTXo4sk5l5Ckg
 jye8BoG+8CqxCd2FahBTI8Annje94Zzz0OrSXiY8k6RG10GspQ3ZNsXgULnNTBHf8q
 SXRiNP8nTfC/YW/vSJbtz5j/o6PUKuOGzBDWfj8Q=
Date: Tue, 14 Apr 2020 18:45:30 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [RFC PATCH 02/16] ASoC: pcm512x: use "sclk" string to retrieve
 clock
Message-ID: <20200414174530.GK5412@sirena.org.uk>
References: <20200409195841.18901-1-pierre-louis.bossart@linux.intel.com>
 <20200409195841.18901-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aqWxf8ydqYKP8htK"
Content-Disposition: inline
In-Reply-To: <20200409195841.18901-3-pierre-louis.bossart@linux.intel.com>
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


--aqWxf8ydqYKP8htK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2020 at 02:58:27PM -0500, Pierre-Louis Bossart wrote:
> Using devm_clk_get() with a NULL string fails on ACPI platforms, use
> the "sclk" string as a fallback.

Is this something that could be fixed at the ACPI level?

--aqWxf8ydqYKP8htK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6V9roACgkQJNaLcl1U
h9BjSwf+Pss0RQ4uA5Mylj+hH2CPMjVyKi4bXcMsc0WKzPqaEjAl7piwqVzzlCzr
z1G7YxB8Azwdu5vQYLVXDBpUDUPqaxzYr5/9JkqjrXNKn2oquMs0aqpdP2Vir+In
zUogWkOk2zrRbf8uHYwXVN85CY5b3xbf2CDkA6RNZOzAJ1M4MnIylSXNmGlEfPqS
DPgtxVAB+7PDCN41/egJGbTmddfD/r1uHc7ePHBMdNgPvoxO4bGFzt+7dvIhPKms
V+gTxUY6IWDXxlXrQeCV0S+iT3BM7UdNcKd6xJDbLwISy7ApTtoNtyUyMU1ZSek9
zsjTBu467jgS9V0USWLBlD9nq9VDyw==
=y8RE
-----END PGP SIGNATURE-----

--aqWxf8ydqYKP8htK--
