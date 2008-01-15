From: th.huth@googlemail.com
Subject: [PATCH] snd-powermac: handle dead DMA transfers
Date: Tue, 15 Jan 2008 21:43:44 +0100
Message-ID: <20080115214344.320c7fbe@phineus>
References: <20080114002111.2ef21467@phineus>
	<20080114000640.GO9040@baikonur.stro.at>
	<s5h7iicll9n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 496082440B
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 21:43:52 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so2744694fgb.44
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 12:43:51 -0800 (PST)
In-Reply-To: <s5h7iicll9n.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch provides the snd-powermac sound driver with the ability to handle
dead DMA transfers. If a dead DMA transfer is detected, the driver now sets
up a new DMA transfer to continue with the sound output at the point where the
old transfer died.

This dead DMA transfer handling has become necessary with recent kernels on
certain G4 PowerMacs. Please refer to the following URLs for more information:

 https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3126
 https://bugs.launchpad.net/ubuntu/+source/linux-source-2.6.20/+bug/87652
 http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=436723

The patch is based on the dead DMA transfer handling code from the old dmasound
driver which can be found in the file sound/oss/dmasound/dmasound_awacs.c in
the Linux source code.

Signed-off-by: T. H. Huth <th.huth@googlemail.com>

--- alsa-kernel/ppc/pmac.c_original	2008-01-15 19:50:23.000000000 +0100
+++ alsa-kernel/ppc/pmac.c	2008-01-15 21:10:54.000000000 +0100
@@ -45,6 +45,18 @@ static int tumbler_freqs[1] = {
 	44100
 };
 
+
+/*
+ * we will allocate a single 'emergency' dbdma cmd block to use if the
+ * tx status comes up "DEAD".  This happens on some PowerComputing Pmac
+ * clones, either owing to a bug in dbdma or some interaction between
+ * IDE and sound.  However, this measure would deal with DEAD status if
+ * it appeared elsewhere.
+ */
+static struct pmac_dbdma emergency_dbdma;
+static int emergency_in_use;
+
+
 /*
  * allocate DBDMA command arrays
  */
@@ -376,6 +388,75 @@ static snd_pcm_uframes_t snd_pmac_captur
 
 
 /*
+ * Handle DEAD DMA transfers:
+ * if the TX status comes up "DEAD" - reported on some Power Computing machines
+ * we need to re-start the dbdma - but from a different physical start address
+ * and with a different transfer length.  It would get very messy to do this
+ * with the normal dbdma_cmd blocks - we would have to re-write the buffer start
+ * addresses each time.  So, we will keep a single dbdma_cmd block which can be
+ * fiddled with.
+ * When DEAD status is first reported the content of the faulted dbdma block is
+ * copied into the emergency buffer and we note that the buffer is in use.
+ * we then bump the start physical address by the amount that was successfully
+ * output before it died.
+ * On any subsequent DEAD result we just do the bump-ups (we know that we are
+ * already using the emergency dbdma_cmd).
+ * CHECK: this just tries to "do it".  It is possible that we should abandon
+ * xfers when the number of residual bytes gets below a certain value - I can
+ * see that this might cause a loop-forever if a too small transfer causes
+ * DEAD status.  However this is a TODO for now - we'll see what gets reported.
+ * When we get a successful transfer result with the emergency buffer we just
+ * pretend that it completed using the original dmdma_cmd and carry on.  The
+ * 'next_cmd' field will already point back to the original loop of blocks.
+ */
+static inline void snd_pmac_pcm_dead_xfer(struct pmac_stream *rec,
+					  volatile struct dbdma_cmd __iomem *cp)
+{
+	unsigned short req, res ;
+	unsigned int phy ;
+
+	/* printk(KERN_WARNING "snd-powermac: DMA died - patching it up!\n"); */
+
+	/* to clear DEAD status we must first clear RUN
+	   set it to quiescent to be on the safe side */
+	(void)in_le32(&rec->dma->status);
+	out_le32(&rec->dma->control, (RUN|PAUSE|FLUSH|WAKE) << 16);
+
+	if (!emergency_in_use) { /* new problem */
+		memcpy((void *)emergency_dbdma.cmds, (void *)cp,
+		       sizeof(struct dbdma_cmd));
+		emergency_in_use = 1;
+		st_le16(&cp->xfer_status, 0);
+		st_le16(&cp->req_count, rec->period_size);
+		cp = emergency_dbdma.cmds;
+	}
+
+	/* now bump the values to reflect the amount
+	   we haven't yet shifted */
+	req = ld_le16(&cp->req_count);
+	res = ld_le16(&cp->res_count);
+	phy = ld_le32(&cp->phy_addr);
+	phy += (req - res);
+	st_le16(&cp->req_count, res);
+	st_le16(&cp->res_count, 0);
+	st_le16(&cp->xfer_status, 0);
+	st_le32(&cp->phy_addr, phy);
+
+	st_le32(&cp->cmd_dep, rec->cmd.addr
+		+ sizeof(struct dbdma_cmd)*((rec->cur_period+1)%rec->nperiods));
+
+	st_le16(&cp->command, OUTPUT_MORE | BR_ALWAYS | INTR_ALWAYS);
+
+	/* point at our patched up command block */
+	out_le32(&rec->dma->cmdptr, emergency_dbdma.addr);
+
+	/* we must re-start the controller */
+	(void)in_le32(&rec->dma->status);
+	/* should complete clearing the DEAD status */
+	out_le32(&rec->dma->control, ((RUN|WAKE) << 16) + (RUN|WAKE));
+}
+
+/*
  * update playback/capture pointer from interrupts
  */
 static void snd_pmac_pcm_update(struct snd_pmac *chip, struct pmac_stream *rec)
@@ -386,11 +467,27 @@ static void snd_pmac_pcm_update(struct s
 
 	spin_lock(&chip->reg_lock);
 	if (rec->running) {
-		cp = &rec->cmd.cmds[rec->cur_period];
 		for (c = 0; c < rec->nperiods; c++) { /* at most all fragments */
+
+			if (emergency_in_use)   /* already using DEAD xfer? */
+				cp = emergency_dbdma.cmds;
+			else
+				cp = &rec->cmd.cmds[rec->cur_period];
+
 			stat = ld_le16(&cp->xfer_status);
+
+			if (stat & DEAD) {
+				snd_pmac_pcm_dead_xfer(rec, cp);
+				break; /* this block is still going */
+			}
+
+			if (emergency_in_use) {
+				emergency_in_use = 0 ; /* done that */
+			}
+
 			if (! (stat & ACTIVE))
 				break;
+
 			/*printk("update frag %d\n", rec->cur_period);*/
 			st_le16(&cp->xfer_status, 0);
 			st_le16(&cp->req_count, rec->period_size);
@@ -398,9 +495,8 @@ static void snd_pmac_pcm_update(struct s
 			rec->cur_period++;
 			if (rec->cur_period >= rec->nperiods) {
 				rec->cur_period = 0;
-				cp = rec->cmd.cmds;
-			} else
-				cp++;
+			}
+
 			spin_unlock(&chip->reg_lock);
 			snd_pcm_period_elapsed(rec->substream);
 			spin_lock(&chip->reg_lock);
@@ -770,6 +866,7 @@ static int snd_pmac_free(struct snd_pmac
 	snd_pmac_dbdma_free(chip, &chip->playback.cmd);
 	snd_pmac_dbdma_free(chip, &chip->capture.cmd);
 	snd_pmac_dbdma_free(chip, &chip->extra_dma);
+	snd_pmac_dbdma_free(chip, &emergency_dbdma);
 	if (chip->macio_base)
 		iounmap(chip->macio_base);
 	if (chip->latch_base)
@@ -1108,7 +1205,8 @@ int __init snd_pmac_new(struct snd_card 
 
 	if (snd_pmac_dbdma_alloc(chip, &chip->playback.cmd, PMAC_MAX_FRAGS + 1) < 0 ||
 	    snd_pmac_dbdma_alloc(chip, &chip->capture.cmd, PMAC_MAX_FRAGS + 1) < 0 ||
-	    snd_pmac_dbdma_alloc(chip, &chip->extra_dma, 2) < 0) {
+	    snd_pmac_dbdma_alloc(chip, &chip->extra_dma, 2) < 0 ||
+	    snd_pmac_dbdma_alloc(chip, &emergency_dbdma, 2) < 0) {
 		err = -ENOMEM;
 		goto __error;
 	}
