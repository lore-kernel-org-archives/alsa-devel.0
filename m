From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH asoc-dev (take #2)] ASoC: Convert N810 machine
	driver to use gpiolib
Date: Thu, 15 May 2008 09:04:23 +0300
Message-ID: <1210831463-14704-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 297EF246E5
	for <alsa-devel@alsa-project.org>;
	Thu, 15 May 2008 08:04:06 +0200 (CEST)
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m4F62hvb015322
	for <alsa-devel@alsa-project.org>; Thu, 15 May 2008 01:04:03 -0500
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Use gpiolib since it is now available for OMAPs. Change also references to
HW version RX44 to product name N810.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/n810.c |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index c2afffb..c32487b 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -30,15 +30,15 @@
 
 #include <asm/mach-types.h>
 #include <asm/arch/hardware.h>
-#include <asm/arch/gpio.h>
+#include <linux/gpio.h>
 #include <asm/arch/mcbsp.h>
 
 #include "omap-mcbsp.h"
 #include "omap-pcm.h"
 #include "../codecs/tlv320aic3x.h"
 
-#define RX44_HEADSET_AMP_GPIO	10
-#define RX44_SPEAKER_AMP_GPIO	101
+#define N810_HEADSET_AMP_GPIO	10
+#define N810_SPEAKER_AMP_GPIO	101
 
 static struct clk *sys_clkout2;
 static struct clk *sys_clkout2_src;
@@ -154,9 +154,9 @@ static int n810_spk_event(struct snd_soc_dapm_widget *w,
 			  struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
-		omap_set_gpio_dataout(RX44_SPEAKER_AMP_GPIO, 1);
+		gpio_set_value(N810_SPEAKER_AMP_GPIO, 1);
 	else
-		omap_set_gpio_dataout(RX44_SPEAKER_AMP_GPIO, 0);
+		gpio_set_value(N810_SPEAKER_AMP_GPIO, 0);
 
 	return 0;
 }
@@ -165,9 +165,9 @@ static int n810_jack_event(struct snd_soc_dapm_widget *w,
 			   struct snd_kcontrol *k, int event)
 {
 	if (SND_SOC_DAPM_EVENT_ON(event))
-		omap_set_gpio_dataout(RX44_HEADSET_AMP_GPIO, 1);
+		gpio_set_value(N810_HEADSET_AMP_GPIO, 1);
 	else
-		omap_set_gpio_dataout(RX44_HEADSET_AMP_GPIO, 0);
+		gpio_set_value(N810_HEADSET_AMP_GPIO, 0);
 
 	return 0;
 }
@@ -303,12 +303,12 @@ static int __init n810_soc_init(void)
 	clk_set_parent(sys_clkout2_src, func96m_clk);
 	clk_set_rate(sys_clkout2, 12000000);
 
-	if (omap_request_gpio(RX44_HEADSET_AMP_GPIO) < 0)
+	if (gpio_request(N810_HEADSET_AMP_GPIO, "hs_amp") < 0)
 		BUG();
-	if (omap_request_gpio(RX44_SPEAKER_AMP_GPIO) < 0)
+	if (gpio_request(N810_SPEAKER_AMP_GPIO, "spk_amp") < 0)
 		BUG();
-	omap_set_gpio_direction(RX44_HEADSET_AMP_GPIO, 0);
-	omap_set_gpio_direction(RX44_SPEAKER_AMP_GPIO, 0);
+	gpio_direction_output(N810_HEADSET_AMP_GPIO, 0);
+	gpio_direction_output(N810_SPEAKER_AMP_GPIO, 0);
 
 	return 0;
 err2:
@@ -323,6 +323,9 @@ err1:
 
 static void __exit n810_soc_exit(void)
 {
+	gpio_free(N810_SPEAKER_AMP_GPIO);
+	gpio_free(N810_HEADSET_AMP_GPIO);
+
 	platform_device_unregister(n810_snd_device);
 }
 
-- 
1.5.5.1
