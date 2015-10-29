From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] snd-cs46xx: Fix suspend for all channels
Date: Thu, 29 Oct 2015 20:52:24 +0100
Message-ID: <1446148344-1209-1-git-send-email-linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gsystem.sk (ns.gsystem.sk [62.176.172.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 08DEC264F34
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 20:52:33 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.com>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

snd_cs46xx_suspend() is missing snd_pcm_suspend_all calls for pcm_rear,
pcm_center_lfe and pcm_iec958.

There's also a copy/paste bug in snd_cs46xx_pcm_iec958(), overwriting
pcm_rear in struct snd_cs46xx, leaving pcm_iec958 unused.

Fix all this to allow all channels to survive suspend/resume.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
---
 sound/pci/cs46xx/cs46xx_lib.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index e62c841..2706f27 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -1864,7 +1864,7 @@ int snd_cs46xx_pcm_iec958(struct snd_cs46xx *chip, int device)
 	/* global setup */
 	pcm->info_flags = 0;
 	strcpy(pcm->name, "CS46xx - IEC958");
-	chip->pcm_rear = pcm;
+	chip->pcm_iec958 = pcm;
 
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(chip->pci), 64*1024, 256*1024);
@@ -3780,6 +3780,11 @@ static int snd_cs46xx_suspend(struct device *dev)
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	chip->in_suspend = 1;
 	snd_pcm_suspend_all(chip->pcm);
+#ifdef CONFIG_SND_CS46XX_NEW_DSP
+	snd_pcm_suspend_all(chip->pcm_rear);
+	snd_pcm_suspend_all(chip->pcm_center_lfe);
+	snd_pcm_suspend_all(chip->pcm_iec958);
+#endif
 	// chip->ac97_powerdown = snd_cs46xx_codec_read(chip, AC97_POWER_CONTROL);
 	// chip->ac97_general_purpose = snd_cs46xx_codec_read(chip, BA0_AC97_GENERAL_PURPOSE);
 
-- 
Ondrej Zary
