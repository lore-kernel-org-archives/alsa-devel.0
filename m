From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: Allow specifying dmic data pins
	through device-properties" to the asoc tree
Date: Fri, 11 May 2018 03:51:14 +0100 (BST)
Message-ID: <20180511025115.02C8744007A@finisterre.ee.mobilebroadband>
References: <20180508153604.23711-6-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 33593267281
 for <alsa-devel@alsa-project.org>; Fri, 11 May 2018 04:51:20 +0200 (CEST)
In-Reply-To: <20180508153604.23711-6-hdegoede@redhat.com>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: Allow specifying dmic data pins through device-properties

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

>From fb509fa962243e20bddcc5cab74c4a2153c01ff6 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 8 May 2018 17:35:50 +0200
Subject: [PATCH] ASoC: rt5640: Allow specifying dmic data pins through
 device-properties

Allow specifying dmic data pins through device-properties / dt. This will
allow us to stop exporting rt5640_dmic_enable() once all callers of it have
been converted to setting device-properties for this instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 265a0786851d..d7c7b207f3cc 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2097,6 +2097,10 @@ static int rt5640_probe(struct snd_soc_component *component)
 {
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct rt5640_priv *rt5640 = snd_soc_component_get_drvdata(component);
+	u32 dmic1_data_pin = 0;
+	u32 dmic2_data_pin = 0;
+	bool dmic_en = false;
+	u32 val;
 
 	/* Check if MCLK provided */
 	rt5640->mclk = devm_clk_get(component->dev, "mclk");
@@ -2157,6 +2161,21 @@ static int rt5640_probe(struct snd_soc_component *component)
 		snd_soc_component_update_bits(component, RT5640_IN1_IN2,
 					      RT5640_IN_DF2, RT5640_IN_DF2);
 
+	if (device_property_read_u32(component->dev, "realtek,dmic1-data-pin",
+				     &val) == 0 && val) {
+		dmic1_data_pin = val - 1;
+		dmic_en = true;
+	}
+
+	if (device_property_read_u32(component->dev, "realtek,dmic2-data-pin",
+				     &val) == 0 && val) {
+		dmic2_data_pin = val - 1;
+		dmic_en = true;
+	}
+
+	if (dmic_en)
+		rt5640_dmic_enable(component, dmic1_data_pin, dmic2_data_pin);
+
 	return 0;
 }
 
-- 
2.17.0
