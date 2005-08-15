From: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: [-mm PATCH 06/32] sound: fix-up schedule_timeout() usage
Date: Mon, 15 Aug 2005 11:10:45 -0700
Message-ID: <20050815181045.GI2854@us.ibm.com>
References: <20050815180514.GC2854@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0C1BE1C9
	for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2005 20:10:49 +0200 (MEST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j7FIAlOc019235
	for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2005 14:10:47 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j7FIAkPJ240126
	for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2005 14:10:47 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j7FIAkWZ021163
	for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2005 14:10:46 -0400
Content-Disposition: inline
In-Reply-To: <20050815180514.GC2854@us.ibm.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz, greg@kroah.com, khali@linux-fr.org, zab@zabbo.net, mulix@mulix.org
Cc: akpm@osdl.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Description: Use schedule_timeout_{,un}interruptible() instead of
set_current_state()/schedule_timeout() to reduce kernel size. Also use
human-time conversion functions instead of hard-coded division to avoid
rounding issues.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 sound/core/seq/seq_instr.c            |   12 ++++--------
 sound/core/seq/seq_lock.c             |    3 +--
 sound/core/seq/seq_memory.c           |    3 +--
 sound/i2c/cs8427.c                    |    3 +--
 sound/isa/ad1848/ad1848_lib.c         |    6 ++----
 sound/isa/gus/gus_pcm.c               |    3 +--
 sound/isa/sb/emu8000.c                |    9 +++------
 sound/isa/sb/emu8000_patch.c          |    3 +--
 sound/isa/sb/emu8000_pcm.c            |    3 +--
 sound/isa/sscape.c                    |   17 ++---------------
 sound/isa/wavefront/wavefront_synth.c |    6 ++----
 sound/pci/ac97/ac97_codec.c           |   15 +++++----------
 sound/pci/ali5451/ali5451.c           |   12 ++++--------
 sound/pci/atiixp.c                    |    3 +--
 sound/pci/atiixp_modem.c              |    3 +--
 sound/pci/cs4281.c                    |    6 ++----
 sound/pci/ens1370.c                   |    3 +--
 sound/pci/fm801.c                     |    9 +++------
 sound/pci/ice1712/pontis.c            |    3 +--
 sound/pci/intel8x0.c                  |    3 +--
 sound/pci/intel8x0m.c                 |    3 +--
 sound/pci/maestro3.c                  |    9 +++------
 sound/pci/mixart/mixart.c             |    3 +--
 sound/pci/trident/trident_main.c      |    3 +--
 sound/pci/via82xx.c                   |    6 ++----
 sound/pci/via82xx_modem.c             |    6 ++----
 sound/pci/ymfpci/ymfpci_main.c        |    5 ++---
 sound/usb/usbaudio.c                  |    3 +--
 28 files changed, 51 insertions(+), 112 deletions(-)

diff -urpN 2.6.13-rc5-mm1/sound/core/seq/seq_instr.c 2.6.13-rc5-mm1-dev/sound/core/seq/seq_instr.c
--- 2.6.13-rc5-mm1/sound/core/seq/seq_instr.c	2005-08-07 09:57:38.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/core/seq/seq_instr.c	2005-08-10 15:28:48.000000000 -0700
@@ -109,8 +109,7 @@ void snd_seq_instr_list_free(snd_seq_kin
 			spin_lock_irqsave(&list->lock, flags);
 			while (instr->use) {
 				spin_unlock_irqrestore(&list->lock, flags);
-				set_current_state(TASK_INTERRUPTIBLE);
-				schedule_timeout(1);
+				schedule_timeout_interruptible(1);
 				spin_lock_irqsave(&list->lock, flags);
 			}				
 			spin_unlock_irqrestore(&list->lock, flags);
@@ -199,10 +198,8 @@ int snd_seq_instr_list_free_cond(snd_seq
 		while (flist) {
 			instr = flist;
 			flist = instr->next;
-			while (instr->use) {
-				set_current_state(TASK_INTERRUPTIBLE);
-				schedule_timeout(1);
-			}				
+			while (instr->use)
+				schedule_timeout_interruptible(1);
 			if (snd_seq_instr_free(instr, atomic)<0)
 				snd_printk(KERN_WARNING "instrument free problem\n");
 			instr = next;
@@ -554,8 +551,7 @@ static int instr_free(snd_seq_kinstr_ops
 			instr->ops->notify(instr->ops->private_data, instr, SNDRV_SEQ_INSTR_NOTIFY_REMOVE);
 		while (instr->use) {
 			spin_unlock_irqrestore(&list->lock, flags);
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1);
+			schedule_timeout_interruptible(1);
 			spin_lock_irqsave(&list->lock, flags);
 		}				
 		spin_unlock_irqrestore(&list->lock, flags);
diff -urpN 2.6.13-rc5-mm1/sound/core/seq/seq_lock.c 2.6.13-rc5-mm1-dev/sound/core/seq/seq_lock.c
--- 2.6.13-rc5-mm1/sound/core/seq/seq_lock.c	2005-03-01 23:38:06.000000000 -0800
+++ 2.6.13-rc5-mm1-dev/sound/core/seq/seq_lock.c	2005-08-10 15:29:07.000000000 -0700
@@ -39,8 +39,7 @@ void snd_use_lock_sync_helper(snd_use_lo
 			snd_printk(KERN_WARNING "seq_lock: timeout [%d left] in %s:%d\n", atomic_read(lockp), file, line);
 			break;
 		}
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 		max_count--;
 	}
 }
diff -urpN 2.6.13-rc5-mm1/sound/core/seq/seq_memory.c 2.6.13-rc5-mm1-dev/sound/core/seq/seq_memory.c
--- 2.6.13-rc5-mm1/sound/core/seq/seq_memory.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/core/seq/seq_memory.c	2005-08-10 15:29:14.000000000 -0700
@@ -423,8 +423,7 @@ int snd_seq_pool_done(pool_t *pool)
 			snd_printk(KERN_WARNING "snd_seq_pool_done timeout: %d cells remain\n", atomic_read(&pool->counter));
 			break;
 		}
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 		max_count--;
 	}
 	
diff -urpN 2.6.13-rc5-mm1/sound/i2c/cs8427.c 2.6.13-rc5-mm1-dev/sound/i2c/cs8427.c
--- 2.6.13-rc5-mm1/sound/i2c/cs8427.c	2005-03-01 23:37:30.000000000 -0800
+++ 2.6.13-rc5-mm1-dev/sound/i2c/cs8427.c	2005-08-10 15:29:20.000000000 -0700
@@ -302,8 +302,7 @@ static void snd_cs8427_reset(snd_i2c_dev
 		snd_i2c_unlock(cs8427->bus);
 		if (!(data & CS8427_UNLOCK))
 			break;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	}
 	snd_i2c_lock(cs8427->bus);
 	chip->regmap[CS8427_REG_CLOCKSOURCE] &= ~CS8427_RXDMASK;
diff -urpN 2.6.13-rc5-mm1/sound/isa/ad1848/ad1848_lib.c 2.6.13-rc5-mm1-dev/sound/isa/ad1848/ad1848_lib.c
--- 2.6.13-rc5-mm1/sound/isa/ad1848/ad1848_lib.c	2005-08-07 10:05:22.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/isa/ad1848/ad1848_lib.c	2005-08-10 15:29:40.000000000 -0700
@@ -243,8 +243,7 @@ static void snd_ad1848_mce_down(ad1848_t
 			snd_printk("mce_down - auto calibration time out (2)\n");
 			return;
 		}
-		set_current_state(TASK_INTERRUPTIBLE);
-		time = schedule_timeout(time);
+		time = schedule_timeout_interruptible(time);
 		spin_lock_irqsave(&chip->reg_lock, flags);
 	}
 #if 0
@@ -257,8 +256,7 @@ static void snd_ad1848_mce_down(ad1848_t
 			snd_printk("mce_down - auto calibration time out (3)\n");
 			return;
 		}
-		set_current_state(TASK_INTERRUPTIBLE);
-		time = schedule_timeout(time);
+		time = schedule_timeout_interruptible(time);
 		spin_lock_irqsave(&chip->reg_lock, flags);
 	}
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
diff -urpN 2.6.13-rc5-mm1/sound/isa/gus/gus_pcm.c 2.6.13-rc5-mm1-dev/sound/isa/gus/gus_pcm.c
--- 2.6.13-rc5-mm1/sound/isa/gus/gus_pcm.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/isa/gus/gus_pcm.c	2005-08-10 15:29:46.000000000 -0700
@@ -333,8 +333,7 @@ static int snd_gf1_pcm_poke_block(snd_gu
 			}
 		}
 		if (count > 0 && !in_interrupt()) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1);
+			schedule_timeout_interruptible(1);
 			if (signal_pending(current))
 				return -EAGAIN;
 		}
diff -urpN 2.6.13-rc5-mm1/sound/isa/sb/emu8000.c 2.6.13-rc5-mm1-dev/sound/isa/sb/emu8000.c
--- 2.6.13-rc5-mm1/sound/isa/sb/emu8000.c	2005-08-07 09:57:38.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/isa/sb/emu8000.c	2005-08-10 15:30:06.000000000 -0700
@@ -135,8 +135,7 @@ static void __init
 snd_emu8000_read_wait(emu8000_t *emu)
 {
 	while ((EMU8000_SMALR_READ(emu) & 0x80000000) != 0) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_interruptible(1);
 		if (signal_pending(current))
 			break;
 	}
@@ -148,8 +147,7 @@ static void __init
 snd_emu8000_write_wait(emu8000_t *emu)
 {
 	while ((EMU8000_SMALW_READ(emu) & 0x80000000) != 0) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_interruptible(1);
 		if (signal_pending(current))
 			break;
 	}
@@ -437,8 +435,7 @@ size_dram(emu8000_t *emu)
 	for (i = 0; i < 10000; i++) {
 		if ((EMU8000_SMALW_READ(emu) & 0x80000000) == 0)
 			break;
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_interruptible(1);
 		if (signal_pending(current))
 			break;
 	}
diff -urpN 2.6.13-rc5-mm1/sound/isa/sb/emu8000_patch.c 2.6.13-rc5-mm1-dev/sound/isa/sb/emu8000_patch.c
--- 2.6.13-rc5-mm1/sound/isa/sb/emu8000_patch.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/isa/sb/emu8000_patch.c	2005-08-10 15:30:14.000000000 -0700
@@ -109,8 +109,7 @@ static void
 snd_emu8000_write_wait(emu8000_t *emu)
 {
 	while ((EMU8000_SMALW_READ(emu) & 0x80000000) != 0) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_interruptible(1);
 		if (signal_pending(current))
 			break;
 	}
diff -urpN 2.6.13-rc5-mm1/sound/isa/sb/emu8000_pcm.c 2.6.13-rc5-mm1-dev/sound/isa/sb/emu8000_pcm.c
--- 2.6.13-rc5-mm1/sound/isa/sb/emu8000_pcm.c	2005-03-01 23:38:32.000000000 -0800
+++ 2.6.13-rc5-mm1-dev/sound/isa/sb/emu8000_pcm.c	2005-08-10 15:30:20.000000000 -0700
@@ -117,8 +117,7 @@ snd_emu8000_write_wait(emu8000_t *emu, i
 {
 	while ((EMU8000_SMALW_READ(emu) & 0x80000000) != 0) {
 		if (can_schedule) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1);
+			schedule_timeout_interruptible(1);
 			if (signal_pending(current))
 				break;
 		}
diff -urpN 2.6.13-rc5-mm1/sound/isa/sscape.c 2.6.13-rc5-mm1-dev/sound/isa/sscape.c
--- 2.6.13-rc5-mm1/sound/isa/sscape.c	2005-03-01 23:37:48.000000000 -0800
+++ 2.6.13-rc5-mm1-dev/sound/isa/sscape.c	2005-08-10 15:31:18.000000000 -0700
@@ -344,19 +344,6 @@ static void soundscape_free(snd_card_t *
 }
 
 /*
- * Put this process into an idle wait-state for a certain number
- * of "jiffies". The process can almost certainly be rescheduled
- * while we're waiting, and so we must NOT be holding any spinlocks
- * when we call this function. If we are then we risk DEADLOCK in
- * SMP (Ha!) or pre-emptible kernels.
- */
-static inline void sleep(long jiffs, int state)
-{
-	set_current_state(state);
-	schedule_timeout(jiffs);
-}
-
-/*
  * Tell the SoundScape to begin a DMA tranfer using the given channel.
  * All locking issues are left to the caller.
  */
@@ -393,7 +380,7 @@ static int obp_startup_ack(struct sounds
 		unsigned long flags;
 		unsigned char x;
 
-		sleep(1, TASK_INTERRUPTIBLE);
+		schedule_timeout_interruptible(1);
 
 		spin_lock_irqsave(&s->lock, flags);
 		x = inb(HOST_DATA_IO(s->io_base));
@@ -420,7 +407,7 @@ static int host_startup_ack(struct sound
 		unsigned long flags;
 		unsigned char x;
 
-		sleep(1, TASK_INTERRUPTIBLE);
+		schedule_timeout_interruptible(1);
 
 		spin_lock_irqsave(&s->lock, flags);
 		x = inb(HOST_DATA_IO(s->io_base));
diff -urpN 2.6.13-rc5-mm1/sound/isa/wavefront/wavefront_synth.c 2.6.13-rc5-mm1-dev/sound/isa/wavefront/wavefront_synth.c
--- 2.6.13-rc5-mm1/sound/isa/wavefront/wavefront_synth.c	2005-08-07 09:57:38.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/isa/wavefront/wavefront_synth.c	2005-08-10 15:33:04.000000000 -0700
@@ -275,8 +275,7 @@ static int
 wavefront_sleep (int limit)
 
 {
-	set_current_state(TASK_INTERRUPTIBLE);
-	schedule_timeout(limit);
+	schedule_timeout_interruptible(limit);
 
 	return signal_pending(current);
 }
@@ -1788,8 +1787,7 @@ wavefront_should_cause_interrupt (snd_wa
 	outb (val,port);
 	spin_unlock_irq(&dev->irq_lock);
 	while (1) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		if ((timeout = schedule_timeout(timeout)) == 0)
+		if ((timeout = schedule_timeout_interruptible(timeout)) == 0)
 			return;
 		if (dev->irq_ok)
 			return;
diff -urpN 2.6.13-rc5-mm1/sound/pci/ac97/ac97_codec.c 2.6.13-rc5-mm1-dev/sound/pci/ac97/ac97_codec.c
--- 2.6.13-rc5-mm1/sound/pci/ac97/ac97_codec.c	2005-08-07 10:05:23.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/ac97/ac97_codec.c	2005-08-10 15:33:41.000000000 -0700
@@ -1756,8 +1756,7 @@ static int ac97_reset_wait(ac97_t *ac97,
 			if ((snd_ac97_read(ac97, AC97_REC_GAIN) & 0x7fff) == 0x0a05)
 				return 0;
 		}
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	} while (time_after_eq(end_time, jiffies));
 	return -ENODEV;
 }
@@ -2019,8 +2018,7 @@ int snd_ac97_mixer(ac97_bus_t *bus, ac97
 		do {
 			if ((snd_ac97_read(ac97, AC97_POWERDOWN) & 0x0f) == 0x0f)
 				goto __ready_ok;
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
+			schedule_timeout_uninterruptible(1);
 		} while (time_after_eq(end_time, jiffies));
 		snd_printk(KERN_WARNING "AC'97 %d analog subsections not ready\n", ac97->num);
 	}
@@ -2052,8 +2050,7 @@ int snd_ac97_mixer(ac97_bus_t *bus, ac97
 		do {
 			if ((snd_ac97_read(ac97, AC97_EXTENDED_MSTATUS) & tmp) == tmp)
 				goto __ready_ok;
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
+			schedule_timeout_uninterruptible(1);
 		} while (time_after_eq(end_time, jiffies));
 		snd_printk(KERN_WARNING "MC'97 %d converters and GPIO not ready (0x%x)\n", ac97->num, snd_ac97_read(ac97, AC97_EXTENDED_MSTATUS));
 	}
@@ -2294,8 +2291,7 @@ void snd_ac97_resume(ac97_t *ac97)
 		do {
 			if (snd_ac97_read(ac97, AC97_MASTER) == 0x8101)
 				break;
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
+			schedule_timeout_uninterruptible(1);
 		} while (time_after_eq(end_time, jiffies));
 		/* FIXME: extra delay */
 		ac97->bus->ops->write(ac97, AC97_MASTER, 0x8000);
@@ -2307,8 +2303,7 @@ void snd_ac97_resume(ac97_t *ac97)
 			unsigned short val = snd_ac97_read(ac97, AC97_EXTENDED_MID);
 			if (val != 0xffff && (val & 1) != 0)
 				break;
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
+			schedule_timeout_uninterruptible(1);
 		} while (time_after_eq(end_time, jiffies));
 	}
 __reset_ready:
diff -urpN 2.6.13-rc5-mm1/sound/pci/ali5451/ali5451.c 2.6.13-rc5-mm1-dev/sound/pci/ali5451/ali5451.c
--- 2.6.13-rc5-mm1/sound/pci/ali5451/ali5451.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/ali5451/ali5451.c	2005-08-10 15:34:09.000000000 -0700
@@ -404,10 +404,8 @@ static int snd_ali_codec_ready(	ali_t *c
 		res = snd_ali_5451_peek(codec,port);
 		if (! (res & 0x8000))
 			return 0;
-		if (sched) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
-		}
+		if (sched)
+			schedule_timeout_uninterruptible(1);
 	} while (time_after_eq(end_time, jiffies));
 	snd_ali_5451_poke(codec, port, res & ~0x8000);
 	snd_printdd("ali_codec_ready: codec is not ready.\n ");
@@ -427,10 +425,8 @@ static int snd_ali_stimer_ready(ali_t *c
 		dwChk2 = snd_ali_5451_peek(codec, ALI_STIMER);
 		if (dwChk2 != dwChk1)
 			return 0;
-		if (sched) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
-		}
+		if (sched)
+			schedule_timeout_uninterruptible(1);
 	} while (time_after_eq(end_time, jiffies));
 	snd_printk("ali_stimer_read: stimer is not ready.\n");
 	return -EIO;
diff -urpN 2.6.13-rc5-mm1/sound/pci/atiixp.c 2.6.13-rc5-mm1-dev/sound/pci/atiixp.c
--- 2.6.13-rc5-mm1/sound/pci/atiixp.c	2005-08-07 10:05:23.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/atiixp.c	2005-08-10 15:34:17.000000000 -0700
@@ -328,8 +328,7 @@ static int snd_atiixp_update_bits(atiixp
 
 /* delay for one tick */
 #define do_delay() do { \
-	set_current_state(TASK_UNINTERRUPTIBLE); \
-	schedule_timeout(1); \
+	schedule_timeout_uninterruptible(1); \
 } while (0)
 
 
diff -urpN 2.6.13-rc5-mm1/sound/pci/atiixp_modem.c 2.6.13-rc5-mm1-dev/sound/pci/atiixp_modem.c
--- 2.6.13-rc5-mm1/sound/pci/atiixp_modem.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/atiixp_modem.c	2005-08-10 15:34:24.000000000 -0700
@@ -306,8 +306,7 @@ static int snd_atiixp_update_bits(atiixp
 
 /* delay for one tick */
 #define do_delay() do { \
-	set_current_state(TASK_UNINTERRUPTIBLE); \
-	schedule_timeout(1); \
+	schedule_timeout_uninterruptible(1); \
 } while (0)
 
 
diff -urpN 2.6.13-rc5-mm1/sound/pci/cs4281.c 2.6.13-rc5-mm1-dev/sound/pci/cs4281.c
--- 2.6.13-rc5-mm1/sound/pci/cs4281.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/cs4281.c	2005-08-10 15:34:48.000000000 -0700
@@ -534,8 +534,7 @@ static void snd_cs4281_delay(unsigned in
 			delay = 1;
 		end_time = jiffies + delay;
 		do {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
+			schedule_timeout_uninterruptible(1);
 		} while (time_after_eq(end_time, jiffies));
 	} else {
 		udelay(delay);
@@ -544,8 +543,7 @@ static void snd_cs4281_delay(unsigned in
 
 static inline void snd_cs4281_delay_long(void)
 {
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(1);
+	schedule_timeout_uninterruptible(1);
 }
 
 static inline void snd_cs4281_pokeBA0(cs4281_t *chip, unsigned long offset, unsigned int val)
diff -urpN 2.6.13-rc5-mm1/sound/pci/ens1370.c 2.6.13-rc5-mm1-dev/sound/pci/ens1370.c
--- 2.6.13-rc5-mm1/sound/pci/ens1370.c	2005-08-07 10:05:23.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/ens1370.c	2005-08-10 15:34:55.000000000 -0700
@@ -583,8 +583,7 @@ static void snd_es1370_codec_write(ak453
 			outw(ES_1370_CODEC_WRITE(reg, val), ES_REG(ensoniq, 1370_CODEC));
 			return;
 		}
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	} while (time_after(end_time, jiffies));
 	snd_printk("codec write timeout, status = 0x%x\n", inl(ES_REG(ensoniq, STATUS)));
 }
diff -urpN 2.6.13-rc5-mm1/sound/pci/fm801.c 2.6.13-rc5-mm1-dev/sound/pci/fm801.c
--- 2.6.13-rc5-mm1/sound/pci/fm801.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/fm801.c	2005-08-10 15:35:17.000000000 -0700
@@ -1303,8 +1303,7 @@ static int __devinit snd_fm801_create(sn
 	do {
 		if ((inw(FM801_REG(chip, AC97_CMD)) & (3<<8)) == (1<<8))
 			goto __ac97_secondary;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	} while (time_after(timeout, jiffies));
 	snd_printk("Primary AC'97 codec not found\n");
 	snd_fm801_free(chip);
@@ -1329,8 +1328,7 @@ static int __devinit snd_fm801_create(sn
 					goto __ac97_ok;
 				}
 			}
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_timeout(1);
+			schedule_timeout_uninterruptible(1);
 		} while (time_after(timeout, jiffies));
 	}
 
@@ -1343,8 +1341,7 @@ static int __devinit snd_fm801_create(sn
 	do {
 		if ((inw(FM801_REG(chip, AC97_CMD)) & (3<<8)) == (1<<8))
 			goto __ac97_ok;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	} while (time_after(timeout, jiffies));
 	snd_printk("Primary AC'97 codec not responding\n");
 	snd_fm801_free(chip);
diff -urpN 2.6.13-rc5-mm1/sound/pci/ice1712/pontis.c 2.6.13-rc5-mm1-dev/sound/pci/ice1712/pontis.c
--- 2.6.13-rc5-mm1/sound/pci/ice1712/pontis.c	2005-03-01 23:38:13.000000000 -0800
+++ 2.6.13-rc5-mm1-dev/sound/pci/ice1712/pontis.c	2005-08-10 15:35:23.000000000 -0700
@@ -794,8 +794,7 @@ static int __devinit pontis_init(ice1712
 	/* initialize WM8776 codec */
 	for (i = 0; i < ARRAY_SIZE(wm_inits); i += 2)
 		wm_put(ice, wm_inits[i], wm_inits[i+1]);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(1);
+	schedule_timeout_uninterruptible(1);
 	for (i = 0; i < ARRAY_SIZE(wm_inits2); i += 2)
 		wm_put(ice, wm_inits2[i], wm_inits2[i+1]);
 
diff -urpN 2.6.13-rc5-mm1/sound/pci/intel8x0.c 2.6.13-rc5-mm1-dev/sound/pci/intel8x0.c
--- 2.6.13-rc5-mm1/sound/pci/intel8x0.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/intel8x0.c	2005-08-10 15:35:31.000000000 -0700
@@ -2153,8 +2153,7 @@ static void do_ali_reset(intel8x0_t *chi
 }
 
 #define do_delay(chip) do {\
-	set_current_state(TASK_UNINTERRUPTIBLE);\
-	schedule_timeout(1);\
+	schedule_timeout_uninterruptible(1);\
 } while (0)
 
 static int snd_intel8x0_ich_chip_init(intel8x0_t *chip, int probing)
diff -urpN 2.6.13-rc5-mm1/sound/pci/intel8x0m.c 2.6.13-rc5-mm1-dev/sound/pci/intel8x0m.c
--- 2.6.13-rc5-mm1/sound/pci/intel8x0m.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/intel8x0m.c	2005-08-10 15:35:38.000000000 -0700
@@ -934,8 +934,7 @@ static int __devinit snd_intel8x0_mixer(
  */
 
 #define do_delay(chip) do {\
-	set_current_state(TASK_UNINTERRUPTIBLE);\
-	schedule_timeout(1);\
+	schedule_timeout_uninterruptible(1);\
 } while (0)
 
 static int snd_intel8x0m_ich_chip_init(intel8x0_t *chip, int probing)
diff -urpN 2.6.13-rc5-mm1/sound/pci/maestro3.c 2.6.13-rc5-mm1-dev/sound/pci/maestro3.c
--- 2.6.13-rc5-mm1/sound/pci/maestro3.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/maestro3.c	2005-08-12 13:52:25.000000000 -0700
@@ -2075,8 +2075,7 @@ static void snd_m3_ac97_reset(m3_t *chip
 		outw(0, io + GPIO_DATA);
 		outw(dir | GPO_PRIMARY_AC97, io + GPIO_DIRECTION);
 
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout((delay1 * HZ) / 1000);
+		schedule_timeout_uninterruptible(msecs_to_jiffies(delay1));
 
 		outw(GPO_PRIMARY_AC97, io + GPIO_DATA);
 		udelay(5);
@@ -2084,8 +2083,7 @@ static void snd_m3_ac97_reset(m3_t *chip
 		outw(IO_SRAM_ENABLE | SERIAL_AC_LINK_ENABLE, io + RING_BUS_CTRL_A);
 		outw(~0, io + GPIO_MASK);
 
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout((delay2 * HZ) / 1000);
+		schedule_timeout_uninterruptible(msecs_to_jiffies(delay2));
 
 		if (! snd_m3_try_read_vendor(chip))
 			break;
@@ -2130,8 +2128,7 @@ static int __devinit snd_m3_mixer(m3_t *
 
 	/* seems ac97 PCM needs initialization.. hack hack.. */
 	snd_ac97_write(chip->ac97, AC97_PCM, 0x8000 | (15 << 8) | 15);
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(HZ / 10);
+	schedule_timeout_uninterruptible(msecs_to_jiffies(100));
 	snd_ac97_write(chip->ac97, AC97_PCM, 0);
 
 	memset(&id, 0, sizeof(id));
diff -urpN 2.6.13-rc5-mm1/sound/pci/mixart/mixart.c 2.6.13-rc5-mm1-dev/sound/pci/mixart/mixart.c
--- 2.6.13-rc5-mm1/sound/pci/mixart/mixart.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/mixart/mixart.c	2005-08-10 15:38:31.000000000 -0700
@@ -451,8 +451,7 @@ static int mixart_sync_nonblock_events(m
 			snd_printk(KERN_ERR "mixart: cannot process nonblock events!\n");
 			return -EBUSY;
 		}
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	}
 	return 0;
 }
diff -urpN 2.6.13-rc5-mm1/sound/pci/trident/trident_main.c 2.6.13-rc5-mm1-dev/sound/pci/trident/trident_main.c
--- 2.6.13-rc5-mm1/sound/pci/trident/trident_main.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/trident/trident_main.c	2005-08-10 15:38:42.000000000 -0700
@@ -3206,8 +3206,7 @@ static inline void snd_trident_free_game
  */
 static inline void do_delay(trident_t *chip)
 {
-	set_current_state(TASK_UNINTERRUPTIBLE);
-	schedule_timeout(1);
+	schedule_timeout_uninterruptible(1);
 }
 
 /*
diff -urpN 2.6.13-rc5-mm1/sound/pci/via82xx.c 2.6.13-rc5-mm1-dev/sound/pci/via82xx.c
--- 2.6.13-rc5-mm1/sound/pci/via82xx.c	2005-08-07 10:05:23.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/via82xx.c	2005-08-10 15:38:55.000000000 -0700
@@ -1893,8 +1893,7 @@ static int snd_via82xx_chip_init(via82xx
 		pci_read_config_byte(chip->pci, VIA_ACLINK_STAT, &pval);
 		if (pval & VIA_ACLINK_C00_READY) /* primary codec ready */
 			break;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	} while (time_before(jiffies, end_time));
 
 	if ((val = snd_via82xx_codec_xread(chip)) & VIA_REG_AC97_BUSY)
@@ -1913,8 +1912,7 @@ static int snd_via82xx_chip_init(via82xx
 			chip->ac97_secondary = 1;
 			goto __ac97_ok2;
 		}
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_interruptible(1);
 	} while (time_before(jiffies, end_time));
 	/* This is ok, the most of motherboards have only one codec */
 
diff -urpN 2.6.13-rc5-mm1/sound/pci/via82xx_modem.c 2.6.13-rc5-mm1-dev/sound/pci/via82xx_modem.c
--- 2.6.13-rc5-mm1/sound/pci/via82xx_modem.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/via82xx_modem.c	2005-08-10 15:39:08.000000000 -0700
@@ -966,8 +966,7 @@ static int snd_via82xx_chip_init(via82xx
 		pci_read_config_byte(chip->pci, VIA_ACLINK_STAT, &pval);
 		if (pval & VIA_ACLINK_C00_READY) /* primary codec ready */
 			break;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	} while (time_before(jiffies, end_time));
 
 	if ((val = snd_via82xx_codec_xread(chip)) & VIA_REG_AC97_BUSY)
@@ -985,8 +984,7 @@ static int snd_via82xx_chip_init(via82xx
 			chip->ac97_secondary = 1;
 			goto __ac97_ok2;
 		}
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_interruptible(1);
 	} while (time_before(jiffies, end_time));
 	/* This is ok, the most of motherboards have only one codec */
 
diff -urpN 2.6.13-rc5-mm1/sound/pci/ymfpci/ymfpci_main.c 2.6.13-rc5-mm1-dev/sound/pci/ymfpci/ymfpci_main.c
--- 2.6.13-rc5-mm1/sound/pci/ymfpci/ymfpci_main.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/pci/ymfpci/ymfpci_main.c	2005-08-12 13:52:35.000000000 -0700
@@ -92,7 +92,7 @@ static int snd_ymfpci_codec_ready(ymfpci
 		if ((snd_ymfpci_readw(chip, reg) & 0x8000) == 0)
 			return 0;
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	} while (time_before(jiffies, end_time));
 	snd_printk("codec_ready: codec %i is not ready [0x%x]\n", secondary, snd_ymfpci_readw(chip, reg));
 	return -EBUSY;
@@ -727,8 +727,7 @@ static void snd_ymfpci_irq_wait(ymfpci_t
 		init_waitqueue_entry(&wait, current);
 		add_wait_queue(&chip->interrupt_sleep, &wait);
 		atomic_inc(&chip->interrupt_sleep_count);
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ/20);
+		schedule_timeout_uninterruptible(msecs_to_jiffies(50));
 		remove_wait_queue(&chip->interrupt_sleep, &wait);
 	}
 }
diff -urpN 2.6.13-rc5-mm1/sound/usb/usbaudio.c 2.6.13-rc5-mm1-dev/sound/usb/usbaudio.c
--- 2.6.13-rc5-mm1/sound/usb/usbaudio.c	2005-08-07 09:58:16.000000000 -0700
+++ 2.6.13-rc5-mm1-dev/sound/usb/usbaudio.c	2005-08-10 15:39:30.000000000 -0700
@@ -810,8 +810,7 @@ static int wait_clear_urbs(snd_usb_subst
 		}
 		if (! alive)
 			break;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
+		schedule_timeout_uninterruptible(1);
 	} while (time_before(jiffies, end_time));
 	if (alive)
 		snd_printk(KERN_ERR "timeout: still %d active urbs..\n", alive);


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
