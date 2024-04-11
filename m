Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6701C4345F
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Apr 2024 17:49:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4BB2C2BE2;
	Thu, 11 Apr 2024 19:49:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4BB2C2BE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712857772;
	bh=9aJw8QoZy00PI1Vlq06euzR5zwJG7a7zFfna87TrmXU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FJ1UiOjgFuj9DbbjjwnCBMRf/DOVk8e89yhgcRehKNTFlBGvRsAL31YeOhazhozFN
	 14hEOonppRdgNyQWy8YYy4F+1N7Vk/99u6yA1Zt8gmBuQnSEkbTrXzuVze8pQm9Vkg
	 Q3PeMFJdxpPGukAFyr3HoIFuu+HaO5nEOZasyA9g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 39176F80568; Thu, 11 Apr 2024 19:48:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9842EF8057F;
	Thu, 11 Apr 2024 19:48:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AFB93F8028B; Thu, 11 Apr 2024 19:48:54 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 60DFEF8013D
	for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2024 19:48:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60DFEF8013D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oEd8xKdY
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 91EFF62102;
	Thu, 11 Apr 2024 17:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B96C072AA;
	Thu, 11 Apr 2024 17:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712857726;
	bh=9aJw8QoZy00PI1Vlq06euzR5zwJG7a7zFfna87TrmXU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oEd8xKdYy3jH3o3gCDEyDn2ste+PUbngtTrUbUy1QuoIMk6Sv8L1uCxR6jZc2qLZG
	 PFBy0Y4DM+YNfPIj6B6dZhP2BIl/BxtZpX0CNhRH52BAW8JfJoz5cZYrotT8Bgvad1
	 lWlrk9zVfCKUk+vHEUUH1JZYsAEJnml+0AjMKP4gWOAph2F7a/QkLy5zoM6QVSZYIi
	 KqpZGc5hFuJ7Gm957Y2Px11Rszgi6amml5yYH1j5xMmF8/mxKWWE0I1SNC0qHFovi+
	 SrnJhTWbwd5OEbf3qXN9lXpfmbTMv3emCDAwGNWUmrNTGfjBY0WH/9q71F6cEjUYCo
	 8q6gH3YDRJ6LQ==
From: Vinod Koul <vkoul@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
In-Reply-To: <20240403132716.325880-1-krzysztof.kozlowski@linaro.org>
References: <20240403132716.325880-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH RESEND] soundwire: qcom: allow multi-link on newer
 devices
Message-Id: <171285772329.544231.15578305335747563968.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 23:18:43 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
Message-ID-Hash: THN63RDNXBR36TE4TM2LXTRYI7VQM6UN
X-Message-ID-Hash: THN63RDNXBR36TE4TM2LXTRYI7VQM6UN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/THN63RDNXBR36TE4TM2LXTRYI7VQM6UN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Wed, 03 Apr 2024 15:27:16 +0200, Krzysztof Kozlowski wrote:
> Newer Qualcomm SoCs like X1E80100 might come with four speakers spread
> over two Soundwire controllers, thus they need a multi-link Soundwire
> stream runtime.
> 
> 

Applied, thanks!

[1/1] soundwire: qcom: allow multi-link on newer devices
      commit: ce5e811e069168898ae2ff02a90de68637ed7dc4

Best regards,
-- 
~Vinod


