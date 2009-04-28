From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 3/5] pxa: clean up the legacy SSP API
Date: Tue, 28 Apr 2009 23:20:35 +0100
Message-ID: <20090428222035.GG29277@n2100.arm.linux.org.uk>
References: <f17812d70904222206n73b3f7d1se18a2615c7aad2bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 89E87103838
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Apr 2009 00:21:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70904222206n73b3f7d1se18a2615c7aad2bc@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2009 at 01:06:12PM +0800, Eric Miao wrote:
> Actually, due to the number of possible SSP configurations, it's quite a
> difficult job to maintain an API that can be well re-used. The guideline
> here is to keep only a list of SSP devices and their basic information,
> and it's up to the user driver (like SPI or Audio SSP) to configure the
> SSP in a desired way.

Hmm, the LX battery driver uses this API for its rudimentary battery
communication channel with the PCON.

What are you suggesting as the replacement API?  Direct register access?

Attached is the (entire) driver as it stands, which does need more work
prior to submission (well, if the placement of the PCON I2C driver in
initial patch set ever gets resolved.)

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lx-battery-monitoring.diff"

cb466960004e47212a23e474562e66e4aa48123e
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 7871f05..8c9ae6d 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_HP_ILO)		+= hpilo.o
 obj-$(CONFIG_ISL29003)		+= isl29003.o
 obj-$(CONFIG_C2PORT)		+= c2port/
 obj-y				+= eeprom/
+obj-$(CONFIG_MACH_NETBOOKPRO)	+= lx/
diff --git a/drivers/misc/lx/Makefile b/drivers/misc/lx/Makefile
new file mode 100644
index 0000000..c53c032
--- /dev/null
+++ b/drivers/misc/lx/Makefile
@@ -0,0 +1,6 @@
+
+lx-battery-y				:= lx-battery-core.o
+lx-battery-$(CONFIG_APM_EMULATION)	+= lx-battery-apm.o
+lx-battery-$(CONFIG_PROC_FS)		+= lx-battery-procfs.o
+
+obj-y		 	:= lx-battery.o
diff --git a/drivers/misc/lx/lx-battery-apm.c b/drivers/misc/lx/lx-battery-apm.c
new file mode 100644
index 0000000..3ab7f91
--- /dev/null
+++ b/drivers/misc/lx/lx-battery-apm.c
@@ -0,0 +1,123 @@
+/*
+ * drivers/misc/lx/lx-battery-apm.c
+ *
+ * (c) 2004 Simtec Electronics
+ * Written by Ben Dooks
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/apm-emulation.h>
+#include <linux/pm.h>
+
+#include <mach/lx-pcon.h>
+
+#include "lx-battery.h"
+
+static void lx_apm_get_powerstatus(struct apm_power_info *pwr)
+{
+	struct pcon_battinfo batt;
+
+	if (lx_battmon_getstate(&batt)) {
+		pr_debug("apm: failed to read power info\n");
+		return;
+	}
+
+	if (batt.flags & NBP_PCON_PWRF_ACPresent)
+		pwr->ac_line_status = APM_AC_ONLINE;
+	else
+		pwr->ac_line_status = APM_AC_OFFLINE;
+
+	if (batt.flags & NBP_PCON_PWRF_BatteryPreset) {
+		if (batt.charge_state == NBP_PCON_CS_Charging) {
+			pwr->battery_status = APM_BATTERY_STATUS_CHARGING;
+			pwr->battery_flag = APM_BATTERY_FLAG_CHARGING;
+		} else {
+			pwr->battery_flag = 0;
+		}
+
+		if (batt.main_batt_capacity_percent >= 20) {
+			pwr->battery_status = APM_BATTERY_STATUS_HIGH;
+			pwr->battery_flag |= APM_BATTERY_FLAG_HIGH;
+		} else if (batt.main_batt_capacity_percent >= 5) {
+			pwr->battery_status = APM_BATTERY_STATUS_LOW;
+			pwr->battery_flag |= APM_BATTERY_FLAG_LOW;
+		} else {
+			pwr->battery_status = APM_BATTERY_STATUS_CRITICAL;
+			pwr->battery_flag |= APM_BATTERY_FLAG_CRITICAL;
+		}
+
+		if (batt.discharge_current) {
+			/*
+			 * max_capacity is in mAh, discharge_current is mA,
+			 * so mAh/mA = hours not minutes. --rmk
+			 */
+			pwr->units = APM_UNITS_SECS;
+			pwr->time = batt.max_capacity *
+				    batt.main_batt_capacity_percent * 36 /
+				      batt.discharge_current;
+
+			if (pwr->time >= 32767) {
+				pwr->time /= 60;
+				pwr->units = APM_UNITS_MINS;
+			}
+		}
+
+		pwr->battery_life = batt.main_batt_capacity_percent;
+	} else {
+		pwr->battery_status = APM_BATTERY_STATUS_NOT_PRESENT;
+		pwr->battery_flag = APM_BATTERY_FLAG_NOT_PRESENT;
+	}
+}
+
+/*
+ * irq 1 is "power failing"
+ * irq 2 is "please suspend"
+ */
+static irqreturn_t power_irq(int irqno, void *arg)
+{
+	apm_queue_event((apm_event_t)(int)arg);
+	return IRQ_HANDLED;
+}
+
+static int __init lx_apm_init(void)
+{
+	int ret;
+
+	ret = request_irq(IRQ_GPIO(0), power_irq,
+			  IRQF_DISABLED|IRQF_TRIGGER_RISING,
+			  "Battery Warning", (void *)APM_CRITICAL_SUSPEND);
+	if (ret) {
+		pr_err("LX: Failed to get irq for battery warning\n");
+		return ret;
+	}
+
+	ret = request_irq(IRQ_GPIO(1), power_irq,
+			  IRQF_DISABLED|IRQF_TRIGGER_RISING|IRQF_TRIGGER_FALLING,
+			  "Suspend Request", (void *)APM_SYS_SUSPEND);
+	if (ret) {
+		pr_err("LX: Failed to get irq for suspend request\n");
+		free_irq(IRQ_GPIO(0), (void *)APM_CRITICAL_SUSPEND);
+		return ret;
+	}
+
+	apm_get_power_status = lx_apm_get_powerstatus;
+
+	return 0;
+}
+
+static void __exit lx_apm_exit(void)
+{
+	free_irq(IRQ_GPIO(1), (void *)APM_SYS_SUSPEND);
+	free_irq(IRQ_GPIO(0), (void *)APM_CRITICAL_SUSPEND);
+
+	apm_get_power_status = NULL;
+}
+
+module_init(lx_apm_init);
+module_exit(lx_apm_exit);
+
+MODULE_AUTHOR("Ben Dooks, Simtec Electronics <ben@simtec.co.uk>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LX APM Emulation interface");
diff --git a/drivers/misc/lx/lx-battery-core.c b/drivers/misc/lx/lx-battery-core.c
new file mode 100644
index 0000000..563147a
--- /dev/null
+++ b/drivers/misc/lx/lx-battery-core.c
@@ -0,0 +1,432 @@
+/*
+ * LX battery monitoring
+ *
+ * Copyright (c) 2004 Simtec Electronics
+ *
+ * http://armlinux.simtec.co.uk/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * PCON sends 32-byte data frames to the PXA over the SSP bus.  When
+ * enabled, it will attempt a transfer once every 10 seconds by raising
+ * DREQ1.  This causes the SSP tx DMA to start, thereby causing the SSP
+ * clock to run.  This allows the SSP rx DMA to receive the battery state
+ * information.
+ *
+ * If no battery is fitted, PCON will not send battery state.  This
+ * causes us to time out and re-send the request to enable battery state
+ * from PCON.  We could avoid this by checking whether PCON says the
+ * battery is fitted, but for safety we leave the timer running.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/workqueue.h>
+
+#include <mach/dma.h>
+#include <mach/hardware.h>
+#include <mach/pxa2xx-regs.h>
+#include <mach/regs-ssp.h>
+#include <mach/ssp.h>
+#include <mach/lx-pcon.h>
+
+#include "lx-battery.h"
+
+#define SPI_DMASIZE     (32)
+#define SPI_RXBUFFERS   (12)
+
+#define SPI_DMA_CMD	\
+	(DCMD_FLOWSRC | DCMD_BURST32 | DCMD_WIDTH2 | SPI_DMASIZE)
+
+#define SPI_RXDMA_CMD	(DCMD_INCTRGADDR | SPI_DMA_CMD | DCMD_ENDIRQEN)
+#define SPI_TXDMA_CMD	(DCMD_INCSRCADDR | SPI_DMA_CMD)
+
+#define BAT_TIMEOUT	(30 * HZ)
+
+/* size of this structure must be aligned to 4 words */
+struct spi_buffer {
+	pxa_dma_desc	dma_desc;
+	u32		data[SPI_DMASIZE / sizeof(u32)];
+};
+
+/*
+ * This describes the DMA data buffer.
+ */
+struct spi_dma_data {
+	struct spi_buffer	rx[SPI_RXBUFFERS] __attribute__((aligned(16)));
+	struct spi_buffer	tx __attribute__((aligned(16)));
+};
+
+struct bat_priv {
+	struct device		*dev;
+	struct ssp_dev		ssp;
+	struct ssp_state	state;
+	struct spi_dma_data	*cpu_ring;
+	dma_addr_t		dma_ring;
+	int			rx_chan;
+	int			tx_chan;
+	unsigned int		rx_last;
+	dma_addr_t 		rx_phys[SPI_RXBUFFERS];
+	struct timer_list	timer;
+	struct work_struct	work;
+
+	struct pcon_battinfo	battinfo;
+	struct power_stats	stats;
+};
+
+/*
+ * This macro returns the DMA address of element 'x' from the above
+ * structure.
+ */
+#define SPI_DMAPTR(bat,x) \
+	(bat->dma_ring + offsetof(struct spi_dma_data, x))
+
+static struct bat_priv *global_bat;
+
+int lx_battmon_getstate(struct pcon_battinfo *info)
+{
+	unsigned long flags;
+	int ret = -ENOENT;
+
+	local_irq_save(flags);
+	if (global_bat && global_bat->battinfo.magic == PCON_BATTINFO_MAGIC) {
+		memcpy(info, &global_bat->battinfo, sizeof(*info));
+		ret = 0;
+	}
+	local_irq_restore(flags);
+	return ret;
+}
+
+int lx_battmon_getstats(struct power_stats *stats)
+{
+	unsigned long flags;
+	int ret = -ENOENT;
+
+	local_irq_save(flags);
+	if (global_bat) {
+		memcpy(stats, &global_bat->stats, sizeof(*stats));
+		ret = 0;
+	}
+	local_irq_restore(flags);
+	return ret;
+}
+
+static struct pcon_battinfo *lx_to_battinfo(u32 *data)
+{
+	u32 *ptr = data;
+	unsigned int i;
+
+	/*
+	 * 16-bit swap the data.
+	 */
+	for (i = 0; i < SPI_DMASIZE / sizeof(u32); i++, ptr++) {
+		u32 t1, t2;
+		t1  = *ptr;
+		t2  = (t1 >> 8) & ~0x0000ff00;
+		t2 |= (t1 << 8) & ~0x00ff0000;
+		*ptr = t2;
+	}
+	return (struct pcon_battinfo *)data;
+}
+
+static void lx_bat_rx(struct bat_priv *bat, u32 *data)
+{
+	struct pcon_battinfo *battinfo = lx_to_battinfo(data);
+
+	if (battinfo->magic == PCON_BATTINFO_MAGIC) {
+		bat->battinfo = *battinfo;
+		bat->stats.last_good = jiffies;
+		bat->stats.num_good++;
+
+		/* If successfully received, restart the timeout */
+		mod_timer(&bat->timer, jiffies + BAT_TIMEOUT);
+	} else {
+		bat->stats.last_bad = jiffies;
+		bat->stats.num_bad++;
+	}
+
+	/* zero the buffer we where given */
+	memset(data, 0, SPI_DMASIZE);
+}
+
+static void lx_bat_rxirq(int irq, void *param)
+{
+	struct bat_priv *bat = param;
+	unsigned int dcsr, dtadr;
+	dma_addr_t ddadr;
+
+	dcsr  = DCSR(bat->rx_chan);
+	ddadr = DDADR(bat->rx_chan);
+	dtadr = DTADR(bat->rx_chan);
+
+	/* clear all pending interrupts */
+	DCSR(bat->rx_chan) = dcsr;
+
+	dev_dbg(bat->dev, "rx irq: dcsr=%08x, ddadr=%08x, dtadr=%08x\n",
+	    dcsr, ddadr, dtadr);
+
+	if (dcsr & DCSR_BUSERR)
+		dev_err(bat->dev, "rx: dma error (%08x)\n", dcsr);
+
+	if (dcsr & DCSR_ENDINTR) {
+		unsigned int buff = bat->rx_last;
+
+		dev_dbg(bat->dev, "rx: dma channel end\n");
+
+		while (1) {
+			struct spi_buffer *rx = &bat->cpu_ring->rx[buff];
+
+			buff = (buff + 1) % SPI_RXBUFFERS;
+
+			/* check: see if this is the last buffer... */
+			if (bat->rx_phys[buff] == (ddadr & ~15))
+				break;
+
+			bat->rx_last = buff;
+			lx_bat_rx(bat, rx->data);
+		}
+	}
+}
+
+static void lx_bat_txirq(int irq, void *param)
+{
+	struct bat_priv *bat = param;
+	unsigned int dcsr = DCSR(bat->tx_chan);
+
+	DCSR(bat->tx_chan) = dcsr | DCSR_ENDINTR | DCSR_STARTINTR | DCSR_BUSERR;
+
+	dev_dbg(bat->dev, "tx: dcsr=%08x\n", dcsr);
+}
+
+/*
+ * Disable the SPI engine and its associated DMA channels.
+ */
+static void lx_bat_disable(struct bat_priv *bat)
+{
+	ssp_disable(&bat->ssp);
+
+	DCSR(bat->rx_chan) = 0;
+	DCSR(bat->tx_chan) = 0;
+
+	CKEN &= ~(1 << 3); //pxa_set_cken(CKEN3_SSP, 0);
+}
+
+/*
+ * Enable the SPI engine and its associated DMA channels.
+ */
+static void lx_bat_enable(struct bat_priv *bat)
+{
+	CKEN |= (1 << 3); //pxa_set_cken(CKEN3_SSP, 1);
+
+	DRCMR(1) = bat->tx_chan | DRCMR_MAPVLD;
+	DRCMR(bat->ssp.ssp->drcmr_rx) = bat->rx_chan | DRCMR_MAPVLD;
+
+	bat->rx_last = 0;
+	DDADR(bat->rx_chan) = SPI_DMAPTR(bat, rx[0].dma_desc);
+	DDADR(bat->tx_chan) = SPI_DMAPTR(bat, tx.dma_desc);
+
+	ssp_enable(&bat->ssp);
+
+	DCSR(bat->rx_chan) |= DCSR_RUN;
+	DCSR(bat->tx_chan) |= DCSR_RUN;
+}
+
+static void lx_bat_work(struct work_struct *work)
+{
+	struct bat_priv *bat = container_of(work, struct bat_priv, work);
+	int ret;
+
+	lx_bat_disable(bat);
+	lx_bat_enable(bat);
+
+	ret = pcon_monitorbattery(1, 0);
+	if (ret < 0)
+		dev_err(bat->dev, "LX: battery monitor setstate failed\n");
+
+	mod_timer(&bat->timer, jiffies + BAT_TIMEOUT);
+}
+
+static void lx_bat_timeout(unsigned long data)
+{
+	struct work_struct *work = (struct work_struct *)data;
+	pr_debug("LX: battery monitor timeout, restarting\n");
+	schedule_work(work);
+}
+
+static int __init lx_bat_probe(struct platform_device *dev)
+{
+	struct bat_priv *bat;
+	int ret, i;
+
+	if (global_bat)
+		return -EBUSY;
+
+	bat = kzalloc(sizeof(*bat), GFP_KERNEL);
+	if (!bat) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+
+	bat->dev = &dev->dev;
+	platform_set_drvdata(dev, bat);
+
+	setup_timer(&bat->timer, lx_bat_timeout, (unsigned long)&bat->work);
+	INIT_WORK(&bat->work, lx_bat_work);
+
+	ret = ssp_init(&bat->ssp, PXA25x_SSP, SSP_NO_IRQ);
+	if (ret)
+		goto err_ssp;
+
+	/*
+	 * SSCR0 -> 0xF | (1<<7)  (0x8F)
+	 * SSCR1 -> (11<<6) | (15<<10)  = (0x3EC0)
+	 *
+	 * SSCR0 = SSCR0_Motorola | SSCR0_DataSize(16) | SSCR0_SerClkDiv(2);
+	 * SSCR1 = SSCR1_TxTresh(12) | SSCR1_RxTresh(16);
+	 */
+	ssp_config(&bat->ssp, SSCR0_Motorola | SSCR0_DataSize(16),
+		SSCR1_TxTresh(12) | SSCR1_RxTresh(16), 0, SSCR0_SerClkDiv(4));
+
+	bat->cpu_ring = dma_alloc_coherent(bat->dev,
+					   sizeof(struct spi_dma_data),
+					   &bat->dma_ring, GFP_KERNEL);
+
+	if (bat->cpu_ring == NULL) {
+		dev_err(bat->dev, "no memory for DMA buffers\n");
+		ret = -ENOMEM;
+		goto err_dmabuf;
+	}
+
+	memset(bat->cpu_ring, 0, sizeof(struct spi_dma_data));
+
+	for (i = 0; i < SPI_RXBUFFERS; i++) {
+		struct spi_buffer *rx = &bat->cpu_ring->rx[i];
+		dma_addr_t ddadr = SPI_DMAPTR(bat, rx[i + 1].dma_desc);
+
+		if (i == SPI_RXBUFFERS - 1)
+			ddadr = bat->dma_ring;
+
+		rx->dma_desc.ddadr = ddadr;
+		rx->dma_desc.dsadr = bat->ssp.ssp->phys_base + SSDR;
+		rx->dma_desc.dtadr = SPI_DMAPTR(bat, rx[i].data);
+		rx->dma_desc.dcmd  = SPI_RXDMA_CMD;
+
+		bat->rx_phys[i] = SPI_DMAPTR(bat, rx[i].dma_desc);
+	}
+
+	bat->cpu_ring->tx.dma_desc.ddadr = SPI_DMAPTR(bat, tx.dma_desc);
+	bat->cpu_ring->tx.dma_desc.dsadr = SPI_DMAPTR(bat, tx.data);
+	bat->cpu_ring->tx.dma_desc.dtadr = bat->ssp.ssp->phys_base + SSDR;
+	bat->cpu_ring->tx.dma_desc.dcmd  = SPI_TXDMA_CMD;
+
+	bat->rx_chan = pxa_request_dma("SPI RX", DMA_PRIO_LOW,
+				       lx_bat_rxirq, bat);
+	if (bat->rx_chan < 0) {
+		dev_err(bat->dev, "failed to allocate RX DMA channel (%d)\n",
+			bat->rx_chan);
+		ret = bat->rx_chan;
+		goto err_rxdma;
+	}
+
+	bat->tx_chan = pxa_request_dma("SPI TX", DMA_PRIO_LOW,
+				       lx_bat_txirq, bat);
+	if (bat->tx_chan < 0) {
+		dev_err(bat->dev, "failed to allocate TX DMA channel (%d)\n",
+			bat->tx_chan);
+		ret = bat->tx_chan;
+		goto err_txdma;
+	}
+
+	lx_bat_enable(bat);
+	pcon_monitorbattery(1, PCON_FLG_ASYNC);
+	mod_timer(&bat->timer, jiffies + BAT_TIMEOUT);
+
+	global_bat = bat;
+
+	return 0;
+
+ err_txdma:
+	pxa_free_dma(bat->rx_chan);
+ err_rxdma:
+	dma_free_coherent(bat->dev, sizeof(struct spi_dma_data), bat->cpu_ring,
+			  bat->dma_ring);
+ err_dmabuf:
+	ssp_exit(&bat->ssp);
+ err_ssp:
+	kfree(bat);
+ err_out:
+	return ret;
+}
+
+static int lx_bat_remove(struct platform_device *dev)
+{
+	struct bat_priv *bat = platform_get_drvdata(dev);
+
+	global_bat = NULL;
+
+	pcon_monitorbattery(0, 0);
+	lx_bat_disable(bat);
+
+	del_timer_sync(&bat->timer);
+	cancel_work_sync(&bat->work);
+	pxa_free_dma(bat->tx_chan);
+	pxa_free_dma(bat->rx_chan);
+	dma_free_coherent(bat->dev, sizeof(struct spi_dma_data), bat->cpu_ring,
+			  bat->dma_ring);
+	ssp_exit(&bat->ssp);
+	kfree(bat);
+	return 0;
+}
+
+static int lx_bat_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct bat_priv *bat = platform_get_drvdata(dev);
+	pcon_monitorbattery(0, 0);
+	lx_bat_disable(bat);
+	del_timer_sync(&bat->timer);
+	ssp_save_state(&bat->ssp, &bat->state);
+	return 0;
+}
+
+static int lx_bat_resume(struct platform_device *dev)
+{
+	struct bat_priv *bat = platform_get_drvdata(dev);
+	ssp_restore_state(&bat->ssp, &bat->state);
+	lx_bat_enable(bat);
+	pcon_monitorbattery(1, PCON_FLG_ASYNC);
+	mod_timer(&bat->timer, jiffies + BAT_TIMEOUT);
+	return 0;
+}
+
+static struct platform_driver bat_driver = {
+	.probe	 = lx_bat_probe,
+	.remove  = lx_bat_remove,
+	.suspend = lx_bat_suspend,
+	.resume	 = lx_bat_resume,
+	.driver = {
+		.name = "lx-spi",
+	},
+};
+
+static int __init lx_bat_init(void)
+{
+	return platform_driver_register(&bat_driver);
+}
+
+static void __exit lx_bat_exit(void)
+{
+	platform_driver_unregister(&bat_driver);
+}
+
+module_init(lx_bat_init);
+module_exit(lx_bat_exit);
+
+MODULE_AUTHOR("Ben Dooks, Simtec Electronics <ben@simtec.co.uk>");
+MODULE_DESCRIPTION("LX SPI Battery Monitor");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/lx/lx-battery-procfs.c b/drivers/misc/lx/lx-battery-procfs.c
new file mode 100644
index 0000000..892ea2a
--- /dev/null
+++ b/drivers/misc/lx/lx-battery-procfs.c
@@ -0,0 +1,140 @@
+/*
+ * drivers/misc/lx/lx-battery-procfs.c
+ *
+ * Copyright (c) 2004 Simtec Electronics
+ * Written by Ben Dooks
+ *
+ * http://armlinux.simtec.co.uk/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/jiffies.h>
+
+#include "lx-battery.h"
+
+static int lx_batproc_proc_rd_stats(char *page, char **start, off_t off,
+				    int count, int *eof, void *data)
+{
+	struct power_stats stats;
+	unsigned long timediff;
+	int i;
+
+	lx_battmon_getstats(&stats);
+
+	/* work out how long since last management frame received */
+	timediff = (jiffies - stats.last_good) / (HZ / 10);
+	i = sprintf(page, "Good frames: %ld (%ld.%ld secs)\n",
+		    stats.num_good, timediff / 10, timediff % 10);
+
+	if (stats.num_bad) {
+		timediff = (jiffies - stats.last_bad) / (HZ / 10);
+		i += sprintf(page+i, "Bad frames:  %ld (%ld.%ld secs)\n",
+			    stats.num_bad, timediff / 10, timediff % 10);
+	}
+
+	return i;
+}
+
+static const char *charge_state[] = {
+	[NBP_PCON_CS_NotCharging] = "not charging",
+	[NBP_PCON_CS_Charging] = "charging",
+	[NBP_PCON_CS_QuickChargeComplete] = "quick charging",
+	[NBP_PCON_CS_ChargeComplete] = "charging complete",
+};
+
+static int lx_batproc_proc_rd_drv(char *page, char **start, off_t off,
+				  int count, int *eof, void *data)
+{
+	struct pcon_battinfo bi;
+	int i = lx_battmon_getstate(&bi);
+
+	if (i)
+		return sprintf(page, "Invalid battery state\n");
+
+	i += sprintf(page+i, "Main Battery: %spresent\n",
+		     bi.flags & NBP_PCON_PWRF_BatteryPreset ? "" : "not ");
+	i += sprintf(page+i, " Temperature      : %d.%d C\n",
+		     bi.temperature / 10, bi.temperature % 10);
+	i += sprintf(page+i, " Maximum Capacity : %d mAh\n",
+		     bi.max_capacity);
+	i += sprintf(page+i, " Voltage          : %d mV\n",
+		     bi.main_batt_voltage);
+	i += sprintf(page+i, " Capacity         : %d %%\n",
+		     bi.main_batt_capacity_percent);
+	i += sprintf(page+i, " Charge Current   : %d mA\n",
+		     bi.charge_current);
+	i += sprintf(page+i, " Discharge Current: %d mA\n",
+		     bi.discharge_current);
+	i += sprintf(page+i, " Status           : %scalibrated%s\n\n",
+		     bi.flags & NBP_PCON_PWRF_Calibrated ? "" : "not ",
+		     bi.flags & NBP_PCON_PWRF_Calibrating ? ", calibrating" : "");
+
+	i += sprintf(page+i, "Backup Battery: %spresent\n",
+		     bi.flags & NBP_PCON_PWRF_BackupBatteryPreset ? "" : "not ");
+	i += sprintf(page+i, " Battery          : %d mV\n",
+		     bi.backup_batt_voltage);
+	i += sprintf(page+i, " Capacity         : %d %%\n\n",
+		     bi.backup_batt_capacity_percent);
+
+	i += sprintf(page+i, "Charger State:\n");
+	i += sprintf(page+i, " AC %splugged in\n",
+		     bi.flags & NBP_PCON_PWRF_ACPresent ? "" : "not " );
+	i += sprintf(page+i, " Charging %s\n",
+		     bi.flags & NBP_PCON_PWRF_ChargeEnabled ? "enabled" : "disabled");
+	i += sprintf(page+i, " Status: ");
+
+	if (bi.charge_state < ARRAY_SIZE(charge_state) &&
+	    charge_state[bi.charge_state])
+		i += sprintf(page+i, "%s\n", charge_state[bi.charge_state]);
+	else
+		i += sprintf(page+i, "unknown state (%d)\n", bi.charge_state);
+
+	return i;
+}
+
+static int __init lx_batproc_init(void)
+{
+	struct proc_dir_entry *pde;
+	int ret = -ENOMEM;
+
+	pde = create_proc_read_entry("driver/battery", 0, NULL,
+				     lx_batproc_proc_rd_drv, NULL);
+	if (pde == NULL) {
+		pr_err("LX: failed to create /proc/driver/battery entry\n");
+		goto err_out;
+	}
+
+	pde = create_proc_read_entry("driver/battery-stats", 0, NULL,
+				     lx_batproc_proc_rd_stats, NULL);
+	if (pde == NULL) {
+		pr_err("LX: failed to create /proc/driver/battery-stats entry\n");
+		goto err_drv;
+	}
+
+	return 0;
+
+ err_drv:
+	remove_proc_entry("driver/battery", NULL);
+ err_out:
+	return ret;
+}
+
+static void __exit lx_batproc_exit(void)
+{
+	remove_proc_entry("driver/battery-stats", NULL);
+	remove_proc_entry("driver/battery", NULL);
+}
+
+module_init(lx_batproc_init);
+module_exit(lx_batproc_exit);
+
+MODULE_AUTHOR("Ben Dooks, Simtec Electronics <ben@simtec.co.uk>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("LX Battery Monitor procfs support");
diff --git a/drivers/misc/lx/lx-battery.h b/drivers/misc/lx/lx-battery.h
new file mode 100644
index 0000000..e57fb9d
--- /dev/null
+++ b/drivers/misc/lx/lx-battery.h
@@ -0,0 +1,37 @@
+/* struct pcon_battinfo should be 32bytes long */
+struct pcon_battinfo {
+	u16	flags;
+#define NBP_PCON_PWRF_BatteryPreset		0x0001
+#define NBP_PCON_PWRF_ACPresent 		0x0002
+#define NBP_PCON_PWRF_ChargeEnabled		0x0004
+#define NBP_PCON_PWRF_BackupBatteryPreset	0x0008
+#define NBP_PCON_PWRF_Calibrated		0x0010
+#define NBP_PCON_PWRF_Calibrating		0x0020
+	u16	unused[4];
+	u16	max_capacity;
+	u16	temperature;
+	u16	charge_state;
+#define NBP_PCON_CS_NotCharging 		0
+#define NBP_PCON_CS_Charging			1
+#define NBP_PCON_CS_QuickChargeComplete		2
+#define NBP_PCON_CS_ChargeComplete		3
+	u16	main_batt_voltage;
+	u16	backup_batt_voltage;
+	u8	main_batt_capacity_percent;
+	u8	backup_batt_capacity_percent;
+	u16	charge_current;
+	u16	discharge_current;
+	u16	pad[2];
+	u16	magic;
+#define PCON_BATTINFO_MAGIC	(0xADB0)
+} __attribute__((__packed__));
+
+struct power_stats {
+	unsigned long last_good;
+	unsigned long num_good;
+	unsigned long last_bad;
+	unsigned long num_bad;
+};
+
+extern int lx_battmon_getstate(struct pcon_battinfo *info);
+extern int lx_battmon_getstats(struct power_stats *stats);

--huq684BweRXVnRxX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--huq684BweRXVnRxX--
