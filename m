From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98383: fix boolean assignments to
	true/false" to the asoc tree
Date: Mon,  7 Jan 2019 18:58:22 +0000 (GMT)
Message-ID: <20190107185822.85B8D1127491@debutante.sirena.org.uk>
References: <20190105020249.8639-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CF9E0266BE8
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 19:58:23 +0100 (CET)
In-Reply-To: <20190105020249.8639-8-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ryan Lee <RyanS.Lee@maximintegrated.com>, tiwai@suse.de, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, liam.r.girdwood@linux.intel.com, Grant Grundler <grundler@chromium.org>, broonie@kernel.org, Benson Leung <bleung@chromium.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98383: fix boolean assignments to true/false

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

>From 7c3727ba7de2b94a066e38776660e648fa4ed28a Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 4 Jan 2019 20:02:35 -0600
Subject: [PATCH] ASoC: max98383: fix boolean assignments to true/false

Reported by Coccinelle:

sound/soc/codecs/max98373.c:411:2-20: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98373.c:922:2-27: WARNING: Assignment of bool to 0/1
sound/soc/codecs/max98373.c:924:2-27: WARNING: Assignment of bool to 0/1

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 9c8616a7b61c..528695cd6a1c 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -408,7 +408,7 @@ static int max98373_dac_event(struct snd_soc_dapm_widget *w,
 		regmap_update_bits(max98373->regmap,
 			MAX98373_R20FF_GLOBAL_SHDN,
 			MAX98373_GLOBAL_EN_MASK, 0);
-		max98373->tdm_mode = 0;
+		max98373->tdm_mode = false;
 		break;
 	default:
 		return 0;
@@ -919,9 +919,9 @@ static int max98373_i2c_probe(struct i2c_client *i2c,
 
 	/* update interleave mode info */
 	if (device_property_read_bool(&i2c->dev, "maxim,interleave_mode"))
-		max98373->interleave_mode = 1;
+		max98373->interleave_mode = true;
 	else
-		max98373->interleave_mode = 0;
+		max98373->interleave_mode = false;
 
 
 	/* regmap initialization */
-- 
2.20.1
