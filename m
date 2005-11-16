From: "Kurt J. Bosch" <kjb-temp-2005@gmx.de>
Subject: Re: Changed ens1370.c to enable Suspend ens1371
Date: Wed, 16 Nov 2005 14:03:56 +0100
Message-ID: <437B2E3C.6020408@gmx.de>
References: <4374DBBC.9040100@gmx.de>	<s5hd5l7ys84.wl%tiwai@suse.de>	<43787D8A.5090907@gmx.de> <s5hoe4nxiv0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060004030401070504000307"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoe4nxiv0.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060004030401070504000307
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



Takashi Iwai schrieb:
> At Mon, 14 Nov 2005 13:05:30 +0100,
> Kurt J. Bosch wrote:
> 
>>Summary: Fix missing suspend/resume-code for ens1371
>>
>>This patch fixes missing suspend/resume-code for snd-ens1371
>>(but not for snd-ens1370)
>>
>>Signed-off-by: Kurt J. Bosch <kjb-temp-2005@gmx.de>
>>
>>--- 2.6.10-5-686/ens1370.org.c	2004-12-24 22:35:24.000000000 +0100
>>+++ 2.6.10-5-686/ens1370.c	2005-11-14 11:36:58.000000000 +0100
>>@@ -19,6 +19,14 @@
>>  *
>>  */
>> 
>>+/* Power-Management-Code ( CONFIG_PM )
>>+ * for ens1371 only ( FIXME )
>>+ * derived from cs4281.c, atiixp.c and via82xx.c
>>+ * using http://www.alsa-project.org/~iwai/writing-an-alsa-driver/c1540.htm
>>+ * by Kurt J. Bosch
>>+ */
>>+
>>+
>> #include <sound/driver.h>
>> #include <asm/io.h>
>> #include <linux/delay.h>
>>@@ -1875,6 +1883,129 @@
>> };
>> #endif
>> 
>>+static void snd_ensoniq_chip_init(ensoniq_t * ensoniq)
>>+{
>>+#ifdef CHIP1371
>>+	int idx;
>>+	struct pci_dev *pci = ensoniq->pci;
>>+#endif
>>+// this code was part of snd_ensoniq_create
>>+#ifdef CHIP1370	
>>+	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
>>+	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
>>+	outl(ES_MEM_PAGEO(ES_PAGE_ADC), ES_REG(ensoniq, MEM_PAGE));
>>+	outl(ensoniq->dma_bug.addr, ES_REG(ensoniq, PHANTOM_FRAME));
>>+	outl(0, ES_REG(ensoniq, PHANTOM_COUNT));
>>+#else
>>+	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
>>+	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
>>+	outl(0, ES_REG(ensoniq, 1371_LEGACY));
>>+	for (idx = 0; es1371_ac97_reset_hack[idx].vid != (unsigned short)PCI_ANY_ID; idx++)
>>+		if (pci->vendor == es1371_ac97_reset_hack[idx].vid &&
>>+		    pci->device == es1371_ac97_reset_hack[idx].did &&
>>+		    ensoniq->rev == es1371_ac97_reset_hack[idx].rev) {
>>+		        unsigned long tmo;
>>+			signed long tmo2;
>>+
>>+			ensoniq->cssr |= ES_1371_ST_AC97_RST;
> 
> 
> 
> ensoniq->cssr shouldn't be overridden here.
> 
> 
>>+static int snd_ensoniq_resume (snd_card_t * card,
>>+                               unsigned int state)
>>+{
>>+	ensoniq_t *ensoniq = card->pm_private_data;
>>+
>>+	pci_enable_device(ensoniq->pci);
>>+        pci_set_power_state(ensoniq->pci, 0);	
>>+	pci_set_master(ensoniq->pci);
> 
> 
> Don't mix up tab and spaces.
> 
> 
>>+#ifdef CHIP1371 /* FIXME - this should apply to 1370 too as soon as 1370-suspend-code is written by some one :) */
>>+	snd_card_set_pm_callback(card, snd_ensoniq_suspend, snd_ensoniq_resume, ensoniq);
>>+#endif
> 
> 
> It's still better than nothing.  Better to remove this ifdef.
> 
> 
> 
>>@@ -2364,6 +2432,9 @@
>> 	.id_table = snd_audiopci_ids,
>> 	.probe = snd_audiopci_probe,
>> 	.remove = __devexit_p(snd_audiopci_remove),
>>+#ifdef CHIP1371 /* FIXME - this should apply to 1370 too as soon as 1370-suspend-code is written by some one :) */
>>+	SND_PCI_PM_CALLBACKS
>>+#endif
> 
> 
> Ditto.
> 
> 
OK - fixed that too

--------------060004030401070504000307
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
+++ 2.6.10-5-686/ens1370.c	2005-11-16 12:05:36.000000000 +0100
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
@@ -1875,6 +1883,128 @@
 };
 #endif
 
+static void snd_ensoniq_chip_init(ensoniq_t * ensoniq)
+{
+#ifdef CHIP1371
+	int idx;
+	struct pci_dev *pci = ensoniq->pci;
+#endif
+// this code was part of snd_ensoniq_create before introduction of suspend/resume
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
+	pci_set_power_state(ensoniq->pci, 0);	
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
@@ -1938,12 +2068,6 @@
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
@@ -1954,74 +2078,22 @@
 			ensoniq->ctrl |= ES_1371_GPIO_OUT(1);	/* turn amplifier on */
 			break;
 		}
-	/* initialize the chips */
-	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
-	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
-	outl(0, ES_REG(ensoniq, 1371_LEGACY));
 	for (idx = 0; es1371_ac97_reset_hack[idx].vid != (unsigned short)PCI_ANY_ID; idx++)
 		if (pci->vendor == es1371_ac97_reset_hack[idx].vid &&
 		    pci->device == es1371_ac97_reset_hack[idx].did &&
 		    ensoniq->rev == es1371_ac97_reset_hack[idx].rev) {
-		        unsigned long tmo;
-			signed long tmo2;
-
 			ensoniq->cssr |= ES_1371_ST_AC97_RST;
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
 			break;
 		}
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
+	snd_card_set_pm_callback(card, snd_ensoniq_suspend, snd_ensoniq_resume, ensoniq);
 
 	snd_card_set_dev(card, &pci->dev);
 
@@ -2342,7 +2414,7 @@
 		card->driver,
 		ensoniq->port,
 		ensoniq->irq);
-
+		
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -2364,6 +2436,7 @@
 	.id_table = snd_audiopci_ids,
 	.probe = snd_audiopci_probe,
 	.remove = __devexit_p(snd_audiopci_remove),
+	SND_PCI_PM_CALLBACKS
 };
 	
 static int __init alsa_card_ens137x_init(void)

--------------060004030401070504000307
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
+++ 2.6.12-9-686/ens1370.c	2005-11-16 12:04:04.000000000 +0100
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
@@ -1922,6 +1929,128 @@
 };
 #endif
 
+static void snd_ensoniq_chip_init(ensoniq_t * ensoniq)
+{
+#ifdef CHIP1371
+	int idx;
+	struct pci_dev *pci = ensoniq->pci;
+#endif
+// this code was part of snd_ensoniq_create before introduction of suspend/resume
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
+	pci_set_power_state(ensoniq->pci, 0);	
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
@@ -1984,12 +2113,6 @@
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
@@ -2000,69 +2123,16 @@
 			ensoniq->ctrl |= ES_1371_GPIO_OUT(1);	/* turn amplifier on */
 			break;
 		}
-	/* initialize the chips */
-	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
-	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
-	outl(0, ES_REG(ensoniq, 1371_LEGACY));
 	for (idx = 0; es1371_ac97_reset_hack[idx].vid != (unsigned short)PCI_ANY_ID; idx++)
 		if (pci->vendor == es1371_ac97_reset_hack[idx].vid &&
 		    pci->device == es1371_ac97_reset_hack[idx].did &&
 		    ensoniq->rev == es1371_ac97_reset_hack[idx].rev) {
-		        unsigned long tmo;
-			signed long tmo2;
-
 			ensoniq->cssr |= ES_1371_ST_AC97_RST;
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
 			break;
 		}
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
@@ -2071,6 +2141,8 @@
 
 	snd_ensoniq_proc_init(ensoniq);
 
+	snd_card_set_pm_callback(card, snd_ensoniq_suspend, snd_ensoniq_resume, ensoniq);
+
 	snd_card_set_dev(card, &pci->dev);
 
 	*rensoniq = ensoniq;
@@ -2397,6 +2469,7 @@
 	.id_table = snd_audiopci_ids,
 	.probe = snd_audiopci_probe,
 	.remove = __devexit_p(snd_audiopci_remove),
+	SND_PCI_PM_CALLBACKS
 };
 	
 static int __init alsa_card_ens137x_init(void)

--------------060004030401070504000307
Content-Type: text/x-patch;
 name="ens1370.c_CVS_rev_1.90_ens1371_suspend.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ens1370.c_CVS_rev_1.90_ens1371_suspend.patch"

Summary: Fix missing suspend/resume-code for ens1371

This patch fixes missing suspend/resume-code for snd-ens1371
(but not for snd-ens1370)

Signed-off-by: Kurt J. Bosch <kjb-temp-2005@gmx.de>

--- Alsa_CVS_rev_1.90/ens1370.org.c	2005-11-06 11:11:38.000000000 +0100
+++ Alsa_CVS_rev_1.90/ens1370.c	2005-11-16 12:06:08.000000000 +0100
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
@@ -1924,6 +1931,117 @@
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
+	pci_set_power_state(ensoniq->pci, 0);	
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
@@ -1986,12 +2104,6 @@
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
@@ -2002,59 +2114,16 @@
 			ensoniq->ctrl |= ES_1371_GPIO_OUT(1);	/* turn amplifier on */
 			break;
 		}
-	/* initialize the chips */
-	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
-	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
-	outl(0, ES_REG(ensoniq, 1371_LEGACY));
 	for (idx = 0; es1371_ac97_reset_hack[idx].vid != (unsigned short)PCI_ANY_ID; idx++)
 		if (pci->vendor == es1371_ac97_reset_hack[idx].vid &&
 		    pci->device == es1371_ac97_reset_hack[idx].did &&
 		    ensoniq->rev == es1371_ac97_reset_hack[idx].rev) {
 			ensoniq->cssr |= ES_1371_ST_AC97_RST;
-			outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
-			/* need to delay around 20ms(bleech) to give
-			some CODECs enough time to wakeup */
-			msleep(20);
 			break;
 		}
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
@@ -2063,6 +2132,8 @@
 
 	snd_ensoniq_proc_init(ensoniq);
 
+	snd_card_set_pm_callback(card, snd_ensoniq_suspend, snd_ensoniq_resume, ensoniq);
+
 	snd_card_set_dev(card, &pci->dev);
 
 	*rensoniq = ensoniq;
@@ -2390,6 +2461,7 @@
 	.id_table = snd_audiopci_ids,
 	.probe = snd_audiopci_probe,
 	.remove = __devexit_p(snd_audiopci_remove),
+	SND_PCI_PM_CALLBACKS
 };
 	
 static int __init alsa_card_ens137x_init(void)

--------------060004030401070504000307--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
