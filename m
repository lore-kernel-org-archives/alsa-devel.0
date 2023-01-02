Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A02C4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Jan 2023 00:07:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A257751E;
	Mon,  2 Jan 2023 01:07:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A257751E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672618076;
	bh=jlPeJZeQYZ4yIPjGo8SjrONFcNbow4lvs25CiRF5HWg=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=U1ujMuMQwETLn76w3vwAzKPZHuzaU6u6XPTUmSL4zoKtkWtw+GvPEN8H7ERrYYl7z
	 NU7pLrK/legOVagHCM4Bq0/hzYFcYDTGjzM4LtPwDA4N5wnYDBPNAGlXci546DzsjY
	 YlzFgza5PMEII6gTWwxmnTKgJCUKRF3SC/+XLGyY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C69E3F802E8;
	Mon,  2 Jan 2023 01:07:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45018F803DC; Mon,  2 Jan 2023 01:07:04 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E5541F8023B
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2023 01:07:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5541F8023B
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oRy4qR28
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CA675B80B32;
 Mon,  2 Jan 2023 00:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77E3C433D2;
 Mon,  2 Jan 2023 00:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1672618019;
 bh=jlPeJZeQYZ4yIPjGo8SjrONFcNbow4lvs25CiRF5HWg=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=oRy4qR28cMs92DmL+zYulpiGpTOpXBm7+Ke1kGRHlrd8NhcGesQgqxjcr4ACTmFl7
 gTFhpLk/kCPBq9UpiJu2n2gfbkebsV6SCqA+ozRr1/Moyzeg3r2g1vlR8l2jLBAyTf
 K902C7NG+0rQ6oqoSW1Sc7uilD0DF841clUJCMKH5EkxsaOGLDRWiX7MqrFmFQsuZk
 mfa0ZnxbQuSrN/yFZMcXTIuzJokxVU1Mb5tRiBl8Uj6rmrX6dXabspo7UlN/KpbD68
 utzMtTOXj0LO62yUss2RmumVspbFdCZC0OHD75lzt7XXMj/Z4vcxpCyW/Qsorw3mFk
 k2vmbzuRRkPeg==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>
In-Reply-To: <20221231061545.2110253-1-computersforpeace@gmail.com>
References: <20221231061545.2110253-1-computersforpeace@gmail.com>
Subject: Re: [PATCH] ASoC: qcom: lpass-cpu: Fix fallback SD line index handling
Message-Id: <167261801758.166157.11703189928077074093.b4-ty@kernel.org>
Date: Mon, 02 Jan 2023 00:06:57 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-69c4d
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, 30 Dec 2022 22:15:45 -0800, Brian Norris wrote:
> These indices should reference the ID placed within the dai_driver
> array, not the indices of the array itself.
> 
> This fixes commit 4ff028f6c108 ("ASoC: qcom: lpass-cpu: Make I2S SD
> lines configurable"), which among others, broke IPQ8064 audio
> (sound/soc/qcom/lpass-ipq806x.c) because it uses ID 4 but we'd stop
> initializing the mi2s_playback_sd_mode and mi2s_capture_sd_mode arrays
> at ID 0.
> 
> [...]

Applied to

   broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: lpass-cpu: Fix fallback SD line index handling
      commit: 000bca8d706d1bf7cca01af75787247c5a2fdedf

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
