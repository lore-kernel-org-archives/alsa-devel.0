From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 02/12] ASoC: core: Introduce SOC_DOUBLE_R_VALUE
	macro
Date: Tue,  4 Oct 2011 14:39:39 +0300
Message-ID: <1317728389-22062-3-git-send-email-peter.ujfalusi@ti.com>
References: <1317728389-22062-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog115.obsmtp.com (na3sys009aog115.obsmtp.com
	[74.125.149.238])
	by alsa0.perex.cz (Postfix) with ESMTP id B0AF62460D
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 13:40:02 +0200 (CEST)
Received: by mail-bw0-f52.google.com with SMTP id 5so677728bke.11
	for <alsa-devel@alsa-project.org>; Tue, 04 Oct 2011 04:40:01 -0700 (PDT)
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
for the SOC_DOUBLE_R type of controls.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc.h |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3d7c7f7..9d0524a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -37,6 +37,10 @@
 #define SOC_SINGLE_VALUE_EXT(xreg, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xreg, .max = xmax, .platform_max = xmax, .invert = xinvert})
+#define SOC_DOUBLE_R_VALUE(xlreg, xrreg, xshift, xmax, xinvert) \
+	((unsigned long)&(struct soc_mixer_control) \
+	{.reg = xlreg, .rreg = xrreg, .shift = xshift, .rshift = xshift, \
+	.max = xmax, .platform_max = xmax, .invert = xinvert})
 #define SOC_SINGLE(xname, reg, shift, max, invert) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_volsw, .get = snd_soc_get_volsw,\
@@ -60,9 +64,8 @@
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.info = snd_soc_info_volsw_2r, \
 	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
-		.max = xmax, .platform_max = xmax, .invert = xinvert} }
+	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
+					    xmax, xinvert) }
 #define SOC_DOUBLE_TLV(xname, reg, shift_left, shift_right, max, invert, tlv_array) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
@@ -79,9 +82,8 @@
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw_2r, \
 	.get = snd_soc_get_volsw_2r, .put = snd_soc_put_volsw_2r, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
-		.max = xmax, .platform_max = xmax, .invert = xinvert} }
+	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
+					    xmax, xinvert) }
 #define SOC_DOUBLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
 {	.iface  = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
@@ -155,9 +157,8 @@
 	.tlv.p = (tlv_array), \
 	.info = snd_soc_info_volsw_2r, \
 	.get = xhandler_get, .put = xhandler_put, \
-	.private_value = (unsigned long)&(struct soc_mixer_control) \
-		{.reg = reg_left, .rreg = reg_right, .shift = xshift, \
-		.max = xmax, .platform_max = xmax, .invert = xinvert} }
+	.private_value = SOC_DOUBLE_R_VALUE(reg_left, reg_right, xshift, \
+					    xmax, xinvert) }
 #define SOC_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_bool_ext, \
-- 
1.7.7
