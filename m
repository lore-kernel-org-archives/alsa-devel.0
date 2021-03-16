Return-Path: <SRS0=ENK7=IO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B28CC433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 18:03:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1877B65132
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Mar 2021 18:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1877B65132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9BC22193A;
	Tue, 16 Mar 2021 19:02:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9BC22193A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615917815;
	bh=3R/vB/7tMgve+KQBBMahuJ86d+Jwqw3flfkV7zUdYPo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R2cQEkdGkYY5BikDDahROLLpRS7ffA9MT7kHzgvmP8o6fQ+xFJbB3YvS6RE5KpK7Q
	 dUnftUdpFanV1F8oNmALiDMp/a2KzChoEWaOhz8P86XF56Co137RB4CH01D31FIcQ3
	 BC4sW5pFmOUu2JCqdCaI1/okzmvEzhsqIyMnL/vQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FB84F804B1;
	Tue, 16 Mar 2021 19:00:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 218A7F804AF; Tue, 16 Mar 2021 19:00:25 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33131F804AC
 for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2021 19:00:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33131F804AC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="on8wn5iY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3575965134;
 Tue, 16 Mar 2021 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615917620;
 bh=3R/vB/7tMgve+KQBBMahuJ86d+Jwqw3flfkV7zUdYPo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=on8wn5iY+hTmZj0WcRhLLacBP55sAvgJ6lJQWjuz0SxTcA/JhtlNl8CmcvTMjejPY
 jkxVPvrDOg8LOcnC7iYgCIRDGV2dEL3L3oK4BKkCviDX7HNGkxREk4z5CBgvk2h+PT
 oVupmcurRB7Xs+RtVTg2pIAWjMN6ABztWP1DfdYrHz1MX7JxYpVnDLF/2MJ0OMjGV+
 hdEI+fObwtxcD/MEnaKQ/I0x3qD+hfqPjanlldJPcvOQgFZBwUr5Pp/MwvjnPTRzA6
 nENU/aJDKAh40WjgvxSCtHDZhFZsStfHjpEQnPMnBmj6TU2PvPlZLLQH3H/JsnfWfv
 GPdxKY1vktzfg==
From: Mark Brown <broonie@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>,
	lgirdwood@gmail.com
Subject: Re: [PATCH 0/2] Do not handle MCLK device clock in simple-card-utils
Date: Tue, 16 Mar 2021 17:59:48 +0000
Message-Id: <161591744695.13544.12030388405319375507.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1615829492-8972-1-git-send-email-spujar@nvidia.com>
References: <1615829492-8972-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
 jonathanh@nvidia.com, sharadg@nvidia.com, michael@walle.cc,
 Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

On Mon, 15 Mar 2021 23:01:30 +0530, Sameer Pujar wrote:
> With commit 1e30f642cf29 ("ASoC: simple-card-utils: Fix device module clock")
> simple-card-utils can control MCLK clock for rate updates or enable/disable.
> But this is breaking some platforms where it is expected that codec drivers
> would actually handle the MCLK clock. One such example is following platform.
>   - "arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts"
> 
> In above case codec, wm8904, is using internal PLL and configures sysclk
> based on fixed MCLK input. In such cases it is expected that, required PLL
> output or sysclk, is just passed via set_sysclk() callback and card driver
> need not actually update MCLK rate. Instead, codec can take ownership of
> this clock and do the necessary configuration.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: simple-card-utils: Do not handle device clock
      commit: 8ca88d53351cc58d535b2bfc7386835378fb0db2
[2/2] ASoC: rt5659: Update MCLK rate in set_sysclk()
      commit: dbf54a9534350d6aebbb34f5c1c606b81a4f35dd

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
