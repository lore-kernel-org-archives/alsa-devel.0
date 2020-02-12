Return-Path: <SRS0=t/pq=4B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00736C352A4
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:01:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D1EC2168B
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Feb 2020 00:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j8kiI0uD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1EC2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5BEC1688;
	Thu, 13 Feb 2020 01:00:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5BEC1688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581552092;
	bh=bjuAzOVWmkqUzHlwfWPNn9siSYxwugbAVgOM6JMg7/k=;
	h=Date:From:To:In-Reply-To:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=j8kiI0uDGgO/h1YOHk1jEf4n7RBXC+fFEJ/gDMC26mMPQ8yrvld62A7nytyqhANTw
	 1ZPk52VnD1gooSeTf59SNOhfDGuVbxrEfA09fxSsZHiQRtO+3x6LihEvOsH+Cw8CmU
	 5Lgb6B0VACjibQHkazl/wUgmtYX1G/JcCPdbF4NM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29836F8029A;
	Thu, 13 Feb 2020 00:57:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0FD0BF80299; Thu, 13 Feb 2020 00:57:25 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id E50FCF8027C
 for <alsa-devel@alsa-project.org>; Thu, 13 Feb 2020 00:57:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E50FCF8027C
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66002106F;
 Wed, 12 Feb 2020 15:57:19 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCBEF3F68E;
 Wed, 12 Feb 2020 15:57:18 -0800 (PST)
Date: Wed, 12 Feb 2020 23:57:17 +0000
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8736bjcexx.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <applied-8736bjcexx.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: [alsa-devel] Applied "ASoC: soc-pcm: move soc_pcm_close() next to
	soc_pcm_open()" to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: soc-pcm: move soc_pcm_close() next to soc_pcm_open()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

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

From 62c86d1d5fd942c741791be94f670b99ffedfb5c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 10 Feb 2020 12:14:41 +0900
Subject: [PATCH] ASoC: soc-pcm: move soc_pcm_close() next to soc_pcm_open()

This patch moves soc_pcm_close() next to soc_pcm_open().
This is prepare for soc_pcm_open() cleanup.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/8736bjcexx.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 88 ++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ae94d8a86992..8aa775e0eb0d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -507,6 +507,50 @@ static int soc_pcm_components_close(struct snd_pcm_substream *substream)
 	return ret;
 }
 
+/*
+ * Called by ALSA when a PCM substream is closed. Private data can be
+ * freed here. The cpu DAI, codec DAI, machine and components are also
+ * shutdown.
+ */
+static int soc_pcm_close(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai;
+	int i;
+
+	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
+
+	snd_soc_runtime_deactivate(rtd, substream->stream);
+
+	snd_soc_dai_digital_mute(cpu_dai, 1, substream->stream);
+
+	snd_soc_dai_shutdown(cpu_dai, substream);
+
+	for_each_rtd_codec_dai(rtd, i, codec_dai)
+		snd_soc_dai_shutdown(codec_dai, substream);
+
+	soc_rtd_shutdown(rtd, substream);
+
+	soc_pcm_components_close(substream);
+
+	snd_soc_dapm_stream_stop(rtd, substream->stream);
+
+	mutex_unlock(&rtd->card->pcm_mutex);
+
+	for_each_rtd_components(rtd, i, component) {
+		pm_runtime_mark_last_busy(component->dev);
+		pm_runtime_put_autosuspend(component->dev);
+	}
+
+	for_each_rtd_components(rtd, i, component)
+		if (!component->active)
+			pinctrl_pm_select_sleep_state(component->dev);
+
+	return 0;
+}
+
 /*
  * Called by ALSA when a PCM substream is opened, the runtime->hw record is
  * then initialized and any private data can be allocated. This also calls
@@ -663,50 +707,6 @@ static void codec2codec_close_delayed_work(struct snd_soc_pcm_runtime *rtd)
 	 */
 }
 
-/*
- * Called by ALSA when a PCM substream is closed. Private data can be
- * freed here. The cpu DAI, codec DAI, machine and components are also
- * shutdown.
- */
-static int soc_pcm_close(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_component *component;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai;
-	int i;
-
-	mutex_lock_nested(&rtd->card->pcm_mutex, rtd->card->pcm_subclass);
-
-	snd_soc_runtime_deactivate(rtd, substream->stream);
-
-	snd_soc_dai_digital_mute(cpu_dai, 1, substream->stream);
-
-	snd_soc_dai_shutdown(cpu_dai, substream);
-
-	for_each_rtd_codec_dai(rtd, i, codec_dai)
-		snd_soc_dai_shutdown(codec_dai, substream);
-
-	soc_rtd_shutdown(rtd, substream);
-
-	soc_pcm_components_close(substream);
-
-	snd_soc_dapm_stream_stop(rtd, substream->stream);
-
-	mutex_unlock(&rtd->card->pcm_mutex);
-
-	for_each_rtd_components(rtd, i, component) {
-		pm_runtime_mark_last_busy(component->dev);
-		pm_runtime_put_autosuspend(component->dev);
-	}
-
-	for_each_rtd_components(rtd, i, component)
-		if (!component->active)
-			pinctrl_pm_select_sleep_state(component->dev);
-
-	return 0;
-}
-
 /*
  * Called by ALSA when the PCM substream is prepared, can set format, sample
  * rate, etc.  This function is non atomic and can be called multiple times,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
