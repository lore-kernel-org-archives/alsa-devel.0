From: Jaroslav Kysela <perex@perex.cz>
Subject: snd-hda-intel - wallclk patch
Date: Mon, 10 May 2010 18:57:37 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005101849490.6856@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A1B71247CF
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 18:57:38 +0200 (CEST)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	881F2149B1C for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 18:57:38 +0200 (CEST)
Received: from eeebox2.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	5229384AAB for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 18:57:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: tiwai@perex.cz
List-Id: alsa-devel@alsa-project.org

Hi,

 	I would like to ask HDA gurus to check this patch (I will include 
it to my tree once acked). The patch uses WALLCLK from HDA chips (marked 
as required in the HDA specification) to check for bogus - too early - 
interrups which confuses the upper PCM layer (sound skipping issues).

 	More details about patch testing on problematic hardware can be 
found at:

 	https://bugzilla.kernel.org/show_bug.cgi?id=15912

 					Thanks,
 						Jaroslav

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 236b4ca..714978f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -174,7 +174,7 @@ MODULE_DESCRIPTION("Intel HDA driver");
  #define   ICH6_GSTS_FSTS	(1 << 1)   /* flush status */
  #define ICH6_REG_INTCTL			0x20
  #define ICH6_REG_INTSTS			0x24
-#define ICH6_REG_WALCLK			0x30
+#define ICH6_REG_WALLCLK		0x30	/* 24Mhz source */
  #define ICH6_REG_SYNC			0x34
  #define ICH6_REG_CORBLBASE		0x40
  #define ICH6_REG_CORBUBASE		0x44
@@ -340,8 +340,8 @@ struct azx_dev {
  	unsigned int period_bytes; /* size of the period in bytes */
  	unsigned int frags;	/* number for period in the play buffer */
  	unsigned int fifo_size;	/* FIFO size */
-	unsigned long start_jiffies;	/* start + minimum jiffies */
-	unsigned long min_jiffies;	/* minimum jiffies before position is valid */
+	unsigned long start_wallclk;	/* start + minimum wallclk */
+	unsigned long period_wallclk;	/* wallclk for period */

  	void __iomem *sd_addr;	/* stream descriptor pointer */

@@ -361,7 +361,6 @@ struct azx_dev {
  	unsigned int opened :1;
  	unsigned int running :1;
  	unsigned int irq_pending :1;
-	unsigned int start_flag: 1;	/* stream full start flag */
  	/*
  	 * For VIA:
  	 *  A flag to ensure DMA position is 0
@@ -1674,8 +1673,9 @@ static int azx_pcm_prepare(struct snd_pcm_substream *substream)
  			return err;
  	}

-	azx_dev->min_jiffies = (runtime->period_size * HZ) /
-						(runtime->rate * 2);
+	/* wallclk has 24Mhz clock source */
+	azx_dev->period_wallclk = (((runtime->period_size * 24000) /
+						runtime->rate) * 1000);
  	azx_setup_controller(chip, azx_dev);
  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
  		azx_dev->fifo_size = azx_sd_readw(azx_dev, SD_FIFOSIZE) + 1;
@@ -1729,14 +1729,15 @@ static int azx_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
  		if (s->pcm->card != substream->pcm->card)
  			continue;
  		azx_dev = get_azx_dev(s);
-		if (rstart) {
-			azx_dev->start_flag = 1;
-			azx_dev->start_jiffies = jiffies + azx_dev->min_jiffies;
-		}
-		if (start)
+		if (start) {
+			azx_dev->start_wallclk = azx_readl(chip, WALLCLK);
+			if (!rstart)
+				azx_dev->start_wallclk -=
+						azx_dev->period_wallclk;
  			azx_stream_start(chip, azx_dev);
-		else
+		} else {
  			azx_stream_stop(chip, azx_dev);
+		}
  		azx_dev->running = start;
  	}
  	spin_unlock(&chip->reg_lock);
@@ -1880,12 +1881,13 @@ static snd_pcm_uframes_t azx_pcm_pointer(struct snd_pcm_substream *substream)
   */
  static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
  {
+	u32 wallclk;
  	unsigned int pos;

-	if (azx_dev->start_flag &&
-	    time_before_eq(jiffies, azx_dev->start_jiffies))
+	wallclk = azx_readl(chip, WALLCLK);
+	if ((wallclk - azx_dev->start_wallclk) <
+				(azx_dev->period_wallclk * 2) / 3)
  		return -1;	/* bogus (too early) interrupt */
-	azx_dev->start_flag = 0;

  	pos = azx_get_position(chip, azx_dev);
  	if (chip->position_fix == POS_FIX_AUTO) {
@@ -1899,13 +1901,12 @@ static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
  			chip->position_fix = POS_FIX_POSBUF;
  	}

-	if (!bdl_pos_adj[chip->dev_index])
-		return 1; /* no delayed ack */
  	if (WARN_ONCE(!azx_dev->period_bytes,
  		      "hda-intel: zero azx_dev->period_bytes"))
  		return 0; /* this shouldn't happen! */
  	if (pos % azx_dev->period_bytes > azx_dev->period_bytes / 2)
  		return 0; /* NG - it's below the period boundary */
+	azx_dev->start_wallclk = wallclk;
  	return 1; /* OK, it's fine */
  }

@@ -1915,7 +1916,7 @@ static int azx_position_ok(struct azx *chip, struct azx_dev *azx_dev)
  static void azx_irq_pending_work(struct work_struct *work)
  {
  	struct azx *chip = container_of(work, struct azx, irq_pending_work);
-	int i, pending;
+	int i, pending, ok;

  	if (!chip->irq_pending_warned) {
  		printk(KERN_WARNING
@@ -1934,11 +1935,14 @@ static void azx_irq_pending_work(struct work_struct *work)
  			    !azx_dev->substream ||
  			    !azx_dev->running)
  				continue;
-			if (azx_position_ok(chip, azx_dev)) {
+			ok = azx_position_ok(chip, azx_dev);
+			if (ok > 0) {
  				azx_dev->irq_pending = 0;
  				spin_unlock(&chip->reg_lock);
  				snd_pcm_period_elapsed(azx_dev->substream);
  				spin_lock(&chip->reg_lock);
+			} else if (ok < 0) {
+				pending = 0;	/* too early */
  			} else
  				pending++;
  		}

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
