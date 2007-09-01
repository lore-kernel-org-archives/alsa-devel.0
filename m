From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] dbri: more cleanups
Date: Sat, 1 Sep 2007 22:57:30 +0200
Message-ID: <20070901225730.a9211c8a.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id ED6B8243FD
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Sep 2007 22:51:39 +0200 (CEST)
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <alsa-devel@alsa-project.org>; 1 Sep 2007 22:51:21 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch:
- removes redundant constant suffices
- removes redundant parentheses
- removes redundant curly brackets
- removes check if a spinlock is locked inside method which is
  only called with the spinlock locked
- moves few functions to the __init section
- removes line which appears twice after the previous patch
- minor comments improvements

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff -urp old/sound/sparc/dbri.c new/sound/sparc/dbri.c
--- old/sound/sparc/dbri.c	2007-08-30 10:27:00.000000000 +0200
+++ new/sound/sparc/dbri.c	2007-09-01 22:48:24.947948928 +0200
@@ -233,12 +233,12 @@ static struct {
 ****************************************************************************/
 
 /* DBRI main registers */
-#define REG0	0x00UL		/* Status and Control */
-#define REG1	0x04UL		/* Mode and Interrupt */
-#define REG2	0x08UL		/* Parallel IO */
-#define REG3	0x0cUL		/* Test */
-#define REG8	0x20UL		/* Command Queue Pointer */
-#define REG9	0x24UL		/* Interrupt Queue Pointer */
+#define REG0	0x00		/* Status and Control */
+#define REG1	0x04		/* Mode and Interrupt */
+#define REG2	0x08		/* Parallel IO */
+#define REG3	0x0c		/* Test */
+#define REG8	0x20		/* Command Queue Pointer */
+#define REG9	0x24		/* Interrupt Queue Pointer */
 
 #define DBRI_NO_CMDS	64
 #define DBRI_INT_BLK	64
@@ -565,7 +565,7 @@ struct snd_dbri {
 /* Translate the ALSA direction into the array index */
 #define DBRI_STREAMNO(substream)				\
 		(substream->stream ==				\
-		 SNDRV_PCM_STREAM_PLAYBACK? DBRI_PLAY: DBRI_REC)
+		 SNDRV_PCM_STREAM_PLAYBACK ? DBRI_PLAY: DBRI_REC)
 
 /* Return a pointer to dbri_streaminfo */
 #define DBRI_STREAM(dbri, substream)	\
@@ -611,8 +611,8 @@ The list is terminated with a WAIT comma
 CPU interrupt to signal completion.
 
 Since the DBRI can run in parallel with the CPU, several means of
-synchronization present themselves. The method implemented here is only
-use of the dbri_cmdwait() to wait for execution of batch of sent commands.
+synchronization present themselves. The method implemented here uses
+the dbri_cmdwait() to wait for execution of batch of sent commands.
 
 A circular command buffer is used here. A new command is being added
 while another can be executed. The scheme works by adding two WAIT commands
@@ -648,15 +648,14 @@ static void dbri_cmdwait(struct snd_dbri
 	}
 	spin_unlock_irqrestore(&dbri->lock, flags);
 
-	if (maxloops == 0) {
+	if (maxloops == 0)
 		printk(KERN_ERR "DBRI: Chip never completed command buffer\n");
-	} else {
+	else
 		dprintk(D_CMD, "Chip completed command buffer (%d)\n",
 			MAXLOOPS - maxloops - 1);
-	}
 }
 /*
- * Lock the command queue and returns pointer to a space for len cmd words
+ * Lock the command queue and return pointer to space for len cmd words
  * It locks the cmdlock spinlock.
  */
 static s32 *dbri_cmdlock(struct snd_dbri *dbri, int len)
@@ -749,7 +748,7 @@ static void dbri_reset(struct snd_dbri *
 }
 
 /* Lock must not be held before calling this */
-static void dbri_initialize(struct snd_dbri *dbri)
+static void __init dbri_initialize(struct snd_dbri *dbri)
 {
 	s32 *cmd;
 	u32 dma_addr;
@@ -804,7 +803,7 @@ list ordering, among other things.  The 
 here interface closely with the transmit and receive interrupt code.
 
 */
-static int pipe_active(struct snd_dbri *dbri, int pipe)
+static inline int pipe_active(struct snd_dbri *dbri, int pipe)
 {
 	return ((pipe >= 0) && (dbri->pipes[pipe].desc != -1));
 }
@@ -1144,10 +1143,10 @@ static int setup_descs(struct snd_dbri *
 	while (len > 0) {
 		int mylen;
 
-		for (; desc < DBRI_NO_DESCS; desc++) {
+		for (; desc < DBRI_NO_DESCS; desc++)
 			if (!dbri->dma->desc[desc].ba)
 				break;
-		}
+
 		if (desc == DBRI_NO_DESCS) {
 			printk(KERN_ERR "DBRI: setup_descs: No descriptors\n");
 			return -1;
@@ -1308,7 +1307,7 @@ to the DBRI via the CHI interface and fe
  * Lock must not be held before calling it.
 
 */
-static void cs4215_setup_pipes(struct snd_dbri *dbri)
+static __init void cs4215_setup_pipes(struct snd_dbri *dbri)
 {
 	unsigned long flags;
 
@@ -1341,7 +1340,7 @@ static void cs4215_setup_pipes(struct sn
 	dbri_cmdwait(dbri);
 }
 
-static int cs4215_init_data(struct cs4215 *mm)
+static __init int cs4215_init_data(struct cs4215 *mm)
 {
 	/*
 	 * No action, memory resetting only.
@@ -1633,7 +1632,7 @@ static int cs4215_prepare(struct snd_dbr
 /*
  *
  */
-static int cs4215_init(struct snd_dbri *dbri)
+static __init int cs4215_init(struct snd_dbri *dbri)
 {
 	u32 reg2 = sbus_readl(dbri->regs + REG2);
 	dprintk(D_MM, "cs4215_init: reg2=0x%x\n", reg2);
@@ -1771,13 +1770,10 @@ static void xmit_descs(struct snd_dbri *
 
 static void transmission_complete_intr(struct snd_dbri *dbri, int pipe)
 {
-	struct dbri_streaminfo *info;
-	int td;
+	struct dbri_streaminfo *info = &dbri->stream_info[DBRI_PLAY];
+	int td = dbri->pipes[pipe].desc;
 	int status;
 
-	info = &dbri->stream_info[DBRI_PLAY];
-
-	td = dbri->pipes[pipe].desc;
 	while (td >= 0) {
 		if (td >= DBRI_NO_DESCS) {
 			printk(KERN_ERR "DBRI: invalid td on pipe %d\n", pipe);
@@ -1798,12 +1794,9 @@ static void transmission_complete_intr(s
 	}
 
 	/* Notify ALSA */
-	if (spin_is_locked(&dbri->lock)) {
-		spin_unlock(&dbri->lock);
-		snd_pcm_period_elapsed(info->substream);
-		spin_lock(&dbri->lock);
-	} else
-		snd_pcm_period_elapsed(info->substream);
+	spin_unlock(&dbri->lock);
+	snd_pcm_period_elapsed(info->substream);
+	spin_lock(&dbri->lock);
 }
 
 static void reception_complete_intr(struct snd_dbri *dbri, int pipe)
@@ -1830,12 +1823,9 @@ static void reception_complete_intr(stru
 		rd, DBRI_RD_STATUS(status), DBRI_RD_CNT(status));
 
 	/* Notify ALSA */
-	if (spin_is_locked(&dbri->lock)) {
-		spin_unlock(&dbri->lock);
-		snd_pcm_period_elapsed(info->substream);
-		spin_lock(&dbri->lock);
-	} else
-		snd_pcm_period_elapsed(info->substream);
+	spin_unlock(&dbri->lock);
+	snd_pcm_period_elapsed(info->substream);
+	spin_lock(&dbri->lock);
 }
 
 static void dbri_process_one_interrupt(struct snd_dbri *dbri, int x)
@@ -1848,13 +1838,12 @@ static void dbri_process_one_interrupt(s
 	int rval = D_INTR_GETRVAL(x);
 #endif
 
-	if (channel == D_INTR_CMD) {
+	if (channel == D_INTR_CMD)
 		dprintk(D_CMD, "INTR: Command: %-5s  Value:%d\n",
 			cmds[command], val);
-	} else {
+	else
 		dprintk(D_INT, "INTR: Chan:%d Code:%d Val:%#x\n",
 			channel, code, rval);
-	}
 
 	switch (code) {
 	case D_INTR_CMDI:
@@ -1986,10 +1975,10 @@ static irqreturn_t snd_dbri_interrupt(in
 		PCM Interface
 ****************************************************************************/
 static struct snd_pcm_hardware snd_dbri_pcm_hw = {
-	.info		= (SNDRV_PCM_INFO_MMAP |
-			   SNDRV_PCM_INFO_INTERLEAVED |
-			   SNDRV_PCM_INFO_BLOCK_TRANSFER |
-			   SNDRV_PCM_INFO_MMAP_VALID),
+	.info		= SNDRV_PCM_INFO_MMAP |
+			  SNDRV_PCM_INFO_INTERLEAVED |
+			  SNDRV_PCM_INFO_BLOCK_TRANSFER |
+			  SNDRV_PCM_INFO_MMAP_VALID,
 	.formats	= SNDRV_PCM_FMTBIT_MU_LAW |
 			  SNDRV_PCM_FMTBIT_A_LAW |
 			  SNDRV_PCM_FMTBIT_U8 |
@@ -1999,7 +1988,7 @@ static struct snd_pcm_hardware snd_dbri_
 	.rate_max		= 48000,
 	.channels_min		= 1,
 	.channels_max		= 2,
-	.buffer_bytes_max	= (64 * 1024),
+	.buffer_bytes_max	= 64 * 1024,
 	.period_bytes_min	= 1,
 	.period_bytes_max	= DBRI_TD_MAXCNT,
 	.periods_min		= 1,
@@ -2266,11 +2255,10 @@ static int snd_cs4215_info_volume(struct
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
 	uinfo->count = 2;
 	uinfo->value.integer.min = 0;
-	if (kcontrol->private_value == DBRI_PLAY) {
+	if (kcontrol->private_value == DBRI_PLAY)
 		uinfo->value.integer.max = DBRI_MAX_VOLUME;
-	} else {
+	else
 		uinfo->value.integer.max = DBRI_MAX_GAIN;
-	}
 	return 0;
 }
 
@@ -2304,7 +2292,7 @@ static int snd_cs4215_put_volume(struct 
 		info->right_gain = ucontrol->value.integer.value[1];
 		changed = 1;
 	}
-	if (changed == 1) {
+	if (changed) {
 		/* First mute outputs, and wait 1/8000 sec (125 us)
 		 * to make sure this takes.  This avoids clicking noises.
 		 */
@@ -2442,11 +2430,10 @@ static int __init snd_dbri_mixer(struct 
 	card = dbri->card;
 	strcpy(card->mixername, card->shortname);
 
-	for (idx = 0; idx < ARRAY_SIZE(dbri_controls); idx++) {
+	for (idx = 0; idx < ARRAY_SIZE(dbri_controls); idx++)
 		if ((err = snd_ctl_add(card,
 				snd_ctl_new1(&dbri_controls[idx], dbri))) < 0)
 			return err;
-	}
 
 	for (idx = DBRI_REC; idx < DBRI_NO_STREAMS; idx++) {
 		dbri->stream_info[idx].left_gain = 0;
@@ -2478,19 +2465,18 @@ static void dbri_debug_read(struct snd_i
 	int pipe;
 	snd_iprintf(buffer, "debug=%d\n", dbri_debug);
 
-	for (pipe = 0; pipe < 32; pipe++) {
+	for (pipe = 0; pipe < 32; pipe++)
 		if (pipe_active(dbri, pipe)) {
 			struct dbri_pipe *pptr = &dbri->pipes[pipe];
 			snd_iprintf(buffer,
 				    "Pipe %d: %s SDP=0x%x desc=%d, "
 				    "len=%d next %d\n",
 				    pipe,
-				   ((pptr->sdp & D_SDP_TO_SER) ? "output" :
-								 "input"),
+				   (pptr->sdp & D_SDP_TO_SER) ? "output" :
+								 "input",
 				    pptr->sdp, pptr->desc,
 				    pptr->length, pptr->nextpipe);
 		}
-	}
 }
 #endif
 
@@ -2502,7 +2488,7 @@ void snd_dbri_proc(struct snd_dbri *dbri
 		snd_info_set_text_ops(entry, dbri, dbri_regs_read);
 
 #ifdef DBRI_DEBUG
-	if (! snd_card_proc_new(dbri->card, "debug", &entry)) {
+	if (!snd_card_proc_new(dbri->card, "debug", &entry)) {
 		snd_info_set_text_ops(entry, dbri, dbri_debug_read);
 		entry->mode = S_IFREG | S_IRUGO;	/* Readable only. */
 	}
@@ -2637,7 +2623,6 @@ static int __init dbri_attach(int prom_n
 		goto _err;
 
 	if ((err = snd_dbri_mixer(dbri)) < 0)
-	if ((err = snd_dbri_mixer(dbri)) < 0)
 		goto _err;
 
 	/* /proc file handling */
@@ -2668,7 +2653,7 @@ static int __init dbri_init(void)
 	int found = 0;
 
 	/* Probe each SBUS for the DBRI chip(s). */
-	for_all_sbusdev(sdev, sbus) {
+	for_all_sbusdev(sdev, sbus)
 		/*
 		 * The version is coded in the last character
 		 */
@@ -2679,7 +2664,6 @@ static int __init dbri_init(void)
 			if (dbri_attach(sdev->prom_node, sdev) == 0)
 				found++;
 		}
-	}
 
 	return (found > 0) ? 0 : -EIO;
 }
