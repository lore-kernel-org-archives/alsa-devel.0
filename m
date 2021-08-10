Return-Path: <SRS0=vr1N=NB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A3DC4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 15:21:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C896560FC4
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 15:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C896560FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 820DB847;
	Tue, 10 Aug 2021 17:20:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 820DB847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628608885;
	bh=jl3RsWR+UcsKoql2BcO8OIIxJBAOHD7TPFdPhmiPJnY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pOtHzbB/WN11ecz3Xiw+41R42HK0F3npnRR24Epw4pL0YgBf9WLGKWl4hXPFVhsJV
	 7UFJhJ5DZoH9iKqwUKXLBaa8jhqyEtugyvYbls7ReBqhZdFy69t/fW60jjUZyR0WWF
	 R2CfV1DOPt9YEGYWEAiY7MuB+cOZQT+vKR/Qru4g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 213CCF800C8;
	Tue, 10 Aug 2021 17:20:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69A54F80245; Tue, 10 Aug 2021 17:20:33 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A4B9F800C8
 for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2021 17:20:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A4B9F800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Yxael6Ct"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 292A760F25;
 Tue, 10 Aug 2021 15:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628608823;
 bh=jl3RsWR+UcsKoql2BcO8OIIxJBAOHD7TPFdPhmiPJnY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Yxael6Ct6ez1wKcenBPrC6z9pMpZhQPd/Qobfhbyh0UoHBomZPldm0Lmw+dv5Yc71
 yFDRjNByXH0vn6f4qrOdVKGO9S9YqJQjFPawXwnWpj018Xjb3jl7kfiSCJKOABfwED
 XgocEwIbrX/Wkya3t8F8aB/Cd80G57vm/3nlIBYZnTAahgxviQLZgAtt/lgOSAYAnP
 l2nW7j5/5SkXs3G8rhi6MipHqFE8AT7ZFT0kFuYfM1x4a4GawvZcc5JZczYLGMRG5G
 tROvZ8/chwMcew31YfaIQTxNVqfjM7qvp7DB6ksmGHn6UeXBBvWazDvm/TbVh2MZNc
 dGfq5AwQ6/rIg==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
	Curtis Malainey <cujomalainey@chromium.org>
Subject: Re: [PATCH v2] ASoC: Intel: Fix platform ID matching
Date: Tue, 10 Aug 2021 16:20:01 +0100
Message-Id: <162860604513.6045.9202565907130554514.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210809213544.1682444-1-cujomalainey@chromium.org>
References: <20210809213544.1682444-1-cujomalainey@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Rander Wang <rander.wang@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Matt Davis <mattedavis@google.com>, Mark Brown <broonie@kernel.org>,
 Paul Olaru <paul.olaru@oss.nxp.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Brent Lu <brent.lu@intel.com>
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

On Mon, 9 Aug 2021 14:35:39 -0700, Curtis Malainey wrote:
> Sparse warnings triggered truncating the IDs of some platform device
> tables. Unfortunately some of the IDs in the match tables were missed
> which breaks audio. The KBL change has been verified to fix audio, the
> CML change was not tested as it was found through grepping the broken
> changes and found to match the same situation in anticipation that it
> should also be fixed.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Intel: Fix platform ID matching
      commit: f4eeaed04e861b95f1f2c911263f2fcaa959c078

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
