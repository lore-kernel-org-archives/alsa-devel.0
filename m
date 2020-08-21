Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F19C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:42:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595002072D
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 16:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Nqs0HwVv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFhKobVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595002072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB0261714;
	Fri, 21 Aug 2020 18:41:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB0261714
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598028132;
	bh=0Qa41WQlaYq/whDhAGtnEAcxJQQ+D6ScKD4SEYqiqdA=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nqs0HwVvTAIw9zK8/CxQma/nDBYj4SZtUnUg0iVrAM6vzCKRL035WybTeUP2ayLjp
	 Ed15s943HlCcSvCkjXn6gkn7PP/ruTHpspWhsql5wqpvsxtLPrfXcIbXGJRRV5UHqk
	 M+W/wCaobzYSVc+yG/fXBk3+i+icx5hIXrFtZqfI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0C4EF80255;
	Fri, 21 Aug 2020 18:40:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 29874F80253; Fri, 21 Aug 2020 18:40:27 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37B7DF800C0
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 18:40:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37B7DF800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tFhKobVf"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 54B9620738;
 Fri, 21 Aug 2020 16:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598028014;
 bh=0Qa41WQlaYq/whDhAGtnEAcxJQQ+D6ScKD4SEYqiqdA=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=tFhKobVfrzEG7yup28B6oQxCu0m22fBgl45+OOMhAm9D7nVDVZsOcc962F1Sz/OF4
 661BJ0vOFE/0lckXY67wn6Dev3Gxf4wID6Vj/z+CIK9DCpewVVcNRBKT1bc5iYurIQ
 c+K3prNzAP6vny8RTXe3CVki7na7i/iIm8KWIlFg=
Date: Fri, 21 Aug 2020 17:39:41 +0100
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, Bard Liao <yung-chuan.liao@linux.intel.com>
In-Reply-To: <20200820134542.8682-1-yung-chuan.liao@linux.intel.com>
References: <20200820134542.8682-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] ASoC: intel: sof_sdw: add .exit callback function
Message-Id: <159802798181.25503.2778020961455268836.b4-ty@kernel.org>
Cc: vkoul@kernel.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
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

On Thu, 20 Aug 2020 21:45:42 +0800, Bard Liao wrote:
> We may allocate some resources in sof_sdw_codec_info .init function.
> Adding a corresponding .exit function can help to release these resources.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: intel: sof_sdw: add .exit callback function
      commit: 751365035b4f360369ed6b0990283fd25d4ee32c

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
