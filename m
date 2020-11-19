Return-Path: <SRS0=WcGQ=EZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208BAC56201
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 17:12:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3641E241A6
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Nov 2020 17:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kwGRF0uo";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="q51cnzkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3641E241A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94048172F;
	Thu, 19 Nov 2020 18:11:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94048172F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605805923;
	bh=Pl+VaTCd0Kg4ijGjNnnoD3cnGXyL0yjZsgVFyZZv8B4=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kwGRF0uo5HALFv+mNMeUD2iepkMcmumCEaa9XOzRVm60XpMdm2R5Sf8nreERl6lUw
	 Yyh8Q28ddQDaPFFw8x4ueuGHMHG4nsk4xVH39RrG+iN+mEZmefwWxw7iuD6MZeqcbJ
	 aEH18JTxMWPlB+cqAIV3O2aewrmNgUbRy0b7+jFM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E0452F804D2;
	Thu, 19 Nov 2020 18:09:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DD9CF804D6; Thu, 19 Nov 2020 18:09:36 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF1B9F804BD
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2020 18:09:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF1B9F804BD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="q51cnzkA"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 72CF924695;
 Thu, 19 Nov 2020 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605805772;
 bh=Pl+VaTCd0Kg4ijGjNnnoD3cnGXyL0yjZsgVFyZZv8B4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=q51cnzkA1wsaOBro1dZqgzSwM2FA2z5bpkQXLC2kDxqYB/xyLcwXj1/qhwclrEC0v
 Hf9Kk055Rr6PbrmS42lyq0x9H7V4i41L/N4Akoz/Pib7UKyQSnV65at2V+XKUC3kwh
 pFzBTtTfQhm03dNNG4J4BMAHawPWC7LsBwR1eu08=
Date: Thu, 19 Nov 2020 17:09:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Xiubo.Lee@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
 nicoleotsuka@gmail.com, timur@kernel.org, perex@perex.cz, festevam@gmail.com,
 alsa-devel@alsa-project.org, tiwai@suse.com
In-Reply-To: <1605768038-4582-1-git-send-email-shengjiu.wang@nxp.com>
References: <1605768038-4582-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_sai: Correct the clock source for mclk0
Message-Id: <160580573380.54454.17925861225420646982.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Thu, 19 Nov 2020 14:40:38 +0800, Shengjiu Wang wrote:
> On VF610, mclk0 = bus_clk;
> On i.MX6SX/6UL/6ULL/7D, mclk0 = mclk1;
> On i.MX7ULP, mclk0 = bus_clk;
> On i.MX8QM/8QXP, mclk0 = bus_clk;
> On i.MX8MQ/8MN/8MM/8MP, mclk0 = bus_clk;
> 
> So add variable mclk0_is_mclk1 in fsl_sai_soc_data to
> distinguish these platforms.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Correct the clock source for mclk0
      commit: 53233e40c142b1e0e1df9d9ac0ffc0945cfffbc9

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
