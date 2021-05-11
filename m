Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9506DC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:28:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34F661622
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 08:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34F661622
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B51CD1777;
	Tue, 11 May 2021 10:28:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B51CD1777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620721733;
	bh=yX814QtGmlEUeWuzc2cmSHioA1C9NjdHxkqLmgy5cKU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C7loDkcVI5wh/mnYsBqIu/rtVT7Xbosk2YXQum+CEs9CE8vOHK56cqk4l67ldppsW
	 XCQJalp+9464UMdsp2uU5EegOnWfECPHvjAOzWeypUhlyp2vMIynFxXOTVGufIe2+E
	 rHIK2uui6d5hgLpoOLiqLlBgt8eJ//3NPhuJYoek=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36E37F801D5;
	Tue, 11 May 2021 10:27:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 17D8DF80245; Tue, 11 May 2021 10:27:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E112F80129
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 10:27:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E112F80129
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="U5xIm9DM"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2C1B613C3;
 Tue, 11 May 2021 08:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620721643;
 bh=yX814QtGmlEUeWuzc2cmSHioA1C9NjdHxkqLmgy5cKU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=U5xIm9DM+030Fdr83Joy1qxFGvwXpAS2hTP40CQ1fNfYNNJGMxOAtyonkC1a3Iw/v
 eiTD0DIoy+H35+TeCSwENki8WroQChFQxRHnlVsnjZW3SQGbZoQr4+Z5K64LuYyPGM
 ndKgFUA7Pzahh3UJRC8dIcbtE3d2Eu2ZuIEHu26TsAHBgXG12XhvRZrwV9HY+nsVyP
 MlcgjnIlKf72qGar8T2bn9e+OaCEVQxn/Dr7LmaX+j+0HUzzx+VQZhoehfAmHY/gKA
 0PVxt8chNbeds9nGtU4By/c10hv5tSHq9EzwvqDIg5IKByjqyS2y8f4bVNVauXL4lx
 N7yXjfvtlBJAw==
From: Mark Brown <broonie@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	oder_chiou@realtek.com
Subject: Re: [PATCH] ASoC: rt286: Remove redundant assignment to d_len_code
Date: Tue, 11 May 2021 09:25:43 +0100
Message-Id: <162072058170.33157.14418303282464363989.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1620298735-31708-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1620298735-31708-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org
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

On Thu, 6 May 2021 18:58:55 +0800, Jiapeng Chong wrote:
> Variable d_len_code is set to zero, but this value is never read as
> it is overwritten or not used later on, hence it is a redundant
> assignment and can be removed.
> 
> Clean up the following clang-analyzer warning:
> 
> sound/soc/codecs/rt286.c:728:2: warning: Value stored to 'd_len_code' is
> never read [clang-analyzer-deadcode.DeadStores].

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt286: Remove redundant assignment to d_len_code
      commit: 1d122dd3b168f55e2e29982cff80f1c15f66ef26

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
