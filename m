From: drechsler2@t-online.de (Max Drechsler)
Subject: (no subject)
Date: Thu, 24 Apr 2003 17:21:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <FEEJLNFINNCBLJGNJNHPGEAFCAAA.drechsler2@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

Based on the recently released oss driver from nvidia, i added spdif support
to the intel8x0 driver module.
Now I have one problem:
I can only access the spdif, if I open the device directly in
snd_intel8x0_playback_open (line 961 in intel8x0.c).
But how about the mixer controls, they don´t work!
So, how can I route the data to the spdif output via mixer controls?
I also haven´t yet found the functions who access the device specific open,
close, etc. functions.
Perhaps somebody can give me a hint to this topic.

											Greets, Max Drechsler
The patch to the intel8x0 driver module:

diff -uNr alsa-driver-0.9.2/alsa-kernel/pci/intel8x0.c
alsa-driver-0.9.2-nforce-spdif/alsa-kernel/pci/intel8x0.c
--- alsa-driver-0.9.2/alsa-kernel/pci/intel8x0.c	2003-03-10
17:08:16.000000000 +0100
+++ alsa-driver-0.9.2-nforce-spdif/alsa-kernel/pci/intel8x0.c	2003-04-24
15:44:27.000000000 +0200
@@ -139,7 +139,7 @@
 #define PCI_DEVICE_ID_NVIDIA_MCP3_AUDIO	0x00da
 #endif

-enum { DEVICE_INTEL, DEVICE_INTEL_ICH4, DEVICE_SIS, DEVICE_ALI };
+enum { DEVICE_INTEL, DEVICE_INTEL_ICH4, DEVICE_SIS, DEVICE_ALI,
DEVICE_NFORCE };

 #define ICHREG(x) ICH_REG_##x

@@ -227,6 +227,9 @@
 #define   ICH_MCINT		0x00000080	/* MIC capture interrupt */
 #define   ICH_POINT		0x00000040	/* playback interrupt */
 #define   ICH_PIINT		0x00000020	/* capture interrupt */
+/* nforce stuff */
+#define   ICH_NVSPINT		0x00000010	/* nforce spdif interrupt */
+/* XXX */
 #define   ICH_MOINT		0x00000004	/* modem playback interrupt */
 #define   ICH_MIINT		0x00000002	/* modem capture interrupt */
 #define   ICH_GSCI		0x00000001	/* GPI status change interrupt */
@@ -298,6 +301,8 @@

 enum { ICHD_PCMIN, ICHD_PCMOUT, ICHD_MIC, ICHD_MIC2, ICHD_PCM2IN,
ICHD_SPBAR, ICHD_LAST = ICHD_SPBAR };
 enum { ALID_PCMIN, ALID_PCMOUT, ALID_MIC, ALID_AC97SPDIFOUT, ALID_SPDIFIN,
ALID_SPDIFOUT, ALID_LAST = ALID_SPDIFOUT };
+/* nforce stuff XXX */
+enum { NVD_PCMIN, NVD_PCMOUT, NVD_MIC, NVD_SPDIFOUT, NVD_LAST =
NVD_SPDIFOUT }; /* XXX */

 #define get_ichdev(substream) (ichdev_t
*)(substream->runtime->private_data)

@@ -396,9 +401,9 @@
 	{ 0x8086, 0x24d5, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL_ICH4 }, /*
ICH5 */
 	{ 0x8086, 0x7195, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* 440MX
*/
 	{ 0x1039, 0x7012, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_SIS },	/* SI7012 */
-	{ 0x10de, 0x01b1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* NFORCE
*/
-	{ 0x10de, 0x006a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* NFORCE2
*/
-	{ 0x10de, 0x00da, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* NFORCE3
*/
+	{ 0x10de, 0x01b1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },	/* NFORCE
*/
+	{ 0x10de, 0x006a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },	/*
NFORCE2 */
+	{ 0x10de, 0x00da, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },	/*
NFORCE3 */
 	{ 0x1022, 0x746d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* AMD8111
*/
 	{ 0x1022, 0x7445, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_INTEL },	/* AMD768
*/
 	{ 0x10b9, 0x5455, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_ALI },   /* Ali5455
*/
@@ -953,8 +958,7 @@
 	intel8x0_t *chip = snd_pcm_substream_chip(substream);
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int err;
-
-	err = snd_intel8x0_pcm_open(substream, &chip->ichd[ICHD_PCMOUT]);
+	err = snd_intel8x0_spdif_open(substream, &chip->ichd[NVD_SPDIFOUT]);
 	if (chip->multi6) {
 		runtime->hw.channels_max = 6;
 		snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
&hw_constraints_channels6);
@@ -1035,16 +1039,25 @@

 static int snd_intel8x0_spdif_open(snd_pcm_substream_t * substream)
 {
+	int ichdef;
 	intel8x0_t *chip = snd_pcm_substream_chip(substream);
-
-	return snd_intel8x0_pcm_open(substream, &chip->ichd[ICHD_SPBAR]);
+	if (chip->device_type != DEVICE_NFORCE)
+		ichdef = ICHD_SPBAR;
+	else
+		ichdef = NVD_SPDIFOUT;
+	return snd_intel8x0_pcm_open(substream, &chip->ichd[ichdef]);
 }

 static int snd_intel8x0_spdif_close(snd_pcm_substream_t * substream)
 {
+	int ichdef;
 	intel8x0_t *chip = snd_pcm_substream_chip(substream);
+	if (chip->device_type != DEVICE_NFORCE)
+		ichdef = ICHD_SPBAR;
+        else
+                ichdef = NVD_SPDIFOUT;

-	chip->ichd[ICHD_SPBAR].substream = NULL;
+	chip->ichd[ichdef].substream = NULL;
 	return 0;
 }

@@ -1513,6 +1526,17 @@
 	{ ICHD_SPBAR, { AC97_SPDIF, 0, 0 }, AC97_RATES_SPDIF },
 };

+static struct _ac97_nv_rate_regs {
+        unsigned int ichd;
+        unsigned short regs[3];
+        short rates_idx;
+} ac97_nv_rate_regs[] = {
+        { NVD_PCMOUT, { AC97_PCM_FRONT_DAC_RATE, AC97_PCM_SURR_DAC_RATE,
AC97_PCM_LFE_DAC_RATE }, AC97_RATES_FRONT_DAC },
+        { NVD_PCMIN, { AC97_PCM_LR_ADC_RATE, 0, 0 }, AC97_RATES_ADC },
+        { NVD_MIC, { AC97_PCM_MIC_ADC_RATE, 0, 0 }, AC97_RATES_MIC_ADC },
+        { NVD_SPDIFOUT, { AC97_SPDIF, 0, 0 }, AC97_RATES_SPDIF },
+};
+
 static struct _ac97_ali_rate_regs {
 	unsigned int ichd;
 	unsigned short regs[3];
@@ -1539,23 +1563,35 @@
 	int err, i, num, channels = 2, codecs, _codecs;
 	unsigned int glob_sta = 0;

-	for (i = 0; i <= ICHD_LAST; i++) {
-		if (chip->device_type != DEVICE_ALI) {
-			struct _ac97_rate_regs *aregs;
-			aregs = &ac97_rate_regs[i];
-			ichdev = &chip->ichd[aregs->ichd];
-			ichdev->ac97_rate_regs[0] = aregs->regs[0];
-			ichdev->ac97_rate_regs[1] = aregs->regs[1];
-			ichdev->ac97_rate_regs[2] = aregs->regs[2];
-			ichdev->ac97_rates_idx = aregs->rates_idx;
-		} else {
-			struct _ac97_ali_rate_regs *aregs;
-			aregs = &ac97_ali_rate_regs[i];
+	if (chip->device_type != DEVICE_NFORCE)  {
+		for (i = 0; i <= ICHD_LAST; i++) {
+			if (chip->device_type != DEVICE_ALI) {
+				struct _ac97_rate_regs *aregs;
+				aregs = &ac97_rate_regs[i];
+				ichdev = &chip->ichd[aregs->ichd];
+				ichdev->ac97_rate_regs[0] = aregs->regs[0];
+				ichdev->ac97_rate_regs[1] = aregs->regs[1];
+				ichdev->ac97_rate_regs[2] = aregs->regs[2];
+				ichdev->ac97_rates_idx = aregs->rates_idx;
+			} else {
+				struct _ac97_ali_rate_regs *aregs;
+				aregs = &ac97_ali_rate_regs[i];
+				ichdev = &chip->ichd[aregs->ichd];
+				ichdev->ac97_rate_regs[0] = aregs->regs[0];
+				ichdev->ac97_rate_regs[1] = aregs->regs[1];
+				ichdev->ac97_rate_regs[2] = aregs->regs[2];
+				ichdev->ac97_rates_idx = aregs->rates_idx;
+			}
+		}
+	} else {
+		for (i = 0; i <= NVD_LAST; i++) {
+			struct _ac97_nv_rate_regs *aregs;
+			aregs = &ac97_nv_rate_regs[i];
 			ichdev = &chip->ichd[aregs->ichd];
 			ichdev->ac97_rate_regs[0] = aregs->regs[0];
-			ichdev->ac97_rate_regs[1] = aregs->regs[1];
-			ichdev->ac97_rate_regs[2] = aregs->regs[2];
-			ichdev->ac97_rates_idx = aregs->rates_idx;
+                        ichdev->ac97_rate_regs[1] = aregs->regs[1];
+                        ichdev->ac97_rate_regs[2] = aregs->regs[2];
+                        ichdev->ac97_rates_idx = aregs->rates_idx;
 		}
 	}
 	chip->in_ac97_init = 1;
@@ -1618,14 +1654,17 @@
 	if (x97->ext_id & AC97_EI_VRM)
 		chip->ichd[ICHD_MIC].ac97 = x97;
 	if (x97->ext_id & AC97_EI_SPDIF) {
-		if (chip->device_type != DEVICE_ALI)
-			chip->ichd[ICHD_SPBAR].ac97 = x97;
-		else
+		if (chip->device_type == DEVICE_ALI)
 			chip->ichd[ALID_AC97SPDIFOUT].ac97 = x97;
+		else if (chip->device_type == DEVICE_NFORCE)
+			chip->ichd[NVD_SPDIFOUT].ac97 = x97;
+		else
+			chip->ichd[ICHD_SPBAR].ac97 = x97;
 	}
 	/* make sure, that we have DACs at right slot for rev2.2 */
-	if (ac97_is_rev22(x97))
+	if (ac97_is_rev22(x97))  {
 		snd_ac97_update_bits(x97, AC97_EXTENDED_ID, AC97_EI_DACS_SLOT_MASK, 0);
+	}
 	/* AnalogDevices CNR boards uses special codec chaining */
 	/* skip standard test method for secondary codecs in this case */
 	if (x97->flags & AC97_AD_MULTI)
@@ -1658,6 +1697,12 @@
 					chip->ichd[ICHD_SPBAR].ac97 = x97;
 			}
 			break;
+		case DEVICE_NFORCE:
+			if (x97->ext_id & AC97_EI_VRM) {
+				if (chip->ichd[NVD_MIC].ac97 == NULL)
+					chip->ichd[NVD_MIC].ac97 = x97;
+			}
+			break;
 		default:
 			if (x97->ext_id & AC97_EI_VRM) {
 				if (chip->ichd[ICHD_MIC].ac97 == NULL)
@@ -1776,6 +1821,82 @@
 	schedule_timeout(1);
 }

+static int snd_intel8x0_nv_chip_init(intel8x0_t *chip)
+{
+        signed long end_time;
+        unsigned int cnt, status, nstatus;
+
+        /* put logic to right state */
+        /* first clear status bits */
+	cnt = igetdword(chip, ICHREG(GLOB_STA));
+        iputdword(chip, ICHREG(GLOB_STA), cnt & (ICH_RCS | ICH_MCINT |
ICH_POINT | ICH_PIINT | ICH_NVSPINT));
+
+        /* ACLink on, 2 channels */
+        cnt = igetdword(chip, ICHREG(GLOB_CNT));
+        cnt &= ~(ICH_ACLINK | ICH_PCM_246_MASK);
+        /* finish cold or do warm reset */
+        cnt |= (cnt & ICH_AC97COLD) == 0 ? ICH_AC97COLD : ICH_AC97WARM;
+        iputdword(chip, ICHREG(GLOB_CNT), cnt);
+        end_time = (jiffies + (HZ / 4)) + 1;
+        do {
+                if ((igetdword(chip, ICHREG(GLOB_CNT)) & ICH_AC97WARM) ==
0)
+                        goto __ok;
+                do_delay(chip);
+        } while (time_after_eq(end_time, jiffies));
+        snd_printk("AC'97 warm reset still in progress? [0x%x]\n",
igetdword(chip, ICHREG(GLOB_CNT)));
+        return -EIO;
+
+      __ok:
+        /* wait for any codec ready status.
+         * Once it becomes ready it should remain ready
+         * as long as we do not disable the ac97 link.
+         */
+        end_time = jiffies + HZ;
+        do {
+                status = igetdword(chip, ICHREG(GLOB_STA)) & (ICH_PCR |
ICH_SCR | ICH_TCR);
+                if (status)
+                        goto __ok1;
+                do_delay(chip);
+        } while (time_after_eq(end_time, jiffies));
+        snd_printk(KERN_ERR "codec_ready: codec is not ready [0x%x]\n",
igetdword(chip, ICHREG(GLOB_STA)));
+        return -EIO;
+
+      __ok1:
+        if (status == (ICH_PCR | ICH_SCR | ICH_TCR))
+                goto __ok3;
+        /* wait for other codecs ready status. No secondary codecs? , ok */
+        end_time = jiffies + HZ / 4;
+        do {
+                nstatus = igetdword(chip, ICHREG(GLOB_STA)) & (ICH_PCR |
ICH_SCR | ICH_TCR);
+                if (nstatus != status) {
+                        status = nstatus;
+                        goto __ok2;
+                }
+                do_delay(chip);
+        } while (time_after_eq(end_time, jiffies));
+
+      __ok2:
+        if (status == (ICH_PCR | ICH_SCR | ICH_TCR))
+                goto __ok3;
+        /* wait for other codecs ready status. No other secondary codecs? ,
ok */
+        /* end_time is not initialized here */
+        do {
+                nstatus = igetdword(chip, ICHREG(GLOB_STA)) & (ICH_PCR |
ICH_SCR | ICH_TCR);
+                if (nstatus != status) {
+                        status = nstatus;
+                        goto __ok2;
+                }
+                do_delay(chip);
+        } while (time_after_eq(end_time, jiffies));
+
+      __ok3:
+        if (chip->device_type == DEVICE_SIS) {	/* FIXME seems to be like
nforce*/
+                /* unmute the output on SIS7012 */
+                iputword(chip, 0x4c, igetword(chip, 0x4c) | 1);
+        }
+        return 0;
+}
+
 static int snd_intel8x0_ich_chip_init(intel8x0_t *chip)
 {
 	signed long end_time;
@@ -1891,10 +2012,12 @@
 	unsigned int i;
 	int err;

-	if (chip->device_type != DEVICE_ALI)
-		err = snd_intel8x0_ich_chip_init(chip);
-	else
+	if (chip->device_type == DEVICE_ALI)
 		err = snd_intel8x0_ali_chip_init(chip);
+	else if (chip->device_type == DEVICE_NFORCE)
+		err = snd_intel8x0_nv_chip_init(chip);
+	else
+		err = snd_intel8x0_ich_chip_init(chip);
 	if (err < 0)
 		return err;

@@ -2170,6 +2293,7 @@
 	int err;
 	unsigned int i;
 	unsigned int int_sta_masks;
+	u32 regvalue = 0;
 	ichdev_t *ichdev;
 	static snd_device_ops_t ops = {
 		.dev_free =	snd_intel8x0_dev_free,
@@ -2181,9 +2305,17 @@
 		ALI_INT_PCMIN, ALI_INT_PCMOUT, ALI_INT_MICIN,
 		ALI_INT_CODECSPDIFOUT, ALI_INT_SPDIFIN, ALI_INT_SPDIFOUT
 	};
+	/* XXX nforce stuff */
+	static u32 nv_int_sta_masks[4] = {
+		ICH_PIINT, ICH_POINT, ICH_MCINT, ICH_NVSPINT
+	};/* XXX */
 	static u32 ali_reg_offsets[6] = {
 		0x40, 0x50, 0x60, 0x70, 0xa0, 0xb0
 	};
+	/* XXX nforce stuff */
+	static u32 nv_reg_offsets[4] = {
+		0x00, 0x10, 0x20, 0x70
+	};/* XXX */

 	*r_intel8x0 = NULL;

@@ -2202,6 +2334,12 @@
 	snd_intel8x0_proc_init(chip);
 	sprintf(chip->ac97_name, "%s - AC'97", card->shortname);
 	sprintf(chip->ctrl_name, "%s - Controller", card->shortname);
+	// enable nforce spdif XXX
+	if (chip->device_type == DEVICE_NFORCE)  {
+		pci_read_config_dword(pci,0x4C,&regvalue);
+		regvalue = (regvalue & 0xFEFFFFFF) |  0x1000000;
+		pci_write_config_dword(pci,0x4C,regvalue);
+	}	/* XXX */
 	if (pci_resource_flags(pci, 2) & IORESOURCE_MEM) {	/* ICH4 and Nforce */
 		chip->mmio = 1;
 		chip->addr = pci_resource_start(pci, 2);
@@ -2256,35 +2394,50 @@
 	synchronize_irq(chip->irq);

 	/* initialize offsets */
-	for (i = 0; i <= ICHD_LAST; i++) {
-		ichdev = &chip->ichd[i];
-		ichdev->ichd = i;
-		ichdev->reg_offset = i * 0x10 + (i >= 0x30 ? 0x10 : 0);
-		ichdev->roff_sr = ICH_REG_OFF_SR;
-		ichdev->roff_picb = ICH_REG_OFF_PICB;
-		ichdev->int_sta_mask = device_type == DEVICE_ALI ? ali_int_sta_masks[i] :
intel_int_sta_masks[i];
-	}
-	switch (device_type) {
-	case DEVICE_SIS:
-		for (i = 0; i <= ICHD_LAST; i++) {
+	if (chip->device_type != DEVICE_NFORCE)  {
+		for (i = 0; i <= ICHD_LAST; i++) {
 			ichdev = &chip->ichd[i];
-			ichdev->roff_sr = ICH_REG_OFF_PICB;
-			ichdev->roff_picb = ICH_REG_OFF_SR;
+			ichdev->ichd = i;
+			ichdev->reg_offset = i * 0x10 + (i >= 0x30 ? 0x10 : 0);
+			ichdev->roff_sr = ICH_REG_OFF_SR;
+			ichdev->roff_picb = ICH_REG_OFF_PICB;
+			ichdev->int_sta_mask = device_type == DEVICE_ALI ? ali_int_sta_masks[i]
: intel_int_sta_masks[i];
 		}
-		break;
-	case DEVICE_ALI:
-		for (i = 0; i <= ALID_LAST; i++) {
+		switch (chip->device_type) {
+		case DEVICE_SIS:
+			for (i = 0; i <= ICHD_LAST; i++) {
+				ichdev = &chip->ichd[i];
+				ichdev->roff_sr = ICH_REG_OFF_PICB;
+				ichdev->roff_picb = ICH_REG_OFF_SR;
+			}
+			break;
+		case DEVICE_ALI:
+			for (i = 0; i <= ALID_LAST; i++) {
+				ichdev = &chip->ichd[i];
+				ichdev->reg_offset = ali_reg_offsets[i];
+				ichdev->ali_slot = i + 1;	/* is this right for last three devices? --jk
*/
+			}
+		}
+	} else {
+	/* nforce stuff XXX */
+		for (i = 0; i <= NVD_LAST; i++) {
 			ichdev = &chip->ichd[i];
-			ichdev->reg_offset = ali_reg_offsets[i];
-			ichdev->ali_slot = i + 1;	/* is this right for last three devices? --jk
*/
+			ichdev->ichd = i;
+			ichdev->reg_offset = nv_reg_offsets[i];
+			ichdev->int_sta_mask = nv_int_sta_masks[i];
+			ichdev->roff_sr = ICH_REG_OFF_SR;
+			ichdev->roff_picb = ICH_REG_OFF_PICB;
 		}
-	}
+	}/* nforce stuff XXX */
+

 	/* allocate buffer descriptor lists */
 	/* the start of each lists must be aligned to 8 bytes */
 	chip->bdbars_count = 3;
 	if (device_type == DEVICE_INTEL_ICH4 || device_type == DEVICE_ALI)
 		chip->bdbars_count = 6;
+	else if (device_type == DEVICE_NFORCE)
+		chip->bdbars_count = 4;
 	chip->bdbars = (u32 *)snd_malloc_pci_pages(pci, chip->bdbars_count *
sizeof(u32) * ICH_MAX_FRAGS * 2, &chip->bdbars_addr);
 	if (chip->bdbars == NULL) {
 		snd_intel8x0_free(chip);
@@ -2309,7 +2462,6 @@
 	}
 	chip->int_sta_reg = device_type == DEVICE_ALI ? ICH_REG_ALI_INTERRUPTSR :
ICH_REG_GLOB_STA;
 	chip->int_sta_mask = int_sta_masks;
-
 	if ((err = snd_intel8x0_chip_init(chip)) < 0) {
 		snd_intel8x0_free(chip);
 		return err;
@@ -2406,7 +2558,16 @@
 		}
 	}
 	/* activate AC'97 S/PDIF only when associated AC'97 codec */
-	if (chip->bdbars_count > 3) {
+	if (chip->device_type == DEVICE_NFORCE)  {
+		err = 0;
+		if (chip->ichd[NVD_SPDIFOUT].ac97)
+			err = snd_intel8x0_pcm_spdif(chip, pcm_dev++, NULL);
+		if (err < 0) {
+                        snd_card_free(card);
+                        return err;
+		}
+	}
+	if ((chip->bdbars_count > 3)&&(chip->device_type != DEVICE_NFORCE)) {
 		err = 0;
 		if (chip->device_type == DEVICE_ALI) {
 			if (chip->ichd[ALID_AC97SPDIFOUT].ac97)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
