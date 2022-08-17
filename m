Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A375BC25B08
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Aug 2022 14:32:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB25E1658;
	Wed, 17 Aug 2022 16:31:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB25E1658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660746768;
	bh=WQSEZi/ZThfpTh3nKayykvCckCTb+dDa/U+rPQf6mQM=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hB8Qb53Q6/BFZHfbli0U41iGX9am/aFjFSt8WdwVWzGBkm85m+0quG8nEwIfGIDbu
	 qGyAudk6Tgw6WS2STdeD3jhu9k5CkyePEg45wRB8eWwtBGsNKqexPhREnSl0OgN8lV
	 tk7WPO7/+PfIO45pzsrqmffE6dYCd4tuf5NmLXpQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26CD0F8042F;
	Wed, 17 Aug 2022 16:31:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A74BF8042F; Wed, 17 Aug 2022 16:31:12 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 165FAF80301
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2022 16:31:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 165FAF80301
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="dlSU1hK7"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 82A4B614BF;
 Wed, 17 Aug 2022 14:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EB88C4314C;
 Wed, 17 Aug 2022 14:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660746668;
 bh=WQSEZi/ZThfpTh3nKayykvCckCTb+dDa/U+rPQf6mQM=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=dlSU1hK7riqxokULnT4opq7DBwokkzZ9sLHnQi+h8AQgYWkFjkeDfS3vWa87ET/hW
 UFb+OzMBm9VIeWblR5iJP3PcQU+9bY5n6SPPUxiLRpjTg0GGvuaKjBNGlf0pbxe/pK
 aHUslcb1xABNBQZMmMOFTgBggpwqVMOMABoNZa3KsUjfM0YgyYkQF3gpPDbEEX5emB
 j7jx8RY+BY2/bsiQ7mORRua0D2bHePWTHv0k1D58thvlVwn4s4JXp4obByPAttD4UF
 sqLAd3lOy7ytkl7QQngsFJ7hvplaFb7kLgbxTPyaWh3HBPmplKCReNh88q4I0HGDNW
 ymMHCFuAhvTAQ==
From: Mark Brown <broonie@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20220817091519.2487385-1-yangyingliang@huawei.com>
References: <20220817091519.2487385-1-yangyingliang@huawei.com>
Subject: Re: [PATCH -next] ASoC: codecs: es8326: change es8326_regmap_config
 to static
Message-Id: <166074666705.210979.15448004360447274699.b4-ty@kernel.org>
Date: Wed, 17 Aug 2022 15:31:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-fe10a
Cc: zhuning@everest-semi.com, yangxiaohua@everest-semi.com
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

On Wed, 17 Aug 2022 17:15:19 +0800, Yang Yingliang wrote:
> es8326_regmap_config is only used in es8326.c now, change it to static.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: es8326: change es8326_regmap_config to static
      commit: 5c69f11ce85d4a8ea985a6d266574577e94c6506

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
