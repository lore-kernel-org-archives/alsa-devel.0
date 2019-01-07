From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5640: fix boolean assignments" to the
	asoc tree
Date: Mon,  7 Jan 2019 18:58:14 +0000 (GMT)
Message-ID: <20190107185814.E8CCB1127492@debutante.sirena.org.uk>
References: <20190105020249.8639-13-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 263922670C9
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 19:58:16 +0100 (CET)
In-Reply-To: <20190105020249.8639-13-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5640: fix boolean assignments

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

>From e0a99927ff5f395f24e09e6297858cd2006793f7 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:40 -0600
Subject: [PATCH] ASoC: rt5640: fix boolean assignments

Reported by Coccinelle:
sound/soc/codecs/rt5640.c:980:2-17: WARNING: Assignment of bool to 0/1
sound/soc/codecs/rt5640.c:984:2-17: WARNING: Assignment of bool to 0/1
sound/soc/codecs/rt5640.c:2825:1-16: WARNING: Assignment of bool to 0/1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5640.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index fc530481a6e4..b3580ecadecf 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -977,11 +977,11 @@ static int rt5640_hp_event(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		rt5640_pmu_depop(component);
-		rt5640->hp_mute = 0;
+		rt5640->hp_mute = false;
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-		rt5640->hp_mute = 1;
+		rt5640->hp_mute = true;
 		msleep(70);
 		break;
 
@@ -2822,7 +2822,7 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
 	regmap_update_bits(rt5640->regmap, RT5640_DUMMY1,
 				RT5640_MCLK_DET, RT5640_MCLK_DET);
 
-	rt5640->hp_mute = 1;
+	rt5640->hp_mute = true;
 	rt5640->irq = i2c->irq;
 	INIT_DELAYED_WORK(&rt5640->bp_work, rt5640_button_press_work);
 	INIT_WORK(&rt5640->jack_work, rt5640_jack_work);
-- 
2.20.1
