Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5812BC433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:28:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FCE20732
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tx8a9KJB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gi2Lesai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FCE20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 722A81716;
	Mon, 22 Jun 2020 20:27:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 722A81716
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592850487;
	bh=2BOO9spZJDZ19YfZzNTc3m4IUDff21JULnFZyjUGztM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tx8a9KJB5URNVUiDH6ed5PeT72ukrTR7IygKhIhDyQVJKhpD0v/zxPEr2Q9N5StjL
	 CCC1yokPSBo8LSwC36FYFqdr+VGShMZxY35c1BEBfwM6aEAuQcUfNPGIbUj8zqTUsC
	 9Hg74tIfnoCt/cs6brAB2bSofCGSokTh3iVh1mNo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 730BDF801DB;
	Mon, 22 Jun 2020 20:27:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0F1EF801F2; Mon, 22 Jun 2020 20:26:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1ED2F8010D
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 20:26:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1ED2F8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Gi2Lesai"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 661D920732;
 Mon, 22 Jun 2020 18:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592850413;
 bh=2BOO9spZJDZ19YfZzNTc3m4IUDff21JULnFZyjUGztM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Gi2LesaiMpf5fYAFIH9Bwzsw/QIWfZsvtZYAijfllk7FrQTusTTm5cDipj1pPzZUY
 ehNJd5d3oPB4P/jEbuxYeI3515qH/UBGe5z9W436alg2mWriaKXRvwu34AFa+taD/P
 KLRZE5BEY9O3F417iKt2833xWekzRaHsxl5zxspE=
Date: Mon, 22 Jun 2020 19:26:51 +0100
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/5] ASoC: Intel: bdw-rt5677: fix module load/unload issues
Message-ID: <20200622182651.GR4560@sirena.org.uk>
References: <20200622154241.29053-1-pierre-louis.bossart@linux.intel.com>
 <20200622154241.29053-3-pierre-louis.bossart@linux.intel.com>
 <20200622181824.GG2428291@smile.fi.intel.com>
 <04af7e48-e694-7657-5477-81b6e2e8d1c1@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wlFCko3yyTbBmKK8"
Content-Disposition: inline
In-Reply-To: <04af7e48-e694-7657-5477-81b6e2e8d1c1@linux.intel.com>
X-Cookie: laser, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 Curtis Malainey <curtis@malainey.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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


--wlFCko3yyTbBmKK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 22, 2020 at 01:23:04PM -0500, Pierre-Louis Bossart wrote:

> So I explicitly added a test for all possible cases. I don't mind removing
> the _OR_NULL if indeed it's safe, but showing this redundancy also shows an
> intent to deal with such cases.

Yeah, I think that's fine - it's perhaps redundant but we're not in a
hot path and as well as the intentionality it saves the reader from
having to know if gpiod_put() copes with NULL or not.

--wlFCko3yyTbBmKK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7w9+oACgkQJNaLcl1U
h9BnJAf7B1rPGrJmatSlelSQL74Zjr5jLWe8i7sFEnnvfs+OlEVJaQyM/Hcz27UQ
jg/DNqLI3bzwD3KjoCaht8CS7HXrrrrG/KvEM6N5q6hkALIFwmgGAiTnLO44voom
sZnEzM3zSgXW/9vqIIuW2QYIFWfJn+9kfa+ZIt4CgojgJdNlHrDX9px2hLSMpxvQ
k2ohiPs0Jop8nrA90PfE3f2377I+tLH/D80vsPFkl0INuaixlaJ9YWO+PXzu/btf
1XXJLd5bbAjwyDwPr8cNW6AAfmzkivdQ+Jpx4jFb1FG42EwMxfG9RdWAghbN8rOc
KtGUiPyjhRTzpR51AsJhNhVCZoNPJA==
=BCHV
-----END PGP SIGNATURE-----

--wlFCko3yyTbBmKK8--
