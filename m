From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 1/2] ASoC: utils: Add internal call to
	determine if DAI is dummy.
Date: Wed,  8 Jan 2014 10:40:18 +0000
Message-ID: <1389177619-2760-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 71A3F26510A
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 11:40:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Provide a quick way to tell if a DAI is a dummy DAI or a regular DAI.
This is for internal DAPM usage only and is used to determe whether to
insert a DAI link connection into the DAPM graph.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/sound/soc-dai.h | 2 ++
 sound/soc/soc-utils.c   | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 243d3b6..71f27c4 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -123,6 +123,8 @@ int snd_soc_dai_set_tristate(struct snd_soc_dai *dai, int tristate);
 int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
 			     int direction);
 
+int snd_soc_dai_is_dummy(struct snd_soc_dai *dai);
+
 struct snd_soc_dai_ops {
 	/*
 	 * DAI clocking configuration, all optional.
diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 6ebdfd9..7f22ca3 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -119,6 +119,13 @@ static struct snd_soc_dai_driver dummy_dai = {
 	 },
 };
 
+int snd_soc_dai_is_dummy(struct snd_soc_dai *dai)
+{
+	if (dai->driver == &dummy_dai)
+		return 1;
+	return 0;
+}
+
 static int snd_soc_dummy_probe(struct platform_device *pdev)
 {
 	int ret;
-- 
1.8.3.2
