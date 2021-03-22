Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA9BC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 13:02:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D6AA61931
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 13:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6AA61931
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95E751612;
	Mon, 22 Mar 2021 14:01:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95E751612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616418154;
	bh=I1rM7cd8e3ihOuidStsjXpCvxgU1JeiBWj6CfWBrf9c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ouFgXbq1epp7IhrBpzHNe7CpJ0gjKxdV8UdXP5ulDLddpWr5GvKjfSEaK22KjpPdg
	 f8gHmPJZAlkePRDUYMCXr3C5ZioHirdnog4t/Oomw11juOPpIJs107v8yDDLdu3CYj
	 NBh8CXLC47x+FfogeGuK6Vs1CjwVN9VS05Ms6/fY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A418F80240;
	Mon, 22 Mar 2021 14:00:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 05D7EF8016B; Mon, 22 Mar 2021 14:00:51 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36326F80107
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 14:00:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36326F80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="RFdk6ckm"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9AC6601FF;
 Mon, 22 Mar 2021 13:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616418041;
 bh=I1rM7cd8e3ihOuidStsjXpCvxgU1JeiBWj6CfWBrf9c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RFdk6ckm9eiho+qzdSEVj3R7AXpWUyPH5xzgSXVyLnutLIrf0qAWBmBGGzPx+gTwZ
 je3PB2ZElXSDsJKiViOINfQcTlZSEPfYTW9FdmdbwPb6ceDYXPVMsMayHCJ5DqlE2x
 9eqvzFkZ/7UedCS9HC1SSndw/e/KNW886NoG1msvllmra12pcQusywpjEkSuiKrLWb
 u8Zn3+aDwGiomWJT5m9SZISSiOo2fxR/wWumCfSHn+r6IeVRg31HcSWYKCmSdKnRmI
 NfYXc8MeFDS+HeEDkny1SQEnfWLM7yY521nel4kyjn38Nxp5rXABNm/7MyZfohtL4W
 1m+8ik2SwURSg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, festevam@gmail.com,
 timur@kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org, nicoleotsuka@gmail.com
Subject: Re: [PATCH] ASoC: fsl_sai: Don't use devm_regmap_init_mmio_clk
Date: Mon, 22 Mar 2021 13:00:30 +0000
Message-Id: <161641797252.25992.12180615467371169455.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1616141203-13344-1-git-send-email-shengjiu.wang@nxp.com>
References: <1616141203-13344-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>
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

On Fri, 19 Mar 2021 16:06:43 +0800, Shengjiu Wang wrote:
> When there is power domain bind with bus clock,
> 
> The call flow:
> devm_regmap_init_mmio_clk
>    - clk_prepare()
>       - clk_pm_runtime_get()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Don't use devm_regmap_init_mmio_clk
      commit: 2277e7e36b4b8c27eb8d2fb33a20440bc800c2d7

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
