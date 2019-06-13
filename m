From: cezary.rojewski@intel.com
Subject: [PATCH 1/7] ASoC: Intel: Skylake: Fix incorrect
	capture position reporting
Date: Thu, 13 Jun 2019 21:04:30 +0200
Message-ID: <20190613190436.20156-2-cezary.rojewski@intel.com>
References: <20190613190436.20156-1-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 56B16F80791
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2019 21:05:26 +0200 (CEST)
In-Reply-To: <20190613190436.20156-1-cezary.rojewski@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Leoni Prodduvaka <leoni.prodduvaka@intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Cezary Rojewski <cezary.rojewski@intel.com>

HW recommends to set DUM bit on device power up, so that DPIB write
request occurs every frame regardless of whether DPIB has changed or
not. This addresses incorrect position reporting for capture streams.

Signed-off-by: Leoni Prodduvaka <leoni.prodduvaka@intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/skl.c | 21 +++++++++++++++++++++
 sound/soc/intel/skylake/skl.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index f864f7b3df3a..7174b5da4099 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -192,6 +192,25 @@ void skl_update_d0i3c(struct device *dev, bool enable)
 			snd_hdac_chip_readb(bus, VS_D0I3C));
 }
 
+/**
+ * skl_dum_set - set DUM bit in EM2 register
+ * @bus: HD-audio core bus
+ *
+ * Addresses incorrect position reporting for capture streams.
+ * Used on device power up.
+ */
+static void skl_dum_set(struct hdac_bus *bus)
+{
+	/* For the DUM bit to be set, CRST needs to be out of reset state */
+	if (!(snd_hdac_chip_readb(bus, GCTL) & AZX_GCTL_RESET)) {
+		skl_enable_miscbdcge(bus->dev, false);
+		snd_hdac_bus_exit_link_reset(bus);
+		skl_enable_miscbdcge(bus->dev, true);
+	}
+
+	snd_hdac_chip_updatel(bus, VS_EM2, AZX_VS_EM2_DUM, AZX_VS_EM2_DUM);
+}
+
 /* called from IRQ */
 static void skl_stream_update(struct hdac_bus *bus, struct hdac_stream *hstr)
 {
@@ -299,6 +318,7 @@ static int _skl_resume(struct hdac_bus *bus)
 	struct skl *skl = bus_to_skl(bus);
 
 	skl_init_pci(skl);
+	skl_dum_set(bus);
 	skl_init_chip(bus, true);
 
 	return skl_resume_dsp(skl);
@@ -956,6 +976,7 @@ static int skl_first_init(struct hdac_bus *bus)
 
 	/* initialize chip */
 	skl_init_pci(skl);
+	skl_dum_set(bus);
 
 	return skl_init_chip(bus, true);
 }
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 85f8bb6687dc..b92a7f8fe675 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -46,6 +46,7 @@
 #define DMA_TRANSMITION_START	2
 #define DMA_TRANSMITION_STOP	3
 
+#define AZX_VS_EM2_DUM			BIT(23)
 #define AZX_REG_VS_EM2_L1SEN		BIT(13)
 
 struct skl_dsp_resource {
-- 
2.17.1
