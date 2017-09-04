From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs43130: fix spelling mistake: "irq_occurrance" -> "irq_occurrence"" to the asoc tree
Date: Mon,  4 Sep 2017 13:46:31 +0100 (BST)
Message-ID: <20170904124631.EB2F74400FC@finisterre.ee.mobilebroadband>
References: <20170904101232.22339-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904101232.22339-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs43130: fix spelling mistake: "irq_occurrance" -> "irq_occurrence"

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

>From 83ef26ac1326fdd2fc8d160967cdca2e8b46ccd4 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 4 Sep 2017 11:12:32 +0100
Subject: [PATCH] ASoC: cs43130: fix spelling mistake: "irq_occurrance" ->
 "irq_occurrence"

Trivial fix to spelling mistake in variable name

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs43130.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 220e30199c5b..9f1aa0516fd0 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -2147,7 +2147,7 @@ static irqreturn_t cs43130_irq_thread(int irq, void *data)
 	struct cs43130_private *cs43130 = (struct cs43130_private *)data;
 	struct snd_soc_codec *codec = cs43130->codec;
 	unsigned int stickies[CS43130_NUM_INT];
-	unsigned int irq_occurrance = 0;
+	unsigned int irq_occurrence = 0;
 	unsigned int masks[CS43130_NUM_INT];
 	int i, j;
 
@@ -2161,12 +2161,12 @@ static irqreturn_t cs43130_irq_thread(int irq, void *data)
 	for (i = 0; i < ARRAY_SIZE(stickies); i++) {
 		stickies[i] = stickies[i] & (~masks[i]);
 		for (j = 0; j < 8; j++)
-			irq_occurrance += (stickies[i] >> j) & 1;
+			irq_occurrence += (stickies[i] >> j) & 1;
 	}
 	dev_dbg(codec->dev, "number of interrupts occurred (%u)\n",
-		irq_occurrance);
+		irq_occurrence);
 
-	if (!irq_occurrance)
+	if (!irq_occurrence)
 		return IRQ_NONE;
 
 	if (stickies[0] & CS43130_XTAL_RDY_INT) {
-- 
2.13.2
