From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/5] ALSA: fm801: restore TEA575x state on
	resume
Date: Mon, 21 Dec 2015 19:09:56 +0200
Message-ID: <1450717796-66115-5-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1450717796-66115-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 486EE265068
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

The suspend / resume cycle resets the settings of the FM tuner. Restore
frequency settings on resume.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/fm801.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index e3add48..bade9b9 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1427,6 +1427,11 @@ static int snd_fm801_resume(struct device *dev)
 	for (i = 0; i < ARRAY_SIZE(saved_regs); i++)
 		fm801_iowrite16(chip, saved_regs[i], chip->saved_regs[i]);
 
+#ifdef CONFIG_SND_FM801_TEA575X_BOOL
+	if (!(chip->tea575x_tuner & TUNER_DISABLED))
+		snd_tea575x_set_freq(&chip->tea);
+#endif
+
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	return 0;
 }
-- 
2.6.4
