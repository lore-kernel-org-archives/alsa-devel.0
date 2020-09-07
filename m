Return-Path: <SRS0=BS+q=CQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE6DC433E2
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:07:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E3BE20738
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FBBtVEhV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcOH0Ip8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3BE20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C3E717C3;
	Mon,  7 Sep 2020 20:06:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C3E717C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599502024;
	bh=rE3Ye1LJjDh4Q/MkmWpKY6Vaa+V/PLVQe9Zo+jSeqVg=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FBBtVEhVq1TJXNhH3Vg2RRIrTBfAtm/4y/B24U/yjrZQK4lQOKhihtW7L7o50nQQx
	 6z+hZMt7/j12oL1T9etgkI82LzPoqwp0r7THJ3GTU4W6UzbouXezCAc+ENShE9S/Nz
	 HhHtAPbY4xX3xkGr567dQXGAyShu7ZpAxUEb0Qvo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EABACF8021C;
	Mon,  7 Sep 2020 20:06:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A21AEF80227; Mon,  7 Sep 2020 20:06:12 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C0B8F800B9
 for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2020 20:06:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C0B8F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="GcOH0Ip8"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 31035206B5;
 Mon,  7 Sep 2020 18:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599501966;
 bh=rE3Ye1LJjDh4Q/MkmWpKY6Vaa+V/PLVQe9Zo+jSeqVg=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=GcOH0Ip81cL7nMJQrpaZBzrt4lGyuzvds7VmuBroB0krc0fGArdVGKMX9XGCSINDN
 PjmhDZDpcfcAj2lYFMHHa7IuyeZKI4rzTvQofzpaT7Gjb7IgCrVVEKLg1M4akyXmBa
 bFDWWFYwIFNEYx6QR1JzIjZTX7jUV6pBkRBP9T/o=
Date: Mon, 07 Sep 2020 19:05:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20200907111939.16169-1-cezary.rojewski@intel.com>
References: <20200907111939.16169-1-cezary.rojewski@intel.com>
Subject: Re: [PATCH v2] ASoC: core: Do not cleanup uninitialized dais on
 soc_pcm_open failure
Message-Id: <159950192275.52707.2005794404543974482.b4-ty@kernel.org>
Cc: lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 kuninori.morimoto.gx@renesas.com, tiwai@suse.com
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

On Mon, 7 Sep 2020 13:19:39 +0200, Cezary Rojewski wrote:
> Introduce for_each_rtd_dais_rollback macro which behaves exactly like
> for_each_codec_dais_rollback and its cpu_dais equivalent but for all
> dais instead.
> 
> Use newly added macro to fix soc_pcm_open error path and prevent
> uninitialized dais from being cleaned-up.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: core: Do not cleanup uninitialized dais on soc_pcm_open failure
      commit: 20244b2a8a8728c63233d33146e007dcacbcc5c4

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
