From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/6] ALSA: pdaudiocf: Use nonatomic PCM ops
Date: Thu, 11 Sep 2014 16:00:25 +0200
Message-ID: <1410444025-22772-7-git-send-email-tiwai@suse.de>
References: <1410444025-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A50B726575A
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 16:00:32 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 2C1BBAD23
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 14:00:30 +0000 (UTC)
In-Reply-To: <1410444025-22772-1-git-send-email-tiwai@suse.de>
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

Like other fixes, convert the tasklet to a threaded irq and replace
spinlock with mutex appropriately.  ak4117_lock remains as spinlock
since it's called in another spinlock context from ak4117 driver.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
Compile tested only.

 sound/pcmcia/pdaudiocf/pdaudiocf.c      |  3 ++-
 sound/pcmcia/pdaudiocf/pdaudiocf.h      |  5 ++---
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c |  8 +++-----
 sound/pcmcia/pdaudiocf/pdaudiocf_irq.c  | 23 ++++++++++++-----------
 sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c  |  5 +++--
 5 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf.c b/sound/pcmcia/pdaudiocf/pdaudiocf.c
index 56bda124cd4a..d371309067f8 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.c
@@ -222,7 +222,8 @@ static int pdacf_config(struct pcmcia_device *link)
 	if (ret)
 		goto failed;
 
-	ret = pcmcia_request_irq(link, pdacf_interrupt);
+	ret = pcmcia_request_threaded_irq(link, pdacf_interrupt,
+					  pdacf_threaded_irq);
 	if (ret)
 		goto failed;
 
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf.h b/sound/pcmcia/pdaudiocf/pdaudiocf.h
index ea41e57d7179..e9a7d3a784f7 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.h
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.h
@@ -88,10 +88,9 @@ struct snd_pdacf {
 	unsigned long port;
 	int irq;
 
-	spinlock_t reg_lock;
+	struct mutex reg_lock;
 	unsigned short regmap[8];
 	unsigned short suspend_reg_scr;
-	struct tasklet_struct tq;
 
 	spinlock_t ak4117_lock;
 	struct ak4117 *ak4117;
@@ -136,7 +135,7 @@ int snd_pdacf_resume(struct snd_pdacf *chip);
 #endif
 int snd_pdacf_pcm_new(struct snd_pdacf *chip);
 irqreturn_t pdacf_interrupt(int irq, void *dev);
-void pdacf_tasklet(unsigned long private_data);
+irqreturn_t pdacf_threaded_irq(int irq, void *dev);
 void pdacf_reinit(struct snd_pdacf *chip, int resume);
 
 #endif /* __PDAUDIOCF_H */
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf_core.c b/sound/pcmcia/pdaudiocf/pdaudiocf_core.c
index ea0adfb984ad..d724ab0653cf 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf_core.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf_core.c
@@ -162,9 +162,8 @@ struct snd_pdacf *snd_pdacf_create(struct snd_card *card)
 	if (chip == NULL)
 		return NULL;
 	chip->card = card;
-	spin_lock_init(&chip->reg_lock);
+	mutex_init(&chip->reg_lock);
 	spin_lock_init(&chip->ak4117_lock);
-	tasklet_init(&chip->tq, pdacf_tasklet, (unsigned long)chip);
 	card->private_data = chip;
 
 	pdacf_proc_init(chip);
@@ -174,19 +173,18 @@ struct snd_pdacf *snd_pdacf_create(struct snd_card *card)
 static void snd_pdacf_ak4117_change(struct ak4117 *ak4117, unsigned char c0, unsigned char c1)
 {
 	struct snd_pdacf *chip = ak4117->change_callback_private;
-	unsigned long flags;
 	u16 val;
 
 	if (!(c0 & AK4117_UNLCK))
 		return;
-	spin_lock_irqsave(&chip->reg_lock, flags);
+	mutex_lock(&chip->reg_lock);
 	val = chip->regmap[PDAUDIOCF_REG_SCR>>1];
 	if (ak4117->rcs0 & AK4117_UNLCK)
 		val |= PDAUDIOCF_BLUE_LED_OFF;
 	else
 		val &= ~PDAUDIOCF_BLUE_LED_OFF;
 	pdacf_reg_write(chip, PDAUDIOCF_REG_SCR, val);
-	spin_unlock_irqrestore(&chip->reg_lock, flags);
+	mutex_unlock(&chip->reg_lock);
 }
 
 int snd_pdacf_ak4117_create(struct snd_pdacf *chip)
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf_irq.c b/sound/pcmcia/pdaudiocf/pdaudiocf_irq.c
index dcd32201bc8c..ecf0fbd91794 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf_irq.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf_irq.c
@@ -30,6 +30,7 @@ irqreturn_t pdacf_interrupt(int irq, void *dev)
 {
 	struct snd_pdacf *chip = dev;
 	unsigned short stat;
+	bool wake_thread = false;
 
 	if ((chip->chip_status & (PDAUDIOCF_STAT_IS_STALE|
 				  PDAUDIOCF_STAT_IS_CONFIGURED|
@@ -41,13 +42,13 @@ irqreturn_t pdacf_interrupt(int irq, void *dev)
 		if (stat & PDAUDIOCF_IRQOVR)	/* should never happen */
 			snd_printk(KERN_ERR "PDAUDIOCF SRAM buffer overrun detected!\n");
 		if (chip->pcm_substream)
-			tasklet_schedule(&chip->tq);
+			wake_thread = true;
 		if (!(stat & PDAUDIOCF_IRQAKM))
 			stat |= PDAUDIOCF_IRQAKM;	/* check rate */
 	}
 	if (get_irq_regs() != NULL)
 		snd_ak4117_check_rate_and_errors(chip->ak4117, 0);
-	return IRQ_HANDLED;
+	return wake_thread ? IRQ_WAKE_THREAD : IRQ_HANDLED;
 }
 
 static inline void pdacf_transfer_mono16(u16 *dst, u16 xor, unsigned int size, unsigned long rdp_port)
@@ -256,16 +257,16 @@ static void pdacf_transfer(struct snd_pdacf *chip, unsigned int size, unsigned i
 	}
 }
 
-void pdacf_tasklet(unsigned long private_data)
+irqreturn_t pdacf_threaded_irq(int irq, void *dev)
 {
-	struct snd_pdacf *chip = (struct snd_pdacf *) private_data;
+	struct snd_pdacf *chip = dev;
 	int size, off, cont, rdp, wdp;
 
 	if ((chip->chip_status & (PDAUDIOCF_STAT_IS_STALE|PDAUDIOCF_STAT_IS_CONFIGURED)) != PDAUDIOCF_STAT_IS_CONFIGURED)
-		return;
+		return IRQ_HANDLED;
 	
 	if (chip->pcm_substream == NULL || chip->pcm_substream->runtime == NULL || !snd_pcm_running(chip->pcm_substream))
-		return;
+		return IRQ_HANDLED;
 
 	rdp = inw(chip->port + PDAUDIOCF_REG_RDP);
 	wdp = inw(chip->port + PDAUDIOCF_REG_WDP);
@@ -311,15 +312,15 @@ void pdacf_tasklet(unsigned long private_data)
 		size -= cont;
 	}
 #endif
-	spin_lock(&chip->reg_lock);
+	mutex_lock(&chip->reg_lock);
 	while (chip->pcm_tdone >= chip->pcm_period) {
 		chip->pcm_hwptr += chip->pcm_period;
 		chip->pcm_hwptr %= chip->pcm_size;
 		chip->pcm_tdone -= chip->pcm_period;
-		spin_unlock(&chip->reg_lock);
+		mutex_unlock(&chip->reg_lock);
 		snd_pcm_period_elapsed(chip->pcm_substream);
-		spin_lock(&chip->reg_lock);
+		mutex_lock(&chip->reg_lock);
 	}
-	spin_unlock(&chip->reg_lock);
-	/* printk(KERN_DEBUG "TASKLET: end\n"); */
+	mutex_unlock(&chip->reg_lock);
+	return IRQ_HANDLED;
 }
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c b/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c
index 43f995a3f960..b48aa0a78c19 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c
@@ -77,7 +77,7 @@ static int pdacf_pcm_trigger(struct snd_pcm_substream *subs, int cmd)
 	default:
 		return -EINVAL;
 	}
-	spin_lock(&chip->reg_lock);
+	mutex_lock(&chip->reg_lock);
 	chip->pcm_running += inc;
 	tmp = pdacf_reg_read(chip, PDAUDIOCF_REG_SCR);
 	if (chip->pcm_running) {
@@ -91,7 +91,7 @@ static int pdacf_pcm_trigger(struct snd_pcm_substream *subs, int cmd)
 	tmp |= val;
 	pdacf_reg_write(chip, PDAUDIOCF_REG_SCR, tmp);
       __end:
-	spin_unlock(&chip->reg_lock);
+	mutex_unlock(&chip->reg_lock);
 	snd_ak4117_check_rate_and_errors(chip->ak4117, AK4117_CHECK_NO_RATE);
 	return ret;
 }
@@ -296,6 +296,7 @@ int snd_pdacf_pcm_new(struct snd_pdacf *chip)
 
 	pcm->private_data = chip;
 	pcm->info_flags = 0;
+	pcm->nonatomic = true;
 	strcpy(pcm->name, chip->card->shortname);
 	chip->pcm = pcm;
 	
-- 
2.1.0
