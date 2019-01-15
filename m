From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/14] ALSA: isa: Remove superfluous
	snd_pcm_suspend*() calls
Date: Tue, 15 Jan 2019 17:21:44 +0100
Message-ID: <20190115162155.6308-4-tiwai@suse.de>
References: <20190115162155.6308-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BF7B267438
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2019 17:21:56 +0100 (CET)
In-Reply-To: <20190115162155.6308-1-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The call of snd_pcm_suspend_all() & co became superfluous since we
call it in the PCM PM ops.  Let's remove them.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/ad1816a/ad1816a_lib.c | 1 -
 sound/isa/als100.c              | 1 -
 sound/isa/cmi8328.c             | 1 -
 sound/isa/cmi8330.c             | 1 -
 sound/isa/es1688/es1688.c       | 2 --
 sound/isa/es18xx.c              | 2 --
 sound/isa/sb/jazz16.c           | 1 -
 sound/isa/sb/sb16.c             | 1 -
 sound/isa/sb/sb8.c              | 1 -
 sound/isa/wss/wss_lib.c         | 1 -
 10 files changed, 12 deletions(-)

diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index fba6d22f7f4b..61e8c7e524db 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -518,7 +518,6 @@ void snd_ad1816a_suspend(struct snd_ad1816a *chip)
 	int reg;
 	unsigned long flags;
 
-	snd_pcm_suspend_all(chip->pcm);
 	spin_lock_irqsave(&chip->lock, flags);
 	for (reg = 0; reg < 48; reg++)
 		chip->image[reg] = snd_ad1816a_read(chip, reg);
diff --git a/sound/isa/als100.c b/sound/isa/als100.c
index f63142ec287e..571108021e9d 100644
--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -322,7 +322,6 @@ static int snd_als100_pnp_suspend(struct pnp_card_link *pcard, pm_message_t stat
 	struct snd_sb *chip = acard->chip;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
 	snd_sbmixer_suspend(chip);
 	return 0;
 }
diff --git a/sound/isa/cmi8328.c b/sound/isa/cmi8328.c
index de6ef1b1cf0e..617977516201 100644
--- a/sound/isa/cmi8328.c
+++ b/sound/isa/cmi8328.c
@@ -434,7 +434,6 @@ static int snd_cmi8328_suspend(struct device *pdev, unsigned int n,
 	cmi = card->private_data;
 	snd_cmi8328_cfg_save(cmi->port, cmi->cfg);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(cmi->wss->pcm);
 	cmi->wss->suspend(cmi->wss);
 
 	return 0;
diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index 6b8c46942efb..7e5aa06414c4 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -484,7 +484,6 @@ static int snd_cmi8330_suspend(struct snd_card *card)
 	struct snd_cmi8330 *acard = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(acard->pcm);
 	acard->wss->suspend(acard->wss);
 	snd_sbmixer_suspend(acard->sb);
 	return 0;
diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index 3dfe7e592c25..87527627e059 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -301,10 +301,8 @@ static int snd_es968_pnp_suspend(struct pnp_card_link *pcard,
 				 pm_message_t state)
 {
 	struct snd_card *card = pnp_get_card_drvdata(pcard);
-	struct snd_es1688 *chip = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
 	return 0;
 }
 
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 0d103d6f805e..77aa9a27fb3b 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1731,8 +1731,6 @@ static int snd_es18xx_suspend(struct snd_card *card, pm_message_t state)
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 
-	snd_pcm_suspend_all(chip->pcm);
-
 	/* power down */
 	chip->pm_reg = (unsigned char)snd_es18xx_read(chip, ES18XX_PM);
 	chip->pm_reg |= (ES18XX_PM_FM | ES18XX_PM_SUS);
diff --git a/sound/isa/sb/jazz16.c b/sound/isa/sb/jazz16.c
index bfa0055e1fd6..7a313ff589c7 100644
--- a/sound/isa/sb/jazz16.c
+++ b/sound/isa/sb/jazz16.c
@@ -356,7 +356,6 @@ static int snd_jazz16_suspend(struct device *pdev, unsigned int n,
 	struct snd_sb *chip = acard->chip;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
 	snd_sbmixer_suspend(chip);
 	return 0;
 }
diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
index 8f9ebeb998f6..3844d4c02f49 100644
--- a/sound/isa/sb/sb16.c
+++ b/sound/isa/sb/sb16.c
@@ -471,7 +471,6 @@ static int snd_sb16_suspend(struct snd_card *card, pm_message_t state)
 	struct snd_sb *chip = acard->chip;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
 	snd_sbmixer_suspend(chip);
 	return 0;
 }
diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index d77dcba276b5..aa2a83eb81a9 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -218,7 +218,6 @@ static int snd_sb8_suspend(struct device *dev, unsigned int n,
 	struct snd_sb *chip = acard->chip;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
 	snd_sbmixer_suspend(chip);
 	return 0;
 }
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 3a5008837576..b11ef97bce1b 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -1625,7 +1625,6 @@ static void snd_wss_suspend(struct snd_wss *chip)
 	int reg;
 	unsigned long flags;
 
-	snd_pcm_suspend_all(chip->pcm);
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	for (reg = 0; reg < 32; reg++)
 		chip->image[reg] = snd_wss_in(chip, reg);
-- 
2.20.1
