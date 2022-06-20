Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6BFC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jun 2022 13:08:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69326170F;
	Mon, 20 Jun 2022 15:07:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69326170F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655730485;
	bh=HHDQX3NlnZLPN1fa0iK8DZnWO6BfR1zyzteOcjoiVi0=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f5PqS5fHAZbJHJvrLdM9chgXEfQFMhnKsCKtQEYS86TuM8QLNowcdoVe499vjtHix
	 olEf6bi4Wfdp0dpr4NWk42YZyDRYH1Dk44lryjSNlsa4/LaqCFCrardqE0Hv1/zUxU
	 g4jK0+4Di8ymzeOZ1hRCSPxZScHAjF2PtrsPj4Bs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AAB88F804CF;
	Mon, 20 Jun 2022 15:07:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1FBB5F804D2; Mon, 20 Jun 2022 15:07:12 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7C56F800E3
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 15:07:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7C56F800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jDPIXvHQ"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1C8B061555;
 Mon, 20 Jun 2022 13:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51062C3411C;
 Mon, 20 Jun 2022 13:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655730420;
 bh=HHDQX3NlnZLPN1fa0iK8DZnWO6BfR1zyzteOcjoiVi0=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=jDPIXvHQX18UEYQlx4HNpijY7v08HdK6Z59LniMV9r6zv5YWWaYLYW5omi0xo5tNJ
 52P7pJC3yL817qJOTzi74pG3W7u4Z/7jXhpc7DWmoDsN9qbXbqyTomZp6cfw4YnywO
 EEJVxNjLTLRMQN1V6UoboeIjDmsV+CROjfZe5DP4TwrNJfEc1JJyN/B/a8C5ko9XrT
 X2HCWjphlXV+qI2lCAcoWuJ2G5xfQFw5n/cWypFAuQMewZSrAx+kcJS7vXd0I21Vf7
 M2GPQ3hYyJyz19+E5VOD6xwj2Y5LOg5cKW4cpIgMPfILwACbm/v91EaCZjFutI8SUj
 E5RWkgbTxPEgA==
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
In-Reply-To: <20220617210230.7685-1-srinivas.kandagatla@linaro.org>
References: <20220617210230.7685-1-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: update ASoC Qualcomm maintainer email-id
Message-Id: <165573041905.667528.13097598599735683089.b4-ty@kernel.org>
Date: Mon, 20 Jun 2022 14:06:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, tiwai@suse.com
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

On Fri, 17 Jun 2022 14:02:30 -0700, Srinivas Kandagatla wrote:
> Update Banajit's email address from codeaurora.org to quicinc.com, as
> codeaurora.org is not in use anymore.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] MAINTAINERS: update ASoC Qualcomm maintainer email-id
      commit: ad9894ac6cc1c1f7c36451d508d69f6ba677834a

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
