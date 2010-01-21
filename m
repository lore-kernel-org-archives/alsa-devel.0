From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] ASoC: add helper macros to declare struct
	soc_enum instances
Date: Thu, 21 Jan 2010 22:04:03 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1001212157160.9137@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 447552451D
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 22:04:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Several shortcuts for popular uses of some of SOC_ENUM_* and 
SOC_VALUE_ENUM_* macros.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 08909cc..9537144 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -169,6 +169,23 @@
 	.private_value = (unsigned long)&xenum }
 
 /*
+ * Simplified versions of above macros, declaring a struct and calculating
+ * ARRAY_SIZE internally
+ */
+#define SOC_ENUM_DOUBLE_DECL(name, xreg, xshift_l, xshift_r, xtexts) \
+	struct soc_enum name = SOC_ENUM_DOUBLE(xreg, xshift_l, xshift_r, \
+						ARRAY_SIZE(xtexts), xtexts)
+#define SOC_ENUM_SINGLE_DECL(name, xreg, xshift, xtexts) \
+	SOC_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xtexts)
+#define SOC_ENUM_SINGLE_EXT_DECL(name, xtexts) \
+	struct soc_enum name = SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(xtexts), xtexts)
+#define SOC_VALUE_ENUM_DOUBLE_DECL(name, xreg, xshift_l, xshift_r, xmask, xtexts, xvalues) \
+	struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, \
+							ARRAY_SIZE(xtexts), xtexts, xvalues)
+#define SOC_VALUE_ENUM_SINGLE_DECL(name, xreg, xshift, xmask, xtexts, xvalues) \
+	SOC_VALUE_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xmask, xtexts, xvalues)
+
+/*
  * Bias levels
  *
  * @ON:      Bias is fully on for audio playback and capture operations.
