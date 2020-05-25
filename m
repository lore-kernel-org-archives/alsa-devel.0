Return-Path: <SRS0=YV0t=7H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C127BC433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2020 15:00:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E73420878
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2020 15:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YSoYkHJK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt8IWFBM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E73420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2B9D1725;
	Mon, 25 May 2020 16:59:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2B9D1725
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590418837;
	bh=xv7x59AoctvLsjyArJKKMotK6vJa0TElIvyKjP6jGP4=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YSoYkHJK3krt66bV4SUEi5owmU52b4Gm8KMddiIPTo0JT6ZKvrBAP6Vfzuq/rK1fD
	 HmFyMUuiVYGP5o1bUGRa9x6TpJWYpj5uJog8kt+8KFsLnjJr32NMlmA4Z8y4sOmJGv
	 CXvlLktwWwCtj8ylfqcRtIrY+AV3qZhW9vL5Z/60=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28879F802BC;
	Mon, 25 May 2020 16:57:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2239CF802BD; Mon, 25 May 2020 16:57:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8899AF802A9
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2020 16:57:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8899AF802A9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Vt8IWFBM"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7B3CD20890;
 Mon, 25 May 2020 14:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590418643;
 bh=xv7x59AoctvLsjyArJKKMotK6vJa0TElIvyKjP6jGP4=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Vt8IWFBMCLjX7YmfudACYHN6YkW0RjJpqgJvENaS7c5aEw29p6ZZk3RbUWC5/sUTM
 W0kL4PGYN3Yfjsa1p+kOX3PLGuw6Berq1xpEYkBhnH32um3c5Js0Xnp3yNsa9NDPw9
 S+yCeM8jYheAPvYy/g539gCH+E2VbaJCsC4CL+GQ=
Date: Mon, 25 May 2020 15:57:20 +0100
From: Mark Brown <broonie@kernel.org>
To: Xiubo.Lee@gmail.com, lgirdwood@gmail.com,
 Tang Bin <tangbin@cmss.chinamobile.com>, festevam@gmail.com, timur@kernel.org,
 perex@perex.cz, nicoleotsuka@gmail.com
In-Reply-To: <20200513111408.11452-1-tangbin@cmss.chinamobile.com>
References: <20200513111408.11452-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: fsl: imx-audmix: Fix unused assignment to variable
 'ret'
Message-Id: <159041861697.1370.3156349238499561936.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>
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

On Wed, 13 May 2020 19:14:08 +0800, Tang Bin wrote:
> Omit unused initialized value, because 'ret' will be assigined
> by the function snd_soc_component_read().

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: imx-audmix: Fix unused assignment to variable 'ret'
      commit: 085c02d355ac585184ef4f00eb333cd86f6add80

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
