From: "Kurt J. Bosch" <kjb-temp-2005@gmx.de>
Subject: Re: Changed ens1370.c to enable Suspend ens1371
Date: Mon, 14 Nov 2005 13:05:30 +0100
Message-ID: <43787D8A.5090907@gmx.de>
References: <4374DBBC.9040100@gmx.de> <s5hd5l7ys84.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090104000403060805060209"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5l7ys84.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------090104000403060805060209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Takashi Iwai schrieb:
> At Fri, 11 Nov 2005 18:58:20 +0100,
> Kurt J. Bosch wrote:
> 
>>Hi,
>>
>>I changed driver ens1371 to enable suspend to disk
>>only using some other drivers as kind of templates.
>>(No special handling of any registers added.)
>>
>>I did some testing on Ubuntu Breezy
>>Linux version 2.6.12-9-686 (buildd@rothera) (gcc version 3.4.5 20050809
>>(prerelease) (Ubuntu 3.4.4-6ubuntu8)) #1 Mon Oct 10 13:25:32 BST 2005
>>alsa 1.0.9b
and on Ubuntu Breezy with the kernel from Hoary
Linux version 2.6.10-5-686 (buildd@terranova) (gcc version 3.3.5 (Debian 
1:3.3.5-8ubuntu2)) #1 Mon Oct 10 11:28:02 UTC 2005
(which I use most time)
>>and it seems to work fine for me.
>>
>>I am using swsusp not swsusp2
>>but with script hibernate 1.07
>>and removed snd-ens1371 from /etc/hibernate/blacklisted-modules
>>thus it is not longer unloaded.
>>
>>patch for ens1370.c CVS revision 1.90
>>
>>is appended
patchs for kernels 2.6.12 and 2.6.10 too :)
> 
> 
> Thanks for the patch.  But, please make a patch with diff -u.
> 
> The pcm info flag SNDRV_PCM_INFO_RESUME can't be set in your case.
> 
> This INFO_RESUME flag means that the full suspend/resume is supported.
> That is, the PCM stream is resumed fully only by calling
> snd_pcm_trigger(RESUME) without snd_pcm_prepare(), etc.
> 
> In your case, it's a partial suspend/resume support.  That is, the
> resume is done by explicitly calling snd_pcm_prepare() snd restart
> from the app.
> 
> Also, add a proper changelog with signed-off-by line.  It's like
> below:
> 
> 	Summary: Fix blah ...
> 
> 	This patch fixes blah blah...
> 	...
> 
> 	Signed-off-by: Foo Bar <foo@bar.com>
> 
ok - I fixed that



--------------090104000403060805060209
Content-Type: text/x-patch;
 name="ens1370.c_2.6.10_ens1371_suspend.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ens1370.c_2.6.10_ens1371_suspend.patch"

Summary: Fix missing suspend/resume-code for ens1371

This patch fixes missing suspend/resume-code for snd-ens1371
(but not for snd-ens1370)

Signed-off-by: Kurt J. Bosch <kjb-temp-2005@gmx.de>

--- 2.6.10-5-686/ens1370.org.c	2004-12-24 22:35:24.000000000 +0100
+++ 2.6.10-5-686/ens1370.c	2005-11-14 11:36:58.000000000 +0100
@@ -19,6 +19,14 @@
  *
  */
 
+/* Power-Management-Code ( CONFIG_PM )
+ * for ens1371 only ( FIXME )
+ * derived from cs4281.c, atiixp.c and via82xx.c
+ * using http://www.alsa-project.org/~iwai/writing-an-alsa-driver/c1540.htm
+ * by Kurt J. Bosch
+ */
+
+
 #include <sound/driver.h>
 #include <asm/io.h>
 #include <linux/delay.h>
@@ -1875,6 +1883,129 @@
 };
 #endif
 
+static void snd_ensoniq_chip_init(ensoniq_t * ensoniq)
+{
+#ifdef CHIP1371
+	int idx;
+	struct pci_dev *pci = ensoniq->pci;
+#endif
+// this code was part of snd_ensoniq_create
+#ifdef CHIP1370	
+	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
+	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
+	outl(ES_MEM_PAGEO(ES_PAGE_ADC), ES_REG(ensoniq, MEM_PAGE));
+	outl(ensoniq->dma_bug.addr, ES_REG(ensoniq, PHANTOM_FRAME));
+	outl(0, ES_REG(ensoniq, PHANTOM_COUNT));
+#else
+	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
+	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
+	outl(0, ES_REG(ensoniq, 1371_LEGACY));
+	for (idx = 0; es1371_ac97_reset_hack[idx].vid != (unsigned short)PCI_ANY_ID; idx++)
+		if (pci->vendor == es1371_ac97_reset_hack[idx].vid &&
+		    pci->device == es1371_ac97_reset_hack[idx].did &&
+		    ensoniq->rev == es1371_ac97_reset_hack[idx].rev) {
+		        unsigned long tmo;
+			signed long tmo2;
+
+			ensoniq->cssr |= ES_1371_ST_AC97_RST;
+			outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
+			/* need to delay around 20ms(bleech) to give
+			some CODECs enough time to wakeup */
+			tmo = jiffies + (HZ / 50) + 1;
+			while (1) {
+				tmo2 = tmo - jiffies;
+				if (tmo2 <= 0)
+					break;
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				schedule_timeout(tmo2);
+			}
+			break;
+		}
+	/* AC'97 warm reset to start the bitclk */
+	outl(ensoniq->ctrl | ES_1371_SYNC_RES, ES_REG(ensoniq, CONTROL));
+	inl(ES_REG(ensoniq, CONTROL));
+	udelay(20);
+	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
+	/* Init the sample rate converter */
+	snd_es1371_wait_src_ready(ensoniq);	
+	outl(ES_1371_SRC_DISABLE, ES_REG(ensoniq, 1371_SMPRATE));
+	for (idx = 0; idx < 0x80; idx++)
+		snd_es1371_src_write(ensoniq, idx, 0);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC1 + ES_SMPREG_TRUNC_N, 16 << 4);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC1 + ES_SMPREG_INT_REGS, 16 << 10);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC2 + ES_SMPREG_TRUNC_N, 16 << 4);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC2 + ES_SMPREG_INT_REGS, 16 << 10);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_ADC, 1 << 12);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_ADC + 1, 1 << 12);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC1, 1 << 12);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC1 + 1, 1 << 12);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC2, 1 << 12);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC2 + 1, 1 << 12);
+	snd_es1371_adc_rate(ensoniq, 22050);
+	snd_es1371_dac1_rate(ensoniq, 22050);
+	snd_es1371_dac2_rate(ensoniq, 22050);
+	/* WARNING:
+	 * enabling the sample rate converter without properly programming
+	 * its parameters causes the chip to lock up (the SRC busy bit will
+	 * be stuck high, and I've found no way to rectify this other than
+	 * power cycle) - Thomas Sailer
+	 */
+	snd_es1371_wait_src_ready(ensoniq);
+	outl(0, ES_REG(ensoniq, 1371_SMPRATE));
+	/* try reset codec directly */
+	outl(ES_1371_CODEC_WRITE(0, 0), ES_REG(ensoniq, 1371_CODEC));
+#endif
+	outb(ensoniq->uartc = 0x00, ES_REG(ensoniq, UART_CONTROL));
+	outb(0x00, ES_REG(ensoniq, UART_RES));
+	outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
+	
+	synchronize_irq(ensoniq->irq);
+}
+
+#ifdef CONFIG_PM
+static int snd_ensoniq_suspend (snd_card_t * card,
+                                unsigned int state)
+{
+	ensoniq_t *ensoniq = card->pm_private_data;
+	
+	snd_pcm_suspend_all(ensoniq->pcm1);
+	snd_pcm_suspend_all(ensoniq->pcm2);
+	
+#ifdef CHIP1371	
+	if (ensoniq->u.es1371.ac97)
+		snd_ac97_suspend(ensoniq->u.es1371.ac97);
+#else
+	/* FIXME */
+#endif	
+        pci_set_power_state(ensoniq->pci, 3);
+	pci_disable_device(ensoniq->pci);
+        snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+	return 0;
+}
+
+static int snd_ensoniq_resume (snd_card_t * card,
+                               unsigned int state)
+{
+	ensoniq_t *ensoniq = card->pm_private_data;
+
+	pci_enable_device(ensoniq->pci);
+        pci_set_power_state(ensoniq->pci, 0);	
+	pci_set_master(ensoniq->pci);
+
+	snd_ensoniq_chip_init(ensoniq);
+    
+#ifdef CHIP1371	
+	if (ensoniq->u.es1371.ac97)
+		snd_ac97_resume(ensoniq->u.es1371.ac97);
+#else
+	/* FIXME */
+#endif	
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+
 static int __devinit snd_ensoniq_create(snd_card_t * card,
 				     struct pci_dev *pci,
 				     ensoniq_t ** rensoniq)
@@ -1938,12 +2069,6 @@
 	ensoniq->ctrl = ES_1370_CDC_EN | ES_1370_PCLKDIVO(ES_1370_SRTODIV(8000));
 #endif
 	ensoniq->sctrl = 0;
-	/* initialize the chips */
-	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
-	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
-	outl(ES_MEM_PAGEO(ES_PAGE_ADC), ES_REG(ensoniq, MEM_PAGE));
-	outl(ensoniq->dma_bug.addr, ES_REG(ensoniq, PHANTOM_FRAME));
-	outl(0, ES_REG(ensoniq, PHANTOM_COUNT));
 #else
 	ensoniq->ctrl = 0;
 	ensoniq->sctrl = 0;
@@ -1954,74 +2079,17 @@
 			ensoniq->ctrl |= ES_1371_GPIO_OUT(1);	/* turn amplifier on */
 			break;
 		}
-	/* initialize the chips */
-	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
-	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
-	outl(0, ES_REG(ensoniq, 1371_LEGACY));
-	for (idx = 0; es1371_ac97_reset_hack[idx].vid != (unsigned short)PCI_ANY_ID; idx++)
-		if (pci->vendor == es1371_ac97_reset_hack[idx].vid &&
-		    pci->device == es1371_ac97_reset_hack[idx].did &&
-		    ensoniq->rev == es1371_ac97_reset_hack[idx].rev) {
-		        unsigned long tmo;
-			signed long tmo2;
-
-			ensoniq->cssr |= ES_1371_ST_AC97_RST;
-			outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
-			/* need to delay around 20ms(bleech) to give
-			some CODECs enough time to wakeup */
-			tmo = jiffies + (HZ / 50) + 1;
-			while (1) {
-				tmo2 = tmo - jiffies;
-				if (tmo2 <= 0)
-					break;
-				set_current_state(TASK_UNINTERRUPTIBLE);
-				schedule_timeout(tmo2);
-			}
-			break;
-		}
-	/* AC'97 warm reset to start the bitclk */
-	outl(ensoniq->ctrl | ES_1371_SYNC_RES, ES_REG(ensoniq, CONTROL));
-	inl(ES_REG(ensoniq, CONTROL));
-	udelay(20);
-	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
-	/* Init the sample rate converter */
-	snd_es1371_wait_src_ready(ensoniq);	
-	outl(ES_1371_SRC_DISABLE, ES_REG(ensoniq, 1371_SMPRATE));
-	for (idx = 0; idx < 0x80; idx++)
-		snd_es1371_src_write(ensoniq, idx, 0);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC1 + ES_SMPREG_TRUNC_N, 16 << 4);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC1 + ES_SMPREG_INT_REGS, 16 << 10);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC2 + ES_SMPREG_TRUNC_N, 16 << 4);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC2 + ES_SMPREG_INT_REGS, 16 << 10);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_ADC, 1 << 12);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_ADC + 1, 1 << 12);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC1, 1 << 12);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC1 + 1, 1 << 12);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC2, 1 << 12);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC2 + 1, 1 << 12);
-	snd_es1371_adc_rate(ensoniq, 22050);
-	snd_es1371_dac1_rate(ensoniq, 22050);
-	snd_es1371_dac2_rate(ensoniq, 22050);
-	/* WARNING:
-	 * enabling the sample rate converter without properly programming
-	 * its parameters causes the chip to lock up (the SRC busy bit will
-	 * be stuck high, and I've found no way to rectify this other than
-	 * power cycle) - Thomas Sailer
-	 */
-	snd_es1371_wait_src_ready(ensoniq);
-	outl(0, ES_REG(ensoniq, 1371_SMPRATE));
-	/* try reset codec directly */
-	outl(ES_1371_CODEC_WRITE(0, 0), ES_REG(ensoniq, 1371_CODEC));
 #endif
-	outb(ensoniq->uartc = 0x00, ES_REG(ensoniq, UART_CONTROL));
-	outb(0x00, ES_REG(ensoniq, UART_RES));
-	outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
-	synchronize_irq(ensoniq->irq);
+
+	snd_ensoniq_chip_init(ensoniq);
 
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ensoniq, &ops)) < 0) {
 		snd_ensoniq_free(ensoniq);
 		return err;
 	}
+#ifdef CHIP1371 /* FIXME - this should apply to 1370 too as soon as 1370-suspend-code is written by some one :) */
+	snd_card_set_pm_callback(card, snd_ensoniq_suspend, snd_ensoniq_resume, ensoniq);
+#endif
 
 	snd_card_set_dev(card, &pci->dev);
 
@@ -2342,7 +2410,7 @@
 		card->driver,
 		ensoniq->port,
 		ensoniq->irq);
-
+		
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -2364,6 +2432,9 @@
 	.id_table = snd_audiopci_ids,
 	.probe = snd_audiopci_probe,
 	.remove = __devexit_p(snd_audiopci_remove),
+#ifdef CHIP1371 /* FIXME - this should apply to 1370 too as soon as 1370-suspend-code is written by some one :) */
+	SND_PCI_PM_CALLBACKS
+#endif
 };
 	
 static int __init alsa_card_ens137x_init(void)

--------------090104000403060805060209
Content-Type: text/x-patch;
 name="ens1370.c_2.6.12_ens1371_suspend.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ens1370.c_2.6.12_ens1371_suspend.patch"

Summary: Fix missing suspend/resume-code for ens1371

This patch fixes missing suspend/resume-code for snd-ens1371
(but not for snd-ens1370)

Signed-off-by: Kurt J. Bosch <kjb-temp-2005@gmx.de>

--- 2.6.12-9-686/ens1370.org.c	2005-10-10 14:12:34.000000000 +0200
+++ 2.6.12-9-686/ens1370.c	2005-11-14 11:22:48.000000000 +0100
@@ -19,6 +19,13 @@
  *
  */
 
+/* Power-Management-Code ( CONFIG_PM )
+ * for ens1371 only ( FIXME )
+ * derived from cs4281.c, atiixp.c and via82xx.c
+ * using http://www.alsa-project.org/~iwai/writing-an-alsa-driver/c1540.htm
+ * by Kurt J. Bosch
+ */
+
 #include <sound/driver.h>
 #include <asm/io.h>
 #include <linux/delay.h>
@@ -1922,85 +1929,20 @@
 };
 #endif
 
-static int __devinit snd_ensoniq_create(snd_card_t * card,
-				     struct pci_dev *pci,
-				     ensoniq_t ** rensoniq)
+static void snd_ensoniq_chip_init(ensoniq_t * ensoniq)
 {
-	ensoniq_t *ensoniq;
-	unsigned short cmdw;
-	unsigned char cmdb;
 #ifdef CHIP1371
 	int idx;
+	struct pci_dev *pci = ensoniq->pci;
 #endif
-	int err;
-	static snd_device_ops_t ops = {
-		.dev_free =	snd_ensoniq_dev_free,
-	};
-
-	*rensoniq = NULL;
-	if ((err = pci_enable_device(pci)) < 0)
-		return err;
-	ensoniq = kcalloc(1, sizeof(*ensoniq), GFP_KERNEL);
-	if (ensoniq == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
-	}
-	spin_lock_init(&ensoniq->reg_lock);
-	init_MUTEX(&ensoniq->src_mutex);
-	ensoniq->card = card;
-	ensoniq->pci = pci;
-	ensoniq->irq = -1;
-	if ((err = pci_request_regions(pci, "Ensoniq AudioPCI")) < 0) {
-		kfree(ensoniq);
-		pci_disable_device(pci);
-		return err;
-	}
-	ensoniq->port = pci_resource_start(pci, 0);
-	if (request_irq(pci->irq, snd_audiopci_interrupt, SA_INTERRUPT|SA_SHIRQ, "Ensoniq AudioPCI", (void *)ensoniq)) {
-		snd_printk("unable to grab IRQ %d\n", pci->irq);
-		snd_ensoniq_free(ensoniq);
-		return -EBUSY;
-	}
-	ensoniq->irq = pci->irq;
-#ifdef CHIP1370
-	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
-				16, &ensoniq->dma_bug) < 0) {
-		snd_printk("unable to allocate space for phantom area - dma_bug\n");
-		snd_ensoniq_free(ensoniq);
-		return -EBUSY;
-	}
-#endif
-	pci_set_master(pci);
-	pci_read_config_byte(pci, PCI_REVISION_ID, &cmdb);
-	ensoniq->rev = cmdb;
-	pci_read_config_word(pci, PCI_SUBSYSTEM_VENDOR_ID, &cmdw);
-	ensoniq->subsystem_vendor_id = cmdw;
-	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &cmdw);
-	ensoniq->subsystem_device_id = cmdw;
+// this code was part of snd_ensoniq_create before introduction of suspend/resume
 #ifdef CHIP1370
-#if 0
-	ensoniq->ctrl = ES_1370_CDC_EN | ES_1370_SERR_DISABLE | ES_1370_PCLKDIVO(ES_1370_SRTODIV(8000));
-#else	/* get microphone working */
-	ensoniq->ctrl = ES_1370_CDC_EN | ES_1370_PCLKDIVO(ES_1370_SRTODIV(8000));
-#endif
-	ensoniq->sctrl = 0;
-	/* initialize the chips */
 	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
 	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
 	outl(ES_MEM_PAGEO(ES_PAGE_ADC), ES_REG(ensoniq, MEM_PAGE));
 	outl(ensoniq->dma_bug.addr, ES_REG(ensoniq, PHANTOM_FRAME));
 	outl(0, ES_REG(ensoniq, PHANTOM_COUNT));
 #else
-	ensoniq->ctrl = 0;
-	ensoniq->sctrl = 0;
-	ensoniq->cssr = 0;
-	for (idx = 0; es1371_amplifier_hack[idx].svid != (unsigned short)PCI_ANY_ID; idx++)
-		if (ensoniq->subsystem_vendor_id == es1371_amplifier_hack[idx].svid &&
-		    ensoniq->subsystem_device_id == es1371_amplifier_hack[idx].sdid) {
-			ensoniq->ctrl |= ES_1371_GPIO_OUT(1);	/* turn amplifier on */
-			break;
-		}
-	/* initialize the chips */
 	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
 	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
 	outl(0, ES_REG(ensoniq, 1371_LEGACY));
@@ -2062,7 +2004,129 @@
 	outb(ensoniq->uartc = 0x00, ES_REG(ensoniq, UART_CONTROL));
 	outb(0x00, ES_REG(ensoniq, UART_RES));
 	outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
+	
 	synchronize_irq(ensoniq->irq);
+}
+
+#ifdef CONFIG_PM
+static int snd_ensoniq_suspend (snd_card_t * card,
+                                pm_message_t state)
+{
+	ensoniq_t *ensoniq = card->pm_private_data;
+	
+	snd_pcm_suspend_all(ensoniq->pcm1);
+	snd_pcm_suspend_all(ensoniq->pcm2);
+	
+#ifdef CHIP1371	
+	if (ensoniq->u.es1371.ac97)
+		snd_ac97_suspend(ensoniq->u.es1371.ac97);
+#else
+	/* FIXME */
+#endif	
+        pci_set_power_state(ensoniq->pci, 3);
+	pci_disable_device(ensoniq->pci);
+        // snd_power_change_state(card, SNDRV_CTL_POWER_D3hot); // only 2.6.10
+	return 0;
+}
+
+static int snd_ensoniq_resume (snd_card_t * card
+                              )
+{
+	ensoniq_t *ensoniq = card->pm_private_data;
+
+	pci_enable_device(ensoniq->pci);
+        pci_set_power_state(ensoniq->pci, 0);	
+	pci_set_master(ensoniq->pci);
+
+	snd_ensoniq_chip_init(ensoniq);
+    
+#ifdef CHIP1371	
+	if (ensoniq->u.es1371.ac97)
+		snd_ac97_resume(ensoniq->u.es1371.ac97);
+#else
+	/* FIXME */
+#endif	
+	// snd_power_change_state(card, SNDRV_CTL_POWER_D0); // only 2.6.10
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+
+static int __devinit snd_ensoniq_create(snd_card_t * card,
+				     struct pci_dev *pci,
+				     ensoniq_t ** rensoniq)
+{
+	ensoniq_t *ensoniq;
+	unsigned short cmdw;
+	unsigned char cmdb;
+#ifdef CHIP1371
+	int idx;
+#endif
+	int err;
+	static snd_device_ops_t ops = {
+		.dev_free =	snd_ensoniq_dev_free,
+	};
+
+	*rensoniq = NULL;
+	if ((err = pci_enable_device(pci)) < 0)
+		return err;
+	ensoniq = kcalloc(1, sizeof(*ensoniq), GFP_KERNEL);
+	if (ensoniq == NULL) {
+		pci_disable_device(pci);
+		return -ENOMEM;
+	}
+	spin_lock_init(&ensoniq->reg_lock);
+	init_MUTEX(&ensoniq->src_mutex);
+	ensoniq->card = card;
+	ensoniq->pci = pci;
+	ensoniq->irq = -1;
+	if ((err = pci_request_regions(pci, "Ensoniq AudioPCI")) < 0) {
+		kfree(ensoniq);
+		pci_disable_device(pci);
+		return err;
+	}
+	ensoniq->port = pci_resource_start(pci, 0);
+	if (request_irq(pci->irq, snd_audiopci_interrupt, SA_INTERRUPT|SA_SHIRQ, "Ensoniq AudioPCI", (void *)ensoniq)) {
+		snd_printk("unable to grab IRQ %d\n", pci->irq);
+		snd_ensoniq_free(ensoniq);
+		return -EBUSY;
+	}
+	ensoniq->irq = pci->irq;
+#ifdef CHIP1370
+	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
+				16, &ensoniq->dma_bug) < 0) {
+		snd_printk("unable to allocate space for phantom area - dma_bug\n");
+		snd_ensoniq_free(ensoniq);
+		return -EBUSY;
+	}
+#endif
+	pci_set_master(pci);
+	pci_read_config_byte(pci, PCI_REVISION_ID, &cmdb);
+	ensoniq->rev = cmdb;
+	pci_read_config_word(pci, PCI_SUBSYSTEM_VENDOR_ID, &cmdw);
+	ensoniq->subsystem_vendor_id = cmdw;
+	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &cmdw);
+	ensoniq->subsystem_device_id = cmdw;
+#ifdef CHIP1370
+#if 0
+	ensoniq->ctrl = ES_1370_CDC_EN | ES_1370_SERR_DISABLE | ES_1370_PCLKDIVO(ES_1370_SRTODIV(8000));
+#else	/* get microphone working */
+	ensoniq->ctrl = ES_1370_CDC_EN | ES_1370_PCLKDIVO(ES_1370_SRTODIV(8000));
+#endif
+	ensoniq->sctrl = 0;
+#else
+	ensoniq->ctrl = 0;
+	ensoniq->sctrl = 0;
+	ensoniq->cssr = 0;
+	for (idx = 0; es1371_amplifier_hack[idx].svid != (unsigned short)PCI_ANY_ID; idx++)
+		if (ensoniq->subsystem_vendor_id == es1371_amplifier_hack[idx].svid &&
+		    ensoniq->subsystem_device_id == es1371_amplifier_hack[idx].sdid) {
+			ensoniq->ctrl |= ES_1371_GPIO_OUT(1);	/* turn amplifier on */
+			break;
+		}
+#endif
+
+	snd_ensoniq_chip_init(ensoniq);
 
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ensoniq, &ops)) < 0) {
 		snd_ensoniq_free(ensoniq);
@@ -2071,6 +2135,10 @@
 
 	snd_ensoniq_proc_init(ensoniq);
 
+#ifdef CHIP1371 /* FIXME - this should apply to 1370 too as soon as 1370-suspend-code is written by some one :) */
+	snd_card_set_pm_callback(card, snd_ensoniq_suspend, snd_ensoniq_resume, ensoniq);
+#endif
+
 	snd_card_set_dev(card, &pci->dev);
 
 	*rensoniq = ensoniq;
@@ -2397,6 +2465,9 @@
 	.id_table = snd_audiopci_ids,
 	.probe = snd_audiopci_probe,
 	.remove = __devexit_p(snd_audiopci_remove),
+#ifdef CHIP1371 /* FIXME - this should apply to 1370 too as soon as 1370-suspend-code is written by some one :) */
+	SND_PCI_PM_CALLBACKS
+#endif
 };
 	
 static int __init alsa_card_ens137x_init(void)

--------------090104000403060805060209
Content-Type: text/x-patch;
 name="ens1370.c_CVS_rev_1.90_ens1371_suspend.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ens1370.c_CVS_rev_1.90_ens1371_suspend.patch"

Summary: Fix missing suspend/resume-code for ens1371

This patch fixes missing suspend/resume-code for snd-ens1371
(but not for snd-ens1370)

Signed-off-by: Kurt J. Bosch <kjb-temp-2005@gmx.de>

--- CVS/ens1370.CVS-rev-1.90.c	2005-11-06 11:11:38.000000000 +0100
+++ CVS/ens1370.c	2005-11-14 11:21:58.000000000 +0100
@@ -19,6 +19,13 @@
  *
  */
 
+/* Power-Management-Code ( CONFIG_PM )
+ * for ens1371 only ( FIXME )
+ * derived from cs4281.c, atiixp.c and via82xx.c
+ * using http://www.alsa-project.org/~iwai/writing-an-alsa-driver/c1540.htm
+ * by Kurt J. Bosch
+ */
+
 #include <sound/driver.h>
 #include <asm/io.h>
 #include <linux/delay.h>
@@ -1924,6 +1931,118 @@
 };
 #endif
 
+static void snd_ensoniq_chip_init(ensoniq_t * ensoniq)
+{
+#ifdef CHIP1371
+	int idx;
+	struct pci_dev *pci = ensoniq->pci;
+#endif
+// this code was part of snd_ensoniq_create before intruduction of suspend/resume
+#ifdef CHIP1370
+	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
+	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
+	outl(ES_MEM_PAGEO(ES_PAGE_ADC), ES_REG(ensoniq, MEM_PAGE));
+	outl(ensoniq->dma_bug.addr, ES_REG(ensoniq, PHANTOM_FRAME));
+	outl(0, ES_REG(ensoniq, PHANTOM_COUNT));
+#else
+	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
+	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
+	outl(0, ES_REG(ensoniq, 1371_LEGACY));
+	for (idx = 0; es1371_ac97_reset_hack[idx].vid != (unsigned short)PCI_ANY_ID; idx++)
+		if (pci->vendor == es1371_ac97_reset_hack[idx].vid &&
+		    pci->device == es1371_ac97_reset_hack[idx].did &&
+		    ensoniq->rev == es1371_ac97_reset_hack[idx].rev) {
+			ensoniq->cssr |= ES_1371_ST_AC97_RST;
+			outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
+			/* need to delay around 20ms(bleech) to give
+			some CODECs enough time to wakeup */
+			msleep(20);
+			break;
+		}
+	/* AC'97 warm reset to start the bitclk */
+	outl(ensoniq->ctrl | ES_1371_SYNC_RES, ES_REG(ensoniq, CONTROL));
+	inl(ES_REG(ensoniq, CONTROL));
+	udelay(20);
+	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
+	/* Init the sample rate converter */
+	snd_es1371_wait_src_ready(ensoniq);	
+	outl(ES_1371_SRC_DISABLE, ES_REG(ensoniq, 1371_SMPRATE));
+	for (idx = 0; idx < 0x80; idx++)
+		snd_es1371_src_write(ensoniq, idx, 0);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC1 + ES_SMPREG_TRUNC_N, 16 << 4);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC1 + ES_SMPREG_INT_REGS, 16 << 10);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC2 + ES_SMPREG_TRUNC_N, 16 << 4);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC2 + ES_SMPREG_INT_REGS, 16 << 10);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_ADC, 1 << 12);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_ADC + 1, 1 << 12);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC1, 1 << 12);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC1 + 1, 1 << 12);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC2, 1 << 12);
+	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC2 + 1, 1 << 12);
+	snd_es1371_adc_rate(ensoniq, 22050);
+	snd_es1371_dac1_rate(ensoniq, 22050);
+	snd_es1371_dac2_rate(ensoniq, 22050);
+	/* WARNING:
+	 * enabling the sample rate converter without properly programming
+	 * its parameters causes the chip to lock up (the SRC busy bit will
+	 * be stuck high, and I've found no way to rectify this other than
+	 * power cycle) - Thomas Sailer
+	 */
+	snd_es1371_wait_src_ready(ensoniq);
+	outl(0, ES_REG(ensoniq, 1371_SMPRATE));
+	/* try reset codec directly */
+	outl(ES_1371_CODEC_WRITE(0, 0), ES_REG(ensoniq, 1371_CODEC));
+#endif
+	outb(ensoniq->uartc = 0x00, ES_REG(ensoniq, UART_CONTROL));
+	outb(0x00, ES_REG(ensoniq, UART_RES));
+	outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
+	synchronize_irq(ensoniq->irq);
+}
+
+#ifdef CONFIG_PM
+static int snd_ensoniq_suspend (snd_card_t * card,
+                                pm_message_t state)
+{
+	ensoniq_t *ensoniq = card->pm_private_data;
+	
+	snd_pcm_suspend_all(ensoniq->pcm1);
+	snd_pcm_suspend_all(ensoniq->pcm2);
+	
+#ifdef CHIP1371	
+	if (ensoniq->u.es1371.ac97)
+		snd_ac97_suspend(ensoniq->u.es1371.ac97);
+#else
+	/* FIXME */
+#endif	
+        pci_set_power_state(ensoniq->pci, 3);
+	pci_disable_device(ensoniq->pci);
+        // snd_power_change_state(card, SNDRV_CTL_POWER_D3hot); // only 2.6.10
+	return 0;
+}
+
+static int snd_ensoniq_resume (snd_card_t * card
+                              )
+{
+	ensoniq_t *ensoniq = card->pm_private_data;
+
+	pci_enable_device(ensoniq->pci);
+        pci_set_power_state(ensoniq->pci, 0);	
+	pci_set_master(ensoniq->pci);
+
+	snd_ensoniq_chip_init(ensoniq);
+    
+#ifdef CHIP1371	
+	if (ensoniq->u.es1371.ac97)
+		snd_ac97_resume(ensoniq->u.es1371.ac97);
+#else
+	/* FIXME */
+#endif	
+	// snd_power_change_state(card, SNDRV_CTL_POWER_D0); // only 2.6.10
+	return 0;
+}
+#endif /* CONFIG_PM */
+
+
 static int __devinit snd_ensoniq_create(snd_card_t * card,
 				     struct pci_dev *pci,
 				     ensoniq_t ** rensoniq)
@@ -1986,12 +2105,6 @@
 	ensoniq->ctrl = ES_1370_CDC_EN | ES_1370_PCLKDIVO(ES_1370_SRTODIV(8000));
 #endif
 	ensoniq->sctrl = 0;
-	/* initialize the chips */
-	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
-	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
-	outl(ES_MEM_PAGEO(ES_PAGE_ADC), ES_REG(ensoniq, MEM_PAGE));
-	outl(ensoniq->dma_bug.addr, ES_REG(ensoniq, PHANTOM_FRAME));
-	outl(0, ES_REG(ensoniq, PHANTOM_COUNT));
 #else
 	ensoniq->ctrl = 0;
 	ensoniq->sctrl = 0;
@@ -2002,59 +2115,9 @@
 			ensoniq->ctrl |= ES_1371_GPIO_OUT(1);	/* turn amplifier on */
 			break;
 		}
-	/* initialize the chips */
-	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
-	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
-	outl(0, ES_REG(ensoniq, 1371_LEGACY));
-	for (idx = 0; es1371_ac97_reset_hack[idx].vid != (unsigned short)PCI_ANY_ID; idx++)
-		if (pci->vendor == es1371_ac97_reset_hack[idx].vid &&
-		    pci->device == es1371_ac97_reset_hack[idx].did &&
-		    ensoniq->rev == es1371_ac97_reset_hack[idx].rev) {
-			ensoniq->cssr |= ES_1371_ST_AC97_RST;
-			outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
-			/* need to delay around 20ms(bleech) to give
-			some CODECs enough time to wakeup */
-			msleep(20);
-			break;
-		}
-	/* AC'97 warm reset to start the bitclk */
-	outl(ensoniq->ctrl | ES_1371_SYNC_RES, ES_REG(ensoniq, CONTROL));
-	inl(ES_REG(ensoniq, CONTROL));
-	udelay(20);
-	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
-	/* Init the sample rate converter */
-	snd_es1371_wait_src_ready(ensoniq);	
-	outl(ES_1371_SRC_DISABLE, ES_REG(ensoniq, 1371_SMPRATE));
-	for (idx = 0; idx < 0x80; idx++)
-		snd_es1371_src_write(ensoniq, idx, 0);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC1 + ES_SMPREG_TRUNC_N, 16 << 4);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC1 + ES_SMPREG_INT_REGS, 16 << 10);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC2 + ES_SMPREG_TRUNC_N, 16 << 4);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_DAC2 + ES_SMPREG_INT_REGS, 16 << 10);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_ADC, 1 << 12);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_ADC + 1, 1 << 12);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC1, 1 << 12);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC1 + 1, 1 << 12);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC2, 1 << 12);
-	snd_es1371_src_write(ensoniq, ES_SMPREG_VOL_DAC2 + 1, 1 << 12);
-	snd_es1371_adc_rate(ensoniq, 22050);
-	snd_es1371_dac1_rate(ensoniq, 22050);
-	snd_es1371_dac2_rate(ensoniq, 22050);
-	/* WARNING:
-	 * enabling the sample rate converter without properly programming
-	 * its parameters causes the chip to lock up (the SRC busy bit will
-	 * be stuck high, and I've found no way to rectify this other than
-	 * power cycle) - Thomas Sailer
-	 */
-	snd_es1371_wait_src_ready(ensoniq);
-	outl(0, ES_REG(ensoniq, 1371_SMPRATE));
-	/* try reset codec directly */
-	outl(ES_1371_CODEC_WRITE(0, 0), ES_REG(ensoniq, 1371_CODEC));
 #endif
-	outb(ensoniq->uartc = 0x00, ES_REG(ensoniq, UART_CONTROL));
-	outb(0x00, ES_REG(ensoniq, UART_RES));
-	outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
-	synchronize_irq(ensoniq->irq);
+
+	snd_ensoniq_chip_init(ensoniq);
 
 	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, ensoniq, &ops)) < 0) {
 		snd_ensoniq_free(ensoniq);
@@ -2063,6 +2126,10 @@
 
 	snd_ensoniq_proc_init(ensoniq);
 
+#ifdef CHIP1371 /* FIXME - this should apply to 1370 too as soon as 1370-suspend-code is written by some one :) */
+	snd_card_set_pm_callback(card, snd_ensoniq_suspend, snd_ensoniq_resume, ensoniq);
+#endif
+
 	snd_card_set_dev(card, &pci->dev);
 
 	*rensoniq = ensoniq;
@@ -2390,6 +2457,9 @@
 	.id_table = snd_audiopci_ids,
 	.probe = snd_audiopci_probe,
 	.remove = __devexit_p(snd_audiopci_remove),
+#ifdef CHIP1371 /* FIXME - this should apply to 1370 too as soon as 1370-suspend-code is written by some one :) */
+	SND_PCI_PM_CALLBACKS
+#endif
 };
 	
 static int __init alsa_card_ens137x_init(void)

--------------090104000403060805060209--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
