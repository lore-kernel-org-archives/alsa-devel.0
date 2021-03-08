Return-Path: <SRS0=LCrH=IG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84AEC433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:10:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D33F65210
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Mar 2021 16:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D33F65210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7D2418C1;
	Mon,  8 Mar 2021 17:09:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7D2418C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615219816;
	bh=prCh/xGiHbNquextTbUBnmsLnM6OjHCR/I80pp00SsU=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qizHFwhTUEPOKj5f+d/JlTpNa02ZeKfA09qFps3vjj8VWdNurC/mCCEWU8CF5f6af
	 RSclpoUVHD1Jc08/gnNyUN4MyR4lNDS67PLvKX0T12tNQVFS04n1jM1UfmYILah98l
	 xoj+EbIkr41I6kiZ6+FJ8F+uoylM6vjH/jj7gzaQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E2B9CF80279;
	Mon,  8 Mar 2021 17:08:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57643F80430; Mon,  8 Mar 2021 17:08:20 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D708F80279
 for <alsa-devel@alsa-project.org>; Mon,  8 Mar 2021 17:08:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D708F80279
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="gb+oYKAX"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0756C65227;
 Mon,  8 Mar 2021 16:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615219695;
 bh=prCh/xGiHbNquextTbUBnmsLnM6OjHCR/I80pp00SsU=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=gb+oYKAXJIzpXVYIbMN1vWuHVFEeQWDYFCJe7JnEAYcWMq1fcar5Y47NtfhdeKvAT
 2MCwS8hQiY2NR1M5N09x/8zp4uT1xBWinGDnhJ2Dv3o2uw6IrsunmfqmxTmKRTFnH2
 nZ+l+7a6uMYn4iYc2cTp35BtBNR3mA459Ts5i+iLEn4akOuyM38Kwi1k+a0RMQLIzs
 zhbYQCnTPhtdZ9ZthYPpOn9M0ZPA7ea1RqW4a2dbqgy/ulRkbY1f7AUMUB7FiyqhzX
 2AWKRsLWIFuZGU5uc0Yo14Fy6B/YP3fs5GKdibkCtxooRy+6CVuJqljMMq22HDUwQw
 BF5lhUuaI2MHQ==
From: Mark Brown <broonie@kernel.org>
To: shumingf@realtek.com, lgirdwood@gmail.com
In-Reply-To: <20210302091506.18745-1-shumingf@realtek.com>
References: <20210302091506.18745-1-shumingf@realtek.com>
Subject: Re: [PATCH] ASoC: rt711-sdca: Add RT711 SDCA vendor-specific driver
Message-Id: <161521960848.9621.1458662142974315741.b4-ty@kernel.org>
Date: Mon, 08 Mar 2021 16:06:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, derek.fang@realtek.com, bard.liao@intel.com,
 flove@realtek.com, pierre-louis.bossart@intel.com
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

On Tue, 2 Mar 2021 17:15:06 +0800, shumingf@realtek.com wrote:
> This is the initial codec driver for rt711 SDCA version.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rt711-sdca: Add RT711 SDCA vendor-specific driver
      commit: 1cd2219246bd8a07d490e463ee24d2c813bb5b7c

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
