Return-Path: <SRS0=Xywd=JL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B26C433B4
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Apr 2021 16:08:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FEC6112F
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Apr 2021 16:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FEC6112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94F6F1680;
	Wed, 14 Apr 2021 18:07:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94F6F1680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618416520;
	bh=L4F495iiGqUPwVJ4yGcCT0wnok09sJf0k66HFI3lKV0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XToK+q7GrsTHpTiFNAHdBIKJKKL7eAqe4KdoucOreUqn7anvFUc061oEWKv+vFiU5
	 CRWEsjkp9GTszNEpGoRD00a9c1rejzs7dTMguRTqWF2sdbLINErz8AvPRO0vd2l7sp
	 110R2OmmyqdKH/ecFgXpFcBOTzRvSBMmh8agd9FU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14BEEF8027C;
	Wed, 14 Apr 2021 18:07:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 48C81F80277; Wed, 14 Apr 2021 18:06:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D23EEF800EB
 for <alsa-devel@alsa-project.org>; Wed, 14 Apr 2021 18:06:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D23EEF800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="sMOacyPQ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92C3B611B0;
 Wed, 14 Apr 2021 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618416413;
 bh=L4F495iiGqUPwVJ4yGcCT0wnok09sJf0k66HFI3lKV0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sMOacyPQRr8/MPuUavf2Pn/pCNUvsu2u+/soswqXFs7ti8gxsIqCrnnOGoXrr14nv
 jgVfNHTpijfPBACmIMdeaKYFNwzmmEMo8WCnVCDih1tx22iujjn1kpJwm4I+FksnDO
 FK5kUm/KWi66DUSdc2O22y1lkNbBZrml/El2kDSsFs7UQ5BW7UOoOPc/KLx+TPl+3g
 fv0tUZ3EK0aIiy/lXosQR93QlwL+U62AVQqQKxlxtrN5bPEXV/foClBEfSSMWg+0Bb
 fHXUlhALVM1v/R69olzXhN8jF1pERGrgvtDEmTjkU7wEMfFfJ5lDhCCBELe/gEUdCL
 rqyH7DfzzBThA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, perex@perex.cz, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 -next 1/2] ASoC: ak5558: correct reset polarity
Date: Wed, 14 Apr 2021 17:06:22 +0100
Message-Id: <161841601730.20953.3339137188444911098.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1618382024-31725-1-git-send-email-shengjiu.wang@nxp.com>
References: <1618382024-31725-1-git-send-email-shengjiu.wang@nxp.com>
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

On Wed, 14 Apr 2021 14:33:43 +0800, Shengjiu Wang wrote:
> Reset (aka power off) happens when the reset gpio is made active.
> The reset gpio is GPIO_ACTIVE_LOW

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: ak5558: correct reset polarity
      commit: 0b93bbc977af55fd10687f2c96c807cba95cb927
[2/2] ASoC: ak5558: change function name to ak5558_reset
      commit: 4d5d75ce2b32577afef26a233119d8ee1b764ea7

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
