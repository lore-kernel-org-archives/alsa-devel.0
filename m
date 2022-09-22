Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A39C6FA82
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Sep 2022 11:26:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 86E3341;
	Thu, 22 Sep 2022 13:25:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 86E3341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663845974;
	bh=v+7aFLBrTrG2VuFQafpHnT/e0jXdZQZg+9U7s1XJtW8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J4YioFTx1ro27nRD6fJS4wLsWpWEhPAvfCFZH7ARjwXBdkMDnw0c9tgS23mkG2hFT
	 opjBftjmmAQJ+s8ClUVlzvyGh/ILsBqpP8ESgQFHWH6R3ERf8cnScmxqKLnU1VaSIi
	 6jsDfA6GTnInMwUKNtJwBjzYNg6057fgXPFChxAk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 231B1F80256;
	Thu, 22 Sep 2022 13:25:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B411F8027B; Thu, 22 Sep 2022 13:25:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0195CF8012A
 for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2022 13:25:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0195CF8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="UREMn3sf"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6038862C7E;
 Thu, 22 Sep 2022 11:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09721C433C1;
 Thu, 22 Sep 2022 11:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663845913;
 bh=v+7aFLBrTrG2VuFQafpHnT/e0jXdZQZg+9U7s1XJtW8=;
 h=From:To:Cc:Subject:Date:From;
 b=UREMn3sfYQ9V1lOsImaonWjEYUYOnmmfX6WzLmoAIi3LtiBzHqP2JhlxxeK+hrTSQ
 my+ZlWFE1Uve/qctUxXgeNIr3M0pMfNm4FRk4a4JsssdiZS/yhOoFTievSR9Kv0cf+
 kPlZnnEnPfubwJLrJf2DOIP7rxW0T0Xjlj94/WK1Ie/We1Qx/xg21PhASrNOV2bXhn
 xmMi0RbrgAcEqTgmjMh3BXioIeMtejlgfWSgISvIC/gY4P6wh3cPq/sw9mDcrayJyJ
 JUbP53oUDwE2s9MW5UeTS7bS+0nj8mSF30qmeps2qS1FEdNy53nqjP/1dqk0RGGrKO
 1EsKv3eQw+zQg==
From: Mark Brown <broonie@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: [GIT PULL] ASoC fixes for v6.0-rc6
Date: Thu, 22 Sep 2022 12:25:00 +0100
Message-Id: <20220922112513.09721C433C1@smtp.kernel.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
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

The following changes since commit 80e78fcce86de0288793a0ef0f6acf37656ee4cf:

  Linux 6.0-rc5 (2022-09-11 16:22:01 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-fix-v6.0-rc6

for you to fetch changes up to 0a0342ede303fc420f3a388e1ae82da3ae8ff6bd:

  ASoC: tas2770: Reinit regcache on reset (2022-09-19 18:48:43 +0100)

----------------------------------------------------------------
ASoC: Fixes for v6.0

A few device specific fixes, nothing too large, and a new device
ID for a Dell laptop.

----------------------------------------------------------------
Martin Povišer (1):
      ASoC: tas2770: Reinit regcache on reset

Oder Chiou (1):
      ASoC: rt5640: Fix the issue of the abnormal JD2 status

Pierre-Louis Bossart (1):
      ASoC: Intel: sof_sdw: add support for Dell SKU 0AFF

SJLIN0 (1):
      ASoC: nau8824: Fix semaphore is released unexpectedly

Shengjiu Wang (1):
      ASoC: imx-card: Fix refcount issue with of_node_put

 sound/soc/codecs/nau8824.c       | 17 +++++++++--
 sound/soc/codecs/nau8824.h       |  1 +
 sound/soc/codecs/rt5640.c        | 64 ++++++++++++++++++++++++++++------------
 sound/soc/codecs/rt5640.h        | 14 +++++++++
 sound/soc/codecs/tas2770.c       |  3 ++
 sound/soc/fsl/imx-card.c         |  4 +++
 sound/soc/intel/boards/sof_sdw.c | 10 +++++++
 7 files changed, 91 insertions(+), 22 deletions(-)
