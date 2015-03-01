From: Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH v4 12/15] drm: bridge/dw_hdmi: creat dw-hdmi-audio platform device
Date: Sat, 28 Feb 2015 21:57:09 -0500
Message-ID: <1425178629-2588-1-git-send-email-ykk@rock-chips.com>
References: <1425175834-24661-1-git-send-email-ykk@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425175834-24661-1-git-send-email-ykk@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, dianders@chromium.org, linux-rockchip@lists.infradead.org
Cc: David Airlie <airlied@linux.ie>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, Yakir Yang <ykk@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@freescale.com>, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Max Filippov <jcmvbkbc@gmail.com>, Axel Lin <axel.lin@ingics.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Sean Cross <xobs@kosagi.com>, Ben Zhang <benzh@chromium.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, mmind00@googlemail.com, marcheu@chromium.org, mark.yao@rock-chips.com
List-Id: alsa-devel@alsa-project.org

creat dw-hdmi-audio device dynamically in probe function,
and transfer some interfaces to dw-hdmi-audio driver for
setting hdmi audio format & control hdmi audio clock.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
Changes in v4: None
Changes in v3:
- Remove audio_config & get_connect_status callback functions
  and add write/read/mod register callback functions

Changes in v2:
- Update the audio control interfaces

 drivers/gpu/drm/bridge/dw_hdmi.c | 29 +++++++++++++++++++++++++++++
 include/drm/bridge/dw_hdmi.h     | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/bridge/dw_hdmi.c b/drivers/gpu/drm/bridge/dw_hdmi.c
index 54185e2..2ffd3e7 100644
--- a/drivers/gpu/drm/bridge/dw_hdmi.c
+++ b/drivers/gpu/drm/bridge/dw_hdmi.c
@@ -125,6 +125,8 @@ struct dw_hdmi {
 	struct drm_encoder *encoder;
 	struct drm_bridge *bridge;
 
+	struct platform_device *audio_pdev;
+
 	enum dw_hdmi_devtype dev_type;
 	struct device *dev;
 	struct clk *isfr_clk;
@@ -512,6 +514,12 @@ static void hdmi_clk_regenerator_update_pixel_clock(struct dw_hdmi *hdmi)
 	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock);
 }
 
+static void hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int sample_rate)
+{
+	hdmi->sample_rate = sample_rate;
+	hdmi_set_clk_regenerator(hdmi, hdmi->hdmi_data.video_mode.mpixelclock);
+}
+
 /*
  * this submodule is responsible for the video data synchronization.
  * for example, for RGB 4:4:4 input, the data map is defined as
@@ -1801,6 +1809,8 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 		 struct resource *iores, int irq,
 		 const struct dw_hdmi_plat_data *plat_data)
 {
+	struct platform_device_info pdevinfo;
+	struct dw_hdmi_audio_data audio;
 	struct drm_device *drm = data;
 	struct device_node *np = dev->of_node;
 	struct device_node *ddc_node;
@@ -1920,6 +1930,25 @@ int dw_hdmi_bind(struct device *dev, struct device *master,
 
 	dev_set_drvdata(dev, hdmi);
 
+	memset(&pdevinfo, 0, sizeof(pdevinfo));
+	pdevinfo.parent = dev;
+	pdevinfo.id = PLATFORM_DEVID_NONE;
+
+	audio.irq = irq;
+	audio.dw = hdmi;
+	audio.mod = hdmi_modb;
+	audio.read = hdmi_readb;
+	audio.write = hdmi_writeb;
+	audio.enable = dw_hdmi_audio_enable;
+	audio.disable = dw_hdmi_audio_disable;
+	audio.set_sample_rate = hdmi_set_sample_rate;
+
+	pdevinfo.name = "dw-hdmi-audio";
+	pdevinfo.data = &audio;
+	pdevinfo.size_data = sizeof(audio);
+	pdevinfo.dma_mask = DMA_BIT_MASK(32);
+	hdmi->audio_pdev = platform_device_register_full(&pdevinfo);
+
 	return 0;
 
 err_iahb:
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index e8cfe1c..23ca491 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -12,6 +12,8 @@
 
 #include <drm/drmP.h>
 
+struct dw_hdmi;
+
 enum {
 	DW_HDMI_RES_8,
 	DW_HDMI_RES_10,
@@ -44,6 +46,19 @@ struct dw_hdmi_sym_term {
 	u16 term;       /*transmission termination value*/
 };
 
+struct dw_hdmi_audio_data {
+	int irq;
+	struct dw_hdmi *dw;
+
+	u8 (*read)(struct dw_hdmi *hdmi, int offset);
+	void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
+	void (*mod)(struct dw_hdmi *hdmi, u8 data, u8 mask, unsigned reg);
+
+	void (*enable)(struct dw_hdmi *hdmi);
+	void (*disable)(struct dw_hdmi *hdmi);
+	void (*set_sample_rate)(struct dw_hdmi *hdmi, unsigned int rate);
+};
+
 struct dw_hdmi_plat_data {
 	enum dw_hdmi_devtype dev_type;
 	const struct dw_hdmi_mpll_config *mpll_cfg;
-- 
2.1.2
