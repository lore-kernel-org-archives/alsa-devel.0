From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Restore idle_bias_off initialization
Date: Sun, 24 Aug 2014 15:36:55 +0200
Message-ID: <1408887415-7942-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-152.synserver.de (smtp-out-152.synserver.de
 [212.40.185.152])
 by alsa0.perex.cz (Postfix) with ESMTP id A3649261A29
 for <alsa-devel@alsa-project.org>; Sun, 24 Aug 2014 15:36:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

This was accidentally lost in commit f1d45cc3ae96 ("ASoC: Consolidate
platform and CODEC probe/remove").

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e982cb0..4974b4f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -4010,6 +4010,7 @@ static int snd_soc_component_initialize(struct snd_soc_component *component,
 	dapm->dev = dev;
 	dapm->component = component;
 	dapm->bias_level = SND_SOC_BIAS_OFF;
+	dapm->idle_bias_off = true;
 	if (driver->seq_notifier)
 		dapm->seq_notifier = snd_soc_component_seq_notifier;
 	if (driver->stream_event)
@@ -4399,6 +4400,7 @@ int snd_soc_register_codec(struct device *dev,
 		codec->component.read = snd_soc_codec_drv_read;
 	codec->component.ignore_pmdown_time = codec_drv->ignore_pmdown_time;
 	codec->dapm.codec = codec;
+	codec->dapm.idle_bias_off = codec_drv->idle_bias_off;
 	if (codec_drv->seq_notifier)
 		codec->dapm.seq_notifier = codec_drv->seq_notifier;
 	if (codec_drv->set_bias_level)
-- 
1.8.0
