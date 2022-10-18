Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC1AC43219
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Oct 2022 03:08:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B081F407D;
	Tue, 18 Oct 2022 05:07:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B081F407D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666062500;
	bh=NleOGOgHsVzK8x+TdSpwEiqKpO84mXV39srZaXakc70=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vc1pE1dRTfeMIbBn7PKEzX4rtFY/aAnurf1m9rCffGiiOEjRSVN6vhJeZjIhARWxY
	 nxFimsIgEvOsfnnv10FUJuyfnfWNiA0QazPOCQ5uFpPWp+DthH+lR018DD9C87fv/g
	 YzPRjykEd/GkSfgzMx/n4wefXYM2QSSqqvPfBx5E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 60485F8053B;
	Tue, 18 Oct 2022 05:07:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 82637F8053C; Tue, 18 Oct 2022 05:07:06 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C564F80535
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2022 05:07:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C564F80535
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VBZNbrdg"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B5B4261376;
 Tue, 18 Oct 2022 03:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C428CC43141;
 Tue, 18 Oct 2022 03:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666062421;
 bh=NleOGOgHsVzK8x+TdSpwEiqKpO84mXV39srZaXakc70=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=VBZNbrdgqL0JDxPyIyh1UUnMZMNVJIRL7djrIwdgKmeLXYpbOKlGI/FyAm48G+Wqg
 mBa6eKf4fthCbH92QeQzXq85g0ptsitMUCpWIFo9HBqTqp43Ryghp/wpGXgqGukd+9
 63PdR2DHzD6KPNgYiWpnlsfPwbFvzNLMMsEN3NtvAmI4KSTH3e69eXwOVN1n5oHAg9
 ovCGdFBc64Wswqtv2WB6Znbw2d99v9k7WRHjEkazyLgeGZnHupFELWdce95Q/jh17j
 rpS7b5HlytE7RH2mm3hPwFCk7A5ru3OlGU8bqOE7JYvDfTofVtNcaKl+dTWvMkRKmO
 JDP8gr9ls9Gnw==
From: Bjorn Andersson <andersson@kernel.org>
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, agross@kernel.org,
 srinivas.kandagatla@linaro.org, krzysztof.kozlowski@linaro.org,
 robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v2 00/11] arm64/slimbus/dt-bindings: convert to
 DT Schema, minor cleanups
Date: Mon, 17 Oct 2022 22:05:35 -0500
Message-Id: <166606235859.3553294.11708040908306667736.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220928152027.489543-1-krzysztof.kozlowski@linaro.org>
References: <20220928152027.489543-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, 28 Sep 2022 17:20:16 +0200, Krzysztof Kozlowski wrote:
> Changes since v1
> ================
> 1. Fix commit title typo (Steev).
> 2. Add Rb/Tb tags.
> 
> Dependencies
> ============
> No dependencies. Binding patches are independent from DTS.
> 
> [...]

Applied, thanks!

[01/11] arm64: dts: qcom: sdm845: drop unused slimbus properties
        commit: 0a4594886dd904b73541188c875bf378c463cbbc
[02/11] arm64: dts: qcom: msm8996: drop unused slimbus reg-mames
        commit: 9eae83f9ec9cee5cbc615fd6bc4221c7d62c07d5
[03/11] arm64: dts: qcom: sdm845: correct slimbus children unit addresses
        commit: 251ba7ee1674cb7608fa2c5da6c188e976e83481
[04/11] arm64: dts: qcom: mms8996: correct slimbus children unit addresses
        commit: e92a949e436e9956a2f99a07f9f4f640f42d8f99
[05/11] arm64: dts: qcom: sdm845: drop unused slimbus dmas
        commit: 7b027503c3620bcc8f60f3cef30ee3bc7f7aeede
[06/11] arm64: dts: qcom: msm8996: drop unused slimbus dmas
        commit: 3cc63b981bab83e8e439629e94ea96c1b3ae5888
[07/11] arm64: dts: qcom: sdm845: align node names with DT schema
        commit: 880d93355135515d842a41b7ff50f27daaeb3bec
[08/11] arm64: dts: qcom: msm8996: align node names with DT schema
        commit: 6414b1177e2e4f229b7807009f17ccf9491c6a44

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
