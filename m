From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 08/14] ASoC: Make OpenFirmware helper include
	file conditional
Date: Tue, 29 Jul 2008 11:42:29 +0100
Message-ID: <1217328155-30158-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1217328155-30158-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1217328155-30158-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6147E1037FC
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 12:42:46 +0200 (CEST)
In-Reply-To: <1217328155-30158-7-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The OpenFirmware API headers don't build on all platforms so ensure
that they are not included unless they are being used.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 include/sound/soc-of-simple.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-of-simple.h b/include/sound/soc-of-simple.h
index 696fc51..a064e19 100644
--- a/include/sound/soc-of-simple.h
+++ b/include/sound/soc-of-simple.h
@@ -7,6 +7,8 @@
 #ifndef _INCLUDE_SOC_OF_H_
 #define _INCLUDE_SOC_OF_H_
 
+#if defined(CONFIG_SND_SOC_OF_SIMPLE) || defined(CONFIG_SND_SOC_OF_SIMPLE_MODULE)
+
 #include <linux/of.h>
 #include <sound/soc.h>
 
@@ -18,4 +20,6 @@ int of_snd_soc_register_platform(struct snd_soc_platform *platform,
 				 struct device_node *node,
 				 struct snd_soc_dai *cpu_dai);
 
+#endif
+
 #endif /* _INCLUDE_SOC_OF_H_ */
-- 
1.5.6.3
