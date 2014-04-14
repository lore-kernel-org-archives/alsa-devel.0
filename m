From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 17/17] ASoC: Remove deprecated ENUM/MUX macros
Date: Mon, 14 Apr 2014 21:31:12 +0200
Message-ID: <1397503872-20864-18-git-send-email-lars@metafoo.de>
References: <1397503872-20864-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-027.synserver.de (smtp-out-046.synserver.de
 [212.40.185.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 03DB02656C6
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:31:36 +0200 (CEST)
In-Reply-To: <1397503872-20864-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com, =?UTF-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Jerry Wong <jerry.wong@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

Since there are no users left, we can remove the deprecated ENUM and MUX macros
which are just alias for other macros.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h | 12 ------------
 include/sound/soc.h      |  2 --
 2 files changed, 14 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index ef78f56..5ec03b5 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -107,10 +107,6 @@ struct device;
 {	.id = snd_soc_dapm_mux, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = 1}
-#define SND_SOC_DAPM_VIRT_MUX(wname, wreg, wshift, winvert, wcontrols) \
-	SND_SOC_DAPM_MUX(wname, wreg, wshift, winvert, wcontrols)
-#define SND_SOC_DAPM_VALUE_MUX(wname, wreg, wshift, winvert, wcontrols) \
-	SND_SOC_DAPM_MUX(wname, wreg, wshift, winvert, wcontrols)
 
 /* Simplified versions of above macros, assuming wncontrols = ARRAY_SIZE(wcontrols) */
 #define SOC_PGA_ARRAY(wname, wreg, wshift, winvert,\
@@ -166,10 +162,6 @@ struct device;
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = 1, \
 	.event = wevent, .event_flags = wflags}
-#define SND_SOC_DAPM_VIRT_MUX_E(wname, wreg, wshift, winvert, wcontrols, \
-	wevent, wflags) \
-	SND_SOC_DAPM_MUX_E(wname, wreg, wshift, winvert, wcontrols, wevent, \
-		wflags)
 
 /* additional sequencing control within an event type */
 #define SND_SOC_DAPM_PGA_S(wname, wsubseq, wreg, wshift, winvert, \
@@ -305,16 +297,12 @@ struct device;
  	.get = snd_soc_dapm_get_enum_double, \
  	.put = snd_soc_dapm_put_enum_double, \
   	.private_value = (unsigned long)&xenum }
-#define SOC_DAPM_ENUM_VIRT(xname, xenum) \
-	SOC_DAPM_ENUM(xname, xenum)
 #define SOC_DAPM_ENUM_EXT(xname, xenum, xget, xput) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_info_enum_double, \
 	.get = xget, \
 	.put = xput, \
 	.private_value = (unsigned long)&xenum }
-#define SOC_DAPM_VALUE_ENUM(xname, xenum) \
-	SOC_DAPM_ENUM(xname, xenum)
 #define SOC_DAPM_PIN_SWITCH(xname) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname " Switch", \
 	.info = snd_soc_dapm_info_pin_switch, \
diff --git a/include/sound/soc.h b/include/sound/soc.h
index f001996..3396594 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -196,8 +196,6 @@
 	.info = snd_soc_info_enum_double, \
 	.get = snd_soc_get_enum_double, .put = snd_soc_put_enum_double, \
 	.private_value = (unsigned long)&xenum }
-#define SOC_VALUE_ENUM(xname, xenum) \
-	SOC_ENUM(xname, xenum)
 #define SOC_SINGLE_EXT(xname, xreg, xshift, xmax, xinvert,\
 	 xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-- 
1.8.0
