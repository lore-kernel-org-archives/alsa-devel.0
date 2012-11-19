From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 2/4] ASoC: firmware: Add support for FW based
	widgets.
Date: Mon, 19 Nov 2012 18:12:43 +0000
Message-ID: <1353348765-6238-2-git-send-email-lrg@ti.com>
References: <1353348765-6238-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 724E0261735
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 19:12:59 +0100 (CET)
In-Reply-To: <1353348765-6238-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

This patch adds initial support for firmware based widgets by allowing
soc-dapm.h to be included by userspace firmware generation tools and assigns
IDs to the standard ASoC widgets kcontrol types using the kcontrol_new
index and IDs to kcontrol get/put/info functions.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |   48 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index e1ef63d..c6c9dad 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -13,8 +13,10 @@
 #ifndef __LINUX_SND_SOC_DAPM_H
 #define __LINUX_SND_SOC_DAPM_H
 
+#ifdef __KERNEL__
 #include <linux/types.h>
 #include <sound/control.h>
+#endif
 
 struct device;
 
@@ -254,12 +256,12 @@ struct device;
 /* dapm kcontrol types */
 #define SOC_DAPM_SINGLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
+	.info = snd_soc_info_volsw, .index = SOC_DAPM_IO_VOLSW, \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
 	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
 #define SOC_DAPM_SINGLE_TLV(xname, reg, shift, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_info_volsw, \
+	.info = snd_soc_info_volsw, .index = SOC_DAPM_IO_VOLSW, \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.get = snd_soc_dapm_get_volsw, .put = snd_soc_dapm_put_volsw, \
@@ -269,16 +271,19 @@ struct device;
 	.info = snd_soc_info_enum_double, \
  	.get = snd_soc_dapm_get_enum_double, \
  	.put = snd_soc_dapm_put_enum_double, \
+	.index = SOC_DAPM_IO_ENUM_DOUBLE, \
   	.private_value = (unsigned long)&xenum }
 #define SOC_DAPM_ENUM_VIRT(xname, xenum)		    \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_enum_double, \
 	.get = snd_soc_dapm_get_enum_virt, \
 	.put = snd_soc_dapm_put_enum_virt, \
+	.index = SOC_DAPM_IO_ENUM_VIRT, \
 	.private_value = (unsigned long)&xenum }
 #define SOC_DAPM_ENUM_EXT(xname, xenum, xget, xput) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_enum_double, \
+	.index = SOC_DAPM_IO_ENUM_EXT, \
 	.get = xget, \
 	.put = xput, \
 	.private_value = (unsigned long)&xenum }
@@ -287,12 +292,14 @@ struct device;
 	.info = snd_soc_info_enum_double, \
 	.get = snd_soc_dapm_get_value_enum_double, \
 	.put = snd_soc_dapm_put_value_enum_double, \
+	.index = SOC_DAPM_IO_ENUM_VALUE, \
 	.private_value = (unsigned long)&xenum }
 #define SOC_DAPM_PIN_SWITCH(xname) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname " Switch", \
 	.info = snd_soc_dapm_info_pin_switch, \
 	.get = snd_soc_dapm_get_pin_switch, \
 	.put = snd_soc_dapm_put_pin_switch, \
+	.index = SOC_DAPM_IO_PIN, \
 	.private_value = (unsigned long)xname }
 
 /* dapm stream operations */
@@ -323,6 +330,40 @@ struct device;
 /* regulator widget flags */
 #define SND_SOC_DAPM_REGULATOR_BYPASS     0x1     /* bypass when disabled */
 
+#define SOC_DAPM_TYPE_VOLSW		64
+#define SOC_DAPM_TYPE_ENUM_DOUBLE	65
+#define SOC_DAPM_TYPE_ENUM_VIRT		66
+#define SOC_DAPM_TYPE_ENUM_VALUE	67
+#define SOC_DAPM_TYPE_PIN		68
+#define SOC_DAPM_TYPE_ENUM_EXT		69
+
+#define SOC_DAPM_IO_VOLSW \
+	SOC_CONTROL_ID(SOC_DAPM_TYPE_VOLSW, \
+		SOC_DAPM_TYPE_VOLSW, \
+		SOC_DAPM_TYPE_VOLSW)
+#define SOC_DAPM_IO_ENUM_DOUBLE \
+	SOC_CONTROL_ID(SOC_DAPM_TYPE_ENUM_DOUBLE, \
+		SOC_DAPM_TYPE_ENUM_DOUBLE, \
+		SOC_CONTROL_TYPE_ENUM)
+#define SOC_DAPM_IO_ENUM_VIRT \
+	SOC_CONTROL_ID(SOC_DAPM_TYPE_ENUM_VIRT, \
+		SOC_DAPM_TYPE_ENUM_VIRT, \
+		SOC_CONTROL_TYPE_ENUM)
+#define SOC_DAPM_IO_ENUM_VALUE \
+	SOC_CONTROL_ID(SOC_DAPM_TYPE_ENUM_VALUE, \
+		SOC_DAPM_TYPE_ENUM_VALUE, \
+		SOC_CONTROL_TYPE_ENUM)
+#define SOC_DAPM_IO_PIN \
+	SOC_CONTROL_ID(SOC_DAPM_TYPE_PIN, \
+		SOC_DAPM_TYPE_PIN, \
+		SOC_DAPM_TYPE_PIN)
+#define SOC_DAPM_IO_ENUM_EXT \
+	SOC_CONTROL_ID(SOC_CONTROL_TYPE_EXT, \
+		SOC_CONTROL_TYPE_EXT, \
+		SOC_CONTROL_TYPE_ENUM)
+
+#ifdef __KERNEL__
+
 struct snd_soc_dapm_widget;
 enum snd_soc_dapm_type;
 struct snd_soc_dapm_path;
@@ -421,6 +462,7 @@ void dapm_mark_io_dirty(struct snd_soc_dapm_context *dapm);
 /* dapm path query */
 int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 	struct snd_soc_dapm_widget_list **list);
+#endif
 
 /* dapm widget types */
 enum snd_soc_dapm_type {
@@ -459,6 +501,7 @@ enum snd_soc_dapm_subclass {
 	SND_SOC_DAPM_CLASS_RUNTIME	= 1,
 };
 
+#ifdef __KERNEL__
 /*
  * DAPM audio route definition.
  *
@@ -603,5 +646,6 @@ struct snd_soc_dapm_stats {
 	int path_checks;
 	int neighbour_checks;
 };
+#endif
 
 #endif
-- 
1.7.10.4
