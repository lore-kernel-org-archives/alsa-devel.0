Return-Path: <SRS0=LtCP=G4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2A9C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 14:20:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 711532310A
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 14:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 711532310A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 962701841;
	Mon, 25 Jan 2021 15:19:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 962701841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611584399;
	bh=fYsDyTpc8wvz0Dpsy9WED60vadF1MFuzJBzxnFx4l/o=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RjDNx5n24CITuR1EpwN94mrtv5LKNTGJO6w3lXCBLMTc5fNvnwL0z/zNA1T8myam0
	 TVDqQvgyIhiFSG836SRaUAeWr5eCyeEkR2nh61l/ArznLJSc7sHWmvyfo1mSv6jto/
	 5QFk9YNyCdlRHXasSNRswi1yHtnWeZf1EZpjnMco=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C3EEF8025F;
	Mon, 25 Jan 2021 15:18:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DACB0F80278; Mon, 25 Jan 2021 15:18:13 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6B59AF8014D
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 15:18:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6B59AF8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VU5DBXcg"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BE5E2145D;
 Mon, 25 Jan 2021 14:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611584288;
 bh=fYsDyTpc8wvz0Dpsy9WED60vadF1MFuzJBzxnFx4l/o=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=VU5DBXcgejgroRHtoasGaXEd2Zp5RMXHS9BM0TcazQ0xIVDpRn2rlk5jwmgq426Hv
 X66sWbhGmdOZDichRZAg5orRlt76yhU9REv7z5ihYzW8w9MAjKnX3w9fWj3A7j722Z
 KJiQTyt6aEK5yQ4lCZhF0+pIXdspllTBjHw1raSFDtSAXqzxEvkctVzNVtwVpn5NZ0
 VZqYPSnL+HLjnLvQs9sr8NZ3d/FVCIjq9hv5S6HVzkSmaesnsqekNx0IT/WmgLyu63
 L2hsbtdJev4HiVlO1Rgm5okpVFVcm56Lwb50Ev0PE/YCFqnWQI6X4TqzlTYhYJdGyp
 ymk5Zx+Y/blag==
From: Mark Brown <broonie@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>, alsa-devel@alsa-project.org
In-Reply-To: <20210125081117.814488-1-kai.vehmanen@linux.intel.com>
References: <20210125081117.814488-1-kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: sof_sdw: set proper flags for Dell TGL-H SKU
 0A5E
Message-Id: <161158424212.32959.6636308393612395831.b4-ty@kernel.org>
Date: Mon, 25 Jan 2021 14:17:22 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Libin Yang <libin.yang@intel.com>, cezary.rojewski@intel.com,
 yang.jie@linux.intel.com, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, Hui Wang <hui.wang@canonical.com>,
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

On Mon, 25 Jan 2021 10:11:17 +0200, Kai Vehmanen wrote:
> Add flag "SOF_RT711_JD_SRC_JD2", flag "SOF_RT715_DAI_ID_FIX"
> and "SOF_SDW_FOUR_SPK" to the Dell TGL-H based SKU "0A5E".

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: sof_sdw: set proper flags for Dell TGL-H SKU 0A5E
      commit: 9ad9bc59dde106e56dd59ce2bec7c1b08e1f0eb4

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
