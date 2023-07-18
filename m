Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB92EB64DC
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Jul 2023 17:18:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C9E71F6;
	Tue, 18 Jul 2023 19:17:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C9E71F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689700689;
	bh=hOS8hHZ69rZwffHsfBNU1mv9uSJBfqr7PZFO7Qzp4zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IvBBSsCk9Qp/xxJfowyH6/g2A4aHmQGq4ZcQT5h6T2sfS1PQyrJQjzqdCtT6fMmCe
	 MhV7PXx3SkWi3AjaDrN4GUC26msZxXKUtTEJ9WuJEoI975UJ946BTTp4s7umrGJzw2
	 eHkOUvgiSQ2GbKRvkML+Cw7KzAgMfYz95/Q3p1K0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BA653F80494; Tue, 18 Jul 2023 19:16:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 57EB9F8032D;
	Tue, 18 Jul 2023 19:16:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E39DBF8032D; Tue, 18 Jul 2023 19:16:49 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EBB8BF80153
	for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2023 19:16:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EBB8BF80153
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qvMH347t
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8BFBF614CC;
	Tue, 18 Jul 2023 17:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897CDC433C7;
	Tue, 18 Jul 2023 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689700604;
	bh=hOS8hHZ69rZwffHsfBNU1mv9uSJBfqr7PZFO7Qzp4zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qvMH347thgaPRQviAhGECvzPYxGLqqeaiSZq+AvaobsLnUSrRYYrfFU67IRwlV+fc
	 VB2BSu88aYZWfVyp7WMlzq8KiHqASv6zNH6AG0fbYYIVoYGG6xD0r5oTifwWjkBZFg
	 xFBBjw0dBOsysTgW9SlW6gYHXQHZK6wrw23yWJEbJtSWsbloanoD1+4HTemMc1iHxg
	 jUYinyOQokWu22RrQxmyJQNknZROW5FVlvtYkC+W0zB15ccSXGjiCR5VqIbX6INhc1
	 Panipjui29c1zyyPdXIh6csBzxmi2XrGF0dI2fOXRkNkK6Zb073igSSZTBJssHQup4
	 9dNkl8kINr9BA==
Date: Tue, 18 Jul 2023 18:16:39 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	Lee Jones <lee@kernel.org>, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] mfd: wm5110: Update to use maple tree register
 cache
Message-ID: <b7a1884c-77fb-41c7-b660-10d2d5d68aae@sirena.org.uk>
References: <20230713-mfd-cirrus-maple-v1-0-16dacae402a8@kernel.org>
 <20230713-mfd-cirrus-maple-v1-8-16dacae402a8@kernel.org>
 <20230718154200.GG103419@ediswmail.ad.cirrus.com>
 <20230718170035.GH103419@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s1vFkW2z8enz8TEJ"
Content-Disposition: inline
In-Reply-To: <20230718170035.GH103419@ediswmail.ad.cirrus.com>
X-Cookie: Nothing happens.
Message-ID-Hash: PJ7THF7MCFJCZTA3PN3G7UKGR2PKEAJA
X-Message-ID-Hash: PJ7THF7MCFJCZTA3PN3G7UKGR2PKEAJA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PJ7THF7MCFJCZTA3PN3G7UKGR2PKEAJA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--s1vFkW2z8enz8TEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 18, 2023 at 05:00:35PM +0000, Charles Keepax wrote:
> On Tue, Jul 18, 2023 at 03:42:00PM +0000, Charles Keepax wrote:

> > This one appears to cause me some issues, seems to get the IRQs
> > into a weird state when doing compressed stream stuff. The
> > issue seems to also require commit bfa0b38c1483 ("regmap:
> > maple: Implement block sync for the maple tree cache") to be
> > present. So it definitely seems to relate to the cache sync,
> > but not sure if it is something todo with the device itself,
> > or the maple tree stuff yet.

> Ah... I think I see the regcache_sync sets async=true, but then
> the maple tree code immediately deletes the buffer after calling
> _regmap_raw_write. So its a racy use after free.

> How would we feel about having the maple tree code, clear async
> again?

I was going to say, it must be a maple tree issue.  I think we should
push that async down into the rbtree code, that's probably also broken
for other cache types if used in conjunction with slow buses...

--s1vFkW2z8enz8TEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS2yPYACgkQJNaLcl1U
h9Chbgf+IkhQ8KqyZmS/h4BdOV/WW+wNBQIFknq70iMrXrdCnF4wWE820V5uzfxT
GI1fFTyCYgfvzjrf/SL+av9jBU10AsOaPq2lfXHuQDIH3PFPPayE3yNRSBIIAyyu
an8AxQMPC1aP6G73M9e9rXD3R3I5XcMa5x74gc83LR/V4hPGfy1PW8kJlRJYLf71
srdqss69glOvET27EBCtho0eEYv1pH1KZIRXgPawBnJXnuaVzqw7Ppp61XPalERI
udkzoZvz5mvGb7mfnnYNi9MwYjQf47ycu0qcPoG9VWQbTlaeUwKIXpPEF4/zoYBu
Vb5Nsk+AtKwFkRtuDLF/NSu6BmHTyQ==
=EAHj
-----END PGP SIGNATURE-----

--s1vFkW2z8enz8TEJ--
