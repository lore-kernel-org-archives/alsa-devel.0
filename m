Return-Path: <SRS0=vkql=A4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EDBC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:41:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00ABD207DD
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 15:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sCb4CbxX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKXrsxpb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00ABD207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58BE11661;
	Fri, 17 Jul 2020 17:40:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58BE11661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595000507;
	bh=e39FbaMvv9oiVrlJ/4cxLI+F98AGNWyL8YjtvnwozfU=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sCb4CbxXHaOm75c7eGeG16qX9NNdfF+rcGewcv2kkWtmt9xMos8uO9kFuIsUwS3EM
	 +VoaTDNmErKyps9xepadw01ELLna/eNn9/LIfn0UUEZMhR1DsLy1cZXp5VKdrTrjfk
	 zDsoI7hvXreK7bE+YOVvzaLJ0/VlIM5ZvLmVJDSE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68D78F80110;
	Fri, 17 Jul 2020 17:40:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 979B3F800E4; Fri, 17 Jul 2020 17:40:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 121BBF80110
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 17:39:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 121BBF80110
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TKXrsxpb"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A79E22070A;
 Fri, 17 Jul 2020 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595000391;
 bh=e39FbaMvv9oiVrlJ/4cxLI+F98AGNWyL8YjtvnwozfU=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=TKXrsxpbg4OpY8A41Z8/ewdTz/7ojoSOqVn+SUXpfl8VBb20hvFaXA/u+XoYH/EMK
 1ilRRH+3fghv8Cu4OPVn14v7bG3TptidAFVsotVc9D7nuYNVl/N3MZRgq+YEYnyUo5
 zVCvs6luvW4EiZlhn439MEiTw2uyRVSPr9J+lAoE=
Date: Fri, 17 Jul 2020 16:39:40 +0100
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, tiwai@suse.com, plai@codeaurora.org,
 bgoswami@codeaurora.org, Tang Bin <tangbin@cmss.chinamobile.com>,
 perex@perex.cz
In-Reply-To: <20200714112744.20560-1-tangbin@cmss.chinamobile.com>
References: <20200714112744.20560-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: qcom: qdsp6: Use IS_ERR() instead of
 IS_ERR_OR_NULL()
Message-Id: <159500037997.27597.13743783362171527765.b4-ty@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
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

On Tue, 14 Jul 2020 19:27:44 +0800, Tang Bin wrote:
> In the function q6adm_open(), q6adm_alloc_copp() doesn't return
> NULL. Thus use IS_ERR() to validate the returned value instead
> of IS_ERR_OR_NULL(). And delete the extra line.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: qdsp6: Use IS_ERR() instead of IS_ERR_OR_NULL()
      commit: 16bf5e82facd703ba8f206f00f064e786ea8318c

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
