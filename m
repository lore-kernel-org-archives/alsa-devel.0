From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: core: Allow CODECs to set
	ignore_pmdown_time in the driver struct
Date: Wed,  8 Feb 2012 18:37:16 +0000
Message-ID: <1328726238-556-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE8FB103E98
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 19:37:23 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This is usually not a use case dependant flag anyway.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-core.c |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ecd5d72..d1e7a6a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -657,6 +657,8 @@ struct snd_soc_codec_driver {
 	/* codec stream completion event */
 	int (*stream_event)(struct snd_soc_dapm_context *dapm, int event);
 
+	bool ignore_pmdown_time;  /* Doesn't benefit from pmdown delay */
+
 	/* probe ordering - for components with runtime dependencies */
 	int probe_order;
 	int remove_order;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3a3b487..0b9974f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3380,6 +3380,7 @@ int snd_soc_register_codec(struct device *dev,
 	codec->volatile_register = codec_drv->volatile_register;
 	codec->readable_register = codec_drv->readable_register;
 	codec->writable_register = codec_drv->writable_register;
+	codec->ignore_pmdown_time = codec_drv->ignore_pmdown_time;
 	codec->dapm.bias_level = SND_SOC_BIAS_OFF;
 	codec->dapm.dev = dev;
 	codec->dapm.codec = codec;
-- 
1.7.9.rc1
