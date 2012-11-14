From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 2/3] ASoC: OMAP: HDMI: Update CPU DAI driver name
Date: Tue, 13 Nov 2012 20:30:48 -0600
Message-ID: <1352860249-26348-3-git-send-email-ricardo.neri@ti.com>
References: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1352860249-26348-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: s-guiriec@ti.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>
List-Id: alsa-devel@alsa-project.org

Update the driver name to use the platform device created by the OMAPDSS HDMI
driver for interested audio drivers to use.

This platform device represents the audio functionality of the HDMI IP in
the applicable OMAP processors. It does not make explicit reference to ASoC
concepts such as DAI.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap-hdmi-card.c |    2 +-
 sound/soc/omap/omap-hdmi.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi-card.c b/sound/soc/omap/omap-hdmi-card.c
index 184180e..d6f4dba 100644
--- a/sound/soc/omap/omap-hdmi-card.c
+++ b/sound/soc/omap/omap-hdmi-card.c
@@ -32,7 +32,7 @@
 static struct snd_soc_dai_link omap_hdmi_dai = {
 	.name = "HDMI",
 	.stream_name = "HDMI",
-	.cpu_dai_name = "omap-hdmi-audio-dai",
+	.cpu_dai_name = "omap_hdmi_audio",
 	.platform_name = "omap-pcm-audio",
 	.codec_name = "hdmi-audio-codec",
 	.codec_dai_name = "omap-hdmi-hifi",
diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index f59c69f..6592d6f 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -37,7 +37,7 @@
 #include "omap-pcm.h"
 #include "omap-hdmi.h"
 
-#define DRV_NAME "omap-hdmi-audio-dai"
+#define DRV_NAME "omap_hdmi_audio"
 
 struct hdmi_priv {
 	struct omap_pcm_dma_data dma_params;
-- 
1.7.5.4

