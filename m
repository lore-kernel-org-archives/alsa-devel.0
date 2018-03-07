From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5651: Only create jack
	if we have a jack-detect source" to the asoc tree
Date: Wed, 07 Mar 2018 14:22:33 +0000
Message-ID: <E1etZxh-0002pk-Iz@debutante>
References: <20180304143610.21125-14-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E3098267339
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:22:38 +0100 (CET)
In-Reply-To: <20180304143610.21125-14-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5651: Only create jack if we have a jack-detect source

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

>From aed859a2c7ac8c44ba9b3a6f82b5f08da8a0a975 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:36:01 +0100
Subject: [PATCH] ASoC: Intel: bytcr_rt5651: Only create jack if we have a
 jack-detect source

Only create the jack if we have a valid jack-detect source and properly
check the snd_soc_component_set_jack() return value.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index a874bba3aec0..56f1f076d92c 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -404,17 +404,21 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
 			dev_err(card->dev, "unable to set MCLK rate\n");
 	}
 
-	ret = snd_soc_card_jack_new(runtime->card, "Headset",
+	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
+		ret = snd_soc_card_jack_new(runtime->card, "Headset",
 				    SND_JACK_HEADSET, &priv->jack,
 				    bytcr_jack_pins, ARRAY_SIZE(bytcr_jack_pins));
-	if (ret) {
-		dev_err(runtime->dev, "Headset jack creation failed %d\n", ret);
-		return ret;
-	}
+		if (ret) {
+			dev_err(runtime->dev, "jack creation failed %d\n", ret);
+			return ret;
+		}
 
-	snd_soc_component_set_jack(codec, &priv->jack, NULL);
+		ret = snd_soc_component_set_jack(codec, &priv->jack, NULL);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static const struct snd_soc_pcm_stream byt_rt5651_dai_params = {
-- 
2.16.2
