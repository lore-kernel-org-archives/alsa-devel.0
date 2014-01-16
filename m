From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 2/2] ASoC: soc.h: Add SOC_DOUBLE_R_S_TLV
Date: Thu, 16 Jan 2014 16:02:11 +0100
Message-ID: <1389884531-19429-3-git-send-email-mpa@pengutronix.de>
References: <1389884531-19429-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B05AE261A11
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 16:03:06 +0100 (CET)
In-Reply-To: <1389884531-19429-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Add a macro for signed mixer with two registers and tlv array.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 include/sound/soc.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5907583..e9084ed 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -45,6 +45,11 @@
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xlreg, .rreg = xrreg, .shift = xshift, .rshift = xshift, \
 	.max = xmax, .platform_max = xmax, .invert = xinvert})
+#define SOC_DOUBLE_R_S_VALUE(xlreg, xrreg, xshift, xmin, xmax, xsign_bit, xinvert) \
+	((unsigned long)&(struct soc_mixer_control) \
+	{.reg = xlreg, .rreg = xrreg, .shift = xshift, .rshift = xshift, \
+	.max = xmax, .min = xmin, .platform_max = xmax, .sign_bit = xsign_bit, \
+	.invert = xinvert})
 #define SOC_DOUBLE_R_RANGE_VALUE(xlreg, xrreg, xshift, xmin, xmax, xinvert) \
 	((unsigned long)&(struct soc_mixer_control) \
 	{.reg = xlreg, .rreg = xrreg, .shift = xshift, .rshift = xshift, \
@@ -152,6 +157,15 @@
 		{.reg = xreg, .rreg = xrreg, \
 		.shift = xshift, .rshift = xshift, \
 		.max = xmax, .min = xmin} }
+#define SOC_DOUBLE_R_S_TLV(xname, reg_left, reg_right, xshift, xmin, xmax, xsign_bit, xinvert, tlv_array) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname),\
+	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
+		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
+	.tlv.p = (tlv_array), \
+	.info = snd_soc_info_volsw, \
+	.get = snd_soc_get_volsw, .put = snd_soc_put_volsw, \
+	.private_value = SOC_DOUBLE_R_S_VALUE(reg_left, reg_right, xshift, \
+					    xmin, xmax, xsign_bit, xinvert) }
 #define SOC_DOUBLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \
 {	.iface  = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
-- 
1.8.5.2
