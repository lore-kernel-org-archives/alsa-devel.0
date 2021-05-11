Return-Path: <SRS0=Cjbi=KG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A0EC433B4
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 18:25:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D977B61264
	for <alsa-devel@archiver.kernel.org>; Tue, 11 May 2021 18:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D977B61264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5704918BC;
	Tue, 11 May 2021 20:24:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5704918BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620757520;
	bh=dycFQvBD5hPdP7nLkvlCvJ7Hv4xW5/M386OWJG+5YYQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RYFwP7m2HQMD73Op8f7KYZcFkQYYdCUG8ElfDSjKQmrM1AiUdBncgLy/gW9S0IqWD
	 Wguo0Od6RTkodi//eZNFk9oI/ZHXHlubN3Rn7NfTAVGXfk+ykP/hdVG7O0XUVf/s5I
	 uOAjqquDYI49ipLy3ts7dkuytYjca6d0IP0GD8ks=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64068F8016B;
	Tue, 11 May 2021 20:22:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DDDFF804AE; Tue, 11 May 2021 20:22:45 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 356ABF80245
 for <alsa-devel@alsa-project.org>; Tue, 11 May 2021 20:22:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 356ABF80245
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="t+XZAu7H"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 392156186A;
 Tue, 11 May 2021 18:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620757361;
 bh=dycFQvBD5hPdP7nLkvlCvJ7Hv4xW5/M386OWJG+5YYQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t+XZAu7HZYo9ammqUL45wFBMwMK3JsYixjjRwCt9TGzoZUE8GwhAipKAxZfSomIOC
 PQYTsUUkrowxMDhgnKty4bZEkYspTikm4J6ASgGTKusN3qDN8g4640rwRRJd149Wsb
 sU97BdEW1yh+/gxcpeGat3YyzsROUAArWy9IBndRIn++ulh4e0onXQ7xEPawNSwssT
 wxsU+uK5DTanXAiT4U4QwEbKJKBvq2v23rlkUS9vy7I6e3UJiTNFRMUtHqOoBNwPO3
 VjN+ADVpY32FC0zo7xK3I3d6k6ftusAau6WMCevrr2OQvXdSUQ3Vvvj9UtBkpEbpnl
 H0Y/kM7Rkc3xg==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/5] ASoC: cs53l30: Add missing regmap use_single config
Date: Tue, 11 May 2021 19:21:33 +0100
Message-Id: <162075713911.17925.15118980424314147257.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210511175718.15416-1-ckeepax@opensource.cirrus.com>
References: <20210511175718.15416-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 Mark Brown <broonie@kernel.org>, james.schulman@cirrus.com,
 david.rhodes@cirrus.com
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

On Tue, 11 May 2021 18:57:14 +0100, Charles Keepax wrote:
> This device requires single register transactions, this will
> definely cause problems with the new device ID parsing which
> uses regmap_bulk_read but might also show up in the cache sync
> sometimes. Add the missing flags to the regmap_config.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: cs53l30: Add missing regmap use_single config
      (no commit info)
[2/5] ASoC: cs42l73: Add missing regmap use_single config
      (no commit info)
[3/5] ASoC: cs35l34: Add missing regmap use_single config
      (no commit info)
[4/5] ASoC: cs35l32: Add missing regmap use_single config
      (no commit info)
[5/5] ASoC: cs42l52: Minor tidy up of error paths
      commit: 4ac9b48adf4d561d0e33419d548278f205dd70b5

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
