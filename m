From: Colin King <colin.king@canonical.com>
Subject: [PATCH][sound-next] ASoC: cs43130: fix spelling mistake: "irq_occurrance" -> "irq_occurrence"
Date: Mon,  4 Sep 2017 11:12:32 +0100
Message-ID: <20170904101232.22339-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in variable name

Signed-off-by: Colin Ian King <colin.king@canonical.com>
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
2.14.1
