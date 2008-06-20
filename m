From: Vova Barinov <vova.barinov@gmail.com>
Subject: Re: Problems compiling Davinci ASoC driver
	in	2.6.26-rc6
Date: Fri, 20 Jun 2008 15:47:02 +0400
Message-ID: <485B98B6.3010802@gmail.com>
References: <485B4F74.4020506@embedded-sol.com>
	<1213955679.11838.12.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000304060603080501030802"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 30CB3245A3
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jun 2008 13:46:53 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so611402fgg.44
	for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2008 04:46:52 -0700 (PDT)
In-Reply-To: <1213955679.11838.12.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: Felix Radensky <felix@embedded-sol.com>, alsa-devel@alsa-project.org, Kevin Hilman <khilman@mvista.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000304060603080501030802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Freix,

I see that you use upstream kernel but you should use now davinci git 
tree that at 2.6.26-rc5.
I'm not familiar with it's current status. Kevin Hilman is a maintainer 
and possible that he can answer about ASoC support there and about 
Davinci upstream status too.
FYI: I can't see that Davinci DMA used in Davinci PCM is not in git 
tree. Not sure but possible that Kevin adapted ASoC for git DMA stuff.
You can try the attached required patch that was sent to arm-linux 
mailing list some time ago and patch for i2c hack that is needed for 
Davinici but is not acceptable upstream.

Also I'm no more with MV. So have nothing access to h/w.

Vladimir

Liam Girdwood wrote:
> On Fri, 2008-06-20 at 09:34 +0300, Felix Radensky wrote:
>   
>> Hi,
>>
>> I wanted to test Davinci ASoC driver on Davinci EVM evaluation
>> board, but encountered the following compilation errors:
>>
>>  CC      sound/soc/codecs/tlv320aic3x.o
>> sound/soc/codecs/tlv320aic3x.c:1012: warning: 'aic3x_init' defined but 
>> not used
>>   LD      sound/soc/codecs/snd-soc-tlv320aic3x.o
>>   LD      sound/soc/codecs/built-in.o
>>   CC      sound/soc/davinci/davinci-i2s.o
>> sound/soc/davinci/davinci-i2s.c:402: warning: initialization from 
>> incompatible pointer type
>>   CC      sound/soc/davinci/davinci-pcm.o
>> sound/soc/davinci/davinci-pcm.c: In function `davinci_pcm_enqueue_dma':
>> sound/soc/davinci/davinci-pcm.c:99: error: implicit declaration of 
>> function `davinci_set_dma_src_params'
>> sound/soc/davinci/davinci-pcm.c:99: error: `INCR' undeclared (first use 
>> in this function)
>> sound/soc/davinci/davinci-pcm.c:99: error: (Each undeclared identifier 
>> is reported only once
>> sound/soc/davinci/davinci-pcm.c:99: error: for each function it appears in.)
>> sound/soc/davinci/davinci-pcm.c:99: error: `W8BIT' undeclared (first use 
>> in this function)
>> sound/soc/davinci/davinci-pcm.c:100: error: implicit declaration of 
>> function `davinci_set_dma_dest_params'
>> sound/soc/davinci/davinci-pcm.c:101: error: implicit declaration of 
>> function `davinci_set_dma_src_index'
>> sound/soc/davinci/davinci-pcm.c:102: error: implicit declaration of 
>> function `davinci_set_dma_dest_index'
>> sound/soc/davinci/davinci-pcm.c:103: error: implicit declaration of 
>> function `davinci_set_dma_transfer_params'
>> sound/soc/davinci/davinci-pcm.c:103: error: `ASYNC' undeclared (first 
>> use in this function)
>> sound/soc/davinci/davinci-pcm.c: In function `davinci_pcm_dma_irq':
>> sound/soc/davinci/davinci-pcm.c:117: error: `DMA_COMPLETE' undeclared 
>> (first use in this function)
>> sound/soc/davinci/davinci-pcm.c: In function `davinci_pcm_dma_request':
>> sound/soc/davinci/davinci-pcm.c:134: error: `TCC_ANY' undeclared (first 
>> use in this function)
>> sound/soc/davinci/davinci-pcm.c:143: error: implicit declaration of 
>> function `davinci_request_dma'
>> sound/soc/davinci/davinci-pcm.c:145: error: `EVENTQ_0' undeclared (first 
>> use in this function)
>> sound/soc/davinci/davinci-pcm.c:150: error: `PARAM_ANY' undeclared 
>> (first use in this function)
>> sound/soc/davinci/davinci-pcm.c:153: error: implicit declaration of 
>> function `davinci_free_dma'
>> sound/soc/davinci/davinci-pcm.c:158: error: implicit declaration of 
>> function `davinci_dma_link_lch'
>> sound/soc/davinci/davinci-pcm.c: In function `davinci_pcm_trigger':
>> sound/soc/davinci/davinci-pcm.c:174: error: implicit declaration of 
>> function `davinci_start_dma'
>> sound/soc/davinci/davinci-pcm.c:179: error: implicit declaration of 
>> function `davinci_stop_dma'
>> sound/soc/davinci/davinci-pcm.c: In function `davinci_pcm_prepare':
>> sound/soc/davinci/davinci-pcm.c:194: error: storage size of 'temp' isn't 
>> known
>> sound/soc/davinci/davinci-pcm.c:200: error: implicit declaration of 
>> function `davinci_get_dma_params'
>> sound/soc/davinci/davinci-pcm.c:201: error: implicit declaration of 
>> function `davinci_set_dma_params'
>> sound/soc/davinci/davinci-pcm.c:194: warning: unused variable `temp'
>> sound/soc/davinci/davinci-pcm.c: In function `davinci_pcm_pointer':
>> sound/soc/davinci/davinci-pcm.c:217: error: implicit declaration of 
>> function `davinci_dma_getposition'
>> sound/soc/davinci/davinci-pcm.c: In function `davinci_pcm_close':
>> sound/soc/davinci/davinci-pcm.c:262: error: implicit declaration of 
>> function `davinci_dma_unlink_lch'
>> make[3]: *** [sound/soc/davinci/davinci-pcm.o] Error 1
>> make[2]: *** [sound/soc/davinci] Error 2
>> make[1]: *** [sound/soc] Error 2
>> make: *** [sound] Error 2
>>
>> Are there plans to fix this before release of 2.6.26 ?
>>     
>
> It looks like we are missing some DaVinci DMA definitions for audio.
> They are not anywhere in the current HEAD or in
> include/asm-arm/arch-davinci history.
>
> Vladimir, is this something you could help with.
>
> Thanks
>
> Liam 
>
>
>   


--------------000304060603080501030802
Content-Type: text/plain;
 name="ti_davinci_dma.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ti_davinci_dma.patch"

Signed-off-by: Vladimir Barinov <vbarinov@ru.mvista.com>

Index: linux-2.6.25-rc1/arch/arm/mach-davinci/dma.c
===================================================================
--- /dev/null
+++ linux-2.6.25-rc1/arch/arm/mach-davinci/dma.c
@@ -0,0 +1,919 @@
+/*
+
+ * TI DaVinci DMA Support
+ *
+ * Copyright (C) 2006 Texas Instruments.
+ * Copyright (c) 2007, MontaVista Software, Inc. <source@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#include <asm/hardware.h>
+#include <asm/dma.h>
+
+#define DAVINCI_EDMA_DEBUG 0
+#if DAVINCI_EDMA_DEBUG
+#define DBG(x...) printk(KERN_DEBUG x)
+#else
+#define DBG(x...)
+#endif
+
+static struct davinci_dma_lch {
+	int dev_id;
+	int in_use;
+	int param_no;
+	int tcc;
+} dma_chan[EDMA_NUM_PARAMENTRY];
+
+static struct davinci_dma_lch_intr {
+	void (*callback) (int lch, u16 ch_status, void *data);
+	void *data;
+} intr_data[EDMA_NUM_DMACH];
+
+#define dma_handle_cb(lch, status)	do { \
+	if (intr_data[lch].callback) \
+		intr_data[lch].callback(lch, status, intr_data[lch].data); \
+} while (0)
+
+/*
+ * Each bit field of the elements bellow indicate the corresponding
+ * (EDMA + QDMA) channel availability on arm side events
+ */
+static unsigned int dma2arm_map[3] = {
+	0xffffffff, 0xffffffff, 0x0
+};
+
+/*
+ * Each bit field of the elements bellow indicate corresponding PARAM entry
+ * availibility on arm side events
+ */
+static unsigned int param2arm_map[] = {
+	0xffffffff, 0xffffffff, 0x0000ffff, 0xffffffff,
+};
+
+static int evtqueue_tc_map[EDMA_NUM_EVQUE][2] = {
+	/* {event queue no, TC no} */
+	{0, 0},
+	{1, 1},
+};
+
+static int evtqueue_priority_map[EDMA_NUM_EVQUE][2] = {
+	/* {event queue no, Priority} */
+	{0, 0},
+	{1, 1},
+};
+
+static unsigned int qdma2param_map[8];
+static unsigned int edma2event_map[EDMA_NUM_DMACH / 32];
+static unsigned int dma_intr_reseved[EDMA_NUM_DMACH / 32];
+static unsigned int param_entry_reserved[EDMA_NUM_PARAMENTRY / 32];
+
+static void map_edmach2evt_queue(int lch, int eventq)
+{
+	u32 reg = EDMA_DMAQNUM(lch >> 3);
+	int bit = (lch % 8) << 2;
+
+	CLEAR_REG_VAL(0x7 << bit, reg);
+	SET_REG_VAL((eventq & 0x7) << bit, reg);
+}
+
+static void map_qdmach2evt_queue(int lch, int eventq)
+{
+	u32 reg = EDMA_QDMAQNUM;
+	int bit = (lch - EDMA_NUM_DMACH) << 2;
+
+	CLEAR_REG_VAL(0x7 << bit, reg);
+	SET_REG_VAL((eventq & 0x7) << bit, reg);
+}
+
+static void map_qdmach2param(int lch, int param_no)
+{
+	u32 reg;
+
+	reg = EDMA_QCHMAP(lch - EDMA_NUM_DMACH);
+	CLEAR_REG_VAL(PAENTRY | TRWORD, reg);
+	SET_REG_VAL(((param_no & 0x1ff) << 5) | (QDMA_TRWORD << 2), reg);
+}
+
+static int reserve_param(int lch)
+{
+	int i;
+
+	/* The EDMA Channels are mapped to the first PARAM entries */
+	if (dma_is_edmach(lch)) {
+		param_reserve(lch);
+		return lch;
+	}
+
+	for (i = EDMA_NUM_DMACH; i < EDMA_NUM_PARAMENTRY; i++) {
+		if (param_is_free(i) && param_is_valid(i)) {
+			param_reserve(i);
+			return i;
+		}
+	}
+
+	/* there is no free PaRam */
+	return -EBUSY;
+}
+
+static void free_param(int param_no)
+{
+	param_free(param_no);
+}
+
+static int reserve_dma_interrupt(int lch, int tcc)
+{
+	if (dma_is_edmach(lch)) {
+		if (interrupt_is_free(lch)) {
+			interrupt_reserve(lch);
+			return lch;
+		}
+	} else if (dma_is_qdmach(lch)) {
+		int i = 0;
+
+		if (tcc != TCC_ANY) {
+			if (!interrupt_is_free(tcc))
+				return -EBUSY;
+			if (edmach_has_event(tcc))
+				return -EINVAL;
+			interrupt_reserve(tcc);
+			return tcc;
+		}
+
+		while (i < EDMA_NUM_DMACH) {
+			if (interrupt_is_free(i) && !edmach_has_event(i)) {
+				interrupt_reserve(i);
+				return i;
+			}
+			i++;
+		}
+	}
+
+	/* there is no free interrupt channels */
+	return -EBUSY;
+}
+
+static void free_dma_interrupt(int ch_irq)
+{
+	interrupt_free(ch_irq);
+}
+
+static int request_dma_interrupt(void (*callback) (int lch, u16 ch_status,
+						   void *data),
+				 void *data, int *lch, int *tcc)
+{
+	int ch_irq;
+	u32 reg, mask;
+
+	if (callback) {
+		ch_irq = reserve_dma_interrupt(*lch, *tcc);
+		if (ch_irq < 0)
+			return ch_irq;
+
+		reg = ch_irq < 32 ?  EDMA_SH_IESR(0) : EDMA_SH_IESRH(0);
+		mask = 1 << (ch_irq < 32 ? ch_irq : ch_irq - 32);
+		SET_REG_VAL(mask, reg);
+
+		dma_chan[*lch].tcc = ch_irq;
+		*tcc = ch_irq;
+		intr_data[*tcc].callback = callback;
+		intr_data[*tcc].data = data;
+	} else {
+		dma_chan[*lch].tcc = -1;
+	}
+
+	return 0;
+}
+
+/**
+ * DMA transfer completion interrupt handler
+ */
+static irqreturn_t davinci_dma_irq_handler(int irq, void *dev_id)
+{
+	if (!(dma_read(EDMA_SH_IPR(0)) || dma_read(EDMA_SH_IPRH(0))))
+		return IRQ_NONE;
+
+	while (1) {
+		u32 status_l = dma_read(EDMA_SH_IPR(0));
+		u32 status_h = dma_read(EDMA_SH_IPRH(0));
+		int lch;
+		int i;
+
+		if (!(status_l || status_h))
+			break;
+
+		lch = 0;
+		while (status_l) {
+			i = ffs(status_l);
+			lch += i;
+			/* Clear the corresponding IPR bits */
+			SET_REG_VAL(1 << (lch - 1), EDMA_SH_ICR(0));
+			dma_handle_cb(lch - 1, DMA_COMPLETE);
+			status_l >>= i;
+		}
+
+		lch = 32;
+		while (status_h) {
+			i = ffs(status_h);
+			lch += i;
+			/* Clear the corresponding IPR bits */
+			SET_REG_VAL(1 << (lch - 33), EDMA_SH_ICRH(0));
+			dma_handle_cb(lch - 1, DMA_COMPLETE);
+			status_h >>= i;
+		}
+	}
+	dma_write(0x1, EDMA_SH_IEVAL(0));
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * DMA error interrupt handler
+ */
+static irqreturn_t davinci_dma_ccerr_handler(int irq, void *dev_id)
+{
+	if (!(dma_read(EDMA_EMR) || dma_read(EDMA_EMRH) ||
+	    dma_read(EDMA_QEMR) || dma_read(EDMA_CCERR)))
+		return IRQ_NONE;
+
+	while (1) {
+		u32 status_emr = dma_read(EDMA_EMR);
+		u32 status_emrh = dma_read(EDMA_EMRH);
+		u32 status_qemr = dma_read(EDMA_QEMR);
+		u32 status_ccerr = dma_read(EDMA_CCERR);
+		int lch;
+		int i;
+
+		if (!(status_emr || status_emrh || status_qemr || status_ccerr))
+			break;
+
+		lch = 0;
+		while (status_emr) {
+			i = ffs(status_emr);
+			lch += i;
+			/* Clear the corresponding EMR bits */
+			SET_REG_VAL(1 << (lch - 1), EDMA_EMCR);
+			/* Clear any SER */
+			SET_REG_VAL(1 << (lch - 1), EDMA_SH_SECR(0));
+			dma_handle_cb(lch - 1, DMA_CC_ERROR);
+			status_emr >>= i;
+		}
+
+		lch = 32;
+		while (status_emrh) {
+			i = ffs(status_emrh);
+			lch += i;
+			/* Clear the corresponding IPR bits */
+			SET_REG_VAL(1 << (lch - 1), EDMA_EMCRH);
+			/* Clear any SER */
+			SET_REG_VAL(1 << (lch - 1), EDMA_SH_SECRH(0));
+			dma_handle_cb(lch - 1, DMA_CC_ERROR);
+			status_emrh >>= i;
+		}
+
+		lch = 0;
+		while (status_qemr) {
+			i = ffs(status_qemr);
+			lch += i;
+			/* Clear the corresponding IPR bits */
+			SET_REG_VAL(1 << (lch - 1), EDMA_QEMCR);
+			SET_REG_VAL(1 << (lch - 1), EDMA_SH_QSECR(0));
+			status_qemr >>= i;
+		}
+
+		lch = 0;
+		while (status_ccerr) {
+			i = ffs(status_ccerr);
+			lch += i;
+			/* Clear the corresponding IPR bits */
+			SET_REG_VAL(1 << (lch - 1), EDMA_CCERRCLR);
+			status_ccerr >>= i;
+		}
+	}
+	dma_write(0x1, EDMA_EEVAL);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * DMA channel request - request for the Davinci DMA channel
+ *
+ * dev_id - DMA channel number
+ *
+ * EX: DAVINCI_DMA_MCBSP_TX - For requesting a DMA MasterChannel with MCBSP_TX
+ *     event association
+ *
+ *     EDMA_DMA_CHANNEL_ANY - For requesting a DMA Master channel which does
+ *                            not has event association
+ *
+ *     DAVINCI_EDMA_PARAM_ANY - for requesting a DMA Slave Channel
+ *
+ * dev_name   - name of the dma channel in human readable format
+ * callback   - channel callback function (valied only if you are requesting
+ *              for a DMA MasterChannel)
+ * data       - private data for the channel to be requested
+ * lch        - contains the device id allocated
+ * tcc        - specifies the channel number on which the interrupt is generated
+ *              Valid for QDMA and PARAM channes
+ * eventq_no  - Event Queue no to which the channel will be associated with
+ *              (valied only if you are requesting for a DMA MasterChannel)
+ *              Values : EVENTQ_0/EVENTQ_1 for event queue 0/1.
+ *
+ * Return: zero on success or error on failure
+ */
+int davinci_request_dma(int dev_id, const char *dev_name,
+			void (*callback) (int lch, u16 ch_status, void *data),
+			void *data, int *lch, int *tcc,
+			enum dma_event_q eventq_no)
+{
+	int ret_val = 0;
+	int temp_ch = 0;
+	int i;
+	u32 reg, mask;
+
+	if (dma_is_edmach(dev_id)) {
+		*lch = dev_id;
+		temp_ch = *lch;
+
+		if (!dmach_is_valid(dev_id))
+			return -EINVAL;
+
+		if (dma_chan[dev_id].in_use)
+			return -EBUSY;
+
+		dma_chan[*lch].param_no = reserve_param(*lch);
+		if (dma_chan[*lch].param_no == -1)
+			return -EBUSY;
+
+		reg = dev_id < 32 ? EDMA_DRAE(0) : EDMA_DRAEH(0);
+		mask = 1 << (dev_id < 32 ? dev_id : dev_id - 32);
+		SET_REG_VAL(mask, reg);
+
+		ret_val = request_dma_interrupt(callback, data, lch, tcc);
+		if (ret_val)
+			return ret_val;
+
+		/* Map EDMA channel to event queue */
+		map_edmach2evt_queue(dev_id, eventq_no);
+	} else if (dma_is_qdmach(dev_id)) {
+		*lch = dev_id;
+
+		if (!dmach_is_valid(dev_id))
+			return -EINVAL;
+
+		dma_chan[*lch].param_no = reserve_param(*lch);
+		if (dma_chan[*lch].param_no == -1)
+			return -EBUSY;
+
+		temp_ch = dev_id - EDMA_NUM_DMACH;
+		qdma2param_map[temp_ch] = dma_chan[*lch].param_no;
+		temp_ch = qdma2param_map[temp_ch];
+
+		if (dma_chan[temp_ch].in_use)
+			return -EBUSY;
+
+		SET_REG_VAL(1 << (dev_id - EDMA_NUM_DMACH), EDMA_QRAE(0));
+
+		ret_val = request_dma_interrupt(callback, data, lch, tcc);
+		if (ret_val)
+			return ret_val;
+
+		/* Map QDMA channel to event queue */
+		map_qdmach2evt_queue(*lch, eventq_no);
+		/* Map QDMA channel to PaRAM Set */
+		map_qdmach2param(*lch, dma_chan[*lch].param_no);
+
+		dma_chan[temp_ch].tcc = dma_chan[*lch].tcc;
+		dma_chan[temp_ch].param_no = dma_chan[*lch].param_no;
+	} else if (dev_id == PARAM_ANY) {
+		for (i = (EDMA_NUM_DMACH + EDMA_NUM_QDMACH);
+		     i < EDMA_NUM_PARAMENTRY; i++) {
+			if (!dma_chan[i].in_use) {
+				*lch = i;
+				temp_ch = *lch;
+
+				dma_chan[*lch].param_no = reserve_param(*lch);
+				if (dma_chan[*lch].param_no == -1)
+					return -EBUSY;
+
+				dma_chan[*lch].tcc = *tcc;
+				break;
+			}
+		}
+	}
+
+	dma_chan[temp_ch].in_use = 1;
+	dma_chan[temp_ch].dev_id = *lch;
+
+	reg = EDMA_PARAM_OPT(dma_chan[temp_ch].param_no);
+	if (dma_chan[*lch].tcc != TCC_ANY) {
+		CLEAR_REG_VAL(TCC, reg);
+		SET_REG_VAL((0x3f & dma_chan[*lch].tcc) << 12, reg);
+		/* set TCINTEN bit in PARAM entry */
+		SET_REG_VAL(TCINTEN, reg);
+	} else {
+		CLEAR_REG_VAL(TCINTEN, reg);
+	}
+	/* assign the link field to no link. i.e 0xffff */
+	SET_REG_VAL(0xffff,
+		    EDMA_PARAM_LINK_BCNTRLD(dma_chan[temp_ch].param_no));
+
+	return 0;
+}
+EXPORT_SYMBOL(davinci_request_dma);
+
+void davinci_free_dma(int lch)
+{
+	u32 reg, mask;
+	int tcc;
+
+	if (dma_is_qdmach(lch))
+		lch = qdma2param_map[lch - EDMA_NUM_DMACH];
+
+	free_param(dma_chan[lch].param_no);
+
+	if (lch >= 0 && lch < (EDMA_NUM_DMACH + EDMA_NUM_QDMACH)) {
+		tcc = dma_chan[lch].tcc;
+		free_dma_interrupt(tcc);
+
+		if (lch < EDMA_NUM_DMACH) {
+			/* Clear the corresponding IPR bits */
+			reg = tcc < 32 ? EDMA_SH_ICR(0) : EDMA_SH_ICRH(0);
+			mask = 1 << (tcc < 32 ? tcc : tcc - 32);
+			SET_REG_VAL(mask, reg);
+		}
+
+		intr_data[tcc].callback = NULL;
+		intr_data[tcc].data = NULL;
+	}
+
+	dma_chan[lch].in_use = 0;
+}
+EXPORT_SYMBOL(davinci_free_dma);
+
+/**
+ * DMA source parameters setup
+ * Arguments:
+ *     lch - logical channel number
+ *     src_port - Source port address
+ *     mode - indicates wether addressing mode is fifo.
+ */
+void davinci_set_dma_src_params(int lch, u32 src_port,
+				enum address_mode mode, enum fifo_width width)
+{
+	u32 reg;
+
+	if (dma_is_qdmach(lch))
+		lch = qdma2param_map[lch - EDMA_NUM_DMACH];
+
+	if (!(lch >= 0 && lch < EDMA_NUM_PARAMENTRY))
+		return;
+
+	dma_write(src_port, EDMA_PARAM_SRC(dma_chan[lch].param_no));
+	/* set the fifo addressing mode */
+	if (mode) {
+		reg = EDMA_PARAM_OPT(dma_chan[lch].param_no);
+		/* reset SAM and FWID */
+		CLEAR_REG_VAL(SAM | EDMA_FWID, reg);
+		/* set SAM and program FWID */
+		SET_REG_VAL(mode | ((width & 0x7) << 8), reg);
+	}
+}
+EXPORT_SYMBOL(davinci_set_dma_src_params);
+
+/**
+ * DMA destination parameters setup
+ * Arguments:
+ *     lch - logical channel number or param device
+ *     dest_port - destination port address
+ *     mode - indicates wether addressing mode is fifo.
+ */
+void davinci_set_dma_dest_params(int lch, u32 dest_port,
+				 enum address_mode mode, enum fifo_width width)
+{
+	u32 reg;
+
+	if (dma_is_qdmach(lch))
+		lch = qdma2param_map[lch - EDMA_NUM_DMACH];
+
+	if (!(lch >= 0 && lch < EDMA_NUM_PARAMENTRY))
+		return;
+
+	dma_write(dest_port, EDMA_PARAM_DST(dma_chan[lch].param_no));
+	/* set the fifo addressing mode */
+	if (mode) {
+		reg = EDMA_PARAM_OPT(dma_chan[lch].param_no);
+		/* reset DAM and FWID */
+		CLEAR_REG_VAL(DAM | EDMA_FWID, reg);
+		/* set DAM and program FWID */
+		SET_REG_VAL((mode << 1) | ((width & 0x7) << 8), reg);
+	}
+}
+EXPORT_SYMBOL(davinci_set_dma_dest_params);
+
+/**
+ * DMA source index setup
+ * Arguments:
+ *     lch - logical channel number or param device
+ *     srcbidx - source B-register index
+ *     srccidx - source C-register index
+ */
+void davinci_set_dma_src_index(int lch, u16 src_bidx, u16 src_cidx)
+{
+	u32 reg;
+
+	if (dma_is_qdmach(lch))
+		lch = qdma2param_map[lch - EDMA_NUM_DMACH];
+
+	if (!(lch >= 0 && lch < EDMA_NUM_PARAMENTRY))
+		return;
+
+	reg = EDMA_PARAM_SRC_DST_BIDX(dma_chan[lch].param_no);
+	CLEAR_REG_VAL(0xffff, reg);
+	SET_REG_VAL(src_bidx, reg);
+
+	reg = EDMA_PARAM_SRC_DST_CIDX(dma_chan[lch].param_no);
+	CLEAR_REG_VAL(0xffff, reg);
+	SET_REG_VAL(src_cidx, reg);
+}
+EXPORT_SYMBOL(davinci_set_dma_src_index);
+
+/**
+ * DMA destination index setup
+ * Arguments:
+ *     lch - logical channel number or param device
+ *     srcbidx - dest B-register index
+ *     srccidx - dest C-register index
+ */
+void davinci_set_dma_dest_index(int lch, u16 dest_bidx, u16 dest_cidx)
+{
+	u32 reg;
+
+	if (dma_is_qdmach(lch))
+		lch = qdma2param_map[lch - EDMA_NUM_DMACH];
+
+	if (!(lch >= 0 && lch < EDMA_NUM_PARAMENTRY))
+		return;
+
+	reg = EDMA_PARAM_SRC_DST_BIDX(dma_chan[lch].param_no);
+	CLEAR_REG_VAL(0xffff0000, reg);
+	SET_REG_VAL((u32)dest_bidx << 16, reg);
+
+	reg = EDMA_PARAM_SRC_DST_CIDX(dma_chan[lch].param_no);
+	CLEAR_REG_VAL(0xffff0000, reg);
+	SET_REG_VAL((u32)dest_cidx << 16, reg);
+}
+EXPORT_SYMBOL(davinci_set_dma_dest_index);
+
+/**
+ * DMA transfer parameters setup
+ * Arguments:
+ *     lch - logical channel number or param device
+ *     acnt - acnt register value to be configured
+ *     bcnt - bcnt register value to be configured
+ *     ccnt - ccnt register value to be configured
+ */
+void davinci_set_dma_transfer_params(int lch, u16 acnt, u16 bcnt, u16 ccnt,
+				     u16 bcntrld, enum sync_dimension sync_mode)
+{
+	u32 reg;
+
+	if (dma_is_qdmach(lch))
+		lch = qdma2param_map[lch - EDMA_NUM_DMACH];
+
+	if (!(lch >= 0 && lch < EDMA_NUM_PARAMENTRY))
+		return;
+
+	reg = EDMA_PARAM_LINK_BCNTRLD(dma_chan[lch].param_no);
+	CLEAR_REG_VAL(0xffff0000, reg);
+	SET_REG_VAL((u32)bcntrld << 16, reg);
+
+	reg = EDMA_PARAM_OPT(dma_chan[lch].param_no);
+	if (sync_mode == ASYNC)
+		CLEAR_REG_VAL(SYNCDIM, reg);
+	else
+		SET_REG_VAL(SYNCDIM, reg);
+
+	/* Set the acount, bcount, ccount registers */
+	dma_write(((u32)bcnt << 16) | acnt,
+		  EDMA_PARAM_A_B_CNT(dma_chan[lch].param_no));
+	dma_write(ccnt, EDMA_PARAM_CCNT(dma_chan[lch].param_no));
+}
+EXPORT_SYMBOL(davinci_set_dma_transfer_params);
+
+void davinci_set_dma_params(int lch, struct paramentry_descriptor *d)
+{
+	if (dma_is_qdmach(lch))
+		lch = qdma2param_map[lch - EDMA_NUM_DMACH];
+
+	if (!(lch >= 0 && lch < EDMA_NUM_PARAMENTRY))
+		return;
+
+	dma_write(d->opt, EDMA_PARAM_OPT(dma_chan[lch].param_no));
+	dma_write(d->src, EDMA_PARAM_SRC(dma_chan[lch].param_no));
+	dma_write(d->a_b_cnt, EDMA_PARAM_A_B_CNT(dma_chan[lch].param_no));
+	dma_write(d->dst, EDMA_PARAM_DST(dma_chan[lch].param_no));
+	dma_write(d->src_dst_bidx,
+		      EDMA_PARAM_SRC_DST_BIDX(dma_chan[lch].param_no));
+	dma_write(d->link_bcntrld,
+		      EDMA_PARAM_LINK_BCNTRLD(dma_chan[lch].param_no));
+	dma_write(d->src_dst_cidx,
+		      EDMA_PARAM_SRC_DST_CIDX(dma_chan[lch].param_no));
+	dma_write(d->ccnt, EDMA_PARAM_CCNT(dma_chan[lch].param_no));
+}
+EXPORT_SYMBOL(davinci_set_dma_params);
+
+void davinci_get_dma_params(int lch, struct paramentry_descriptor *d)
+{
+	if (dma_is_qdmach(lch))
+		lch = qdma2param_map[lch - EDMA_NUM_DMACH];
+
+	if (!(lch >= 0 && lch < EDMA_NUM_PARAMENTRY))
+		return;
+
+	d->opt = dma_read(EDMA_PARAM_OPT(dma_chan[lch].param_no));
+	d->src = dma_read(EDMA_PARAM_SRC(dma_chan[lch].param_no));
+	d->a_b_cnt = dma_read(EDMA_PARAM_A_B_CNT(dma_chan[lch].param_no));
+	d->dst = dma_read(EDMA_PARAM_DST(dma_chan[lch].param_no));
+	d->src_dst_bidx =
+	    dma_read(EDMA_PARAM_SRC_DST_BIDX(dma_chan[lch].param_no));
+	d->link_bcntrld =
+	    dma_read(EDMA_PARAM_LINK_BCNTRLD(dma_chan[lch].param_no));
+	d->src_dst_cidx =
+	    dma_read(EDMA_PARAM_SRC_DST_CIDX(dma_chan[lch].param_no));
+	d->ccnt = dma_read(EDMA_PARAM_CCNT(dma_chan[lch].param_no));
+}
+EXPORT_SYMBOL(davinci_get_dma_params);
+
+/**
+ * DMA start - starts the dma on the channel passed
+ * Arguments:
+ *     lch - logical channel number
+ */
+int davinci_start_dma(int lch)
+{
+	int ret = 0;
+	u32 mask;
+
+	if (dma_is_edmach(lch)) {
+		/* Check is EDMA channel with event association */
+		if (!edmach_has_event(lch)) {
+			DBG("ESR=%x\n", dma_read(EDMA_SH_ESR(0)));
+
+			if (lch < 32)
+				SET_REG_VAL(1 << lch, EDMA_SH_ESR(0));
+			else
+				SET_REG_VAL(1 << (lch - 32), EDMA_SH_ESRH(0));
+
+			return ret;
+		}
+
+		DBG("ER=%d\n", dma_read(EDMA_SH_ER(0)));
+		if (lch < 32) {
+			mask = 1 << lch;
+			/* Clear any pedning error */
+			SET_REG_VAL(mask, EDMA_EMCR);
+			/* Clear any SER */
+			SET_REG_VAL(mask, EDMA_SH_SECR(0));
+			SET_REG_VAL(mask, EDMA_SH_EESR(0));
+		} else {
+			mask = 1 << (lch - 32);
+			/* Clear any pedning error */
+			SET_REG_VAL(mask, EDMA_EMCRH);
+			/* Clear any SER */
+			SET_REG_VAL(mask, EDMA_SH_SECRH(0));
+			SET_REG_VAL(mask, EDMA_SH_EESRH(0));
+		}
+		DBG("EER=%d\n", dma_read(EDMA_SH_EER(0)));
+	} else if (dma_is_qdmach(lch)) {
+		SET_REG_VAL(1 << (lch - EDMA_NUM_DMACH), EDMA_SH_QEESR(0));
+	} else {
+		/* for Slave Channels */
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(davinci_start_dma);
+
+/**
+ * DMA stop - stops the dma on the channel passed
+ * Arguments:
+ *     lch - logical channel number
+ */
+void davinci_stop_dma(int lch)
+{
+	u32 reg, mask;
+
+	if (lch < EDMA_NUM_DMACH) {
+		/* Check is EDMA channel with event association */
+		if (!edmach_has_event(lch))
+			return;
+
+		if (lch < 32) {
+			reg = EDMA_SH_EECR(0);
+			mask = 1 << lch;
+			CLEAR_EVENT(mask, EDMA_SH_ER(0), EDMA_SH_ECR(0));
+			CLEAR_EVENT(mask, EDMA_SH_SER(0), EDMA_SH_SECR(0));
+			CLEAR_EVENT(mask, EDMA_EMR, EDMA_EMCR);
+		} else {
+			reg = EDMA_SH_EECRH(0);
+			mask = 1 << (lch - 32);
+			CLEAR_EVENT(mask, EDMA_SH_ERH(0), EDMA_SH_ECRH(0));
+			CLEAR_EVENT(mask, EDMA_SH_SERH(0), EDMA_SH_SECRH(0));
+			CLEAR_EVENT(mask, EDMA_EMRH, EDMA_EMCRH);
+		}
+		SET_REG_VAL(mask, reg);
+		DBG("EER=%d\n", dma_read(EDMA_SH_EER(0)));
+	} else if (dma_is_qdmach(lch)) {
+		/* for QDMA channels */
+		SET_REG_VAL(1 << (lch - EDMA_NUM_DMACH), EDMA_QEECR);
+		DBG("QER=%d\n", dma_read(EDMA_QER));
+		DBG("QEER=%d\n", dma_read(EDMA_QEER));
+	} else if ((lch >= (EDMA_NUM_DMACH + EDMA_NUM_QDMACH)) &&
+		   lch < EDMA_NUM_PARAMENTRY) {
+		/* for slaveChannels */
+		CLEAR_REG_VAL(0xffff, EDMA_PARAM_LINK_BCNTRLD(lch));
+		SET_REG_VAL(0xffff, EDMA_PARAM_LINK_BCNTRLD(lch));
+	}
+}
+EXPORT_SYMBOL(davinci_stop_dma);
+
+/**
+ * DMA channel link - link the two logical channels passed through by linking
+ *                    the link field of head to the param pointed by the
+ *                    lch_queue.
+ * Arguments:
+ *     lch_head  - logical channel number, in which the link field is linked
+ *                 to the param pointed to by lch_queue
+ *     lch_queue - logical channel number or the param entry number, which is
+ *                 to be linked to the lch_head
+ */
+void davinci_dma_link_lch(int lch_head, int lch_queue)
+{
+	u16 link;
+	u32 reg;
+
+	if (dma_is_qdmach(lch_head))
+		lch_head = qdma2param_map[lch_head - EDMA_NUM_DMACH];
+
+	if (dma_is_qdmach(lch_queue))
+		lch_queue = qdma2param_map[lch_queue - EDMA_NUM_DMACH];
+
+	if ((lch_head >= 0 && lch_head < EDMA_NUM_PARAMENTRY) &&
+	    (lch_queue >= 0 && lch_queue < EDMA_NUM_PARAMENTRY)) {
+		/* program LINK */
+		link = (u16)
+		       IO_ADDRESS(EDMA_PARAM_OPT(dma_chan[lch_queue].param_no));
+		reg = EDMA_PARAM_LINK_BCNTRLD(dma_chan[lch_head].param_no);
+		CLEAR_REG_VAL(0xffff, reg);
+		SET_REG_VAL(link, reg);
+	}
+}
+EXPORT_SYMBOL(davinci_dma_link_lch);
+
+/**
+ * DMA channel unlink - unlink the two logical channels passed through by
+ *                      setting the link field of head to 0xffff.
+ * Arguments:
+ *     lch_head - logical channel number, from which the link field is
+ *                to be removed
+ *     lch_queue - logical channel number or the param entry number,
+ *                 which is to be unlinked from lch_head
+ */
+void davinci_dma_unlink_lch(int lch_head, int lch_queue)
+{
+	u32 reg;
+
+	if (dma_is_qdmach(lch_head))
+		lch_head = qdma2param_map[lch_head - EDMA_NUM_DMACH];
+
+	if (dma_is_qdmach(lch_queue))
+		lch_queue = qdma2param_map[lch_queue - EDMA_NUM_DMACH];
+
+	if ((lch_head >= 0 && lch_head < EDMA_NUM_PARAMENTRY) &&
+	    (lch_queue >= 0 && lch_queue < EDMA_NUM_PARAMENTRY)) {
+		reg = EDMA_PARAM_LINK_BCNTRLD(dma_chan[lch_head].param_no);
+		SET_REG_VAL(0xffff, reg);
+	}
+}
+EXPORT_SYMBOL(davinci_dma_unlink_lch);
+
+/**
+ * DMA clean channel - cleans Paramentry and bring back EDMA to initial state
+ * if media has been removed before EDMA has finished. It is usedful for
+ * removable media.
+ * Arguments:
+ *     lch - logical channel number
+ */
+void davinci_clean_channel(int lch)
+{
+	u32 mask;
+
+	if (lch < 32) {
+		DBG("EMR =%d\n", dma_read(EDMA_EMR));
+		mask = 1 << lch;
+		SET_REG_VAL(mask, EDMA_SH_ECR(0));
+		/* Clear the corresponding EMR bits */
+		SET_REG_VAL(mask, EDMA_EMCR);
+		/* Clear any SER */
+		SET_REG_VAL(mask, EDMA_SH_SECR(0));
+	} else {
+		DBG("EMRH =%d\n", dma_read(EDMA_EMRH));
+		mask = 1 << (lch - 32);
+		SET_REG_VAL(mask, EDMA_SH_ECRH(0));
+		/* Clear the corresponding EMRH bits */
+		SET_REG_VAL(mask, EDMA_EMCRH);
+		/* Clear any SER */
+		SET_REG_VAL(mask, EDMA_SH_SECRH(0));
+	}
+
+	SET_REG_VAL((1 << 16) | 0x3, EDMA_CCERRCLR);
+}
+EXPORT_SYMBOL(davinci_clean_channel);
+
+/**
+ * DMA transfer position - returns the current transfer points for the dma
+ * source and destination
+ * Arguments:
+ *     lch - logical channel number
+ *     src - source port position
+ *     dst - destination port position
+ */
+void davinci_dma_getposition(int lch, dma_addr_t *src, dma_addr_t *dst)
+{
+	struct paramentry_descriptor temp;
+
+	davinci_get_dma_params(lch, &temp);
+	if (src != NULL)
+		*src = temp.src;
+	if (dst != NULL)
+		*dst = temp.dst;
+}
+EXPORT_SYMBOL(davinci_dma_getposition);
+
+static int __init davinci_dma_init(void)
+{
+	int i, ret;
+	u32 mask;
+
+	DBG("DMA BASE ADDR=%x\n", (unsigned int)IO_ADDRESS(EDMA_BASE));
+
+	memset((void *)IO_ADDRESS(EDMA_PARAM_OPT(0)), 0x00, EDMA_PARAM_SIZE);
+
+	/* Event queue to TC mapping */
+	for (i = 0; i < EDMA_NUM_EVQUE; i++) {
+		mask = evtqueue_tc_map[i][0] << 2;
+		CLEAR_REG_VAL(0x7 << mask, EDMA_QUETCMAP);
+		mask = (evtqueue_tc_map[i][1] & 0x7) << mask;
+		SET_REG_VAL(mask, EDMA_QUETCMAP);
+	}
+
+	/* Assign priority to event queue */
+	for (i = 0; i < EDMA_NUM_EVQUE; i++) {
+		mask = evtqueue_priority_map[i][0] << 2;
+		CLEAR_REG_VAL(0x7 << mask, EDMA_QUEPRI);
+		mask = (evtqueue_priority_map[i][1] & 0x7) << mask;
+		SET_REG_VAL(mask, EDMA_QUEPRI);
+	}
+
+	for (i = 0; i < EDMA_NUM_REGIONS; i++) {
+		dma_write(0x0, EDMA_DRAE(i));
+		dma_write(0x0, EDMA_DRAEH(i));
+		dma_write(0x0, EDMA_QRAE(i));
+	}
+
+	ret = request_irq(IRQ_CCINT0, davinci_dma_irq_handler, 0, "EDMA", NULL);
+	if (ret) {
+		printk(KERN_ERR "unable to request IRQ %d for DMA (error %d)\n",
+		       IRQ_CCINT0, ret);
+		DBG("request_irq failed\n");
+		return ret;
+	}
+
+	ret = request_irq(IRQ_CCERRINT, davinci_dma_ccerr_handler, 0,
+			  "EDMA CC Err", NULL);
+	if (ret) {
+		printk(KERN_ERR "unable to request IRQ %d for DMA (error %d)\n",
+		       IRQ_CCERRINT, ret);
+		free_irq(IRQ_CCINT0, NULL);
+		return ret;
+	}
+
+	/* TODO: add cpu_is_xxx() check for different Davinci SoCs */
+	edma2event_map[0] = DM644X_DMACH2EVENT_MAP0;
+	edma2event_map[1] = DM644X_DMACH2EVENT_MAP1;
+
+	return 0;
+}
+
+arch_initcall(davinci_dma_init);
Index: linux-2.6.25-rc1/include/asm-arm/arch-davinci/edma.h
===================================================================
--- /dev/null
+++ linux-2.6.25-rc1/include/asm-arm/arch-davinci/edma.h
@@ -0,0 +1,370 @@
+/*
+ * TI DaVinci DMA Support
+ *
+ * Copyright (C) 2006 Texas Instruments.
+ * Copyright (c) 2007, MontaVista Software, Inc. <source@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef __ASM_ARCH_EDMA_H
+#define __ASM_ARCH_EDMA_H
+
+#include <asm/arch/hardware.h>
+
+/*
+ * DMA driver for DaVinci
+ * DMA driver for Davinci abstractes each ParamEntry as a Logical DMA channel
+ * for the user.So on Davinci the user can request 128 DAM channels
+ *
+ * Actual Physical DMA channels = 64 EDMA channels + 8 QDMA channels
+ *
+ * On davinci user can request for two kinds of Logical DMA channels
+ * DMA MasterChannel -> ParamEntry which is associated with a DMA channel.
+ *                      On Davinci there are (64 + 8) MasterChanneles
+ *                      MasterChannel can be triggered by an event or manually
+ *
+ * DMA SlaveChannel  -> ParamEntry which is not associated with DMA cahnnel but
+ *                      which can be used to associate with MasterChannel.
+ *                      On Davinci there are (128-(64 + 8)) SlaveChannels
+ *                      SlaveChannel can only be triggered by a MasterChannel
+ */
+
+#define EDMA_BASE		DAVINCI_DMA_3PCC_BASE
+
+#define EDMA_REV		(EDMA_BASE + 0x0000)
+#define EDMA_CCCFG		(EDMA_BASE + 0x0004)
+#define EDMA_QCHMAP(n)		(EDMA_BASE + 0x0200 + ((n) << 2))
+#define EDMA_DMAQNUM(n)		(EDMA_BASE + 0x0240 + ((n) << 2))
+#define EDMA_QDMAQNUM		(EDMA_BASE + 0x0260)
+#define EDMA_QUETCMAP		(EDMA_BASE + 0x0280)
+#define EDMA_QUEPRI		(EDMA_BASE + 0x0284)
+#define EDMA_EMR		(EDMA_BASE + 0x0300)
+#define EDMA_EMRH		(EDMA_BASE + 0x0304)
+#define EDMA_EMCR		(EDMA_BASE + 0x0308)
+#define EDMA_EMCRH		(EDMA_BASE + 0x030C)
+#define EDMA_QEMR		(EDMA_BASE + 0x0310)
+#define EDMA_QEMCR		(EDMA_BASE + 0x0314)
+#define EDMA_CCERR		(EDMA_BASE + 0x0318)
+#define EDMA_CCERRCLR		(EDMA_BASE + 0x031C)
+#define EDMA_EEVAL		(EDMA_BASE + 0x0320)
+#define EDMA_DRAE(n)		(EDMA_BASE + 0x0340 + ((n) << 3))
+#define EDMA_DRAEH(n)		(EDMA_BASE + 0x0344 + ((n) << 3))
+#define EDMA_QRAE(n)		(EDMA_BASE + 0x0380 + ((n) << 2))
+#define EDMA_QEE0(n)		(EDMA_BASE + 0x0400 + ((n) << 2))
+#define EDMA_QEE1(n)		(EDMA_BASE + 0x0440 + ((n) << 2))
+#define EDMA_QSTAT0		(EDMA_BASE + 0x0600)
+#define EDMA_QSTAT1		(EDMA_BASE + 0x0604)
+#define EDMA_QWMTHRA		(EDMA_BASE + 0x0620)
+#define EDMA_QWMTHRB		(EDMA_BASE + 0x0624)
+#define EDMA_CCSTAT		(EDMA_BASE + 0x0640)
+#define EDMA_AETCTL		(EDMA_BASE + 0x0700)
+#define EDMA_AETSTAT		(EDMA_BASE + 0x0704)
+#define EDMA_AETCMD		(EDMA_BASE + 0x0708)
+#define EDMA_ER			(EDMA_BASE + 0x1000)
+#define EDMA_ERH		(EDMA_BASE + 0x1004)
+#define EDMA_ECR		(EDMA_BASE + 0x1008)
+#define EDMA_ECRH		(EDMA_BASE + 0x100C)
+#define EDMA_ESR		(EDMA_BASE + 0x1010)
+#define EDMA_ESRH		(EDMA_BASE + 0x1014)
+#define EDMA_CER		(EDMA_BASE + 0x1018)
+#define EDMA_CERH		(EDMA_BASE + 0x101C)
+#define EDMA_EER		(EDMA_BASE + 0x1020)
+#define EDMA_EERH		(EDMA_BASE + 0x1024)
+#define EDMA_EECR		(EDMA_BASE + 0x1028)
+#define EDMA_EECRH		(EDMA_BASE + 0x102C)
+#define EDMA_EESR		(EDMA_BASE + 0x1030)
+#define EDMA_EESRH		(EDMA_BASE + 0x1034)
+#define EDMA_SER		(EDMA_BASE + 0x1038)
+#define EDMA_SERH		(EDMA_BASE + 0x103C)
+#define EDMA_SECR		(EDMA_BASE + 0x1040)
+#define EDMA_SECRH		(EDMA_BASE + 0x1044)
+#define EDMA_IER		(EDMA_BASE + 0x1050)
+#define EDMA_IERH		(EDMA_BASE + 0x1054)
+#define EDMA_IECR		(EDMA_BASE + 0x1058)
+#define EDMA_IECRH		(EDMA_BASE + 0x105C)
+#define EDMA_IESR		(EDMA_BASE + 0x1060)
+#define EDMA_IESRH		(EDMA_BASE + 0x1064)
+#define EDMA_IPR		(EDMA_BASE + 0x1068)
+#define EDMA_IPRH		(EDMA_BASE + 0x106C)
+#define EDMA_ICR		(EDMA_BASE + 0x1070)
+#define EDMA_ICRH		(EDMA_BASE + 0x1074)
+#define EDMA_IEVAL		(EDMA_BASE + 0x1078)
+#define EDMA_QER		(EDMA_BASE + 0x1080)
+#define EDMA_QEER		(EDMA_BASE + 0x1084)
+#define EDMA_QEECR		(EDMA_BASE + 0x1088)
+#define EDMA_QEESR		(EDMA_BASE + 0x108C)
+#define EDMA_QSER		(EDMA_BASE + 0x1090)
+#define EDMA_QSECR		(EDMA_BASE + 0x1094)
+
+/* Shadow Registers */
+#define EDMA_SHADOW_BASE	(EDMA_BASE + 0x2000)
+#define EDMA_SHADOW(offset, n)	(EDMA_SHADOW_BASE + offset + (n << 9))
+
+#define EDMA_SH_ER(n)		EDMA_SHADOW(0x00, n)
+#define EDMA_SH_ERH(n)		EDMA_SHADOW(0x04, n)
+#define EDMA_SH_ECR(n)		EDMA_SHADOW(0x08, n)
+#define EDMA_SH_ECRH(n)		EDMA_SHADOW(0x0C, n)
+#define EDMA_SH_ESR(n)		EDMA_SHADOW(0x10, n)
+#define EDMA_SH_ESRH(n)		EDMA_SHADOW(0x14, n)
+#define EDMA_SH_CER(n)		EDMA_SHADOW(0x18, n)
+#define EDMA_SH_CERH(n)		EDMA_SHADOW(0x1C, n)
+#define EDMA_SH_EER(n)		EDMA_SHADOW(0x20, n)
+#define EDMA_SH_EERH(n)		EDMA_SHADOW(0x24, n)
+#define EDMA_SH_EECR(n)		EDMA_SHADOW(0x28, n)
+#define EDMA_SH_EECRH(n)	EDMA_SHADOW(0x2C, n)
+#define EDMA_SH_EESR(n)		EDMA_SHADOW(0x30, n)
+#define EDMA_SH_EESRH(n)	EDMA_SHADOW(0x34, n)
+#define EDMA_SH_SER(n)		EDMA_SHADOW(0x38, n)
+#define EDMA_SH_SERH(n)		EDMA_SHADOW(0x3C, n)
+#define EDMA_SH_SECR(n)		EDMA_SHADOW(0x40, n)
+#define EDMA_SH_SECRH(n)	EDMA_SHADOW(0x44, n)
+#define EDMA_SH_IER(n)		EDMA_SHADOW(0x50, n)
+#define EDMA_SH_IERH(n)		EDMA_SHADOW(0x54, n)
+#define EDMA_SH_IECR(n)		EDMA_SHADOW(0x58, n)
+#define EDMA_SH_IECRH(n)	EDMA_SHADOW(0x5C, n)
+#define EDMA_SH_IESR(n)		EDMA_SHADOW(0x60, n)
+#define EDMA_SH_IESRH(n)	EDMA_SHADOW(0x64, n)
+#define EDMA_SH_IPR(n)		EDMA_SHADOW(0x68, n)
+#define EDMA_SH_IPRH(n)		EDMA_SHADOW(0x6C, n)
+#define EDMA_SH_ICR(n)		EDMA_SHADOW(0x70, n)
+#define EDMA_SH_ICRH(n)		EDMA_SHADOW(0x74, n)
+#define EDMA_SH_IEVAL(n)	EDMA_SHADOW(0x78, n)
+#define EDMA_SH_QER(n)		EDMA_SHADOW(0x80, n)
+#define EDMA_SH_QEER(n)		EDMA_SHADOW(0x84, n)
+#define EDMA_SH_QEECR(n)	EDMA_SHADOW(0x88, n)
+#define EDMA_SH_QEESR(n)	EDMA_SHADOW(0x8C, n)
+#define EDMA_SH_QSER(n)		EDMA_SHADOW(0x90, n)
+#define EDMA_SH_QSECR(n)	EDMA_SHADOW(0x94, n)
+
+/* Paramentry Registers */
+#define EDMA_PARAM_BASE			(EDMA_BASE + 0x4000)
+#define EDMA_PARAM_SIZE			0x1000
+#define EDMA_PARAM(offset, n)		(EDMA_PARAM_BASE + offset + (n << 5))
+
+#define EDMA_PARAM_OPT(n)		EDMA_PARAM(0x00, n)
+#define EDMA_PARAM_SRC(n)		EDMA_PARAM(0x04, n)
+#define EDMA_PARAM_A_B_CNT(n)		EDMA_PARAM(0x08, n)
+#define EDMA_PARAM_DST(n)		EDMA_PARAM(0x0C, n)
+#define EDMA_PARAM_SRC_DST_BIDX(n)	EDMA_PARAM(0x10, n)
+#define EDMA_PARAM_LINK_BCNTRLD(n)	EDMA_PARAM(0x14, n)
+#define EDMA_PARAM_SRC_DST_CIDX(n)	EDMA_PARAM(0x18, n)
+#define EDMA_PARAM_CCNT(n)		EDMA_PARAM(0x1C, n)
+
+/*
+ * Paramentry descriptor
+ */
+struct paramentry_descriptor {
+	unsigned int opt;
+	unsigned int src;
+	unsigned int a_b_cnt;
+	unsigned int dst;
+	unsigned int src_dst_bidx;
+	unsigned int link_bcntrld;
+	unsigned int src_dst_cidx;
+	unsigned int ccnt;
+};
+
+
+#define dma_write(val, addr)	davinci_writel(val, addr)
+#define dma_read(addr)		davinci_readl(addr)
+
+#define SET_REG_VAL(mask, reg) do { \
+	dma_write(dma_read(reg) | (mask), reg); \
+} while (0)
+
+#define CLEAR_REG_VAL(mask, reg) do { \
+	dma_write(dma_read(reg) & ~(mask), reg); \
+} while (0)
+
+#define CLEAR_EVENT(mask, event, reg) do { \
+	if (dma_read(event) & mask) \
+		SET_REG_VAL(mask, reg);	\
+} while (0)
+
+
+#define EDMA_XFER_COMPLETION_INT	IRQ_CCINT0
+#define EDMA_CC_ERROR_INT		IRQ_CCERRINT
+#define EDMA_TC0_ERROR_INT		IRQ_TCERRINT0
+#define EDMA_TC1_ERROR_INT		IRQ_TCERRINT
+
+#define SAM		(1 << 0)
+#define DAM		(1 << 1)
+#define SYNCDIM		(1 << 2)
+#define STATIC		(1 << 3)
+#define EDMA_FWID	(0x7 << 8)
+#define TCCMODE		(0x1 << 11)
+#define TCC		(0x3f << 12)
+#define WIMODE		(0x1 << 19)
+#define TCINTEN		(1 << 20)
+#define ITCINTEN	(1 << 21)
+#define TCCHEN		(1 << 22)
+#define ITCCHEN		(1 << 23)
+#define SECURE		(1 << 30)
+#define PRIV		(1 << 31)
+
+#define TRWORD		(0x7 << 2)
+#define PAENTRY		(0x1ff << 5)
+/* if changing the QDMA_TRWORD do appropriate change in davinci_start_dma */
+#define QDMA_TRWORD	(7 & 0x7)
+
+#define EDMA_NUM_DMACH		64
+#define EDMA_NUM_QDMACH		8
+#define dma_is_edmach(lch)	((lch >= 0) && (lch < EDMA_NUM_DMACH))
+#define dma_is_qdmach(lch)	((lch >= EDMA_NUM_DMACH) && \
+				 (lch < (EDMA_NUM_DMACH + EDMA_NUM_QDMACH)))
+
+#define EDMA_NUM_PARAMENTRY	128
+#define EDMA_NUM_EVQUE		2
+#define EDMA_NUM_REGIONS	4
+
+#define TCC_ANY			-1
+#define DMACH_ANY		-1
+#define PARAM_ANY		-2
+
+
+#define edmach_has_event(lch)	(edma2event_map[lch >> 5] & (1 << (lch % 32)))
+
+#define dmach_is_valid(lch)	(dma2arm_map[lch >> 5] & (1 << (lch % 32)))
+#define param_is_valid(lch)	(param2arm_map[lch >> 5] & (1 << (lch % 32)))
+
+#define param_reserve(lch)	do { \
+	param_entry_reserved[lch >> 5] |= (1 << (lch % 32)); \
+} while (0)
+#define param_free(lch)		do { \
+	param_entry_reserved[lch >> 5] &= ~(1 << (lch % 32)); \
+} while (0)
+#define param_is_free(lch)	\
+	(!(param_entry_reserved[lch >> 5] & (1 << (lch % 32))))
+
+#define interrupt_reserve(lch)	do { \
+	dma_intr_reseved[lch >> 5] |= (1 << (lch % 32));\
+} while (0)
+#define interrupt_free(lch)	do { \
+	dma_intr_reseved[lch >> 5] &= ~(1 << (lch % 32)); \
+} while (0)
+#define interrupt_is_free(lch)	\
+	(!(dma_intr_reseved[lch >> 5] & (1 << (lch % 32))))
+
+#define DM644X_DMACH2EVENT_MAP0	0x3DFF0FFC
+#define DM644X_DMACH2EVENT_MAP1	0x007F1FFF
+
+enum dm644x_edma_ch {
+	DM644X_DMACH_MCBSP_TX = 2,
+	DM644X_DMACH_MCBSP_RX,
+	DM644X_DMACH_VPSS_HIST,
+	DM644X_DMACH_VPSS_H3A,
+	DM644X_DMACH_VPSS_PRVU,
+	DM644X_DMACH_VPSS_RSZ,
+	DM644X_DMACH_IMCOP_IMXINT,
+	DM644X_DMACH_IMCOP_VLCDINT,
+	DM644X_DMACH_IMCO_PASQINT,
+	DM644X_DMACH_IMCOP_DSQINT,
+	DM644X_DMACH_SPI_SPIX = 16,
+	DM644X_DMACH_SPI_SPIR,
+	DM644X_DMACH_UART0_URXEVT0,
+	DM644X_DMACH_UART0_UTXEVT0,
+	DM644X_DMACH_UART1_URXEVT1,
+	DM644X_DMACH_UART1_UTXEVT1,
+	DM644X_DMACH_UART2_URXEVT2,
+	DM644X_DMACH_UART2_UTXEVT2,
+	DM644X_DMACH_MEMSTK_MSEVT,
+	DM644X_DMACH_MMCRXEVT = 26,
+	DM644X_DMACH_MMCTXEVT,
+	DM644X_DMACH_I2C_ICREVT,
+	DM644X_DMACH_I2C_ICXEVT,
+	DM644X_DMACH_GPIO_GPINT0 = 32,
+	DM644X_DMACH_GPIO_GPINT1,
+	DM644X_DMACH_GPIO_GPINT2,
+	DM644X_DMACH_GPIO_GPINT3,
+	DM644X_DMACH_GPIO_GPINT4,
+	DM644X_DMACH_GPIO_GPINT5,
+	DM644X_DMACH_GPIO_GPINT6,
+	DM644X_DMACH_GPIO_GPINT7,
+	DM644X_DMACH_GPIO_GPBNKINT0,
+	DM644X_DMACH_GPIO_GPBNKINT1,
+	DM644X_DMACH_GPIO_GPBNKINT2,
+	DM644X_DMACH_GPIO_GPBNKINT3,
+	DM644X_DMACH_GPIO_GPBNKINT4,
+	DM644X_DMACH_TIMER0_TINT0 = 48,
+	DM644X_DMACH_TIMER1_TINT1,
+	DM644X_DMACH_TIMER2_TINT2,
+	DM644X_DMACH_TIMER3_TINT3,
+	DM644X_DMACH_PWM0,
+	DM644X_DMACH_PWM1,
+	DM644X_DMACH_PWM2,
+};
+
+enum dm644x_qdma_ch {
+	QDMACH0 = EDMA_NUM_DMACH,
+	QDMACH1,
+	QDMACH2,
+	QDMACH3,
+	QDMACH4,
+	QDMACH5,
+	QDMACH6 = 71,
+	QDMACH7
+};
+
+/* ch_status paramater of callback function possible values */
+enum edma_status {
+	DMA_COMPLETE = 1,
+	DMA_CC_ERROR,
+	DMA_TC1_ERROR,
+	DMA_TC2_ERROR
+};
+
+enum address_mode {
+	INCR = 0,
+	FIFO = 1
+};
+
+enum fifo_width {
+	W8BIT = 0,
+	W16BIT = 1,
+	W32BIT = 2,
+	W64BIT = 3,
+	W128BIT = 4,
+	W256BIT = 5
+};
+
+enum dma_event_q {
+	EVENTQ_0 = 0,
+	EVENTQ_1 = 1,
+	EVENTQ_DEFAULT = -1
+};
+
+enum sync_dimension {
+	ASYNC = 0,
+	ABSYNC = 1
+};
+
+int davinci_request_dma(int dev_id,
+			const char *dev_name,
+			void (*callback) (int lch, unsigned short ch_status,
+					  void *data), void *data, int *lch,
+			int *tcc, enum dma_event_q
+);
+void davinci_set_dma_src_params(int lch, u32 src_port,
+				enum address_mode mode, enum fifo_width);
+void davinci_set_dma_dest_params(int lch, u32 dest_port,
+				 enum address_mode mode, enum fifo_width);
+void davinci_set_dma_src_index(int lch, u16 srcbidx, u16 srccidx);
+void davinci_set_dma_dest_index(int lch, u16 destbidx, u16 destcidx);
+void davinci_set_dma_transfer_params(int lch, u16 acnt, u16 bcnt, u16 ccnt,
+				     u16 bcntrld,
+				     enum sync_dimension sync_mode);
+void davinci_set_dma_params(int lch, struct paramentry_descriptor *d);
+void davinci_get_dma_params(int lch, struct paramentry_descriptor *d);
+int davinci_start_dma(int lch);
+void davinci_stop_dma(int lch);
+void davinci_dma_link_lch(int lch_head, int lch_queue);
+void davinci_dma_unlink_lch(int lch_head, int lch_queue);
+void davinci_free_dma(int lch);
+void davinci_dma_getposition(int lch, dma_addr_t *src, dma_addr_t *dst);
+
+#endif		/* __ASM_ARCH_EDMA_H */
Index: linux-2.6.25-rc1/arch/arm/mach-davinci/Makefile
===================================================================
--- linux-2.6.25-rc1.orig/arch/arm/mach-davinci/Makefile
+++ linux-2.6.25-rc1/arch/arm/mach-davinci/Makefile
@@ -5,7 +5,7 @@
 
 # Common objects
 obj-y 			:= time.o irq.o clock.o serial.o io.o id.o psc.o \
-			   gpio.o mux.o mux_cfg.o devices.o
+			   gpio.o mux.o mux_cfg.o devices.o dma.o
 
 # Board specific
 obj-$(CONFIG_MACH_DAVINCI_EVM)  += board-evm.o
Index: linux-2.6.25-rc1/include/asm-arm/arch-davinci/dma.h
===================================================================
--- linux-2.6.25-rc1.orig/include/asm-arm/arch-davinci/dma.h
+++ linux-2.6.25-rc1/include/asm-arm/arch-davinci/dma.h
@@ -13,4 +13,6 @@
 
 #define MAX_DMA_ADDRESS			0xffffffff
 
+#include "edma.h"
+
 #endif /* __ASM_ARCH_DMA_H */

--------------000304060603080501030802
Content-Type: text/plain;
 name="davinci_i2c_quick_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="davinci_i2c_quick_fix.patch"

Index: linux-2.6.24.rc8.alsa/drivers/i2c/busses/i2c-davinci.c
===================================================================
--- linux-2.6.24.rc8.alsa.orig/drivers/i2c/busses/i2c-davinci.c
+++ linux-2.6.24.rc8.alsa/drivers/i2c/busses/i2c-davinci.c
@@ -41,6 +41,11 @@
 
 #include <asm/arch/i2c.h>
 
+/* Hack to enable zero length transfers and smbus quick until clean fix
+ * is available
+ */
+#define DAVINCI_HACK
+
 /* ----- global defines ----------------------------------------------- */
 
 #define DAVINCI_I2C_TIMEOUT	(1*HZ)
@@ -236,9 +241,14 @@ i2c_davinci_xfer_msg(struct i2c_adapter 
 	u32 stat;
 	u16 w;
 	int r;
+#ifdef DAVINCI_HACK
+	u8 zero_byte = 0;
+#endif
 
+#ifndef DAVINCI_HACK
 	if (msg->len == 0)
 		return -EINVAL;
+#endif
 
 	if (!pdata)
 		pdata = &davinci_i2c_platform_data_default;
@@ -249,8 +259,18 @@ i2c_davinci_xfer_msg(struct i2c_adapter 
 	/* set the slave address */
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_SAR_REG, msg->addr);
 
+#ifndef DAVINCI_HACK
 	dev->buf = msg->buf;
 	dev->buf_len = msg->len;
+#else
+	if (msg->len == 0) {
+		dev->buf = &zero_byte;
+		dev->buf_len = 1;
+	} else {
+		dev->buf = msg->buf;
+		dev->buf_len = msg->len;
+	}
+#endif
 
 	davinci_i2c_write_reg(dev, DAVINCI_I2C_CNT_REG, dev->buf_len);
 
@@ -349,7 +369,11 @@ i2c_davinci_xfer(struct i2c_adapter *ada
 
 static u32 i2c_davinci_func(struct i2c_adapter *adap)
 {
+#ifndef DAVINCI_HACK
 	return I2C_FUNC_I2C | (I2C_FUNC_SMBUS_EMUL & ~I2C_FUNC_SMBUS_QUICK);
+#else
+	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
+#endif
 }
 
 /*

--------------000304060603080501030802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000304060603080501030802--
