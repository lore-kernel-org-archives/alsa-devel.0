Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E8AC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:29:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BEF22229
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 01:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="anCiDfSJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7iQ1flQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BEF22229
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0345C16B2;
	Thu, 18 Jun 2020 03:28:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0345C16B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592443782;
	bh=hsh8OBWkdJYDP6rXNi6v/fdteZHhnTVpUh3LbNud6rw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=anCiDfSJ773BBNoMkSFf5TX4QUD/rjIBfjf+qJedtVoxod3P6xThO+ygrwtI2vS8Y
	 goHWRoSUJ1mOy5YiS9Mq1cLJP8TTZCCiD7e2usYNlM6Q2D4p0nKdDbm9scZPLy86xI
	 +oPcmjXA/jnAa4VxjQnSOYvy0eWNMnAMHsOVYTNI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E463CF80308;
	Thu, 18 Jun 2020 03:16:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2752F80308; Thu, 18 Jun 2020 03:16:01 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A691F802A8
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 03:15:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A691F802A8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="o7iQ1flQ"
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1B3FA21D79;
 Thu, 18 Jun 2020 01:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592442954;
 bh=hsh8OBWkdJYDP6rXNi6v/fdteZHhnTVpUh3LbNud6rw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o7iQ1flQyJF5hbnCuCpopU7nMUFXrJA4W3FvD8nLrLKNMf3u3npudCymvZequaezp
 ij9R2VinBeYHjzdMuXosamEaY+nN4clB0JqKnyvmV0Pz+Sk5k0DV+KQ9p5u3s1mdaT
 ek+VwT1vRlA4QiRY7WROS8vZkXCHlA7bXR55F/+s=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 362/388] ASoC: soc-pcm: dpcm: fix playback/capture
 checks
Date: Wed, 17 Jun 2020 21:07:39 -0400
Message-Id: <20200618010805.600873-362-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Daniel Baluta <daniel.baluta@gmail.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit b73287f0b0745961b14e5ebcce92cc8ed24d4d52 ]

Recent changes in the ASoC core prevent multi-cpu BE dailinks from
being used. DPCM does support multi-cpu DAIs for BE Dailinks, but not
for FE.

Handle the FE checks first, and make sure all DAIs support the same
capabilities within the same dailink.

Fixes: 9b5db059366ae2 ("ASoC: soc-pcm: dpcm: Only allow playback/capture if supported")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
BugLink: https://github.com/thesofproject/linux/issues/2031
Link: https://lore.kernel.org/r/20200608194415.4663-2-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1f302de44052..39ce61c5b874 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2908,20 +2908,44 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	struct snd_pcm *pcm;
 	char new_name[64];
 	int ret = 0, playback = 0, capture = 0;
+	int stream;
 	int i;
 
+	if (rtd->dai_link->dynamic && rtd->num_cpus > 1) {
+		dev_err(rtd->dev,
+			"DPCM doesn't support Multi CPU for Front-Ends yet\n");
+		return -EINVAL;
+	}
+
 	if (rtd->dai_link->dynamic || rtd->dai_link->no_pcm) {
-		cpu_dai = asoc_rtd_to_cpu(rtd, 0);
-		if (rtd->num_cpus > 1) {
-			dev_err(rtd->dev,
-				"DPCM doesn't support Multi CPU yet\n");
-			return -EINVAL;
+		if (rtd->dai_link->dpcm_playback) {
+			stream = SNDRV_PCM_STREAM_PLAYBACK;
+
+			for_each_rtd_cpu_dais(rtd, i, cpu_dai)
+				if (!snd_soc_dai_stream_valid(cpu_dai,
+							      stream)) {
+					dev_err(rtd->card->dev,
+						"CPU DAI %s for rtd %s does not support playback\n",
+						cpu_dai->name,
+						rtd->dai_link->stream_name);
+					return -EINVAL;
+				}
+			playback = 1;
+		}
+		if (rtd->dai_link->dpcm_capture) {
+			stream = SNDRV_PCM_STREAM_CAPTURE;
+
+			for_each_rtd_cpu_dais(rtd, i, cpu_dai)
+				if (!snd_soc_dai_stream_valid(cpu_dai,
+							      stream)) {
+					dev_err(rtd->card->dev,
+						"CPU DAI %s for rtd %s does not support capture\n",
+						cpu_dai->name,
+						rtd->dai_link->stream_name);
+					return -EINVAL;
+				}
+			capture = 1;
 		}
-
-		playback = rtd->dai_link->dpcm_playback &&
-			   snd_soc_dai_stream_valid(cpu_dai, SNDRV_PCM_STREAM_PLAYBACK);
-		capture = rtd->dai_link->dpcm_capture &&
-			  snd_soc_dai_stream_valid(cpu_dai, SNDRV_PCM_STREAM_CAPTURE);
 	} else {
 		/* Adapt stream for codec2codec links */
 		int cpu_capture = rtd->dai_link->params ?
-- 
2.25.1

