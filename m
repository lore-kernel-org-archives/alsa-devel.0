From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: [PATCH] ASoC: omap: Fix build errors in ams-delta
Date: Thu, 18 Aug 2011 15:02:47 +0300
Message-ID: <1313668967-5657-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id C3A79246DA
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 14:02:56 +0200 (CEST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: alsa-devel@alsa-project.org

Fix "error: too few arguments to function 'ams_delta_set_bias_level'"
build errors in ams-delta.c that were introduced after commit d4c6005 ("ASoC:
Add context parameter to card DAPM callbacks") by adding dapm context
to ams_delta_set_bias_level calls.

Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 sound/soc/omap/ams-delta.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 30fe0d0..0aa475f 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -514,7 +514,7 @@ static int ams_delta_cx20442_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	/* Set codec bias level */
-	ams_delta_set_bias_level(card, SND_SOC_BIAS_STANDBY);
+	ams_delta_set_bias_level(card, dapm, SND_SOC_BIAS_STANDBY);
 
 	/* Add hook switch - can be used to control the codec from userspace
 	 * even if line discipline fails */
@@ -649,7 +649,9 @@ static void __exit ams_delta_module_exit(void)
 			ams_delta_hook_switch_gpios);
 
 	/* Keep modem power on */
-	ams_delta_set_bias_level(&ams_delta_audio_card, SND_SOC_BIAS_STANDBY);
+	ams_delta_set_bias_level(&ams_delta_audio_card,
+				 &ams_delta_audio_card.rtd[0].codec->dapm,
+				 SND_SOC_BIAS_STANDBY);
 
 	platform_device_unregister(cx20442_platform_device);
 	platform_device_unregister(ams_delta_audio_platform_device);
-- 
1.7.5.4
