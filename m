Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C77C6377D
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 17:12:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB866101E
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 17:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB866101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE1A016FC;
	Thu, 22 Jul 2021 19:11:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE1A016FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626973935;
	bh=+rD2PKxj01stiGTanUKjIRztANneYKa/SZ3LruXgchc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eopOXnR+YKsGA4g/TsP9aN3FBFO2xQPsGWAR54k1GAoNuictByMzigVcCqw6ZgCx4
	 bdVSy8MjKbYv0R0kDZdJ9PtRj0aaRsc9ksmnRWFnpL5T/yS0NqUlOoGjWUoeKxn8Jg
	 zmOpE1A/KMBMgwM/5bjEkLv57a5oZEM+006zXiOQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8655EF800DA;
	Thu, 22 Jul 2021 19:10:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30C98F8049C; Thu, 22 Jul 2021 19:10:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 482C1F80218
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 19:10:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 482C1F80218
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="icYx9b0s"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CDAA610CC;
 Thu, 22 Jul 2021 17:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626973830;
 bh=+rD2PKxj01stiGTanUKjIRztANneYKa/SZ3LruXgchc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=icYx9b0swGiJQNxMBllLxkWlkhl++ExfWLPz5vQOGR9WLXdxQAY02thuCHIfRVy2v
 gXqWAbdIQXqcTlMfcYUuhAmvynD5aXJXIAGPwl2rDX2xSCSumgaAJU7Kj9xIKosw2w
 6ocfM7krt4dYE0PCoOUcl4yEYApADuYyIt5rIz8Jq036axqDSZEIXSlL5ypQ1ILKvE
 LzEQC/CZCb4dnscCSgMUUJHX3c+tlMmtcOX2fZSySbR3zFzRBBlxMd5YiN4uOs3COu
 G5mh0+mQfDc7tg4n14iXreSByLHP7dUMtpWa8w9JWKMDyc3JBlQ05cdoWtotz1AdIN
 lwKVMjej/wt6Q==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: Re: [PATCH] ASoC: amd: enable stop_dma_first flag for
 cz_dai_7219_98357 dai link
Date: Thu, 22 Jul 2021 18:10:02 +0100
Message-Id: <162697068327.1747.17528885369683390221.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210722130328.23796-1-Vijendar.Mukunda@amd.com>
References: <20210722130328.23796-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: Sunil-kumar.Dommati@amd.com, amistry@google.com,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
 Chuhong Yuan <hslester96@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 open list <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Alexander.Deucher@amd.com, nartemiev@google.com
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

On Thu, 22 Jul 2021 18:33:15 +0530, Vijendar Mukunda wrote:
> DMA driver stop sequence should be invoked first before invoking I2S
> controller driver stop sequence for Stoneyridge platform.
> 
> Enable stop_dma_first flag for cz_dai_7219_98357 dai link structure.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: enable stop_dma_first flag for cz_dai_7219_98357 dai link
      commit: 5434d0dc56bce4510109a431a7eb71ec5131ef0f

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
