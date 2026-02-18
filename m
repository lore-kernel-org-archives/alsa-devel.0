Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D208EF8FFC
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:27:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BAD9602D9;
	Wed,  4 Mar 2026 17:27:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BAD9602D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1772641645;
	bh=PM/Uu2f8zmPIzVw+igFkjhrmaVqko/YFD5SiD0naaSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=q1jJ8+GfSqqjljQLt6McitNwLnW0p8kIxou6VQfFuey1NLargzoc0/PJEE/d4LbU8
	 w93iWYONnqHrPlb+vvbSitNUXdJIQTil2+0kLc9FpNgNMTsSa+Q1AYygvdiCo67H7j
	 i5sfJxX1n4DwugOtreMA+DQ2Uoxf8zSpFkBq7ldw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A18D7F806F0; Wed,  4 Mar 2026 17:25:27 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 90CF3F806E8;
	Wed,  4 Mar 2026 17:25:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2C65F804F2; Wed, 18 Feb 2026 16:18:18 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8A823F8045D
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2026 16:18:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A823F8045D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=l3m28IWg
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4FA9F600AE;
	Wed, 18 Feb 2026 15:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485D6C116D0;
	Wed, 18 Feb 2026 15:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771427894;
	bh=PM/Uu2f8zmPIzVw+igFkjhrmaVqko/YFD5SiD0naaSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l3m28IWg9BQhM1eZew6wCEio4p6zbSeJZWzfJ1jG8GgrQ1X3BATgeSDjff/PoBuu0
	 tb6zOQKbVt5a7VsClVYHIkjRKjwXpHbt+eo9GDt1Gegn1S9gF01aCh2Bt6cRkG8Qrw
	 72EWjNoqQOq8MYx1MvZOL+Ff6Qn6A/cGUpaXGqRZeVbdiGSp2fnipnntgcsYeetQHf
	 bc+TIfwypYOwO+NC4rknzQgeyq4AE7/k2XN/0963N4SfQU18TfCp1WKfxPWKiW8Z71
	 SIx4DXuMyzWuVdnT3ZwRuJZ9L/PFUozDXC1iDnrmiOAL7yFFbPMI0jQBe3HZu7ZcQd
	 LnBFgMsppUaBg==
Message-ID: <b9dc73ea-0157-4f4c-9c62-8a3deb5b9bcd@kernel.org>
Date: Wed, 18 Feb 2026 09:18:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ASoC: amd: add ACPI mach entries and quirk
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260218104734.3641481-1-Vijendar.Mukunda@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260218104734.3641481-1-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MailFrom: superm1@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: CWUPVZRAC2GUFWIDPRXPAHH6RJGXXU2G
X-Message-ID-Hash: CWUPVZRAC2GUFWIDPRXPAHH6RJGXXU2G
X-Mailman-Approved-At: Wed, 04 Mar 2026 16:24:49 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CWUPVZRAC2GUFWIDPRXPAHH6RJGXXU2G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 2/18/26 4:45 AM, Vijendar Mukunda wrote:
> Add ACPI mach entries for ACP7.0 platform for RT1320 + RT722 combination
> and include machine driver quirk for Lenovo laptops.
> 
> Vijendar Mukunda (2):
>    ASoC: amd: acp: Add ACP7.0 match entries for Realtek parts
>    ASoC: amd: amd_sdw: add machine driver quirk for Lenovo models
> 
>   sound/soc/amd/acp/acp-sdw-legacy-mach.c  | 16 ++++++++++
>   sound/soc/amd/acp/amd-acp70-acpi-match.c | 37 ++++++++++++++++++++++++
>   2 files changed, 53 insertions(+)
> 
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
