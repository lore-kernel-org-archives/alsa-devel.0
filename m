Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13672EB64DA
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Jul 2023 14:08:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C90DA1F4;
	Thu, 20 Jul 2023 16:07:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C90DA1F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689862117;
	bh=BS0X5yzg72EX3G7E13uL0WPBPoREFNzMn83URNwQ8Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RZG6D4F7yI/hzoS06HUZ1V5adY7ohPS/nzzVi/LpLr6ji6J8Gh7SgEfOg074R4fe9
	 2pEuN096YKuDFQoTQb56xQTG4WOghKOCQlINZ+Z7obpzsFUTRlKhcsNzkz91mSSgtY
	 D4paE/raLKPbsRkaLs71+pufxeSyHLj41zgXCX38=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 94E72F8047D; Thu, 20 Jul 2023 16:07:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F1556F8047D;
	Thu, 20 Jul 2023 16:07:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9BC77F8047D; Thu, 20 Jul 2023 16:07:16 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 26933F80153
	for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2023 16:07:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26933F80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=FpZ5rlZ9
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9FEE561AF8;
	Thu, 20 Jul 2023 14:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E34C433C9;
	Thu, 20 Jul 2023 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689862030;
	bh=BS0X5yzg72EX3G7E13uL0WPBPoREFNzMn83URNwQ8Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FpZ5rlZ9kq4emjeId0Khb5Rh8Rx+OQyXV4RI+hL7Uoj2BXCqpOkZRm8Fs/IXialJi
	 /dX1USOXstaVwWbuzUhcgX31PbRZX6hTgFN5Y3r4EZP45X3GCz8LH4pVIzaeS3ILt3
	 0cSca4U+znkD0x0HAfZmOPC/CxTCxy94w/N0sjkear1qLDKgVe9Zuvl+CSN5cy8mv6
	 E6Z2WBfww3F52NqtQFlFbk1GyL4jYnene0fIpnct3aKYAAWQUw7XM52uKXtzBysEIw
	 G/tcn2a8C74P30yH4k5FZZ95T9YmpIZuaAmG2mrAnkUxXYLjSrkPDuHiJk2o42m3l3
	 ZbC5ELI62p2+w==
Date: Thu, 20 Jul 2023 15:07:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
Subject: Re: [GIT PULL] ASoC fixes for v6.5-rc1-2
Message-ID: <3cda87c3-f502-4034-99a5-394c8e4195cc@sirena.org.uk>
References: <20230720130519.D1DFEC433C7@smtp.kernel.org>
 <87351ik9da.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F9zDDvvWegZUNHXD"
Content-Disposition: inline
In-Reply-To: <87351ik9da.wl-tiwai@suse.de>
X-Cookie: Ginger snap.
Message-ID-Hash: NPVLD5752H7UGBX7GM3WDNTKQMHMYMWW
X-Message-ID-Hash: NPVLD5752H7UGBX7GM3WDNTKQMHMYMWW
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NPVLD5752H7UGBX7GM3WDNTKQMHMYMWW/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--F9zDDvvWegZUNHXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 03:20:17PM +0200, Takashi Iwai wrote:
> On Thu, 20 Jul 2023 15:05:08 +0200,

> The shortlog is confusing as if this contains so many changes,
> although it's basically only three no-merge commits.

It got confused since I sent you an earlier pull request that hasn't
gone to Linus yet - not sure what the best way of handling that is, just
using your branch as the base blows up badly if I merge Linus' tree to
get platform fixes.

> In anyway, I pulled now.  Thanks.

Thanks.

--F9zDDvvWegZUNHXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS5P4kACgkQJNaLcl1U
h9DUjQf7B9WimS8lw3j3sRkx2i/gLRDbzE33Arz+62gdUOsW0W3wbj/XK19vtWxs
odiZ7GNeCcoJ/tB6A/+gIOkJQqZPBQ2aX2cTpt7tK+30+S49xPYlxsNfQYf/lrox
a4lsawT4OlHrGMw9EGjgK2wc3qvX2IRzdd1r+ccWGWRSWezXHhz2qUOu8f5tRDF7
Y/cIqkYb0wBxyRvPkUgHipr2hmklE0Q1UqXu/2Ipyw48fIpY6qMF/xRpbgUV6JoE
7WL6NGQ5yIGSB1l5lOoPRxyVIWwaLMGhyA34LTBWdRfdR+PtKR6XMjuC5K2IkOlY
lbzhGg34vVxY+szikjX10GO4QIE6sA==
=oM/2
-----END PGP SIGNATURE-----

--F9zDDvvWegZUNHXD--
