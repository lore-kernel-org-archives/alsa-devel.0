From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Reporting button
	presses" to the asoc tree
Date: Tue, 10 Jul 2018 19:16:29 +0100
Message-ID: <E1fcxBd-0001fG-TK@debutante>
References: <20180704225935.7902-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BE3F267715
 for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2018 20:16:42 +0200 (CEST)
In-Reply-To: <20180704225935.7902-5-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Reporting button presses

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

>From caed9d636e857997e923dfe473b9310de645d916 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 5 Jul 2018 00:59:35 +0200
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Reporting button presses

Enable reporting of button presses now that the codec driver recently has
gotten support for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 2a8f86dfe4cb..b687043c8425 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dmi.h>
+#include <linux/input.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/slab.h>
@@ -531,13 +532,17 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 
 	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
 		ret = snd_soc_card_jack_new(runtime->card, "Headset",
-				    SND_JACK_HEADSET, &priv->jack,
-				    bytcr_jack_pins, ARRAY_SIZE(bytcr_jack_pins));
+				    SND_JACK_HEADSET | SND_JACK_BTN_0,
+				    &priv->jack, bytcr_jack_pins,
+				    ARRAY_SIZE(bytcr_jack_pins));
 		if (ret) {
 			dev_err(runtime->dev, "jack creation failed %d\n", ret);
 			return ret;
 		}
 
+		snd_jack_set_key(priv->jack.jack, SND_JACK_BTN_0,
+				 KEY_PLAYPAUSE);
+
 		ret = snd_soc_component_set_jack(codec, &priv->jack, NULL);
 		if (ret)
 			return ret;
-- 
2.18.0.rc2
