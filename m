From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Headset button support in
	broxton machine driver" to the asoc tree
Date: Tue, 19 Feb 2019 15:50:13 +0000 (GMT)
Message-ID: <20190219155014.02ED911284B7@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F00AF8078C
 for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2019 12:13:41 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Yong Zhi <yong.zhi@intel.com>
Cc: Naveen Manohar <naveen.m@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Headset button support in broxton machine driver

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9dd9b210f8c6104690ba48a630bbe9af2f32c292 Mon Sep 17 00:00:00 2001
From: Yong Zhi <yong.zhi@intel.com>
Date: Wed, 13 Feb 2019 17:08:51 -0600
Subject: [PATCH] ASoC: Intel: Headset button support in broxton machine driver

Map the 4 headset buttons to KEY_PAUSE, KEY_VOLUMEUP, KEY_VOLUMEDOWN and
KEY_VOICECOMMAND.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Yong Zhi <yong.zhi@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index c00925f9da73..30311b81a543 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -16,6 +16,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
@@ -193,6 +194,12 @@ static int broxton_da7219_codec_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
+	snd_jack_set_key(broxton_headset.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
+	snd_jack_set_key(broxton_headset.jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
+	snd_jack_set_key(broxton_headset.jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
+	snd_jack_set_key(broxton_headset.jack, SND_JACK_BTN_3,
+			 KEY_VOICECOMMAND);
+
 	da7219_aad_jack_det(component, &broxton_headset);
 
 	snd_soc_dapm_ignore_suspend(&rtd->card->dapm, "SoC DMIC");
-- 
2.20.1
