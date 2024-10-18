Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927E7D3F29E
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Oct 2024 21:31:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40001868;
	Fri, 18 Oct 2024 23:31:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40001868
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1729287103;
	bh=MBvpy7HNHufo7wLNxsJXwBL1fUDO4qNiLSPyC9CNR9k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ahDiFOohdSLj730GmXdLuOJYLjnZlo9/U88N7xlQ0Evge2xqzpRTrfmf9iYVFXDEQ
	 Szg8i3+cEDJ3g1NLcJd9m6MJ++7hIDKzt2vG5ri76j5ahsJ+vby+2QDediGPLk3Qgb
	 X+jmWEOmzPw6NMqQ/6rUwCmvfETxuzsUsOzd3eI0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E957BF805BE; Fri, 18 Oct 2024 23:31:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 54515F805D9;
	Fri, 18 Oct 2024 23:31:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B89C5F80448; Fri, 18 Oct 2024 23:30:52 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C6534F80149
	for <alsa-devel@alsa-project.org>; Fri, 18 Oct 2024 23:30:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6534F80149
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fJjLM/4n
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C1BE9A40204;
	Fri, 18 Oct 2024 21:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D1AC4CEC3;
	Fri, 18 Oct 2024 21:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729287048;
	bh=MBvpy7HNHufo7wLNxsJXwBL1fUDO4qNiLSPyC9CNR9k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fJjLM/4npGMaxDfWYLOMbTvcgUJ/4ikAk3+TAjzGKNxvNdiC5aAqQkNHb1QZtQnnt
	 IM/02lHUTohrU8D+wjbPTNmQLls2tAhvCfY1R899FwQX9cG6s+SkgV712yLCMrmLoj
	 //BNItpzUWJ3T/YY6U6eBoScChqqmIdcpR2hlDowZnOngS24YW3AbHRmmTZtpRSI4/
	 sR39CYgNlcsxl1u9VAYPebcBeMGoaMNNCA6ARGuz6e3OjWeium2QRMVzVpxSm+4Ndf
	 9LUTOA4H2qW7avESAvz/P1Kaa71i8WPfimT0nDIRDthNWqkDt8ud2cih4Jgii304Wv
	 pRuAJUjQOL63Q==
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org, a39.skl@gmail.com,
 linux-sound@vger.kernel.org, dmitry.baryshkov@linaro.org,
 Alexey Klimov <alexey.klimov@linaro.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
 vkoul@kernel.org
In-Reply-To: <20241016221049.1145101-1-alexey.klimov@linaro.org>
References: <20241016221049.1145101-1-alexey.klimov@linaro.org>
Subject: Re: [PATCH v2] ASoC: codecs: lpass-rx-macro: fix RXn(rx,n) macro
 for DSM_CTL and SEC7 regs
Message-Id: <172928704586.212383.11476018993792884716.b4-ty@kernel.org>
Date: Fri, 18 Oct 2024 22:30:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746
Message-ID-Hash: YDQSFC6QSRC6ISA7L73BIJ4BDTHWYECV
X-Message-ID-Hash: YDQSFC6QSRC6ISA7L73BIJ4BDTHWYECV
X-MailFrom: broonie@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YDQSFC6QSRC6ISA7L73BIJ4BDTHWYECV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, 16 Oct 2024 23:10:49 +0100, Alexey Klimov wrote:
> Turns out some registers of pre-2.5 version of rxmacro codecs are not
> located at the expected offsets but 0xc further away in memory. So far
> the detected registers are CDC_RX_RX2_RX_PATH_SEC7 and
> CDC_RX_RX2_RX_PATH_DSM_CTL.
> 
> CDC_RX_RXn_RX_PATH_DSM_CTL(rx, n) macro incorrectly generates the address
> 0x540 for RX2 but it should be 0x54C and it also overwrites
> CDC_RX_RX2_RX_PATH_SEC7 which is located at 0x540.
> The same goes for CDC_RX_RXn_RX_PATH_SEC7(rx, n).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: lpass-rx-macro: fix RXn(rx,n) macro for DSM_CTL and SEC7 regs
      commit: 9fc9ef05727ccb45fd881770f2aa5c3774b2e8e2

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

