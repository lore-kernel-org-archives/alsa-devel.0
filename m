Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEC5C04FF8
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Apr 2024 01:26:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60EB3B76;
	Fri, 19 Apr 2024 03:26:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60EB3B76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1713489972;
	bh=KGbKhUOEPigGgq2Jl8R0BeO4mee9gHipm6cfp8UjpCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=P9dxb7XIPwmh3th3jvfH0NUGdGoIRVxxzi+hgiNpVkOwuVGKEEWb56IpJZyUueX+c
	 waQ8vcz7crc5ly+kXjEhDMVO0vvixYeSpOzrgLrhyP9oTfXIt1D93xFOM9e0MKT74T
	 vEE1PMeRZV0UCOlVz4RzObRy11A4DalZ5flLBs54=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44FD2F80588; Fri, 19 Apr 2024 03:25:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D75CF805AA;
	Fri, 19 Apr 2024 03:25:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B5FB8F8025A; Fri, 19 Apr 2024 03:25:28 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5E166F8013D
	for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2024 03:25:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E166F8013D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=U7hTFuXW
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EF9EE615F3;
	Fri, 19 Apr 2024 01:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D78C113CC;
	Fri, 19 Apr 2024 01:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713489920;
	bh=KGbKhUOEPigGgq2Jl8R0BeO4mee9gHipm6cfp8UjpCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7hTFuXWS1rN4vRFGlZpm+5AcFc1ufUbobeGwi6IyoKnBzO1HQ8sc2yHfE5zY05N9
	 S997pklLR0BUTD0HpPceeLvU8w9eidARmOkYShmhZAB0T9WJnLCj4FGsJfmqacqTfP
	 BULyw+QCZfrr7OntnEyLb5Eis1eocVFSv5nWAF7FztMgqAabIClfSJx9bdGJeR5sql
	 9i8Ie+ZzcKBmbmhh+eIcIZQg5lqlo3HlSrD5K/g+nnCt6TmQLPsxINBcVrNiYDMQ4R
	 n52rLEpof1dysIbbHkpzte+Sf2kKESqkJGdgi6lu46Bt4nOCdP7MxMh/00B4qaNSAz
	 ESCIJwrwgQP0Q==
Date: Fri, 19 Apr 2024 10:25:17 +0900
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	linux-sound@vger.kernel.org
Subject: Re: Question: layout of a patchset dependent on another tree
Message-ID: <ZiHH_ZG3YebvefRj@finisterre.sirena.org.uk>
References: <2d1980e9-f5b2-4c9e-9348-af69166d0882@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Li+p0Qq5xCtvKgsP"
Content-Disposition: inline
In-Reply-To: <2d1980e9-f5b2-4c9e-9348-af69166d0882@intel.com>
X-Cookie: TANSTAAFL
Message-ID-Hash: 3IXLEUQL7E6XFYUSSB3G7QZ6JTO64P53
X-Message-ID-Hash: 3IXLEUQL7E6XFYUSSB3G7QZ6JTO64P53
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3IXLEUQL7E6XFYUSSB3G7QZ6JTO64P53/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--Li+p0Qq5xCtvKgsP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 18, 2024 at 01:43:25PM +0200, Cezary Rojewski wrote:

> I'd like to send changes which do modify the avs-driver but are dependent on
> ACPI/NHLT changes I've recently upstream [1] to Rafael's linux-acpi tree.
> Thanks to Rafael, there's an immutable branch [2] that has all relevant
> commits on the top.

> Should I send both the NHLT+avs changes and have broonie/for-next as a base
> for that or provide only the avs changes and state the dependency within the
> cover-letter? The latter will fail to compile without its dependency
> obviously.

I'd send based on the immutable branch so long as that will merge into
my tree easily enough (doesn't have to be perfect).  If it needs the
immutable branch merging into the ASoC tree first then I'd send based on
that merge with a note in the cover letter explaining this.

--Li+p0Qq5xCtvKgsP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYhx/0ACgkQJNaLcl1U
h9CQ1Qf/R4/qXGOmW5XJw5wzcAFG9D51e/SNzL1ah9HEm0NexPfBt/omw5PzS/aZ
abg8j9ZvPYpSxxhM/nGaJ0Qf5NzybfB1ebUkPIAVI/sXXyWJRqUIK3kLqQsyUQOx
K6PWoezrCP6yWrKU3zEjApLMud+fgThArQnz5n0pfJd4eyu5gyojIaeg7NiurtDV
IXchjctOsrWVAMzcoxh5NGjcfCMJQnsID6006jDazXp/aIiKevfUdtV45Yv1UTzr
YhkLZi+G9kmfRBJ+xCP5mT1fjQNpeQuargnhPJu0x9U+zb1XKHApKstYRoYhbzyc
FygHl6AsO8ynHIhMsMgRsDjRH0zPBw==
=8PLJ
-----END PGP SIGNATURE-----

--Li+p0Qq5xCtvKgsP--
