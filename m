From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs53l30: Fix a bug for TDM slot location validation" to the asoc tree
Date: Thu, 21 Jul 2016 12:08:23 +0100
Message-ID: <E1bQBq3-0001oi-6W@debutante>
References: <1468967774-18621-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468967774-18621-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs53l30: Fix a bug for TDM slot location validation

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

>From 622019373c87e335cf926d30ad26b37b9efb27dc Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Tue, 19 Jul 2016 15:36:13 -0700
Subject: [PATCH] ASoC: cs53l30: Fix a bug for TDM slot location validation

The maximum slot number of CS53L30 is 4 while it should support
the situation that's less than 4 channels based on the rx_mask.

So when the driver validates the last slot location, it should
check the last active slot instead of always the 4th one.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs53l30.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 5988b5c672fe..fd5502e3aa34 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -809,8 +809,8 @@ static int cs53l30_set_dai_tdm_slot(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	/* Validate the last CS53L30 slot */
-	slot_next = loc[CS53L30_TDM_SLOT_MAX - 1] + slot_step - 1;
+	/* Validate the last active CS53L30 slot */
+	slot_next = loc[i - 1] + slot_step - 1;
 	if (slot_next > 47) {
 		dev_err(dai->dev, "slot selection out of bounds: %u\n",
 			slot_next);
-- 
2.8.1
