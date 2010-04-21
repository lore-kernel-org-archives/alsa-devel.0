From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 3/4] snd-meastro3: Ignore spurious HV
	interrupts during suspend / resume
Date: Wed, 21 Apr 2010 11:04:08 -0400
Message-ID: <1271862249-22612-3-git-send-email-hdegoede@redhat.com>
References: <1271862249-22612-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.versatel.nl (smtp4.versatel.nl [62.58.50.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 14DBA10380E
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 16:58:52 +0200 (CEST)
In-Reply-To: <1271862249-22612-1-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Hans de Goede <hdegoede@redhat.com>
List-Id: alsa-devel@alsa-project.org

Ignore spurious HV interrupts during suspend / resume, this avoids
mistaking them for a mute button press. This is not very pretty but
it seems the only way to fix the master volume control gets muted
after suspend issue I'm seeing. Note that the es1968 driver is doing
exactly the same.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/pci/maestro3.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index c6593cf..0ed634a 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -849,6 +849,7 @@ struct snd_m3 {
 	struct snd_kcontrol *master_switch;
 	struct snd_kcontrol *master_volume;
 	struct tasklet_struct hwvol_tq;
+	unsigned int in_suspend;
 
 #ifdef CONFIG_PM
 	u16 *suspend_mem;
@@ -1626,6 +1627,11 @@ static void snd_m3_update_hw_volume(unsigned long private_data)
 	outb(0x88, chip->iobase + SHADOW_MIX_REG_MASTER);
 	outb(0x88, chip->iobase + HW_VOL_COUNTER_MASTER);
 
+	/* Ignore spurious HV interrupts during suspend / resume, this avoids
+	   mistaking them for a mute button press. */
+	if (chip->in_suspend)
+		return;
+
 	if (!chip->master_switch || !chip->master_volume)
 		return;
 
@@ -2439,6 +2445,7 @@ static int m3_suspend(struct pci_dev *pci, pm_message_t state)
 	if (chip->suspend_mem == NULL)
 		return 0;
 
+	chip->in_suspend = 1;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	snd_pcm_suspend_all(chip->pcm);
 	snd_ac97_suspend(chip->ac97);
@@ -2512,6 +2519,7 @@ static int m3_resume(struct pci_dev *pci)
 	snd_m3_hv_init(chip);
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+	chip->in_suspend = 0;
 	return 0;
 }
 #endif /* CONFIG_PM */
-- 
1.7.0.1
