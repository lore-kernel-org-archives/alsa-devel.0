From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 01/12] ASoC: core: Introduce SOC_DOUBLE_VALUE
	macro
Date: Tue,  4 Oct 2011 14:39:38 +0300
Message-ID: <1317728389-22062-2-git-send-email-peter.ujfalusi@ti.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73]) by alsa0.perex.cz (Postfix) with ESMTP id CB0F62460A
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 13:40:01 +0200 (CEST)
Received: by mail-bw0-f44.google.com with SMTP id q10so717323bka.31
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 04:39:59 -0700 (PDT)
In-Reply-To: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

With the new macro we can remove duplicated code
for the SOC_DOUBLE type of controls.
We can also remap the SOC_SINGLE_VALUE macro to
SOC_DOUBLE_VALUE

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc.h |   34 ++++++++++++++++------------------
 1 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a4dc699..3d7c7f7 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -28,10 +28,12 @@
 /*
  * Convenience kcontrol builders
  */
-#define SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) \
+#define SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
-	{.reg = xreg, .shift = xshift, .rshift = xshift, .max = xmax, \
-	.platform_max = xmax, .invert = xinvert})
+	{.reg = xreg, .shift = shift_left, .rshift = shift_right, \
+	.max = xmax, .platform_max = xmax, .invert = xinvert})
+#define SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) \
+	SOC_DOUBLE_VALUE(xreg, xshift, xshift, xmax, xinvert)
 #define SOC_SINGLE_VALUE_EXT(xreg, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xreg, .max = xmax, .platform_max = xmax, .invert = xinvert})
@@ -48,13 +50,12 @@
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
 	.put = snd_soc_put_volsw, \
 	.private_value =  SOC_SINGLE_VALUE(reg, shift, max, invert) }
-#define SOC_DOUBLE(xname, xreg, shift_left, shift_right, xmax, xinvert) \
+#define SOC_DOUBLE(xname, reg, shift_left, shift_right, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
 	.put = snd_soc_put_volsw, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .shift = shift_left, .rshift = shift_right, \
-		 .max = xmax, .platform_max = xmax, .invert = xinvert} }
+	.private_value = SOC_DOUBLE_VALUE(reg, shift_left, shift_right, \
+					  max, invert) }
 #define SOC_DOUBLE_R(xname, reg_left, reg_right, xshift, xmax, xinvert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.info = snd_soc_info_volsw_2r, \
@@ -62,16 +63,15 @@
 	.private_value = (unsigned long)&(struct soc_mixer_control) \
 		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
 		.max = xmax, .platform_max = xmax, .invert = xinvert} }
-#define SOC_DOUBLE_TLV(xname, xreg, shift_left, shift_right, xmax, xinvert, tlv_array) \
+#define SOC_DOUBLE_TLV(xname, reg, shift_left, shift_right, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
 		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw, \
 	.put = snd_soc_put_volsw, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .shift = shift_left, .rshift = shift_right,\
-		 .max = xmax, .platform_max = xmax, .invert = xinvert} }
+	.private_value = SOC_DOUBLE_VALUE(reg, shift_left, shift_right, \
+					  max, invert) }
 #define SOC_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax, xinvert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
@@ -121,14 +121,13 @@
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
 	.private_value = SOC_SINGLE_VALUE(xreg, xshift, xmax, xinvert) }
-#define SOC_DOUBLE_EXT(xname, xreg, shift_left, shift_right, xmax, xinvert,\
+#define SOC_DOUBLE_EXT(xname, reg, shift_left, shift_right, max, invert,\
 	 xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .shift = shift_left, .rshift = shift_right, \
-		 .max = xmax, .platform_max = xmax, .invert = xinvert} }
+	.private_value = \
+		SOC_DOUBLE_VALUE(reg, shift_left, shift_right, max, invert) }
 #define SOC_SINGLE_EXT_TLV(xname, xreg, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
@@ -146,9 +145,8 @@
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw, \
 	.get = xhandler_get, .put = xhandler_put, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = xreg, .shift = shift_left, .rshift = shift_right, \
-		.max = xmax, .platform_max = xmax, .invert = xinvert} }
+	.private_value = SOC_DOUBLE_VALUE(xreg, shift_left, shift_right, \
+					  xmax, xinvert) }
 #define SOC_DOUBLE_R_EXT_TLV(xname, reg_left, reg_right, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
-- 
1.7.7
