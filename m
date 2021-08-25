Return-Path: <SRS0=JRP5=NQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98056C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 15:29:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC0761027
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 15:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BFC0761027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E17B168A;
	Wed, 25 Aug 2021 17:28:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E17B168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629905362;
	bh=m7p6daCSPgaKes4En6UWW7yVDDqC2Pu4GbLK9AYNzPA=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q9Y9Zsuj2KI+6Rqv/XU0/EKPzPepRO80xVjeNFW6m56BjbSPpJy+j9K+JSqcXiI9b
	 Htldv22jpP38gAscvjnZ6EqjT71DwsXSddlXqdVjWi5YPhsMJB0ntaOMPzNf1lSMc7
	 P/duIGIM+ulXVHpFWHPFt0onHUvejI/0MY/01sHE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8EF9DF804E5;
	Wed, 25 Aug 2021 17:27:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 574ABF804D0; Wed, 25 Aug 2021 17:27:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC349F800AE
 for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2021 17:27:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC349F800AE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="pwqs1G+F"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07C24610FD;
 Wed, 25 Aug 2021 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629905252;
 bh=m7p6daCSPgaKes4En6UWW7yVDDqC2Pu4GbLK9AYNzPA=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=pwqs1G+F8QgIMdzNMMHzE0kJbxkJNt+b1ROTl740x1V4KaRL8HKLsoRgtYHCuOq8B
 NSMyx+YhZ4l1jYSxxc2S3/u8PWayvsRd9sr9AsTZOEbk0oJ6qrTJZRXEFA/G+a1+XZ
 A1bUiridukYUIdmppaUUNtYamjRmRwJVZlp+Zdb6VO4nWeikhSJKSEjZzJJd0wG4ty
 HloV2VjYfH8l8063pC3RT7AEB4QYNxMIYYYnlk5PrkQRE1GkZzTT6lGB35Ov+I1C2M
 5/967vfvf2+L2ReL6C8bXjyOqX/1NacOO4v6+4FiB/94v4GXQ9n5yoeiH0kb9Xh4hA
 CXg394utPd6Ng==
From: Mark Brown <broonie@kernel.org>
To: nicoleotsuka@gmail.com, festevam@gmail.com, tiwai@suse.com,
 Xiubo.Lee@gmail.com, timur@kernel.org, alsa-devel@alsa-project.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz
In-Reply-To: <1629875681-16373-1-git-send-email-shengjiu.wang@nxp.com>
References: <1629875681-16373-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: imx-rpmsg: change dev_err to dev_err_probe for
 -EPROBE_DEFER
Message-Id: <162990401497.56501.6446443015923932557.b4-ty@kernel.org>
Date: Wed, 25 Aug 2021 16:06:54 +0100
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

On Wed, 25 Aug 2021 15:14:41 +0800, Shengjiu Wang wrote:
> Change dev_err to dev_err_probe for no need print error message
> when defer probe happens.
> 
> 
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-rpmsg: change dev_err to dev_err_probe for -EPROBE_DEFER
      commit: a8946f032eeace6eeb4e51e518275010e5528660

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
