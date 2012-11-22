From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 8/8] ALSA: emu10k1: don't update firmware
	during suspend/resume
Date: Thu, 22 Nov 2012 17:55:00 +0100
Message-ID: <1353603300-3217-9-git-send-email-tiwai@suse.de>
References: <1353603300-3217-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 59EEE2615A7
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 17:55:09 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 27A73A520D
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2012 17:55:09 +0100 (CET)
In-Reply-To: <1353603300-3217-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add a flag to suppress the update in emu1010_firmware_thread() during
suspend/resume.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/emu10k1.h          | 1 +
 sound/pci/emu10k1/emu10k1.c      | 4 ++++
 sound/pci/emu10k1/emu10k1_main.c | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/sound/emu10k1.h b/include/sound/emu10k1.h
index 9dc94b5..f841ba4 100644
--- a/include/sound/emu10k1.h
+++ b/include/sound/emu10k1.h
@@ -1796,6 +1796,7 @@ struct snd_emu10k1 {
 	unsigned int *saved_icode;
 	unsigned int *p16v_saved;
 	unsigned int saved_a_iocfg, saved_hcfg;
+	bool suspend;
 #endif
 
 };
diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index b7c1875..a168138 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -215,6 +215,8 @@ static int snd_emu10k1_suspend(struct device *dev)
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
+	emu->suspend = 1;
+
 	snd_pcm_suspend_all(emu->pcm);
 	snd_pcm_suspend_all(emu->pcm_mic);
 	snd_pcm_suspend_all(emu->pcm_efx);
@@ -260,6 +262,8 @@ static int snd_emu10k1_resume(struct device *dev)
 	if (emu->card_capabilities->ca0151_chip)
 		snd_p16v_resume(emu);
 
+	emu->suspend = 0;
+
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	return 0;
 }
diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index 1dfb94d..cfd6cf9 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -714,6 +714,8 @@ static int emu1010_firmware_thread(void *data)
 		msleep_interruptible(1000);
 		if (kthread_should_stop())
 			break;
+		if (emu->suspend)
+			continue;
 		snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &tmp); /* IRQ Status */
 		snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg); /* OPTIONS: Which cards are attached to the EMU */
 		if (reg & EMU_HANA_OPTION_DOCK_OFFLINE) {
-- 
1.8.0
