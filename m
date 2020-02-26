Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ED6C4BA21
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:52:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B1920714
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c1qSh7C/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B1920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D873316AC;
	Wed, 26 Feb 2020 19:51:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D873316AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582743149;
	bh=PQhne9ttSLDX0rKHR3kqAklhUHbGzQFg0awOZT7AiLw=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=c1qSh7C/BdtDC1Fs3SRPckYBd704SJC9hk37hq5+21xTAhdvEf/ctYrUQwsMCojLe
	 drAFyWQYLdiXohCIiv0sy5EeqI7WK5VioaJmLhW/8NPeXi0uTufRZGthWzrDDsX0zT
	 KCTcB5cxHMSAAxEOFvmfhj6Ijf1s7z6awyWWCAys=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35FE4F802D2;
	Wed, 26 Feb 2020 19:47:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBEBEF802C2; Wed, 26 Feb 2020 19:47:47 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 7B306F802A7
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 19:47:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B306F802A7
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7360C31B;
 Wed, 26 Feb 2020 10:47:43 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCDC53F881;
 Wed, 26 Feb 2020 10:47:42 -0800 (PST)
Date: Wed, 26 Feb 2020 18:47:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Applied "ASoC: pcm: check if cpu-dai supports a given stream" to the
 asoc tree
In-Reply-To: <20200225133917.21314-7-yung-chuan.liao@linux.intel.com>
Message-Id: <applied-20200225133917.21314-7-yung-chuan.liao@linux.intel.com>
X-Patchwork-Hint: ignore
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 liam.r.girdwood@linux.intel.com, Mark Brown <broonie@kernel.org>,
 bard.liao@intel.com
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

   ASoC: pcm: check if cpu-dai supports a given stream

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

From 0e9cf4c452ad7e2776441cbac0b9983abaf17ff0 Mon Sep 17 00:00:00 2001
From: Bard Liao <yung-chuan.liao@linux.intel.com>
Date: Tue, 25 Feb 2020 21:39:17 +0800
Subject: [PATCH] ASoC: pcm: check if cpu-dai supports a given stream

Now multi-cpu-dais are supported, we can skip cpi-dais which don't
support the current stream, following the example of multi-codec-dais.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20200225133917.21314-7-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index adbceaff07b8..90857138c823 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -607,6 +607,20 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 
 	/* first calculate min/max only for CPUs in the DAI link */
 	for_each_rtd_cpu_dai(rtd, i, cpu_dai) {
+
+		/*
+		 * Skip CPUs which don't support the current stream type.
+		 * Otherwise, since the rate, channel, and format values will
+		 * zero in that case, we would have no usable settings left,
+		 * causing the resulting setup to fail.
+		 * At least one CPU should match, otherwise we should have
+		 * bailed out on a higher level, since there would be no
+		 * CPU to support the transfer direction in that case.
+		 */
+		if (!snd_soc_dai_stream_valid(cpu_dai,
+					      substream->stream))
+			continue;
+
 		cpu_stream = snd_soc_dai_get_pcm_stream(cpu_dai, stream);
 
 		cpu_chan_min = max(cpu_chan_min, cpu_stream->channels_min);
@@ -1115,6 +1129,13 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	for_each_rtd_cpu_dai(rtd, i, cpu_dai) {
+		/*
+		 * Skip CPUs which don't support the current stream
+		 * type. See soc_pcm_init_runtime_hw() for more details
+		 */
+		if (!snd_soc_dai_stream_valid(cpu_dai, substream->stream))
+			continue;
+
 		ret = snd_soc_dai_hw_params(cpu_dai, substream, params);
 		if (ret < 0)
 			goto interface_err;
@@ -1150,6 +1171,9 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 
 interface_err:
 	for_each_rtd_cpu_dai_rollback(rtd, i, cpu_dai) {
+		if (!snd_soc_dai_stream_valid(cpu_dai, substream->stream))
+			continue;
+
 		snd_soc_dai_hw_free(cpu_dai, substream);
 		cpu_dai->rate = 0;
 	}
@@ -1226,8 +1250,12 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 		snd_soc_dai_hw_free(codec_dai, substream);
 	}
 
-	for_each_rtd_cpu_dai(rtd, i, cpu_dai)
+	for_each_rtd_cpu_dai(rtd, i, cpu_dai) {
+		if (!snd_soc_dai_stream_valid(cpu_dai, substream->stream))
+			continue;
+
 		snd_soc_dai_hw_free(cpu_dai, substream);
+	}
 
 	mutex_unlock(&rtd->card->pcm_mutex);
 	return 0;
@@ -1904,6 +1932,13 @@ static void dpcm_runtime_merge_chan(struct snd_pcm_substream *substream,
 		int i;
 
 		for_each_rtd_cpu_dai(be, i, dai) {
+			/*
+			 * Skip CPUs which don't support the current stream
+			 * type. See soc_pcm_init_runtime_hw() for more details
+			 */
+			if (!snd_soc_dai_stream_valid(dai, stream))
+				continue;
+
 			cpu_stream = snd_soc_dai_get_pcm_stream(dai, stream);
 
 			*channels_min = max(*channels_min,
@@ -1952,6 +1987,13 @@ static void dpcm_runtime_merge_rate(struct snd_pcm_substream *substream,
 		int i;
 
 		for_each_rtd_cpu_dai(be, i, dai) {
+			/*
+			 * Skip CPUs which don't support the current stream
+			 * type. See soc_pcm_init_runtime_hw() for more details
+			 */
+			if (!snd_soc_dai_stream_valid(dai, stream))
+				continue;
+
 			cpu_stream = snd_soc_dai_get_pcm_stream(dai, stream);
 
 			*rate_min = max(*rate_min, cpu_stream->rate_min);
@@ -1989,6 +2031,13 @@ static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 	int i;
 
 	for_each_rtd_cpu_dai(rtd, i, cpu_dai) {
+		/*
+		 * Skip CPUs which don't support the current stream
+		 * type. See soc_pcm_init_runtime_hw() for more details
+		 */
+		if (!snd_soc_dai_stream_valid(cpu_dai, substream->stream))
+			continue;
+
 		cpu_dai_drv = cpu_dai->driver;
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			dpcm_init_runtime_hw(runtime, &cpu_dai_drv->playback);
-- 
2.20.1

