Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5055DC4451B
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:37:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0ACEA60211;
	Sat, 18 Jul 2026 11:37:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0ACEA60211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784367453;
	bh=y1EbW524xeK96hTgUykTfbwl+Epc9aUPDMeJeNuPUb4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ePZPKyxYYlIIu1psI91s0z6Gm4fTs7PZisBjh1KTBRTi6pQPYxK7JFRYmn3qw/8eE
	 UGAhJ5n9b31uqRkL/e3enZyp5ls8ocvSKUgkp/sZmPS99EdE09CBBX0FB5zaMs7+Ed
	 ek9iZDUOwAVgAQnfkZYv2tgcrVZet451Yd660GT4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9E94DF80615; Sat, 18 Jul 2026 11:36:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FF21F80615;
	Sat, 18 Jul 2026 11:36:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1A9F0F8055A; Tue,  7 Jul 2026 19:49:23 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1783446562;
	b=MLTHZW/YQOX1t5fxHW2KQ11+p8u+Kygf6cGCleui4Yg9LtVtLOxN+pY9MbZQ9pXcRo+A
	 nfE3PbRrjFP4sEZ7z4VabS3Pss97UVJhQ8DIgcZE3tuXL1quH9svY+GpLUISmqNI45FRW
	 4mwmia/Mp5+obuQ6hmbKh3EGGJE8oaPJEULZlZRmpClkgqbiqd5G6Wia7eH95cUWbd8D9
	 3BH47+tPwofKgGFFKild4Ll+ppebnmXAGzFI1IsNO2YdV/MU/xgQaoAklsbEa/uwHUANs
	 fQaSYlLnx04lVIIMsxZ+z+O/G/OB2Uv+U+cWfV5yNgXbx8TLVNEnJ6SWK1b8ESqEWOA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783446562;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=y1EbW524xeK96hTgUykTfbwl+Epc9aUPDMeJeNuPUb4=;
	b=PFcMX1kug0ZC6gLYH33upzO7DEcvtmLhRV2iYFyZJFrlZeBhKrPHBnSl2bTugBUnFU0P
	 4c/0vvqbCW6/fO3mlU8YEdk/UEYJx16C4B38rDHxGGTjB9R0c7miTMynoXjDRYxCu3uS8
	 QaJ3BgBWIPaJ8v3hryXhBv1oVWmBgrKIbLbQRY/uYdrwojMUwArGe1n1n7Ub5wPgoEUMM
	 6H6cDySumo6SbcytMPW3FHM9P+CxoQJcDLZpFCuA7/wTlzo8JLV+TWb+23wTvx60x0oJD
	 rkoo5PVWMc1gQKPlvrhxNr3h5ufhtWUKhscmtRcnyg0/goYQRVopv1OcSNryjgnw3zQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KwMUeCoG;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6B345F8025A
	for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2026 19:49:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B345F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KwMUeCoG
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3EC91601E0;
	Tue,  7 Jul 2026 17:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321571F00A3A;
	Tue,  7 Jul 2026 17:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783446559;
	bh=h1FTRL+xnjk0AYFB/pvxSRsA2pAcCx47vH0N3sV3wus=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KwMUeCoGpqIwVV7wzTpHZmToO8iyWPJxkJWhzDqxzMVK3qdUULlm0O2lpxFbrPTxW
	 +YZz43nueTqUphAIv0LG/MhnXc12S/seFObgXDdYLRevESUpRATZjA1qBgRS8eUYgH
	 8e293lcc7V3NNsJ7Bo4V1fVcDQxIJdhL35ELnjrdbplOTqIojAhna35LqW7McNUGNr
	 gKtU9zK5MPiLMa5Yvo/+evxmeMruQ9K5fkwCOj5trq/8y02eYwj85MWBFqHH/VZCS0
	 FJ8OERXr8A8mlRgkDzaKtT+yKTEbUOYv+QC5A0LRAtG+tqpDXrhh4RppkIlyE7w945
	 MA/fOXek6FpSw==
Message-ID: <1ec22d6a-043b-4e10-956a-866d8d431011@kernel.org>
Date: Tue, 7 Jul 2026 12:49:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ASoC: amd: ps: bug fixes for ACP PCI driver
Content-Language: en-US
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 syed.sabakareem@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260707060130.2514138-1-Vijendar.Mukunda@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260707060130.2514138-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: superm1@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: ZHVY4NF3ID3VPEUHI2BSHOUJQ6C62IO2
X-Message-ID-Hash: ZHVY4NF3ID3VPEUHI2BSHOUJQ6C62IO2
X-Mailman-Approved-At: Sat, 18 Jul 2026 09:36:28 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZHVY4NF3ID3VPEUHI2BSHOUJQ6C62IO2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 7/7/26 00:59, Vijendar Mukunda wrote:
> This series contains three bug fixes for the AMD common ACP PCI driver
> (pci-ps.c) covering ACP6.3, ACP7.0, ACP7.1 and ACP7.2 platforms.
> 
> Vijendar Mukunda (3):
>    ASoC: amd: ps: disable MSI on resume in ACP PCI driver
>    ASoC: amd: ps: fix wrong ACP version string in pci_request_regions()
>    ASoC: amd: ps: replace bitwise OR with logical OR in IRQ return check
> 
>   sound/soc/amd/ps/pci-ps.c | 33 +++++++++++++++++++++++++++++++--
>   1 file changed, 31 insertions(+), 2 deletions(-)
> 
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
