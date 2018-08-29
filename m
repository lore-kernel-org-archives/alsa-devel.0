From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm3060: Improve legibility of
	if-statements" to the asoc tree
Date: Wed, 29 Aug 2018 12:31:27 +0100 (BST)
Message-ID: <20180829113127.6CD381124859@debutante.sirena.org.uk>
References: <20180828214231.10164-2-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 184B526766C
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 13:31:29 +0200 (CEST)
In-Reply-To: <20180828214231.10164-2-kmarinushkin@birdec.tech>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, Mark Brown <broonie@kernel.org>, M R Swami Reddy <mr.swami.reddy@ti.com>, Kevin Cernekee <cernekee@chromium.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm3060: Improve legibility of if-statements

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

>From 080aaf10892eec4b359126473e582f62ebb09496 Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Date: Tue, 28 Aug 2018 23:42:31 +0200
Subject: [PATCH] ASoC: pcm3060: Improve legibility of if-statements

Modified some if-statements to make them more clear

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm3060.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm3060.c b/sound/soc/codecs/pcm3060.c
index 5b9718fa766d..494d9d662be8 100644
--- a/sound/soc/codecs/pcm3060.c
+++ b/sound/soc/codecs/pcm3060.c
@@ -68,7 +68,10 @@ static int pcm3060_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	reg = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG67 : PCM3060_REG72);
+	if (dai->id == PCM3060_DAI_ID_DAC)
+		reg = PCM3060_REG67;
+	else
+		reg = PCM3060_REG72;
 
 	regmap_update_bits(priv->regmap, reg, PCM3060_REG_MASK_FMT, val);
 
@@ -124,7 +127,10 @@ static int pcm3060_hw_params(struct snd_pcm_substream *substream,
 	}
 
 val_ready:
-	reg = (dai->id == PCM3060_DAI_ID_DAC ? PCM3060_REG67 : PCM3060_REG72);
+	if (dai->id == PCM3060_DAI_ID_DAC)
+		reg = PCM3060_REG67;
+	else
+		reg = PCM3060_REG72;
 
 	regmap_update_bits(priv->regmap, reg, PCM3060_REG_MASK_MS, val);
 
-- 
2.18.0
