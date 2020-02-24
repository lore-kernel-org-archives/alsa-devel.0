Return-Path: <SRS0=BBoH=4M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A41C38BFA
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:24:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE622176D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="THuloR+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE622176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79B3416A1;
	Mon, 24 Feb 2020 23:23:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79B3416A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582583051;
	bh=WpwuHGDdL2nU0u8E72sOir8jCufBFVcqjs39i4/OjjQ=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=THuloR+50+beAZeEcEPMMM3I03W0KzWI0I2u3xQn9fpWXcSDQOzeavbMzmNGI5ZnL
	 /tRKNCxhJCKjh27tXpopjBbRgtC4eSmh+UBT5XkSIEnt0Dt3kcTJiPxEQiE2LrYwT3
	 8xRIdZUwitfjHrcSXbE6lDD/LFpwc/TWpySPowKM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 185B3F8025E;
	Mon, 24 Feb 2020 23:21:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A1EE1F8027D; Mon, 24 Feb 2020 23:21:47 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 13BACF80137
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2020 23:21:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13BACF80137
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 995E931B;
 Mon, 24 Feb 2020 14:21:42 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B9453F534;
 Mon, 24 Feb 2020 14:21:41 -0800 (PST)
Date: Mon, 24 Feb 2020 22:21:40 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Applied "ASoC: soc-pcm: move CONFIG_DEBUG_FS functions to top side"
 to the asoc tree
In-Reply-To: <878skzjc9k.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-878skzjc9k.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
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

   ASoC: soc-pcm: move CONFIG_DEBUG_FS functions to top side

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

From c3212829f812a4ac0c6078978c109c6f1ff882c2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Feb 2020 15:56:57 +0900
Subject: [PATCH] ASoC: soc-pcm: move CONFIG_DEBUG_FS functions to top side

This is prepare for CONFIG_DEBUG_FS cleanup

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/878skzjc9k.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 276 ++++++++++++++++++++++----------------------
 1 file changed, 138 insertions(+), 138 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3b3b32923783..fc98ab87fa45 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -28,6 +28,144 @@
 
 #define DPCM_MAX_BE_USERS	8
 
+#ifdef CONFIG_DEBUG_FS
+static const char *dpcm_state_string(enum snd_soc_dpcm_state state)
+{
+	switch (state) {
+	case SND_SOC_DPCM_STATE_NEW:
+		return "new";
+	case SND_SOC_DPCM_STATE_OPEN:
+		return "open";
+	case SND_SOC_DPCM_STATE_HW_PARAMS:
+		return "hw_params";
+	case SND_SOC_DPCM_STATE_PREPARE:
+		return "prepare";
+	case SND_SOC_DPCM_STATE_START:
+		return "start";
+	case SND_SOC_DPCM_STATE_STOP:
+		return "stop";
+	case SND_SOC_DPCM_STATE_SUSPEND:
+		return "suspend";
+	case SND_SOC_DPCM_STATE_PAUSED:
+		return "paused";
+	case SND_SOC_DPCM_STATE_HW_FREE:
+		return "hw_free";
+	case SND_SOC_DPCM_STATE_CLOSE:
+		return "close";
+	}
+
+	return "unknown";
+}
+
+static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
+			       int stream, char *buf, size_t size)
+{
+	struct snd_pcm_hw_params *params = &fe->dpcm[stream].hw_params;
+	struct snd_soc_dpcm *dpcm;
+	ssize_t offset = 0;
+	unsigned long flags;
+
+	/* FE state */
+	offset += snprintf(buf + offset, size - offset,
+			   "[%s - %s]\n", fe->dai_link->name,
+			   stream ? "Capture" : "Playback");
+
+	offset += snprintf(buf + offset, size - offset, "State: %s\n",
+			   dpcm_state_string(fe->dpcm[stream].state));
+
+	if ((fe->dpcm[stream].state >= SND_SOC_DPCM_STATE_HW_PARAMS) &&
+	    (fe->dpcm[stream].state <= SND_SOC_DPCM_STATE_STOP))
+		offset += snprintf(buf + offset, size - offset,
+				   "Hardware Params: "
+				   "Format = %s, Channels = %d, Rate = %d\n",
+				   snd_pcm_format_name(params_format(params)),
+				   params_channels(params),
+				   params_rate(params));
+
+	/* BEs state */
+	offset += snprintf(buf + offset, size - offset, "Backends:\n");
+
+	if (list_empty(&fe->dpcm[stream].be_clients)) {
+		offset += snprintf(buf + offset, size - offset,
+				   " No active DSP links\n");
+		goto out;
+	}
+
+	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+	for_each_dpcm_be(fe, stream, dpcm) {
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		params = &dpcm->hw_params;
+
+		offset += snprintf(buf + offset, size - offset,
+				   "- %s\n", be->dai_link->name);
+
+		offset += snprintf(buf + offset, size - offset,
+				   "   State: %s\n",
+				   dpcm_state_string(be->dpcm[stream].state));
+
+		if ((be->dpcm[stream].state >= SND_SOC_DPCM_STATE_HW_PARAMS) &&
+		    (be->dpcm[stream].state <= SND_SOC_DPCM_STATE_STOP))
+			offset += snprintf(buf + offset, size - offset,
+					   "   Hardware Params: "
+					   "Format = %s, Channels = %d, Rate = %d\n",
+					   snd_pcm_format_name(params_format(params)),
+					   params_channels(params),
+					   params_rate(params));
+	}
+	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
+out:
+	return offset;
+}
+
+static ssize_t dpcm_state_read_file(struct file *file, char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct snd_soc_pcm_runtime *fe = file->private_data;
+	ssize_t out_count = PAGE_SIZE, offset = 0, ret = 0;
+	int stream;
+	char *buf;
+
+	buf = kmalloc(out_count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	for_each_pcm_streams(stream)
+		if (snd_soc_dai_stream_valid(fe->cpu_dai, stream))
+			offset += dpcm_show_state(fe, stream,
+						  buf + offset,
+						  out_count - offset);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, offset);
+
+	kfree(buf);
+	return ret;
+}
+
+static const struct file_operations dpcm_state_fops = {
+	.open = simple_open,
+	.read = dpcm_state_read_file,
+	.llseek = default_llseek,
+};
+
+void soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
+{
+	if (!rtd->dai_link)
+		return;
+
+	if (!rtd->dai_link->dynamic)
+		return;
+
+	if (!rtd->card->debugfs_card_root)
+		return;
+
+	rtd->debugfs_dpcm_root = debugfs_create_dir(rtd->dai_link->name,
+						    rtd->card->debugfs_card_root);
+
+	debugfs_create_file("state", 0444, rtd->debugfs_dpcm_root,
+			    rtd, &dpcm_state_fops);
+}
+#endif
+
 static int soc_rtd_startup(struct snd_soc_pcm_runtime *rtd,
 			   struct snd_pcm_substream *substream)
 {
@@ -2930,141 +3068,3 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 	return snd_soc_dpcm_check_state(fe, be, stream, state, ARRAY_SIZE(state));
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_params);
-
-#ifdef CONFIG_DEBUG_FS
-static const char *dpcm_state_string(enum snd_soc_dpcm_state state)
-{
-	switch (state) {
-	case SND_SOC_DPCM_STATE_NEW:
-		return "new";
-	case SND_SOC_DPCM_STATE_OPEN:
-		return "open";
-	case SND_SOC_DPCM_STATE_HW_PARAMS:
-		return "hw_params";
-	case SND_SOC_DPCM_STATE_PREPARE:
-		return "prepare";
-	case SND_SOC_DPCM_STATE_START:
-		return "start";
-	case SND_SOC_DPCM_STATE_STOP:
-		return "stop";
-	case SND_SOC_DPCM_STATE_SUSPEND:
-		return "suspend";
-	case SND_SOC_DPCM_STATE_PAUSED:
-		return "paused";
-	case SND_SOC_DPCM_STATE_HW_FREE:
-		return "hw_free";
-	case SND_SOC_DPCM_STATE_CLOSE:
-		return "close";
-	}
-
-	return "unknown";
-}
-
-static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
-				int stream, char *buf, size_t size)
-{
-	struct snd_pcm_hw_params *params = &fe->dpcm[stream].hw_params;
-	struct snd_soc_dpcm *dpcm;
-	ssize_t offset = 0;
-	unsigned long flags;
-
-	/* FE state */
-	offset += snprintf(buf + offset, size - offset,
-			"[%s - %s]\n", fe->dai_link->name,
-			stream ? "Capture" : "Playback");
-
-	offset += snprintf(buf + offset, size - offset, "State: %s\n",
-	                dpcm_state_string(fe->dpcm[stream].state));
-
-	if ((fe->dpcm[stream].state >= SND_SOC_DPCM_STATE_HW_PARAMS) &&
-	    (fe->dpcm[stream].state <= SND_SOC_DPCM_STATE_STOP))
-		offset += snprintf(buf + offset, size - offset,
-				"Hardware Params: "
-				"Format = %s, Channels = %d, Rate = %d\n",
-				snd_pcm_format_name(params_format(params)),
-				params_channels(params),
-				params_rate(params));
-
-	/* BEs state */
-	offset += snprintf(buf + offset, size - offset, "Backends:\n");
-
-	if (list_empty(&fe->dpcm[stream].be_clients)) {
-		offset += snprintf(buf + offset, size - offset,
-				" No active DSP links\n");
-		goto out;
-	}
-
-	spin_lock_irqsave(&fe->card->dpcm_lock, flags);
-	for_each_dpcm_be(fe, stream, dpcm) {
-		struct snd_soc_pcm_runtime *be = dpcm->be;
-		params = &dpcm->hw_params;
-
-		offset += snprintf(buf + offset, size - offset,
-				"- %s\n", be->dai_link->name);
-
-		offset += snprintf(buf + offset, size - offset,
-				"   State: %s\n",
-				dpcm_state_string(be->dpcm[stream].state));
-
-		if ((be->dpcm[stream].state >= SND_SOC_DPCM_STATE_HW_PARAMS) &&
-		    (be->dpcm[stream].state <= SND_SOC_DPCM_STATE_STOP))
-			offset += snprintf(buf + offset, size - offset,
-				"   Hardware Params: "
-				"Format = %s, Channels = %d, Rate = %d\n",
-				snd_pcm_format_name(params_format(params)),
-				params_channels(params),
-				params_rate(params));
-	}
-	spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
-out:
-	return offset;
-}
-
-static ssize_t dpcm_state_read_file(struct file *file, char __user *user_buf,
-				size_t count, loff_t *ppos)
-{
-	struct snd_soc_pcm_runtime *fe = file->private_data;
-	ssize_t out_count = PAGE_SIZE, offset = 0, ret = 0;
-	int stream;
-	char *buf;
-
-	buf = kmalloc(out_count, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	for_each_pcm_streams(stream)
-		if (snd_soc_dai_stream_valid(fe->cpu_dai, stream))
-			offset += dpcm_show_state(fe, stream,
-						  buf + offset,
-						  out_count - offset);
-
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, offset);
-
-	kfree(buf);
-	return ret;
-}
-
-static const struct file_operations dpcm_state_fops = {
-	.open = simple_open,
-	.read = dpcm_state_read_file,
-	.llseek = default_llseek,
-};
-
-void soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
-{
-	if (!rtd->dai_link)
-		return;
-
-	if (!rtd->dai_link->dynamic)
-		return;
-
-	if (!rtd->card->debugfs_card_root)
-		return;
-
-	rtd->debugfs_dpcm_root = debugfs_create_dir(rtd->dai_link->name,
-			rtd->card->debugfs_card_root);
-
-	debugfs_create_file("state", 0444, rtd->debugfs_dpcm_root,
-			    rtd, &dpcm_state_fops);
-}
-#endif
-- 
2.20.1

