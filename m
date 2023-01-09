Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA1FC54EBD
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Jan 2023 14:53:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AE997044;
	Mon,  9 Jan 2023 15:52:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AE997044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673275995;
	bh=rtqlm7a55WTBEGFP7RFDOv4Gy1EqcDD3WhvBsTOHcTU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QZVBd2+yFf2xDQcyMJcft9EC8Iyc4eMgfNKd9ybTK+R9QQYO9X6cAjTywXSsf/wSz
	 9zXqVfSPaD8hGujW1Y2oMI9PugvgXcvrneGFHEWW9cIcJalV22uN2P1FinYbYuO0xH
	 OMQurphQ7t1W72g3fBaHwY6hb2u857Eslo+5EvpE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7485F8053D;
	Mon,  9 Jan 2023 15:51:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 15084F8051B; Mon,  9 Jan 2023 15:51:53 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E2D4F800C7
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2023 15:51:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E2D4F800C7
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=SNC5IayH
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 41833B80D41;
 Mon,  9 Jan 2023 14:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77021C433EF;
 Mon,  9 Jan 2023 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673275909;
 bh=rtqlm7a55WTBEGFP7RFDOv4Gy1EqcDD3WhvBsTOHcTU=;
 h=From:To:In-Reply-To:References:Subject:Date:From;
 b=SNC5IayHplZ7eClBcJG5kR8lFBMJ2iqOylUBkV66SfusUKCYAXfGrvzLHM8dRslgJ
 tD0aerVmciqu7QCBsQUSDbW5wy803BF3D2ggVKidzBKOfk3qIEQqKJ2GKoLKUrQTOB
 kCJbK5G4sPiHIu8BuGZCfyrMfUALJwoXdInB6UnAMlXUWW8XDflkA5EUBNLR2gAkjo
 RNNgwwRn+Axo41AphGA/yZkfkSEzdBPfMkiBfGZEQXHLISCvnC9TpdYPtchRE3rBOz
 uGYp3/X9PMJCxt/UNj7WI0J58zIB/Y79asi+jFFv2fDnK5VW0iXXMXIh+AXlVbcx7H
 cyO7X1/OpgEbw==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221225115907.55250-1-krzysztof.kozlowski@linaro.org>
References: <20221225115907.55250-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,lpass-wsa-macro: correct
 clocks on SM8250
Message-Id: <167327590621.170440.11249846867635800211.b4-ty@kernel.org>
Date: Mon, 09 Jan 2023 14:51:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-8b3d1
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

On Sun, 25 Dec 2022 12:59:06 +0100, Krzysztof Kozlowski wrote:
> SM8250 DTS uses additional "va" clock in WSA macro device node:
> 
>   sm8250-sony-xperia-edo-pdx203.dtb: codec@3240000: clock-names: ['mclk', 'npl', 'macro', 'dcodec', 'va', 'fsgen'] is too long
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: dt-bindings: qcom,lpass-wsa-macro: correct clocks on SM8250
      commit: 69568267c5b624eaa86afcafbca1c4765f63e112
[2/2] ASoC: dt-bindings: qcom,lpass-tx-macro: correct clocks on SC7280
      commit: c9fb35f685b2f8a2ead98e3f1b249a1d4e9c040e

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
