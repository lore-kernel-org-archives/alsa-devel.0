From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC v2 13/13] drm: bridge/dw_hdmi-ahb-audio:
 parse ELD from HDMI driver
Date: Thu, 02 Apr 2015 10:22:22 +0100
Message-ID: <E1YdbKQ-00085c-4Z@rmk-PC.arm.linux.org.uk>
References: <20150402092050.GH24899@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 4AD11265892
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 11:24:54 +0200 (CEST)
In-Reply-To: <20150402092050.GH24899@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, David Airlie <airlied@linux.ie>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Parse the ELD (EDID like data) stored from the HDMI driver to restrict
the sample rates and channels which are available to ALSA.  This causes
the ALSA device to reflect the capabilities of the overall audio path,
not just what is supported at the HDMI source interface level.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/gpu/drm/bridge/Kconfig             | 1 +
 drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c | 6 ++++++
 drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h | 1 +
 drivers/gpu/drm/bridge/dw_hdmi.c           | 3 +++
 4 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 557962a67fc5..9fff41e76940 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -7,6 +7,7 @@ config DRM_DW_HDMI_AHB_AUDIO
 	tristate "Synopsis Designware AHB Audio interface"
 	depends on DRM_DW_HDMI && SND
 	select SND_PCM
+	select SND_PCM_ELD
 	select SND_PCM_IEC958
 	help
 	  Support the AHB Audio interface which is part of the Synopsis
diff --git a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
index e98c291268f4..2bb68bda3cb0 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.c
@@ -12,11 +12,13 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <drm/bridge/dw_hdmi.h>
+#include <drm/drm_edid.h>
 
 #include <sound/asoundef.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
+#include <sound/pcm_drm_eld.h>
 #include <sound/pcm_iec958.h>
 
 #include "dw_hdmi-ahb-audio.h"
@@ -284,6 +286,10 @@ static int dw_hdmi_open(struct snd_pcm_substream *substream)
 
 	runtime->hw = dw_hdmi_hw;
 
+	ret = snd_pcm_hw_constraint_eld(runtime, dw->data.eld);
+	if (ret < 0)
+		return ret;
+
 	ret = snd_pcm_limit_hw_rates(runtime);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h
index 1e840118d90a..91f631beecc7 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h
+++ b/drivers/gpu/drm/bridge/dw_hdmi-ahb-audio.h
@@ -8,6 +8,7 @@ struct dw_hdmi_audio_data {
 	void __iomem *base;
 	int irq;
 	struct dw_hdmi *hdmi;
+	u8 *eld;
 };
 
 #endif
diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 1cb427935ed2..dc0aed18019d 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -1446,6 +1446,8 @@ static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
 
 		drm_mode_connector_update_edid_property(connector, edid);
 		ret = drm_add_edid_modes(connector, edid);
+		/* Store the ELD */
+		drm_edid_to_eld(connector, edid);
 		kfree(edid);
 	} else {
 		dev_dbg(hdmi->dev, "failed to get edid\n");
@@ -1725,6 +1727,7 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 		audio.base = hdmi->regs;
 		audio.irq = irq;
 		audio.hdmi = hdmi;
+		audio.eld = hdmi->connector.eld;
 
 		pdevinfo.name = "dw-hdmi-ahb-audio";
 		pdevinfo.data = &audio;
-- 
1.8.3.1
