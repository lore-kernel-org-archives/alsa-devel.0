From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: [PATCH] Several fixes for the Sun DBRI driver
Date: Sat, 10 Sep 2005 13:45:11 +0100
Message-ID: <20050910124510.GA2250@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This patch contains the following fixes to the Alsa DBRI driver:

- Remove 2.6.13 build warning on the prom_getproperty() call.

- Rework command synchronization: send a sequence number with D_WAIT,
and check it in the completion interrupt.
Move synchronization delays from _cmdsend() to _cmdlock() allowing the
CPU to do other usefull things while the DBRI is processing the 
commands.

- Fix first argument of printk() calls.

- Enable burst transfers for DBRI. Original 2.4 patch from Krzysztof 
Helt

- Make dbri_debug module parameter writable from sysfs. Remove obsolete
write access to the /proc debug file.

- Replace udelay() with msleep_interruptible() where possible.

- Update documentation comments.

This diff is against 2.6.13, i.e. ALSA 1.0.9b. I can also send each
fix split out if you want. Please apply.

Thanks,
Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---

--- linux-2.6.13/sound/sparc/dbri.c.orig	2005-09-09 14:45:40.000000000 +0100
+++ linux-2.6.13/sound/sparc/dbri.c	2005-09-10 13:14:11.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  * Driver for DBRI sound chip found on Sparcs.
- * Copyright (C) 2004 Martin Habets (mhabets@users.sourceforge.net)
+ * Copyright (C) 2004, 2005 Martin Habets (mhabets@users.sourceforge.net)
  *
  * Based entirely upon drivers/sbus/audio/dbri.c which is:
  * Copyright (C) 1997 Rudolf Koenig (rfkoenig@immd4.informatik.uni-erlangen.de)
@@ -43,6 +43,12 @@
  * audio devices. But the SUN HW group decided against it, at least on my
  * LX the speakerbox connector has at least 1 pin missing and 1 wrongly
  * connected.
+ *
+ * I've tried to stick to the following function naming conventions:
+ * snd_*	ALSA stuff
+ * cs4215_*	CS4215 codec specfic stuff
+ * dbri_*	DBRI high-level stuff
+ * other	DBRI low-level stuff
  */
 
 #include <sound/driver.h>
@@ -87,7 +93,7 @@
 #define D_DESC	(1<<5)
 
 static int dbri_debug = 0;
-module_param(dbri_debug, int, 0444);
+module_param(dbri_debug, int, 0644);
 MODULE_PARM_DESC(dbri_debug, "Debug value for Sun DBRI soundcard.");
 
 #ifdef DBRI_DEBUG
@@ -320,7 +326,8 @@
 	void __iomem *regs;	/* dbri HW regs */
 	int dbri_version;	/* 'e' and up is OK */
 	int dbri_irqp;		/* intr queue pointer */
-	int wait_seen;
+	int wait_send;		/* sequence of command buffers send */
+	int wait_ackd;		/* sequence of command buffers acknowledged */
 
 	struct dbri_pipe pipes[DBRI_NO_PIPES];	/* DBRI's 32 data pipes */
 	struct dbri_desc descs[DBRI_NO_DESCS];
@@ -625,16 +632,13 @@
 
 Commands are sent to the DBRI by building a list of them in memory,
 then writing the address of the first list item to DBRI register 8.
-The list is terminated with a WAIT command, which can generate a
-CPU interrupt if required.
+The list is terminated with a WAIT command, which generates a
+CPU interrupt to signal completion.
 
 Since the DBRI can run in parallel with the CPU, several means of
-synchronization present themselves.  The original scheme (Rudolf's)
-was to set a flag when we "cmdlock"ed the DBRI, clear the flag when
-an interrupt signaled completion, and wait on a wait_queue if a routine
-attempted to cmdlock while the flag was set.  The problems arose when
-we tried to cmdlock from inside an interrupt handler, which might
-cause scheduling in an interrupt (if we waited), etc, etc
+synchronization present themselves.  The method implemented here is close
+to the original scheme (Rudolf's), and uses 2 counters (wait_send and
+wait_ackd) to synchronize the command buffer between the CPU and the DBRI.
 
 A more sophisticated scheme might involve a circular command buffer
 or an array of command buffers.  A routine could fill one with
@@ -642,70 +646,75 @@
 completion of the current command buffer, look on the list for
 the next one.
 
-I've decided to implement something much simpler - after each command,
-the CPU waits for the DBRI to finish the command by polling the P bit
-in DBRI register 0.  I've tried to implement this in such a way
-that might make implementing a more sophisticated scheme easier.
-
 Every time a routine wants to write commands to the DBRI, it must
 first call dbri_cmdlock() and get an initial pointer into dbri->dma->cmd
-in return.  After the commands have been writen, dbri_cmdsend() is
-called with the final pointer value.
+in return. dbri_cmdlock() will block if the previous commands have not
+been completed yet. After this the commands can be written to the buffer,
+and dbri_cmdsend() is called with the final pointer value to send them
+to the DBRI.
 
 */
 
+static void dbri_process_interrupt_buffer(snd_dbri_t * dbri);
+
 enum dbri_lock_t { NoGetLock, GetLock };
+#define MAXLOOPS 10
 
 static volatile s32 *dbri_cmdlock(snd_dbri_t * dbri, enum dbri_lock_t get)
 {
+	int maxloops = MAXLOOPS;
+
 #ifndef SMP
 	if ((get == GetLock) && spin_is_locked(&dbri->lock)) {
 		printk(KERN_ERR "DBRI: cmdlock called while in spinlock.");
 	}
 #endif
 
+	/* Delay if previous commands are still being processed */
+	while ((--maxloops) > 0 && (dbri->wait_send != dbri->wait_ackd)) {
+		msleep_interruptible(1);
+		/* If dbri_cmdlock() got called from inside the
+		 * interrupt handler, this will do the processing.
+		 */
+		dbri_process_interrupt_buffer(dbri);
+	}
+	if (maxloops == 0) {
+		printk(KERN_ERR "DBRI: Chip never completed command buffer %d\n",
+			dbri->wait_send);
+	} else {
+		dprintk(D_CMD, "Chip completed command buffer (%d)\n",
+			MAXLOOPS - maxloops - 1);
+	}
+
 	/*if (get == GetLock) spin_lock(&dbri->lock); */
 	return &dbri->dma->cmd[0];
 }
 
-static void dbri_process_interrupt_buffer(snd_dbri_t *);
-
 static void dbri_cmdsend(snd_dbri_t * dbri, volatile s32 * cmd)
 {
-	int MAXLOOPS = 1000000;
-	int maxloops = MAXLOOPS;
 	volatile s32 *ptr;
+	u32	reg;
 
 	for (ptr = &dbri->dma->cmd[0]; ptr < cmd; ptr++) {
 		dprintk(D_CMD, "cmd: %lx:%08x\n", (unsigned long)ptr, *ptr);
 	}
 
 	if ((cmd - &dbri->dma->cmd[0]) >= DBRI_NO_CMDS - 1) {
-		printk("DBRI: Command buffer overflow! (bug in driver)\n");
+		printk(KERN_ERR "DBRI: Command buffer overflow! (bug in driver)\n");
 		/* Ignore the last part. */
 		cmd = &dbri->dma->cmd[DBRI_NO_CMDS - 3];
 	}
 
+	dbri->wait_send++;
+	dbri->wait_send &= 0xffff;	/* restrict it to a 16 bit counter. */
 	*(cmd++) = DBRI_CMD(D_PAUSE, 0, 0);
-	*(cmd++) = DBRI_CMD(D_WAIT, 1, 0);
-	dbri->wait_seen = 0;
+	*(cmd++) = DBRI_CMD(D_WAIT, 1, dbri->wait_send);
+
+	/* Set command pointer and signal it is valid. */
 	sbus_writel(dbri->dma_dvma, dbri->regs + REG8);
-	while ((--maxloops) > 0 && (sbus_readl(dbri->regs + REG0) & D_P))
-		barrier();
-	if (maxloops == 0) {
-		printk(KERN_ERR "DBRI: Chip never completed command buffer\n");
-		dprintk(D_CMD, "DBRI: Chip never completed command buffer\n");
-	} else {
-		while ((--maxloops) > 0 && (!dbri->wait_seen))
-			dbri_process_interrupt_buffer(dbri);
-		if (maxloops == 0) {
-			printk(KERN_ERR "DBRI: Chip never acked WAIT\n");
-			dprintk(D_CMD, "DBRI: Chip never acked WAIT\n");
-		} else {
-			dprintk(D_CMD, "Chip completed command "
-				"buffer (%d)\n", MAXLOOPS - maxloops);
-		}
-	}
+	reg = sbus_readl(dbri->regs + REG0);
+	reg |= D_P;
+	sbus_writel(reg, dbri->regs + REG0);
 
 	/*spin_unlock(&dbri->lock); */
 }
@@ -757,10 +766,11 @@
 	for (n = 0; n < DBRI_NO_PIPES; n++)
 		dbri->pipes[n].desc = dbri->pipes[n].first_desc = -1;
 
-	/* We should query the openprom to see what burst sizes this
-	 * SBus supports.  For now, just disable all SBus bursts */
+	/* A brute approach - DBRI falls back to working burst size by itself
+	 * On SS20 D_S does not work, so do not try so high. */
 	tmp = sbus_readl(dbri->regs + REG0);
-	tmp &= ~(D_G | D_S | D_E);
+	tmp |= D_G | D_E;
+	tmp &= ~D_S;
 	sbus_writel(tmp, dbri->regs + REG0);
 
 	/*
@@ -805,13 +815,13 @@
 	volatile int *cmd;
 
 	if (pipe < 0 || pipe > 31) {
-		printk("DBRI: reset_pipe called with illegal pipe number\n");
+		printk(KERN_ERR "DBRI: reset_pipe called with illegal pipe number\n");
 		return;
 	}
 
 	sdp = dbri->pipes[pipe].sdp;
 	if (sdp == 0) {
-		printk("DBRI: reset_pipe called on uninitialized pipe\n");
+		printk(KERN_ERR "DBRI: reset_pipe called on uninitialized pipe\n");
 		return;
 	}
 
@@ -834,12 +844,12 @@
 static void setup_pipe(snd_dbri_t * dbri, int pipe, int sdp)
 {
 	if (pipe < 0 || pipe > 31) {
-		printk("DBRI: setup_pipe called with illegal pipe number\n");
+		printk(KERN_ERR "DBRI: setup_pipe called with illegal pipe number\n");
 		return;
 	}
 
 	if ((sdp & 0xf800) != sdp) {
-		printk("DBRI: setup_pipe called with strange SDP value\n");
+		printk(KERN_ERR "DBRI: setup_pipe called with strange SDP value\n");
 		/* sdp &= 0xf800; */
 	}
 
@@ -872,13 +882,13 @@
 	int nextpipe;
 
 	if (pipe < 0 || pipe > 31 || basepipe < 0 || basepipe > 31) {
-		printk
-		    ("DBRI: link_time_slot called with illegal pipe number\n");
+		printk(KERN_ERR 
+		    "DBRI: link_time_slot called with illegal pipe number\n");
 		return;
 	}
 
 	if (dbri->pipes[pipe].sdp == 0 || dbri->pipes[basepipe].sdp == 0) {
-		printk("DBRI: link_time_slot called on uninitialized pipe\n");
+		printk(KERN_ERR "DBRI: link_time_slot called on uninitialized pipe\n");
 		return;
 	}
 
@@ -960,8 +970,8 @@
 	int val;
 
 	if (pipe < 0 || pipe > 31 || prevpipe < 0 || prevpipe > 31) {
-		printk
-		    ("DBRI: unlink_time_slot called with illegal pipe number\n");
+		printk(KERN_ERR 
+		    "DBRI: unlink_time_slot called with illegal pipe number\n");
 		return;
 	}
 
@@ -1001,22 +1011,22 @@
 	volatile s32 *cmd;
 
 	if (pipe < 16 || pipe > 31) {
-		printk("DBRI: xmit_fixed: Illegal pipe number\n");
+		printk(KERN_ERR "DBRI: xmit_fixed: Illegal pipe number\n");
 		return;
 	}
 
 	if (D_SDP_MODE(dbri->pipes[pipe].sdp) == 0) {
-		printk("DBRI: xmit_fixed: Uninitialized pipe %d\n", pipe);
+		printk(KERN_ERR "DBRI: xmit_fixed: Uninitialized pipe %d\n", pipe);
 		return;
 	}
 
 	if (D_SDP_MODE(dbri->pipes[pipe].sdp) != D_SDP_FIXED) {
-		printk("DBRI: xmit_fixed: Non-fixed pipe %d\n", pipe);
+		printk(KERN_ERR "DBRI: xmit_fixed: Non-fixed pipe %d\n", pipe);
 		return;
 	}
 
 	if (!(dbri->pipes[pipe].sdp & D_SDP_TO_SER)) {
-		printk("DBRI: xmit_fixed: Called on receive pipe %d\n", pipe);
+		printk(KERN_ERR "DBRI: xmit_fixed: Called on receive pipe %d\n", pipe);
 		return;
 	}
 
@@ -1036,17 +1046,17 @@
 static void recv_fixed(snd_dbri_t * dbri, int pipe, volatile __u32 * ptr)
 {
 	if (pipe < 16 || pipe > 31) {
-		printk("DBRI: recv_fixed called with illegal pipe number\n");
+		printk(KERN_ERR "DBRI: recv_fixed called with illegal pipe number\n");
 		return;
 	}
 
 	if (D_SDP_MODE(dbri->pipes[pipe].sdp) != D_SDP_FIXED) {
-		printk("DBRI: recv_fixed called on non-fixed pipe %d\n", pipe);
+		printk(KERN_ERR "DBRI: recv_fixed called on non-fixed pipe %d\n", pipe);
 		return;
 	}
 
 	if (dbri->pipes[pipe].sdp & D_SDP_TO_SER) {
-		printk("DBRI: recv_fixed called on transmit pipe %d\n", pipe);
+		printk(KERN_ERR "DBRI: recv_fixed called on transmit pipe %d\n", pipe);
 		return;
 	}
 
@@ -1075,12 +1085,12 @@
 	int last_desc = -1;
 
 	if (info->pipe < 0 || info->pipe > 15) {
-		printk("DBRI: setup_descs: Illegal pipe number\n");
+		printk(KERN_ERR "DBRI: setup_descs: Illegal pipe number\n");
 		return -2;
 	}
 
 	if (dbri->pipes[info->pipe].sdp == 0) {
-		printk("DBRI: setup_descs: Uninitialized pipe %d\n",
+		printk(KERN_ERR "DBRI: setup_descs: Uninitialized pipe %d\n",
 		       info->pipe);
 		return -2;
 	}
@@ -1090,20 +1100,20 @@
 
 	if (streamno == DBRI_PLAY) {
 		if (!(dbri->pipes[info->pipe].sdp & D_SDP_TO_SER)) {
-			printk("DBRI: setup_descs: Called on receive pipe %d\n",
+			printk(KERN_ERR "DBRI: setup_descs: Called on receive pipe %d\n",
 			       info->pipe);
 			return -2;
 		}
 	} else {
 		if (dbri->pipes[info->pipe].sdp & D_SDP_TO_SER) {
-			printk
-			    ("DBRI: setup_descs: Called on transmit pipe %d\n",
+			printk(KERN_ERR 
+			    "DBRI: setup_descs: Called on transmit pipe %d\n",
 			     info->pipe);
 			return -2;
 		}
 		/* Should be able to queue multiple buffers to receive on a pipe */
 		if (pipe_active(dbri, info->pipe)) {
-			printk("DBRI: recv_on_pipe: Called on active pipe %d\n",
+			printk(KERN_ERR "DBRI: recv_on_pipe: Called on active pipe %d\n",
 			       info->pipe);
 			return -2;
 		}
@@ -1120,7 +1130,7 @@
 				break;
 		}
 		if (desc == DBRI_NO_DESCS) {
-			printk("DBRI: setup_descs: No descriptors\n");
+			printk(KERN_ERR "DBRI: setup_descs: No descriptors\n");
 			return -1;
 		}
 
@@ -1165,7 +1175,7 @@
 	}
 
 	if (first_desc == -1 || last_desc == -1) {
-		printk("DBRI: setup_descs: Not enough descriptors available\n");
+		printk(KERN_ERR "DBRI: setup_descs: Not enough descriptors available\n");
 		return -1;
 	}
 
@@ -1270,7 +1280,7 @@
 		int divisor = 12288 / clockrate;
 
 		if (divisor > 255 || divisor * clockrate != 12288)
-			printk("DBRI: illegal bits_per_frame in setup_chi\n");
+			printk(KERN_ERR "DBRI: illegal bits_per_frame in setup_chi\n");
 
 		*(cmd++) = DBRI_CMD(D_CHI, 0, D_CHI_CHICM(divisor) | D_CHI_FD
 				    | D_CHI_BPF(bits_per_frame));
@@ -1474,7 +1484,6 @@
 	/* Temporarily mute outputs, and wait 1/8000 sec (125 us)
 	 * to make sure this takes.  This avoids clicking noises.
 	 */
-
 	cs4215_setdata(dbri, 1);
 	udelay(125);
 
@@ -1530,8 +1539,8 @@
 	tmp |= D_C;		/* Enable CHI */
 	sbus_writel(tmp, dbri->regs + REG0);
 
-	for (i = 64; ((dbri->mm.status & 0xe4) != 0x20); --i) {
-		udelay(125);
+	for (i = 10; ((dbri->mm.status & 0xe4) != 0x20); --i) {
+		msleep_interruptible(1);
 	}
 	if (i == 0) {
 		dprintk(D_MM, "CS4215 didn't respond to CLB (0x%02x)\n",
@@ -1678,8 +1687,8 @@
 Complicated interrupts are handled by dedicated functions (which
 appear first in this file).  Any pending interrupts can be serviced by
 calling dbri_process_interrupt_buffer(), which works even if the CPU's
-interrupts are disabled.  This function is used by dbri_cmdsend()
-to make sure we're synced up with the chip after each command sequence,
+interrupts are disabled.  This function is used by dbri_cmdlock()
+to make sure we're synced up with the chip before each command sequence,
 even if we're running cli'ed.
 
 */
@@ -1765,11 +1774,13 @@
  * Called by main interrupt handler when DBRI signals transmission complete
  * on a pipe (interrupt triggered by the B bit in a transmit descriptor).
  *
- * Walks through the pipe's list of transmit buffer descriptors, releasing
- * each one's DMA buffer (if present), flagging the descriptor available,
- * and signaling its callback routine (if present), before proceeding
- * to the next one.  Stops when the first descriptor is found without
+ * Walks through the pipe's list of transmit buffer descriptors and marks
+ * them as available. Stops when the first descriptor is found without
  * TBC (Transmit Buffer Complete) set, or we've run through them all.
+ *
+ * The DMA buffers are not released, but re-used. Since the transmit buffer
+ * descriptors are not clobbered, they can be re-submitted as is. This is
+ * done by the xmit_descs() tasklet above since that could take longer.
  */
 
 static void transmission_complete_intr(snd_dbri_t * dbri, int pipe)
@@ -1885,7 +1896,11 @@
 	}
 
 	if (channel == D_INTR_CMD && command == D_WAIT) {
-		dbri->wait_seen++;
+		dbri->wait_ackd = val;
+		if (dbri->wait_send != val) {
+			printk(KERN_ERR "Processing wait command %d when %d was send.\n",
+			       val, dbri->wait_send);
+		}
 		return;
 	}
 
@@ -1994,8 +2009,7 @@
 		 * The only one I've seen is MRR, which will be triggered
 		 * if you let a transmit pipe underrun, then try to CDP it.
 		 *
-		 * If these things persist, we should probably reset
-		 * and re-init the chip.
+		 * If these things persist, we reset the chip.
 		 */
 		if ((++errcnt) % 10 == 0) {
 			dprintk(D_INT, "Interrupt errors exceeded.\n");
@@ -2094,7 +2108,7 @@
 
 	if ((ret = snd_pcm_lib_malloc_pages(substream,
 				params_buffer_bytes(hw_params))) < 0) {
-		snd_printk(KERN_ERR "malloc_pages failed with %d\n", ret);
+		printk(KERN_ERR "malloc_pages failed with %d\n", ret);
 		return ret;
 	}
 
@@ -2455,8 +2469,7 @@
 
 	for (idx = 0; idx < NUM_CS4215_CONTROLS; idx++) {
 		if ((err = snd_ctl_add(card,
-				       snd_ctl_new1(&dbri_controls[idx],
-						    dbri))) < 0)
+				snd_ctl_new1(&dbri_controls[idx], dbri))) < 0)
 			return err;
 	}
 
@@ -2490,8 +2503,6 @@
 	int pipe;
 	snd_iprintf(buffer, "debug=%d\n", dbri_debug);
 
-	snd_iprintf(buffer, "CHI pipe in=%d, out=%d\n",
-		    dbri->chi_in_pipe, dbri->chi_out_pipe);
 	for (pipe = 0; pipe < 32; pipe++) {
 		if (pipe_active(dbri, pipe)) {
 			struct dbri_pipe *pptr = &dbri->pipes[pipe];
@@ -2506,18 +2517,6 @@
 		}
 	}
 }
-
-static void dbri_debug_write(snd_info_entry_t * entry,
-			     snd_info_buffer_t * buffer)
-{
-	char line[80];
-	int i;
-
-	if (snd_info_get_line(buffer, line, 80) == 0) {
-		sscanf(line, "%d\n", &i);
-		dbri_debug = i & 0x3f;
-	}
-}
 #endif
 
 void snd_dbri_proc(snd_dbri_t * dbri)
@@ -2531,9 +2530,7 @@
 #ifdef DBRI_DEBUG
 	err = snd_card_proc_new(dbri->card, "debug", &entry);
 	snd_info_set_text_ops(entry, dbri, 4096, dbri_debug_read);
-	entry->mode = S_IFREG | S_IRUGO | S_IWUSR; /* Writable for root */
-	entry->c.text.write_size = 256;
-	entry->c.text.write = dbri_debug_write;
+	entry->mode = S_IFREG | S_IRUGO;	/* Readable only. */
 #endif
 }
 
@@ -2637,7 +2634,11 @@
 		return -ENOENT;
 	}
 
-	prom_getproperty(prom_node, "intr", (char *)&irq, sizeof(irq));
+	err = prom_getproperty(prom_node, "intr", (char *)&irq, sizeof(irq));
+	if (err < 0) {
+		printk(KERN_ERR "DBRI-%d: Firmware node lacks IRQ property.\n", dev);
+		return -ENODEV;
+	}
 
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE,
 			    sizeof(snd_dbri_t));



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
