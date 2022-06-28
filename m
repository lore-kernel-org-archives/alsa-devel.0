Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E39C43334
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jun 2022 13:26:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 241151DE;
	Tue, 28 Jun 2022 15:25:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 241151DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656422784;
	bh=YkY3YRpWZjvY3kzFvaZglL+Asozb4pp9bZcELGWrGP8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kVGUdJqWF3HTmFDxSBKouTGlOu/k6PucKZnLYjR44KLzXfbvFb00WhBFSBIwQ/w/s
	 AV0Mkx/1U4SwCZNcATwVRiQT1c/QsLz9wRoM4bvf+dGeTsH4k9fkPUJfUPnvpux3mm
	 BQYDX0LHXtUa8kw6D9mlkI5LADEdIBuN7MDh2gQM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AA9C0F80166;
	Tue, 28 Jun 2022 15:25:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1C4CF80107; Tue, 28 Jun 2022 15:25:31 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A7EACF80107
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2022 15:25:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7EACF80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fSjGTW16"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A8ED9B81E2D;
 Tue, 28 Jun 2022 13:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34723C341CD;
 Tue, 28 Jun 2022 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1656422728;
 bh=YkY3YRpWZjvY3kzFvaZglL+Asozb4pp9bZcELGWrGP8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=fSjGTW16tfddElttpgXGHZGOCkexNrDlFnx52h3IqdSzQcDln9QZJ76un6mbTjaEi
 3OpLPiRCAcgBBq8nggxSh4YZAJy/AlmjQF84WXQLTHO+iG3EG6pal8A3g56XJaIkPc
 75abf7TZSzKL2MNgWxUfBjLpl59aK9G5tMxfbVyTj4GxIv1Pe4gD/6sw5gBhM3STX/
 N6x8OrmFjOahz2y9YJFuOrh6MU3xkxkxiLZldmJu17w7+8Q77R1o5SEDRtvveXRWul
 4Z/dSTQxmJeAgfSwdB5Y8GeVo0RRWJ166v9l7M1F6YYjbGj6/lftIgdSMuSjJ6+Nbj
 VnQEi7jp74ayg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, bryan.odonoghue@linaro.org, bjorn.andersson@linaro.org
In-Reply-To: <20220628002858.2638442-1-bryan.odonoghue@linaro.org>
References: <20220628002858.2638442-1-bryan.odonoghue@linaro.org>
Subject: Re: (subset) [PATCH v4 0/2] Fix apq8016 compat string
Message-Id: <165642272593.1448965.607600751272662680.b4-ty@kernel.org>
Date: Tue, 28 Jun 2022 14:25:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org,
 srinivas.kandagatla@linaro.org, krzk+dt@kernel.org
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

On Tue, 28 Jun 2022 01:28:56 +0100, Bryan O'Donoghue wrote:
> V4:
> - Adds Bjorn's RB to first patch
> - Adds missing people to To/Cc list
> 
> V3:
> - Marks qcom,lpass-cpu-apq8016 as deprecated instead of removing - Bjorn
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: qcom: lpass: Fix apq8016 compat string to match yaml
      commit: 2a2ef688b1b03eea3a5b020d9bef50d015f619be

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
