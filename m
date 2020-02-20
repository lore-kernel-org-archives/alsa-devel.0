Return-Path: <SRS0=8DMN=4I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9108CC11D04
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 12:53:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E74D24654
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Feb 2020 12:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ib/iOXU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E74D24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64CFE1686;
	Thu, 20 Feb 2020 13:52:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64CFE1686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582203183;
	bh=UCXHpee8Fe2ZRHRCrRayNd1qvPurIX7DGHc7PK+7MJU=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=ib/iOXU0MC+x934SuD6MOi9zPULuw9si6Pj3IzGfXijJn2AGGfwYNL6m94wnMK6UE
	 YU/KX5t8FzwFDfNalpIe6olgGXjx8G3qMjMyenrp6bm9JIksu9DUtUQFTcqX8aYdGA
	 TFMKW/IHhvmKbQdZ7v051fnkOQdwfcqYakhFnhGQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D45BFF80148;
	Thu, 20 Feb 2020 13:52:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02296F8014A; Thu, 20 Feb 2020 13:52:11 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 55DF3F80114
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2020 13:52:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55DF3F80114
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 038ED31B;
 Thu, 20 Feb 2020 04:52:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79AA03F703;
 Thu, 20 Feb 2020 04:52:03 -0800 (PST)
Date: Thu, 20 Feb 2020 12:52:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Subject: Applied "ASoC: dpcm: remove confusing trace in dpcm_get_be()" to the
 asoc tree
In-Reply-To: <20200219115048.934678-1-jbrunet@baylibre.com>
Message-Id: <applied-20200219115048.934678-1-jbrunet@baylibre.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
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

The patch

   ASoC: dpcm: remove confusing trace in dpcm_get_be()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 9d6ee3656a9fbfe906be5ce6f828f1639da1ee7f Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 19 Feb 2020 12:50:48 +0100
Subject: [PATCH] ASoC: dpcm: remove confusing trace in dpcm_get_be()

Now that dpcm_get_be() is used in dpcm_end_walk_at_be(), it is not a error
if this function does not find a BE for the provided widget. Remove the
related dev_err() trace which is confusing since things might be working
as expected.

When called from dpcm_add_paths(), it is an error if dpcm_get_be() fails to
find a BE for the provided widget. The necessary error trace is already
done in this case.

Fixes: 027a48387183 ("ASoC: soc-pcm: use dpcm_get_be() at dpcm_end_walk_at_be()")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20200219115048.934678-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 63f67eb7c077..aff27c8599ef 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1270,9 +1270,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		}
 	}
 
-	/* dai link name and stream name set correctly ? */
-	dev_err(card->dev, "ASoC: can't get %s BE for %s\n",
-		stream ? "capture" : "playback", widget->name);
+	/* Widget provided is not a BE */
 	return NULL;
 }
 
-- 
2.20.1

