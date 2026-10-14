Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE22CC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:55:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 813CF60209;
	Wed, 14 Oct 2026 13:55:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 813CF60209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791978955;
	bh=/g7MCk/Gsb7irDnQX7W9ONQLd1+H+J5E0tN8p6IXwwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ybr9Elh/MgvflDCN/FuGK499u6dv4bv1SCi7WXeY7Th/V+VS5txpmnbeWu8PLIe82
	 JH88zxXhN8jJR5eKdIN2sa6aU7zygF7O14PZxC1X5mQzx1+V1XkeVUTgwLEqr5GCZd
	 OEwmIDYCwI6QpoePm7XXglRzSFK6AfeaRSa/yYTc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B5A8F805F5; Wed, 14 Oct 2026 13:55:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A07C7F805FF;
	Wed, 14 Oct 2026 13:55:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09BC2F80448; Wed, 14 Oct 2026 13:55:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791978915;
	b=TJ4mSVZUpMoNWQomXDJlkqSqv9RpOJHjPbW0A6LcHubS42eZc6mHKJaXBlLDM/WCZ3jp
	 VJw8DaxeB9yOwRlfRD+cpznq+082rptvpCDEnZJzEq8JK8jSiEGLd3pS996LoZxzaIQJq
	 zjItYG5WiRZw60MnQi/IeepbpqSUxmSOuKwsZiymH8GzF6BqdUON0roZyCBI5UdbkLCek
	 peFVcRB19qlsj80gCVd1sggxbkGuh7jUIsvPZfAbm2E96VhhjuKacL71XUKLHVqpHJeIm
	 yym0FGdtZjqQb2No/VNWNCsbr/KKZLYsfFwbaauhap4JrXijxT8MZxMUGIuTMU2HnmQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791978915;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=/g7MCk/Gsb7irDnQX7W9ONQLd1+H+J5E0tN8p6IXwwo=;
	b=Ryl9tucmabBNfAeWgBIhm0GIkUJcBEVjzQ0XQ6ZymuM4q0w8g1OwtJ6Yv+QDjXv9z1T3
	 V5JFsQYyJbZ7ZY9ANkZvBOgo4I3wOkXHOdPCpDMfOdB4Xgzw9CUupjGcTA7YDkmTSBil+
	 1XrixlRJBu0C67fQyZ1RbswD2tuji+2O9WtkMmzZ/Alt8DWYNB63UMK1lUTSdK6PYAljL
	 YH/dAuYUN/5fIj7NHrXkSbEvDhoubYs0NKKEPCsIPpVD94b5dYKd1xgs42GWg5gSXZptY
	 fPS6kpy6ePv/XGyRxlqvrWuteKTOszF941AJ98DEwXExUTzF/DdZkcBEIK1MSliko4w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=V7SdfNiF;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 32102F800FA;
	Wed, 14 Oct 2026 13:55:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 32102F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=V7SdfNiF
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2FE9443276;
	Wed, 14 Oct 2026 11:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0321E1F000FF;
	Wed, 14 Oct 2026 11:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791978909;
	bh=PJKVNYTz8cEA7hGglxgr5GsM/gY51wMpyvw03FfWbN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V7SdfNiFCB2UnrrV45qpKp1QdVKNEWYhnuhe1atCP2leLhMfwEOJaxgTODJ6QnOqI
	 4FnyA8xntx/xbNhnRqQ1onqAk9VbCtI2cWAk05QSvZniWTxZH14BPG8tlOjJVFBPRi
	 s5x5fdhwsAsgAg5+/gr7NAdaHH4sosnOBqTonp027Nq/FTBQKfeKnQ50OtDE/kmq8J
	 dW1EMcKHRnOz/J4aSJsKhcDyAM2WcKhB+FmaMgPAc5pIltlPPCsQRMvTXaQnkYGrIV
	 9MRMd3tqwAkfYW1UfkIlAnsZOqNE35u4//il60S6pcVFdtoOd9EBgABNo9OjZiIu97
	 WNH+yZekVcFQw==
Date: Wed, 14 Oct 2026 12:55:03 +0100
From: Mark Brown <broonie@kernel.org>
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
	tiwai@suse.com, yung-chuan.liao@linux.intel.com,
	Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
	venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
	Mario.Limonciello@amd.com, Richard.Gong@amd.com, Poojitha.N@amd.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v2 00/10] ASoC: SOF/amd: ACP7.B support and ASP carveout
 firmware loading
Message-ID: <1736b25e-608e-41ac-8e8a-4b0a125766ab@sirena.org.uk>
References: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
 <a22f2a9b-3bb9-40d0-80d6-4ce36758c4f5@sirena.org.uk>
 <031c7453-9652-4573-9de0-5db2a795562c@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DJ8TnKPIJwrD5pi4"
Content-Disposition: inline
In-Reply-To: <031c7453-9652-4573-9de0-5db2a795562c@amd.com>
X-Cookie: Live free or die.
Message-ID-Hash: NDEVVBBM25TJYPWUYDYYRPKSZYHIVL4O
X-Message-ID-Hash: NDEVVBBM25TJYPWUYDYYRPKSZYHIVL4O
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NDEVVBBM25TJYPWUYDYYRPKSZYHIVL4O/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--DJ8TnKPIJwrD5pi4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2026 at 05:21:00PM +0530, Mukunda,Vijendar wrote:
> On 14/10/26 16:14, Mark Brown wrote:

> > v1 is already in my CI queue, can you send an incremental change with
> > the new stuff in here.

> Posted an incremental patch set on top of v1.
> https://lore.kernel.org/alsa-devel/20261013154644.3788064-1-Vijendar.Mukunda@amd.com/T/#m6b17b469c043e46ee50a3a85903324c896c81c4e

Thanks.  If you're sending a series as opposed to a single patch please
always send a cover letter, it makes life a lot easier for tooling.
It'll be fine in this case, just a note for future stuff.

--DJ8TnKPIJwrD5pi4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrPbZYACgkQJNaLcl1U
h9ClEAf9E1iR7hCm+zDfCPNCNxOS+S3V475PoRtG/TmfBbZjSfoOOw29uu5HLg0R
qxGj6pLhkKs5wKkRNPgwvOEW3WdXvlD4g+9RqIvF+seqYwgPJIeEuv5EnuWerhyn
pQdcz7/5H2WIJQe3+nMkotDXKCRq9+8KLx5mMABAkZxzSEfhaHEDcDqVXDQezNnk
hJlHMv3C+QmxKfOb/cAjmsaLIp0S34DjdQw84pW0v5m5HTRZWvSlEy003ju6VK3K
fNmai/07viSQVnXIAH/TKuwlGfX/2709lZA/MQRcOlH+404QAzWr/tOkIRh+IKA4
0S7mvuNP4zSg3ORKxR5iV/ilC/lRUw==
=vqcW
-----END PGP SIGNATURE-----

--DJ8TnKPIJwrD5pi4--
