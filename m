From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/5] ALSA: fm801: no need to suspend absent
	codec
Date: Mon, 21 Dec 2015 19:09:54 +0200
Message-ID: <1450717796-66115-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1450717796-66115-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E02CB265071
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2015 18:10:05 +0100 (CET)
In-Reply-To: <1450717796-66115-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

In case of tuner only card there is no need to take care of the codec which is
anyway absent.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/fm801.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 2761880..c7ba4f1 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1393,12 +1393,17 @@ static int snd_fm801_suspend(struct device *dev)
 	int i;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
-	snd_ac97_suspend(chip->ac97);
-	snd_ac97_suspend(chip->ac97_sec);
+
+	if (chip->tea575x_tuner & TUNER_ONLY) {
+		/* FIXME: tea575x suspend */
+	} else {
+		snd_pcm_suspend_all(chip->pcm);
+		snd_ac97_suspend(chip->ac97);
+		snd_ac97_suspend(chip->ac97_sec);
+	}
+
 	for (i = 0; i < ARRAY_SIZE(saved_regs); i++)
 		chip->saved_regs[i] = fm801_ioread16(chip, saved_regs[i]);
-	/* FIXME: tea575x suspend */
 	return 0;
 }
 
@@ -1414,9 +1419,10 @@ static int snd_fm801_resume(struct device *dev)
 		reset_codec(chip);
 		snd_fm801_chip_multichannel_init(chip);
 		snd_fm801_chip_init(chip);
+		snd_ac97_resume(chip->ac97);
+		snd_ac97_resume(chip->ac97_sec);
 	}
-	snd_ac97_resume(chip->ac97);
-	snd_ac97_resume(chip->ac97_sec);
+
 	for (i = 0; i < ARRAY_SIZE(saved_regs); i++)
 		fm801_iowrite16(chip, saved_regs[i], chip->saved_regs[i]);
 
-- 
2.6.4
