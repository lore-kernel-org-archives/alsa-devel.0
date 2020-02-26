Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5884C4BA24
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:52:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5F620714
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f9AvHIjG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5F620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 773E8169B;
	Wed, 26 Feb 2020 19:51:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 773E8169B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582743133;
	bh=bHNKURmu+SQCGAmgcoQ3e6NzJIGYKu/B6HERhQdXwPA=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=f9AvHIjG2D71kgGZgWns6fXhgr7AcGzDCXMssgMRSqKOZi7nwipk35uHaiitGojaD
	 1xygjtCbXi6juurX0G6ctYoypGOpZYZWWXP+tRA7O+q6u+N0QUOZgRotLOZMv3UFbB
	 Ontn5g/6aZE6Jk/pnAAsGd9cV+rn66X6427u3rEs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57998F802BE;
	Wed, 26 Feb 2020 19:47:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C16CFF802A9; Wed, 26 Feb 2020 19:47:42 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id C77F8F8028F
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 19:47:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C77F8F8028F
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B99B031B;
 Wed, 26 Feb 2020 10:47:38 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0524A3F881;
 Wed, 26 Feb 2020 10:47:38 -0800 (PST)
Date: Wed, 26 Feb 2020 18:47:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Applied "ASoC: soc-dai: add get_sdw_stream() callback" to the asoc
 tree
In-Reply-To: <20200225170041.23644-3-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200225170041.23644-3-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Hui Wang <hui.wang@canonical.com>,
 vkoul@kernel.org, Mark Brown <broonie@kernel.org>,
 srinivas.kandagatla@linaro.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, jank@cadence.com,
 slawomir.blauciak@intel.com, Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

   ASoC: soc-dai: add get_sdw_stream() callback

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

From 36d73c4a9ed7c8a0988cfb9d1282c62d8c422a3b Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 25 Feb 2020 11:00:40 -0600
Subject: [PATCH] ASoC: soc-dai: add get_sdw_stream() callback

We only have a set() operation, provide the dual get() operation to
retrieve the stream information.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200225170041.23644-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-dai.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 92c382690930..7f70db149b81 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -202,6 +202,8 @@ struct snd_soc_dai_ops {
 
 	int (*set_sdw_stream)(struct snd_soc_dai *dai,
 			void *stream, int direction);
+	void *(*get_sdw_stream)(struct snd_soc_dai *dai, int direction);
+
 	/*
 	 * DAI digital mute - optional.
 	 * Called by soc-core to minimise any pops.
@@ -423,4 +425,23 @@ static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
 		return -ENOTSUPP;
 }
 
+/**
+ * snd_soc_dai_get_sdw_stream() - Retrieves SDW stream from DAI
+ * @dai: DAI
+ * @direction: Stream direction(Playback/Capture)
+ *
+ * This routine only retrieves that was previously configured
+ * with snd_soc_dai_get_sdw_stream()
+ *
+ * Returns pointer to stream or NULL;
+ */
+static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai,
+					       int direction)
+{
+	if (dai->driver->ops->get_sdw_stream)
+		return dai->driver->ops->get_sdw_stream(dai, direction);
+	else
+		return NULL;
+}
+
 #endif
-- 
2.20.1

