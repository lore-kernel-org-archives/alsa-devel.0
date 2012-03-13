From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 01/16] ASoC: core: Add multi reg control struct
	& macros
Date: Tue, 13 Mar 2012 16:11:28 +0100
Message-ID: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog103.obsmtp.com (eu1sys200aog103.obsmtp.com
	[207.126.144.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 825E2104338
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 16:12:20 +0100 (CET)
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

Add support for controls that exposes a single signed value
while spanning multiple codec registers in a MSB/LSB manner.

Definition of a generic control struct added.

soc_mreg_control

Also four generic convenience macros added:

SOC_SINGLE_VALUE_S1R  One control value spans one register
SOC_SINGLE_VALUE_S2R  One control value spans two registers
SOC_SINGLE_VALUE_S4R  One control value spans four registers
SOC_SINGLE_VALUE_S8R  One control value spans eight registers

Signed-off-by: Kristoffer KARLSSON <kristoffer.karlsson@stericsson.com>
---
 include/sound/soc.h |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0992dff..dac20e0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -185,6 +185,29 @@
 		 .rreg = xreg_right, .shift = xshift, \
 		 .min = xmin, .max = xmax} }
 
+#define SOC_SINGLE_VALUE_S1R(xreg0, xcount, xmin, xmax, xinvert) \
+	((unsigned long)&(struct soc_mreg_control) \
+	{ .reg = ((unsigned int[]){ xreg0 }), \
+	.rcount = 1, .count = xcount, \
+	.invert = xinvert, .min = xmin, .max = xmax})
+#define SOC_SINGLE_VALUE_S2R(xreg0, xreg1, xcount, xmin, xmax, xinvert) \
+	((unsigned long)&(struct soc_mreg_control) \
+	{.reg = ((unsigned int[]){ xreg0, xreg1 }), \
+	.rcount = 2, .count = xcount, \
+	.min = xmin, .max = xmax, .invert = xinvert})
+#define SOC_SINGLE_VALUE_S4R(xreg0, xreg1, xreg2, xreg3, \
+	xcount, xmin, xmax, xinvert) \
+	((unsigned long)&(struct soc_mreg_control) \
+	{.reg = ((unsigned int[]){ xreg0, xreg1, xreg2, xreg3 }), \
+	.rcount = 4, .count = xcount,  \
+	.min = xmin, .max = xmax, .invert = xinvert})
+#define SOC_SINGLE_VALUE_S8R(xreg0, xreg1, xreg2, xreg3, xreg4, \
+		xreg5, xreg6, xreg7, xcount, xmin, xmax, xinvert) \
+	((unsigned long)&(struct soc_mreg_control) \
+	{.reg = ((unsigned int[]){ xreg0, xreg1, xreg2, xreg3, \
+			xreg4, xreg5, xreg6, xreg7 }), \
+	.rcount = 8, .count = xcount, \
+	.min = xmin, .max = xmax, .invert = xinvert})
 
 /*
  * Simplified versions of above macros, declaring a struct and calculating
@@ -875,6 +898,13 @@ struct soc_mixer_control {
 	unsigned int reg, rreg, shift, rshift, invert;
 };
 
+/* multi register control */
+struct soc_mreg_control {
+	long min, max;
+	unsigned int rcount, count, invert;
+	unsigned int *reg;
+};
+
 /* enumerated kcontrol */
 struct soc_enum {
 	unsigned short reg;
-- 
1.7.8.3
