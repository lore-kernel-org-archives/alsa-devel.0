From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98373: Added TDM off if parameters are all zeroes" to the asoc tree
Date: Wed, 10 Jan 2018 11:13:54 +0000
Message-ID: <E1eZEKQ-000575-By@debutante>
References: <1515560521-10850-3-git-send-email-ryans.lee@maximintegrated.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1515560521-10850-3-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Lee <RyanS.Lee@maximintegrated.com>
Cc: Ryan Lee <ryans.lee@maximintegrated.com>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.comryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ryan.lee.maxim@gmail.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98373: Added TDM off if parameters are all zeroes

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

>From 3831a5b87ff87a31dba2f212bcecd4f2b8c7c6d4 Mon Sep 17 00:00:00 2001
From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Date: Tue, 9 Jan 2018 21:02:00 -0800
Subject: [PATCH] ASoC: max98373: Added TDM off if parameters are all zeroes

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index cb389571b253..ad17bb1fee7b 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -311,7 +311,10 @@ static int max98373_dai_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int mask;
 	int x, slot_found;
 
-	max98373->tdm_mode = true;
+	if (!tx_mask && !rx_mask && !slots && !slot_width)
+		max98373->tdm_mode = false;
+	else
+		max98373->tdm_mode = true;
 
 	/* BCLK configuration */
 	bsel = max98373_get_bclk_sel(slots * slot_width);
-- 
2.15.1
