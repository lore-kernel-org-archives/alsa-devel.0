Return-Path: <SRS0=OLeW=5L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891F2C2D0E5
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:07:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1241B20719
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EaJZhHmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1241B20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C88C1670;
	Thu, 26 Mar 2020 20:06:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C88C1670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585249669;
	bh=oXxhPFY/51FkoynfIal8/MDWdBfqegVkD7SJ/5iwvkY=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=EaJZhHmVGHZCSoawAFx5e88FPJxN2JLqmUofWcBORrztxr5Qs2VAGMsms95gh9WUX
	 X9KiPiINLifhDmk4MtzNdLHV9XFB/U0dpDe6zVRGAasxK7xtXIM4My2Pn1A+5gMCCe
	 GE9jeeCDHeldevAgF1DFjP9LQcaLYJIiGJZkQkmU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5C52EF8028F;
	Thu, 26 Mar 2020 20:05:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C2C74F8028F; Thu, 26 Mar 2020 20:05:02 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 4BEFEF80273
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2020 20:04:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4BEFEF80273
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6F2C7FA;
 Thu, 26 Mar 2020 12:04:57 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AE233F71F;
 Thu, 26 Mar 2020 12:04:57 -0700 (PDT)
Date: Thu, 26 Mar 2020 19:04:55 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Applied "ASoC: rt1308-sdw: add set_tdm_slot() support" to the asoc
 tree
In-Reply-To: <20200325212905.28145-2-pierre-louis.bossart@linux.intel.com>
Message-Id: <applied-20200325212905.28145-2-pierre-louis.bossart@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

   ASoC: rt1308-sdw: add set_tdm_slot() support

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

From f7cc9b996e7417708b8168697762e4bc97fa6696 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 25 Mar 2020 16:29:04 -0500
Subject: [PATCH] ASoC: rt1308-sdw: add set_tdm_slot() support

Add ability to select which of the channels is used, or both, in case
two RT1308 amplifiers are located on the same link.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200325212905.28145-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1308-sdw.c | 23 +++++++++++++++++++++++
 sound/soc/codecs/rt1308-sdw.h |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index d930f60cb797..8763192434c4 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -507,6 +507,28 @@ static void rt1308_sdw_shutdown(struct snd_pcm_substream *substream,
 	kfree(stream);
 }
 
+static int rt1308_sdw_set_tdm_slot(struct snd_soc_dai *dai,
+				   unsigned int tx_mask,
+				   unsigned int rx_mask,
+				   int slots, int slot_width)
+{
+	struct snd_soc_component *component = dai->component;
+	struct rt1308_sdw_priv *rt1308 =
+		snd_soc_component_get_drvdata(component);
+
+	if (tx_mask)
+		return -EINVAL;
+
+	if (slots > 2)
+		return -EINVAL;
+
+	rt1308->rx_mask = rx_mask;
+	rt1308->slots = slots;
+	/* slot_width is not used since it's irrelevant for SoundWire */
+
+	return 0;
+}
+
 static int rt1308_sdw_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
@@ -597,6 +619,7 @@ static const struct snd_soc_dai_ops rt1308_aif_dai_ops = {
 	.hw_free	= rt1308_sdw_pcm_hw_free,
 	.set_sdw_stream	= rt1308_set_sdw_stream,
 	.shutdown	= rt1308_sdw_shutdown,
+	.set_tdm_slot	= rt1308_sdw_set_tdm_slot,
 };
 
 #define RT1308_STEREO_RATES SNDRV_PCM_RATE_48000
diff --git a/sound/soc/codecs/rt1308-sdw.h b/sound/soc/codecs/rt1308-sdw.h
index c9341e70d6cf..c5ce75666dcc 100644
--- a/sound/soc/codecs/rt1308-sdw.h
+++ b/sound/soc/codecs/rt1308-sdw.h
@@ -160,6 +160,8 @@ struct rt1308_sdw_priv {
 	struct sdw_bus_params params;
 	bool hw_init;
 	bool first_hw_init;
+	int rx_mask;
+	int slots;
 };
 
 struct sdw_stream_data {
-- 
2.20.1

