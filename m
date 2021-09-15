Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE21C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 15:24:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCC160F5B
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 15:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FCC160F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0705182F;
	Wed, 15 Sep 2021 17:23:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0705182F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631719459;
	bh=Iq2sTH/qaofQ6nEZPTBwlq8y5cvB7EpizEHayA1L/JY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dkGXGzo9WAdUH8BdXZL1SSnuFT3VWRV/ZRZxfL4NkS+u1A1IK2j1fRSGMmkMHPjDL
	 SzJa/aPrKw5Ccnokr1Hojy1cYULlJzyt/q4ZJbbzqmxMaiWKarZTsRw/kRCrGUE4GV
	 3SIygzSBOcfVsJN7tomVP1mEKiisp3ij/hOpJpT4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 12521F8032C;
	Wed, 15 Sep 2021 17:22:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7826F804BD; Wed, 15 Sep 2021 17:22:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C144DF80227
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 17:22:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C144DF80227
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="PTwW6egG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id E12F660698;
 Wed, 15 Sep 2021 15:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631719359;
 bh=Iq2sTH/qaofQ6nEZPTBwlq8y5cvB7EpizEHayA1L/JY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PTwW6egGz/krolNSjeCL+AgsNjdoBFmMRI+WQ8GmJtH74J72fj1fmYOo6mSD627UR
 nyYIL7CdMwRnym8fr22qINBSlyUA+KkJPZT2mJU3WygeFvyDRx/g2ZNwRloJNXA9cW
 G1eBZ/TwOKEyLxFuAFF+SUr76xEZ3+cg7BmTchohgbh7c3guN7dlQKrkuQnYVQeuTm
 KmxKbdfWX4ytnwS1ewyGXBeRG0mTNqOKlYwt/A0fCvguNpNXH04PnddbO+pjUKEITQ
 spSYwmlxzc9JwzPpOEGqBuKrOe7pR9nhK7NN2Wrtcf0I8vW91NswKocU25+fvRWtaX
 vz35CvADgDDVw==
From: Mark Brown <broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Bixuan Cui <cuibixuan@huawei.com>, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH -next] ASoC: mediatek: mt8195: Add missing of_node_put()
Date: Wed, 15 Sep 2021 16:21:44 +0100
Message-Id: <163171901942.9674.2137516879503383986.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210911081246.33867-1-cuibixuan@huawei.com>
References: <20210911081246.33867-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.com,
 Mark Brown <broonie@kernel.org>, trevor.wu@mediatek.com,
 matthias.bgg@gmail.com
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

On Sat, 11 Sep 2021 16:12:46 +0800, Bixuan Cui wrote:
> The platform_node is returned by of_parse_phandle() should have
> of_node_put() before return.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mediatek: mt8195: Add missing of_node_put()
      commit: b2fc2c92d2fd34d93268f677e514936f50dd6b5c

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
