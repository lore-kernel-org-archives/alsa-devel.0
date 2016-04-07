From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH 1/5 v4] drm/i2c/adv7511: Rename and move to separate folder
Date: Thu,  7 Apr 2016 17:53:55 +0100
Message-ID: <b72bf705db61fd9d9e6dfccbfbb8b142e3538d3d.1460047238.git.joabreu@synopsys.com>
References: <cover.1460047238.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1460047238.git.joabreu@synopsys.com>
In-Reply-To: <cover.1460047238.git.joabreu@synopsys.com>
References: <cover.1460047238.git.joabreu@synopsys.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane.org@lists.infradead.org
To: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, architt@codeaurora.org, airlied@linux.ie, Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com, CARLOS.PALMINHA@synopsys.com, lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Main file of adv7511 driver was renamed from adv7511.c
to adv7511_core.c and moved to separate folder in order
to prepare the adding of audio support.

Struct adv7511 was moved to adv7511.h and functions
adv7511_packet_enable() and adv7511_packet_disable()
were made public also to prepare the adding of audio
support.

Signed-off-by: Jose Abreu <joabreu@synopsys.com>
---

No changes v3 -> v4.

This patch was only introduced in v3.

 drivers/gpu/drm/i2c/Kconfig                        |  6 +---
 drivers/gpu/drm/i2c/Makefile                       |  2 +-
 drivers/gpu/drm/i2c/adv7511/Kconfig                |  6 ++++
 drivers/gpu/drm/i2c/adv7511/Makefile               |  2 ++
 drivers/gpu/drm/i2c/{ => adv7511}/adv7511.h        | 31 +++++++++++++++++++++
 .../drm/i2c/{adv7511.c => adv7511/adv7511_core.c}  | 32 ++--------------------
 6 files changed, 43 insertions(+), 36 deletions(-)
 create mode 100644 drivers/gpu/drm/i2c/adv7511/Kconfig
 create mode 100644 drivers/gpu/drm/i2c/adv7511/Makefile
 rename drivers/gpu/drm/i2c/{ => adv7511}/adv7511.h (93%)
 rename drivers/gpu/drm/i2c/{adv7511.c => adv7511/adv7511_core.c} (97%)

diff --git a/drivers/gpu/drm/i2c/Kconfig b/drivers/gpu/drm/i2c/Kconfig
index 22c7ed6..9258daf 100644
--- a/drivers/gpu/drm/i2c/Kconfig
+++ b/drivers/gpu/drm/i2c/Kconfig
@@ -1,11 +1,7 @@
 menu "I2C encoder or helper chips"
      depends on DRM && DRM_KMS_HELPER && I2C
 
-config DRM_I2C_ADV7511
-	tristate "AV7511 encoder"
-	select REGMAP_I2C
-	help
-	  Support for the Analog Device ADV7511(W) and ADV7513 HDMI encoders.
+source "drivers/gpu/drm/i2c/adv7511/Kconfig"
 
 config DRM_I2C_CH7006
 	tristate "Chrontel ch7006 TV encoder"
diff --git a/drivers/gpu/drm/i2c/Makefile b/drivers/gpu/drm/i2c/Makefile
index 2c72eb5..f144830 100644
--- a/drivers/gpu/drm/i2c/Makefile
+++ b/drivers/gpu/drm/i2c/Makefile
@@ -1,6 +1,6 @@
 ccflags-y := -Iinclude/drm
 
-obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511.o
+obj-y += adv7511/
 
 ch7006-y := ch7006_drv.o ch7006_mode.o
 obj-$(CONFIG_DRM_I2C_CH7006) += ch7006.o
diff --git a/drivers/gpu/drm/i2c/adv7511/Kconfig b/drivers/gpu/drm/i2c/adv7511/Kconfig
new file mode 100644
index 0000000..302c8e34
--- /dev/null
+++ b/drivers/gpu/drm/i2c/adv7511/Kconfig
@@ -0,0 +1,6 @@
+config DRM_I2C_ADV7511
+	tristate "AV7511 encoder"
+	select REGMAP_I2C
+	help
+	  Support for the Analog Device ADV7511(W) and ADV7513 HDMI encoders.
+
diff --git a/drivers/gpu/drm/i2c/adv7511/Makefile b/drivers/gpu/drm/i2c/adv7511/Makefile
new file mode 100644
index 0000000..c13f5a1
--- /dev/null
+++ b/drivers/gpu/drm/i2c/adv7511/Makefile
@@ -0,0 +1,2 @@
+adv7511-y := adv7511_core.o
+obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511.o
diff --git a/drivers/gpu/drm/i2c/adv7511.h b/drivers/gpu/drm/i2c/adv7511/adv7511.h
similarity index 93%
rename from drivers/gpu/drm/i2c/adv7511.h
rename to drivers/gpu/drm/i2c/adv7511/adv7511.h
index 38515b3..fcae1ee 100644
--- a/drivers/gpu/drm/i2c/adv7511.h
+++ b/drivers/gpu/drm/i2c/adv7511/adv7511.h
@@ -286,4 +286,35 @@ struct adv7511_video_config {
 	struct hdmi_avi_infoframe avi_infoframe;
 };
 
+struct adv7511 {
+	struct i2c_client *i2c_main;
+	struct i2c_client *i2c_edid;
+
+	struct regmap *regmap;
+	struct regmap *packet_memory_regmap;
+	enum drm_connector_status status;
+	bool powered;
+
+	unsigned int f_tmds;
+
+	unsigned int current_edid_segment;
+	uint8_t edid_buf[256];
+	bool edid_read;
+
+	wait_queue_head_t wq;
+	struct drm_encoder *encoder;
+
+	bool embedded_sync;
+	enum adv7511_sync_polarity vsync_polarity;
+	enum adv7511_sync_polarity hsync_polarity;
+	bool rgb;
+
+	struct edid *edid;
+
+	struct gpio_desc *gpio_pd;
+};
+
+int adv7511_packet_enable(struct adv7511 *adv7511, unsigned int packet);
+int adv7511_packet_disable(struct adv7511 *adv7511, unsigned int packet);
+
 #endif /* __DRM_I2C_ADV7511_H__ */
diff --git a/drivers/gpu/drm/i2c/adv7511.c b/drivers/gpu/drm/i2c/adv7511/adv7511_core.c
similarity index 97%
rename from drivers/gpu/drm/i2c/adv7511.c
rename to drivers/gpu/drm/i2c/adv7511/adv7511_core.c
index a02112b..2b00581 100644
--- a/drivers/gpu/drm/i2c/adv7511.c
+++ b/drivers/gpu/drm/i2c/adv7511/adv7511_core.c
@@ -20,34 +20,6 @@
 
 #include "adv7511.h"
 
-struct adv7511 {
-	struct i2c_client *i2c_main;
-	struct i2c_client *i2c_edid;
-
-	struct regmap *regmap;
-	struct regmap *packet_memory_regmap;
-	enum drm_connector_status status;
-	bool powered;
-
-	unsigned int f_tmds;
-
-	unsigned int current_edid_segment;
-	uint8_t edid_buf[256];
-	bool edid_read;
-
-	wait_queue_head_t wq;
-	struct drm_encoder *encoder;
-
-	bool embedded_sync;
-	enum adv7511_sync_polarity vsync_polarity;
-	enum adv7511_sync_polarity hsync_polarity;
-	bool rgb;
-
-	struct edid *edid;
-
-	struct gpio_desc *gpio_pd;
-};
-
 static struct adv7511 *encoder_to_adv7511(struct drm_encoder *encoder)
 {
 	return to_encoder_slave(encoder)->slave_priv;
@@ -194,7 +166,7 @@ static void adv7511_set_colormap(struct adv7511 *adv7511, bool enable,
 			   ADV7511_CSC_UPDATE_MODE, 0);
 }
 
-static int adv7511_packet_enable(struct adv7511 *adv7511, unsigned int packet)
+int adv7511_packet_enable(struct adv7511 *adv7511, unsigned int packet)
 {
 	if (packet & 0xff)
 		regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE0,
@@ -209,7 +181,7 @@ static int adv7511_packet_enable(struct adv7511 *adv7511, unsigned int packet)
 	return 0;
 }
 
-static int adv7511_packet_disable(struct adv7511 *adv7511, unsigned int packet)
+int adv7511_packet_disable(struct adv7511 *adv7511, unsigned int packet)
 {
 	if (packet & 0xff)
 		regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE0,
-- 
1.9.1
