Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA73C4345F
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Apr 2024 04:49:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DC082C17;
	Fri, 12 Apr 2024 06:48:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DC082C17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712897347;
	bh=majSr49xz6VE5z5e2UGn7sPKnKS4R4BoP42ZVgZdgqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iWEEfQW6Y+okKi9Gj43/dn3fK17QVhadRnIJiwq3fsUcSxHtsMG7AYC3qpYISLRxw
	 4UmxGeYM3YtNNvQy2k34W3Lnb93NxbYxSg35eHWYUcaAwtmTX55vc0LxRBNgGxqCW3
	 7P7XrXbQm+yM8kJ5a8F28YVA2EfJWf6YyeeLOooU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98AEAF80580; Fri, 12 Apr 2024 06:48:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CF71F805A8;
	Fri, 12 Apr 2024 06:48:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 953EAF8026D; Fri, 12 Apr 2024 06:46:15 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DA0EDF80130
	for <alsa-devel@alsa-project.org>; Fri, 12 Apr 2024 06:46:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA0EDF80130
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bkfiMQkR
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2BE8860ECD;
	Fri, 12 Apr 2024 04:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEACC2BBFC;
	Fri, 12 Apr 2024 04:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712897165;
	bh=majSr49xz6VE5z5e2UGn7sPKnKS4R4BoP42ZVgZdgqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkfiMQkRhl2FYJi6v2fssQAQxIob+KfKzHV0mHFii1I2+ER6EXHB1RZm6zCMhcnny
	 fhvSz6C9OXLUY2z+ZEu655gtN3X7rklxDKa9bK9DTJm0wUD5i5+JMQwq9KycqyZc5+
	 tuxqS1ICpDuFYpa88ZZoHQU76saD8HVSvPSYXKT4cn9n85hxkjHNM/way9w+sjWBWI
	 x+Yuul4yhSMFpVMMqw2XiX1i4b38K8zbC75Tw0lk+hxqPhj5V0MP/pmVeSULRRE0EC
	 aCMFE74AIiMjtViEyiW/HdNDtcx3DYaIpxwJWfgnAQXAkWeFcO9DVXOfefzpNf9zD3
	 RrczCnf1JAd4g==
Date: Fri, 12 Apr 2024 10:16:01 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] soundwire: qcom: allow multi-link on newer devices
Message-ID: <Zhi8iVDBtNckabjO@matsya>
References: <20240403132716.325880-1-krzysztof.kozlowski@linaro.org>
 <171285772329.544231.15578305335747563968.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171285772329.544231.15578305335747563968.b4-ty@kernel.org>
Message-ID-Hash: VA2IYK63LR5UM2B665YRGY3TXJXKEAPM
X-Message-ID-Hash: VA2IYK63LR5UM2B665YRGY3TXJXKEAPM
X-MailFrom: vkoul@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VA2IYK63LR5UM2B665YRGY3TXJXKEAPM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 11-04-24, 23:18, Vinod Koul wrote:
> 
> On Wed, 03 Apr 2024 15:27:16 +0200, Krzysztof Kozlowski wrote:
> > Newer Qualcomm SoCs like X1E80100 might come with four speakers spread
> > over two Soundwire controllers, thus they need a multi-link Soundwire
> > stream runtime.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/1] soundwire: qcom: allow multi-link on newer devices
>       commit: ce5e811e069168898ae2ff02a90de68637ed7dc4

b4 messed up and sent this, not sure why.. V2 was applied

-- 
~Vinod
