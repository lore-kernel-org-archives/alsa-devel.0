Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3F2C52D7D
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Aug 2024 08:27:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 227B72BC0;
	Thu, 15 Aug 2024 10:27:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 227B72BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1723710477;
	bh=ptzjTGluuL+41Igjh0PWCntVwN8czL3T2wfcNMPpkKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=guGzG7e6KdzTvqnmGEGnqYY0x3EyuMuUCwkxKVOBA20qe49hT5ht1rfHLpbQaQAZQ
	 M25MNGCcB3LhKEaYtydlbISYes6NPnUBKylDSTH35lF0fMijswppaDlT1c9IeCS1AO
	 dOtR2uWGX7x1fcNGOBo/hsu3wCCuoqA1nPomTddY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 306B4F808AF; Thu, 15 Aug 2024 10:24:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B73FBF80C52;
	Thu, 15 Aug 2024 10:24:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42B22F80236; Sat, 10 Aug 2024 14:39:42 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E6FBAF80236
	for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2024 14:35:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6FBAF80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WY0M2ZL1
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4221B60C09;
	Sat, 10 Aug 2024 12:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21498C32781;
	Sat, 10 Aug 2024 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723293308;
	bh=ptzjTGluuL+41Igjh0PWCntVwN8czL3T2wfcNMPpkKU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WY0M2ZL1p77mv5fwSxY9HB6+2MkMxt8dYvk6lQoMd19QWPfRtnrnCaicdEJyismKh
	 bqxOR4w5yyWThGtYTsGCQVNA8KCPZflF4Ed5cCju3UFTgL/W0+hGlNs+puMijBVuZr
	 w6sNy7S7B9RKPQMgHVs/2NtMO9L02QYEyT+ttIWJPPVCOvvtRPrU+fZoExehV96k0R
	 VTMa/PdzXkrvcQfrR/kCgec5QCrQ8bS3yf4fmFtvlLG4O04lLeNeaaX6ZJtJyjF8Gi
	 gxdPalOxr/UD+3abDqxxr2Ul/6vGDQMN6whiMlE3cL2nEWizkn3h4M24nD0zm3YcTU
	 j8V6kL3lB3zYA==
Message-ID: <192e3c22-fd63-4891-86b2-89a3383ab76d@kernel.org>
Date: Sat, 10 Aug 2024 14:35:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add DisplayPort sound support for Fairphone 5
 smartphone
To: Luca Weiss <luca.weiss@fairphone.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240809-fp5-dp-sound-v1-0-d7ba2c24f6b9@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240809-fp5-dp-sound-v1-0-d7ba2c24f6b9@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-MailFrom: konradybcio@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: C5QU3TAAGTEPGD5EDCKOCQYPHQOT3MB7
X-Message-ID-Hash: C5QU3TAAGTEPGD5EDCKOCQYPHQOT3MB7
X-Mailman-Approved-At: Thu, 15 Aug 2024 08:23:28 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C5QU3TAAGTEPGD5EDCKOCQYPHQOT3MB7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 9.08.2024 10:33 AM, Luca Weiss wrote:
> Add the necessary sound card bits and some dts additions to enable sound
> over DisplayPort-over-USB-C, e.g. to a connected TV or monitor.
> 
> The UCM files can be found here:
> https://gitlab.com/postmarketOS/pmaports/-/tree/master/device/testing/device-fairphone-fp5/ucm
> 
> Two extra notes:
> 
> 1. I don't quite understand whether the sound driver should have
>    SoC-specific compatible or device-specific compatible. Some earlier
>    patches by another author for a QCM6490 board and a QCS6490 board use
>    device-specific compatible - but from what I can tell this is not how
>    it's generally done for other sound drivers?
> 
> 2. Unfortunately DisplayPort enablement itself for Fairphone 5 is not
>    upstream yet. This is blocked by DSI display bringup upstream which
>    is blocked by DSC 1:1:1 not being supported upstream yet and just
>    working with a hacky patch. Nevertheless, DisplayPort audio was
>    validated working with no additional sound-related changes so once
>    DisplayPort gets enabled, sound should also just work upstream.

You can enable DP and keep DSI disabled for the time being

Konrad
