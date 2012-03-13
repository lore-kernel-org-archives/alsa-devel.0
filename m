From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 06/16] ASoC: core: Add macros for 8bit hwdep
	multi reg cntrl
Date: Tue, 13 Mar 2012 16:11:33 +0100
Message-ID: <1331651503-16917-7-git-send-email-ola.o.lilja@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog116.obsmtp.com (eu1sys200aog116.obsmtp.com
	[207.126.144.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 08EE5104380
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 16:12:48 +0100 (CET)
In-Reply-To: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
List-Id: alsa-devel@alsa-project.org

From: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>

Added four comvenience macros for hwdep multi register controls
that exposes a single signed value while spanning multiple
codec registers in a MSB/LSB manner.

SOC_HWDEP_SINGLE_1R8  One hwdep signed control value spans one 8bit register
SOC_HWDEP_SINGLE_2R8  One hwdep signed control value spans two 8bit two registers
SOC_HWDEP_SINGLE_4R8  One hwdep signed control value spans four 8bit registers
SOC_HWDEP_SINGLE_8R8  One hwdep signed control value spans eight 8bit registers

Signed-off-by: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
---
 include/sound/soc.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a5e782c..4acdd35 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -208,6 +208,35 @@
 			xreg4, xreg5, xreg6, xreg7 }), \
 	.rcount = 8, .count = xcount, \
 	.min = xmin, .max = xmax, .invert = xinvert})
+#define SOC_HWDEP_SINGLE_1R8(xname, reg0, min, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_HWDEP, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.info = snd_soc_info_xr_sx, .get = snd_soc_get_xr8_sx, \
+	.put = snd_soc_put_xr8_sx, \
+	.private_value =  SOC_SINGLE_VALUE_S1R(reg0, 1, min, max, invert) }
+#define SOC_HWDEP_SINGLE_2R8(xname, reg0, reg1, min, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_HWDEP, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.info = snd_soc_info_xr_sx, .get = snd_soc_get_xr8_sx, \
+	.put = snd_soc_put_xr8_sx, \
+	.private_value = SOC_SINGLE_VALUE_S2R(reg0, reg1, \
+				1, min, max, invert) }
+#define SOC_HWDEP_SINGLE_4R8(xname, reg0, reg1, reg2, reg3, min, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_HWDEP, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.info = snd_soc_info_xr_sx, .get = snd_soc_get_xr8_sx, \
+	.put = snd_soc_put_xr8_sx, \
+	.private_value =  SOC_SINGLE_VALUE_S4R(reg0, reg1, reg2, reg3, \
+				1, min, max, invert) }
+#define SOC_HWDEP_SINGLE_8R8(xname, reg0, reg1, reg2, reg3, \
+		reg4, reg5, reg6, reg7, min, max, invert) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_HWDEP, .name = xname, \
+	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE, \
+	.info = snd_soc_info_xr_sx, .get = snd_soc_get_xr8_sx, \
+	.put = snd_soc_put_xr8_sx, \
+	.private_value =  \
+		SOC_SINGLE_VALUE_S4R(reg0, reg1, reg2, reg3, \
+			reg4, reg5, reg6, reg7, 1, min, max, invert) }
 
 #define SOC_ENUM_STROBE(xname, xenum) \
 	SOC_ENUM_EXT(xname, xenum, \
-- 
1.7.8.3
