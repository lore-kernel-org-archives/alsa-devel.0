From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/5] ALSA: fm801: save context before
	suspend devices
Date: Mon, 21 Dec 2015 19:09:55 +0200
Message-ID: <1450717796-66115-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1450717796-66115-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 344E3265068
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2015 18:10:30 +0100 (CET)
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

In symmetry we save context first before suspend and restore it last after
resume.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/fm801.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index c7ba4f1..e3add48 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1394,6 +1394,9 @@ static int snd_fm801_suspend(struct device *dev)
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
+	for (i = 0; i < ARRAY_SIZE(saved_regs); i++)
+		chip->saved_regs[i] = fm801_ioread16(chip, saved_regs[i]);
+
 	if (chip->tea575x_tuner & TUNER_ONLY) {
 		/* FIXME: tea575x suspend */
 	} else {
@@ -1402,8 +1405,6 @@ static int snd_fm801_suspend(struct device *dev)
 		snd_ac97_suspend(chip->ac97_sec);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(saved_regs); i++)
-		chip->saved_regs[i] = fm801_ioread16(chip, saved_regs[i]);
 	return 0;
 }
 
-- 
2.6.4
