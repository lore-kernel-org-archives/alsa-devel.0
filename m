From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dapm - add DAPM macro for external enum
	widgets
Date: Wed, 20 Jul 2011 19:42:20 +0100
Message-ID: <1311187340-4238-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id B65471038BE
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 20:42:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Add a convenience macro for external enumerated widgets.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dapm.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 596387b..655acc5 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -266,6 +266,12 @@
 	.get = snd_soc_dapm_get_enum_virt, \
 	.put = snd_soc_dapm_put_enum_virt, \
 	.private_value = (unsigned long)&xenum }
+#define SOC_DAPM_ENUM_EXT(xname, xenum, xget, xput) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = snd_soc_info_enum_double, \
+	.get = xget, \
+	.put = xput, \
+	.private_value = (unsigned long)&xenum }
 #define SOC_DAPM_VALUE_ENUM(xname, xenum) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_enum_double, \
-- 
1.7.4.1
