From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Headset button support in
	kabylake machine driver" to the asoc tree
Date: Tue, 19 Sep 2017 14:46:27 +0100
Message-ID: <E1duIr5-0008Ex-IZ@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id EC5A8267422
 for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2017 15:46:29 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen M <naveen.m@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Headset button support in kabylake machine driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From ae09a4783b9caf9307f303ef039f8297ce0371fe Mon Sep 17 00:00:00 2001
From: Naveen M <naveen.m@intel.com>
Date: Fri, 15 Sep 2017 13:43:21 +0530
Subject: [PATCH] ASoC: Intel: Headset button support in kabylake machine
 driver

Patch adds headset button support for kabylake machine driver
(kbl_rt5663_max98927).

Signed-off-by: Naveen M <naveen.m@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_max98927.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 7f7607420706..e45b6feca076 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -17,6 +17,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/input.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <sound/core.h>
@@ -208,6 +209,7 @@ static int kabylake_rt5663_codec_init(struct snd_soc_pcm_runtime *rtd)
 	int ret;
 	struct kbl_rt5663_private *ctx = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_jack *jack;
 
 	/*
 	 * Headset buttons map to the google Reference headset.
@@ -221,6 +223,13 @@ static int kabylake_rt5663_codec_init(struct snd_soc_pcm_runtime *rtd)
 		dev_err(rtd->dev, "Headset Jack creation failed %d\n", ret);
 		return ret;
 	}
+
+	jack = &ctx->kabylake_headset;
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_MEDIA);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
+	snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
+
 	rt5663_set_jack_detect(codec, &ctx->kabylake_headset);
 	return ret;
 }
-- 
2.14.1
