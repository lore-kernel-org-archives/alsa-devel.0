Return-Path: <SRS0=DJp9=B4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F8CC433E3
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:07:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB32920786
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Aug 2020 17:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ue0CfN7K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uR9TA7jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB32920786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5CD8417D2;
	Tue, 18 Aug 2020 19:06:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5CD8417D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597770435;
	bh=kWZIADp0fbyfmlx1mMs190XGGSwSELp1BU6+YcV3YmI=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ue0CfN7KPjkHw53jsl3YTr0oD9s4rUknr6luALx98StuX6/gHhzUiqo3EHrqTddZT
	 2A9g28Ht2GEUSbUbSKYYZFC+b2RQb6CUIz8ojSYVgmGXA952P5Y3H8F6M6gdoEoa5Z
	 Zq8YLlGOetfX4YXv0xMe5Y+cbBpIrRDjn79O0BE0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D26F6F8036F;
	Tue, 18 Aug 2020 18:55:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CCAB7F80370; Tue, 18 Aug 2020 18:55:54 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 76A8EF8036F
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2020 18:55:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 76A8EF8036F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="uR9TA7jf"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7C32C207D3;
 Tue, 18 Aug 2020 16:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597769751;
 bh=kWZIADp0fbyfmlx1mMs190XGGSwSELp1BU6+YcV3YmI=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=uR9TA7jfh5MpSxsGF3Mqvhc3Fsc5jKlT8kz8nhAYvI6PhpdUCgS/WaisC3yk2A5tT
 ROtFHmSaDLjq5evfNlKoE4nSZ/exNXuKAxwZTp/GF+e+2d88toPBiXijAfHlQddONU
 Pj1/FYuHr5KtL9DjoOhvs/2C1+75NXErvmwFnvm0=
Date: Tue, 18 Aug 2020 17:55:20 +0100
From: Mark Brown <broonie@kernel.org>
To: festevam@gmail.com, Xiubo.Lee@gmail.com, tiwai@suse.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, timur@kernel.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, perex@perex.cz
In-Reply-To: <20200805063413.4610-1-shengjiu.wang@nxp.com>
References: <20200805063413.4610-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 0/3] refine and clean code for synchronous mode
Message-Id: <159776961930.56094.11883381459081946963.b4-ty@kernel.org>
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

On Wed, 5 Aug 2020 14:34:10 +0800, Shengjiu Wang wrote:
> refine and clean code for synchronous mode
> 
> Shengjiu Wang (3):
>   ASoC: fsl_sai: Refine enable/disable TE/RE sequence in trigger()
>   ASoC: fsl_sai: Drop TMR/RMR settings for synchronous mode
>   ASoC: fsl_sai: Replace synchronous check with fsl_sai_dir_is_synced
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: fsl_sai: Refine enable/disable TE/RE sequence in trigger()
      commit: 94741eba63c23b0f1527b0ae0125e6b553bde10e
[2/3] ASoC: fsl_sai: Drop TMR/RMR settings for synchronous mode
      commit: 7b3bee091ec375777ade2a37e4b0c9319f92de27
[3/3] ASoC: fsl_sai: Replace synchronous check with fsl_sai_dir_is_synced
      commit: 9355a7b1896f6fadcbd63d199d1f343bf2e4fed8

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
