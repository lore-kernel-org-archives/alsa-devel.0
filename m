Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7D4C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 16:47:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670B364EA9
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 16:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670B364EA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EB7C1723;
	Mon,  1 Feb 2021 17:46:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EB7C1723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612198050;
	bh=8FymX8TzgPanqDpwQ4nGQ8xwWxsgizKGDMfRwHbAds8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P+6rpsdZFPSNnvR4r1dPPAnZgBlEvXHTN1InR2RfwG2hagBhuICOGOisRatZePuHL
	 1RQeKOBQ81ciS+4u21gPnbzCrKV/oTgld/94T4UGWQadMTUit9TDcv7I2mKUE85BJf
	 nTQrOV/+I//ChKA7qLheP9Vx6LKKAPuP1cZegSdU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E79FF80153;
	Mon,  1 Feb 2021 17:46:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7FE1FF800E2; Mon,  1 Feb 2021 17:46:37 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 736E9F800E9
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 17:46:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 736E9F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jOIZG+ud"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BB3E60234;
 Mon,  1 Feb 2021 16:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612197987;
 bh=8FymX8TzgPanqDpwQ4nGQ8xwWxsgizKGDMfRwHbAds8=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=jOIZG+ud19ueb/yic+HQ3uKPwGHk8hA8UupCnQKRJOZGBvfK6GabCZPDfqI1R8SD4
 F+4WbKMMVSJG8HJINLnTlsxUAqPkdzpeWQFluiwnvwEN/c56Tw6JMDFJjISQV0AVJW
 /s+kmPogixFNy9UQXTwXwpmNrIEDO8zMsEGjjRCCppTfCx+YUEcJ9iMspSnedB5nmm
 T0hThMIqSZOspra2rT6/eThGjni/HEO7cweKXcegAmhJSpuhDY5hP5Ft17OOjZ08iK
 4weaVdljUTUGtahwrl3hQ9i26qd1jn+7aLfq5GPlQo5/g/9ALJJfLmzzNM6hbVmxUY
 Vv4V1TRUUDTCg==
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20210201093128.1226603-1-kai.vehmanen@linux.intel.com>
References: <20210201093128.1226603-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: topology: Prevent NULL pointer dereference
 with no TLV
Message-Id: <161219793995.46194.16146700113091709353.b4-ty@kernel.org>
Date: Mon, 01 Feb 2021 16:45:39 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 daniel.baluta@nxp.com, pierre-louis.bossart@linux.intel.com,
 lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com,
 Paul Olaru <paul.olaru@oss.nxp.com>, yung-chuan.liao@linux.intel.com,
 Bard Liao <bard.liao@intel.com>
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

On Mon, 1 Feb 2021 11:31:28 +0200, Kai Vehmanen wrote:
> When there is no TLV data in topology, extracting the TLV data
> could result in a NULL pointer exception. Prevent this by making
> sure that the TLV data exists before extracting it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: topology: Prevent NULL pointer dereference with no TLV
      commit: 941d3f0d7e9ffcbee1efeb6f07fa5fc5ef8347ff

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
