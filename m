Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A326DC677F1
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Feb 2023 15:07:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9536A843;
	Thu, 23 Feb 2023 16:06:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9536A843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1677164834;
	bh=pILPGxBt1kJYtwWzhF/f0Y6FgifBCmAAPLsPd7Uf7Jg=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KihCjWqpNaB1SoJz+/31EK4dpqv78J0xXJ/4K04nJryyrga7DMIu5JaDB5VOm92ol
	 p0VwdKgTipra/R4Sf7+/68+4cYzBekD8TiKDfOIP83baxpDgtAohOHwrAeLfW1VMLc
	 fWzvZVlIOO9CtC1pT1iikpjIO38sJySSrsi0LOlU=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 36B1DF80496;
	Thu, 23 Feb 2023 16:06:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 18122F80496; Thu, 23 Feb 2023 16:06:00 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CF2B8F800BA
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2023 16:05:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF2B8F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZSK0Z7mA
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E5A126170C;
	Thu, 23 Feb 2023 15:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAB9C433D2;
	Thu, 23 Feb 2023 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677164753;
	bh=pILPGxBt1kJYtwWzhF/f0Y6FgifBCmAAPLsPd7Uf7Jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSK0Z7mAF/TyVWOcprYHz1DoIxuKXxjdElzHtikBLLxCwtqZVmfpCoOwLTdOt5F1E
	 Jz3ROmBmPnbHHmFnZl3wnN1TBaQQ56an4akdlBDe0l7bhEA33gR128c6YNXEX9Y05C
	 cC7cHKy1bQYSWu8dDYHNxhtU45IbisBGe0Zc7KdMVFnuclopStvYwXlIFKLuKaa8ua
	 OpSWgd7ZNZNZnYmEXPnoapvcYaruSPAy2JUupm4oXJENg3a4EtlAD7oP7u/n73GNM6
	 PMpyLMOBN9+R+C8huYkwV9DbOeCrwZckzhpJo2tw3PrhOlN7RtEnJZxrO7IAOJhay4
	 fe+acPowrfZpQ==
Date: Thu, 23 Feb 2023 15:05:46 +0000
From: Mark Brown <broonie@kernel.org>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Subject: Re: [PATCH] Fix snprintf format warnings during 'alsa' kselftest
 compilation
Message-ID: <Y/eAyrYs+wEu180d@sirena.org.uk>
References: <20230223143214.16564-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="moK3dVaIIIQiq0dD"
Content-Disposition: inline
In-Reply-To: <20230223143214.16564-1-ivan.orlov0322@gmail.com>
X-Cookie: Hindsight is an exact science.
Message-ID-Hash: ZPJUFG5PXJMTL6JNIRVZABKEBF6HHOP3
X-Message-ID-Hash: ZPJUFG5PXJMTL6JNIRVZABKEBF6HHOP3
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: tiwai@suse.com, shuah@kernel.org, alsa-devel@alsa-project.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZPJUFG5PXJMTL6JNIRVZABKEBF6HHOP3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--moK3dVaIIIQiq0dD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 23, 2023 at 05:32:14PM +0300, Ivan Orlov wrote:
> Fix 'alsa' kselftest compilation warnings by making snprintf
> format correspond the actual parameters types.

What warnings are you seeing in what configuration (arch, toolchain, any
custom options...)?  I'm not seeing anything when I test.  Are these
perhaps architecture dependent warnings?

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--moK3dVaIIIQiq0dD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmP3gMkACgkQJNaLcl1U
h9CM4Qf9E0H850zw25V6gVtIWyUE7gWogdUbveseWkxHrigCVh4D6QNPMAPEhfZ+
hJHzOTntQ3rTerdrTVsAHTbv9CFFiJq/q/nHFgbaLzNtWZXEAGpc0SOaIyo3zpIX
EM7Q4yuMVgTCEwVXtyORE+866Mv/ZQdoLc1nLCkuXW5gRxFtitPyQaWppIT78ELA
L7ecbqFM5YzAPSrm3fz9GSXZZ0b7oDlWMh5JbW4ptilREvBwZoGEiXzS8iXYGk1K
4ikV3nfCjeIgTgOFvaAHY3RhpEpesaAA9yw1D4Xp/uRGtVYKVM6ox5KUQefRrixc
CSXH8aLRckd288owYYnZglJxk9fHKA==
=Hvq3
-----END PGP SIGNATURE-----

--moK3dVaIIIQiq0dD--
