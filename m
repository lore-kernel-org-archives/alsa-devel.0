Return-Path: <SRS0=ZBV5=4O=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F7FC4BA06
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 01:40:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFA122082F
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Feb 2020 01:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AF7KKtop"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA122082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 328681697;
	Wed, 26 Feb 2020 02:39:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 328681697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582681215;
	bh=+rDKAYg9GX/O440tvSicowPPrdl+NfZNnd2Wg7T03Tc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AF7KKtopmrIMNVH45NJNsPvYhW6NDURDDJMoolH+T6p2y0FwEqgq5s+75rQbYBaY5
	 A/NHzidZM2WPK1yAd3/AfiWMKsYEx87jPi6mTJA02A7nIOMyoxqMVdY4t7VOODA4jW
	 0z9vMUcvYWJtUaW5b6uC0o6nfZLsmLfLHRlWDKcU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 62A04F802BE;
	Wed, 26 Feb 2020 02:35:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4CA6FF8027D; Wed, 26 Feb 2020 02:35:27 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19F92F8025E
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2020 02:35:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19F92F8025E
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Feb 2020 17:35:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,486,1574150400"; d="scan'208";a="436461014"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga005.fm.intel.com with ESMTP; 25 Feb 2020 17:35:20 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH v5 6/6] ASoC: pcm: check if cpu-dai supports a given stream
Date: Tue, 25 Feb 2020 21:39:17 +0800
Message-Id: <20200225133917.21314-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225133917.21314-1-yung-chuan.liao@linux.intel.com>
References: <20200225133917.21314-1-yung-chuan.liao@linux.intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org,
 bard.liao@intel.com, pierre-louis.bossart@linux.intel.com,
 kuninori.morimoto.gx@renesas.com
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

Now multi-cpu-dais are supported, we can skip cpi-dais which don't
support the current stream, following the example of multi-codec-dais.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.17.1

