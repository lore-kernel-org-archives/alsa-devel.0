From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [Patch v6 3/7] slimbus: qcom: Add Qualcomm Slimbus controller
 driver
Date: Wed, 18 Oct 2017 00:27:22 -0700
Message-ID: <20171018072722.GF1575@tuxbook>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171006155136.4682-4-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

On Fri 06 Oct 08:51 PDT 2017, srinivas.kandagatla@linaro.org wrote:

> From: Sagar Dharia <sdharia@codeaurora.org>
> 
> This controller driver programs manager, interface, and framer
> devices for Qualcomm's slimbus HW block.
> Manager component currently implements logical address setting,
> and messaging interface.
> Interface device reports bus synchronization information, and framer
> device clocks the bus from the time it's woken up, until clock-pause
> is executed by the manager device.
> 
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt |  43 ++
>  drivers/slimbus/Kconfig                            |   9 +
>  drivers/slimbus/Makefile                           |   3 +
>  drivers/slimbus/slim-qcom-ctrl.c                   | 594 +++++++++++++++++++++
>  drivers/slimbus/slim-qcom.h                        |  63 +++
>  5 files changed, 712 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
>  create mode 100644 drivers/slimbus/slim-qcom-ctrl.c
>  create mode 100644 drivers/slimbus/slim-qcom.h
> 
> diff --git a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
> new file mode 100644
> index 0000000..081110d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
> @@ -0,0 +1,43 @@
> +Qualcomm SLIMBUS controller
> +This controller is used if applications processor driver controls slimbus
> +master component.
> +
> +Required properties:
> +
> + - #address-cells - refer to Documentation/devicetree/bindings/slimbus/bus.txt
> + - #size-cells	- refer to Documentation/devicetree/bindings/slimbus/bus.txt
> +
> + - reg : Offset and length of the register region(s) for the device
> + - reg-names : Register region name(s) referenced in reg above
> +	 Required register resource entries are:
> +	 "ctrl": Physical adderess of controller register blocks
> + - compatible : should be "qcom,<SOC-NAME>-slim" for SOC specific compatible or

As you implementation is only compatible with "qcom,slim" this should be
"and" not "or".

> + 		"qcom,slim" if using generic qcom SLIM IP.
> + - interrupts : Interrupt number used by this controller
> + - clocks : Interface and core clocks used by this slimbus controller
> + - clock-names : Required clock-name entries are:
> +	"iface_clk" : Interface clock for this controller
> +	"core_clk" : Interrupt for controller core's BAM
> +
> +
> +Optional property:
> + - reg entry for slew rate : If slew rate control register is provided, this
> +	entry should be used.
> + - reg-name for slew rate: "slew"
> +
> +Example:
> +	slim@28080000 {
> +		compatible = "qcom,slim";
> +		#address-cells = <4>;
> +		#size-cells = <0>;
> +		reg = <0x28080000 0x2000>, <0x80207C 4>;
> +		reg-names = "ctrl", "slew";
> +		interrupts = <0 33 0>;
> +		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
> +		clock-names = "iface_clk", "core_clk";
> +
> +		codec: wcd9310@1{
> +			compatible = "slim217,60";
> +			reg = <1 0>;
> +		};
> +	};
> diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
> index f0b118a..438773e 100644
> --- a/drivers/slimbus/Kconfig
> +++ b/drivers/slimbus/Kconfig
> @@ -9,3 +9,12 @@ menuconfig SLIMBUS
>  
>  	  If unsure, choose N.
>  
> +if SLIMBUS
> +config SLIM_QCOM_CTRL
> +	tristate "Qualcomm Slimbus Manager Component"
> +	depends on SLIMBUS
> +	help
> +	  Select driver if Qualcomm's Slimbus Manager Component is
> +	  programmed using Linux kernel.
> +
> +endif
> diff --git a/drivers/slimbus/Makefile b/drivers/slimbus/Makefile
> index bd1d35e..ed8521a 100644
> --- a/drivers/slimbus/Makefile
> +++ b/drivers/slimbus/Makefile
> @@ -3,3 +3,6 @@
>  #
>  obj-$(CONFIG_SLIMBUS)			+= slimbus.o
>  slimbus-y				:= slim-core.o slim-messaging.o
> +
> +#Controllers
> +obj-$(CONFIG_SLIM_QCOM_CTRL)		+= slim-qcom-ctrl.o
> diff --git a/drivers/slimbus/slim-qcom-ctrl.c b/drivers/slimbus/slim-qcom-ctrl.c
> new file mode 100644
> index 0000000..d0574e1
> --- /dev/null
> +++ b/drivers/slimbus/slim-qcom-ctrl.c
> @@ -0,0 +1,594 @@
> +/* Copyright (c) 2011-2016, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/slimbus.h>
> +#include "slim-qcom.h"
> +
> +#define MSM_SLIM_NAME	"msm_slim_ctrl"

Just put this string in the driver struct.

> +
> +/* Manager registers */
> +#define	MGR_CFG		0x200
> +#define	MGR_STATUS	0x204
> +#define	MGR_INT_EN	0x210
> +#define	MGR_INT_STAT	0x214
> +#define	MGR_INT_CLR	0x218
> +#define	MGR_TX_MSG	0x230
> +#define	MGR_RX_MSG	0x270
> +#define	MGR_IE_STAT	0x2F0
> +#define	MGR_VE_STAT	0x300
> +#define	MGR_CFG_ENABLE	1
> +
> +/* Framer registers */
> +#define	FRM_CFG		0x400
> +#define	FRM_STAT	0x404
> +#define	FRM_INT_EN	0x410
> +#define	FRM_INT_STAT	0x414
> +#define	FRM_INT_CLR	0x418
> +#define	FRM_WAKEUP	0x41C
> +#define	FRM_CLKCTL_DONE	0x420
> +#define	FRM_IE_STAT	0x430
> +#define	FRM_VE_STAT	0x440
> +
> +/* Interface registers */
> +#define	INTF_CFG	0x600
> +#define	INTF_STAT	0x604
> +#define	INTF_INT_EN	0x610
> +#define	INTF_INT_STAT	0x614
> +#define	INTF_INT_CLR	0x618
> +#define	INTF_IE_STAT	0x630
> +#define	INTF_VE_STAT	0x640
> +
> +/* Interrupt status bits */
> +#define	MGR_INT_TX_NACKED_2	BIT(25)
> +#define	MGR_INT_MSG_BUF_CONTE	BIT(26)
> +#define	MGR_INT_RX_MSG_RCVD	BIT(30)
> +#define	MGR_INT_TX_MSG_SENT	BIT(31)
> +
> +/* Framer config register settings */
> +#define	FRM_ACTIVE	1
> +#define	CLK_GEAR	7
> +#define	ROOT_FREQ	11
> +#define	REF_CLK_GEAR	15
> +#define	INTR_WAKE	19
> +
> +static int msm_slim_queue_tx(struct msm_slim_ctrl *dev, u32 *buf, u8 len,
> +			     u32 tx_reg)

Use void * for buf.

> +{
> +	int i;
> +
> +	for (i = 0; i < (len + 3) >> 2; i++) {

If len is in bytes then this looks like you will read outside the
buffer. If buf is guaranteed to be 4-byte aligned make "len" number of
32-bit entries in the array.

> +		dev_dbg(dev->dev, "AHB TX data:0x%x\n", buf[i]);

Drop the debug print, if anything use print_hex_dump to get the whole
chunk.

> +		writel_relaxed(buf[i], dev->base + tx_reg + (i * 4));
> +	}

Replace this loop with:

	__iowrite32_copy(dev->base + tx_reg, buf, len / sizeof(u32));

> +	/* Guarantee that message is sent before returning */

"Ensure ordering of subsequent writes", there's no guarantees that the
write is done at the end of this function.

> +	mb();
> +	return 0;

Why return an int when there are not other return paths?

> +}
> +
> +static irqreturn_t msm_slim_interrupt(int irq, void *d)
> +{
> +	struct msm_slim_ctrl *dev = d;
> +	u32 stat = readl_relaxed(dev->base + MGR_INT_STAT);
> +	int err = 0, ret = IRQ_NONE;
> +

If you split the two large parts of this function into two functions
things will be cleaner and you'll save yourself one level of
indentation.

> +	if (stat & MGR_INT_TX_MSG_SENT || stat & MGR_INT_TX_NACKED_2) {
> +		if (stat & MGR_INT_TX_MSG_SENT)
> +			writel_relaxed(MGR_INT_TX_MSG_SENT,
> +				       dev->base + MGR_INT_CLR);
> +		if (stat & MGR_INT_TX_NACKED_2) {
> +			u32 mgr_stat = readl_relaxed(dev->base + MGR_STATUS);
> +			u32 mgr_ie_stat = readl_relaxed(dev->base +
> +							MGR_IE_STAT);
> +			u32 frm_stat = readl_relaxed(dev->base + FRM_STAT);
> +			u32 frm_cfg = readl_relaxed(dev->base + FRM_CFG);
> +			u32 frm_intr_stat = readl_relaxed(dev->base +
> +							  FRM_INT_STAT);
> +			u32 frm_ie_stat = readl_relaxed(dev->base +
> +							FRM_IE_STAT);
> +			u32 intf_stat = readl_relaxed(dev->base + INTF_STAT);
> +			u32 intf_intr_stat = readl_relaxed(dev->base +
> +							   INTF_INT_STAT);
> +			u32 intf_ie_stat = readl_relaxed(dev->base +
> +							 INTF_IE_STAT);
> +
> +			writel_relaxed(MGR_INT_TX_NACKED_2, dev->base +
> +				       MGR_INT_CLR);
> +			dev_err(dev->dev, "TX Nack MGR:int:0x%x, stat:0x%x\n",
> +				stat, mgr_stat);
> +			dev_err(dev->dev, "TX Nack MGR:ie:0x%x\n", mgr_ie_stat);
> +			dev_err(dev->dev, "TX Nack FRM:int:0x%x, stat:0x%x\n",
> +				frm_intr_stat, frm_stat);
> +			dev_err(dev->dev, "TX Nack FRM:cfg:0x%x, ie:0x%x\n",
> +				frm_cfg, frm_ie_stat);
> +			dev_err(dev->dev, "TX Nack INTF:intr:0x%x, stat:0x%x\n",
> +				intf_intr_stat, intf_stat);
> +			dev_err(dev->dev, "TX Nack INTF:ie:0x%x\n",
> +				intf_ie_stat);
> +			err = -ENOTCONN;
> +		}
> +		/**
> +		 * Guarantee that interrupt clear bit write goes through before
> +		 * signalling completion/exiting ISR
> +		 */

I'm not sure why this is necessary, but this is not "guaranteed" by the
mb().

> +		mb();
> +		slim_return_tx(&dev->ctrl, err);
> +		ret = IRQ_HANDLED;
> +	}
> +	if (stat & MGR_INT_RX_MSG_RCVD) {
> +		u8 mc, mt;
> +		u8 len, i;
> +		u32 *rx_buf, pkt[10];
> +		bool q_rx = false;
> +
> +		pkt[0] = readl_relaxed(dev->base + MGR_RX_MSG);
> +		mt = (pkt[0] >> 5) & 0x7;
> +		mc = (pkt[0] >> 8) & 0xff;
> +		len = pkt[0] & 0x1F;

The way this function deals with cryptic variable names and cryptic
bit shifts is quite hard to follow. Perhaps it makes sense if you know
exactly what's going on?

A comment describing the fields in the read information would be quite
helpful, at least.

> +		dev_dbg(dev->dev, "RX-IRQ: MC: %x, MT: %x\n", mc, mt);
> +
> +		/**
> +		 * this message cannot be handled by ISR, so
> +		 * let work-queue handle it
> +		 */
> +		if (mt == SLIM_MSG_MT_CORE &&
> +			mc == SLIM_MSG_MC_REPORT_PRESENT)
> +			rx_buf = (u32 *)slim_get_rx(&dev->ctrl);
> +		else
> +			rx_buf = pkt;
> +
> +		if (rx_buf == NULL) {

if (!rx_buf)

> +			dev_err(dev->dev, "dropping RX:0x%x due to RX full\n",
> +						pkt[0]);

Why do we need to drop this incoming message? Will things recover from
that?

> +			goto rx_ret_irq;
> +		}
> +
> +		rx_buf[0] = pkt[0];
> +		for (i = 1; i < ((len + 3) >> 2); i++) {
> +			rx_buf[i] = readl_relaxed(dev->base + MGR_RX_MSG +
> +						(4 * i));
> +			dev_dbg(dev->dev, "reading data: %x\n", rx_buf[i]);

Drop this debug message, if you really want to show this use
print_hex_dump() after reading the entire thing.


And you should be able to replace this loop with __ioread32_copy()

> +		}
> +
> +		switch (mc) {
> +			u8 *buf, la;
> +			u16 ele;

What?!

> +
> +		case SLIM_MSG_MC_REPORT_PRESENT:
> +			q_rx = true;
> +			break;
> +		case SLIM_MSG_MC_REPLY_INFORMATION:
> +		case SLIM_MSG_MC_REPLY_VALUE:
> +			slim_msg_response(&dev->ctrl, (u8 *)(rx_buf + 1),
> +					  (u8)(*rx_buf >> 24), (len - 4));
> +			break;
> +		case SLIM_MSG_MC_REPORT_INFORMATION:
> +			buf = (u8 *)rx_buf;
> +			la = buf[2];
> +			ele = (u16)buf[4] << 4;
> +
> +			ele |= ((buf[3] & 0xf0) >> 4);
> +			/**
> +			 * report information is most likely loss of
> +			 * sync or collision detected in data slots
> +			 */
> +			dev_err(dev->dev, "LA:%d report inf ele:0x%x\n",
> +				la, ele);
> +			for (i = 0; i < len - 5; i++)
> +				dev_err(dev->dev, "bit-mask:%x\n",
> +					buf[i+5]);

To whom is this cryptic dump valuable? Please use print_hex_dump()
rather than rolling your own print-loops.

> +			break;
> +		default:
> +			dev_err(dev->dev, "unsupported MC,%x MT:%x\n",
> +				mc, mt);
> +			break;
> +		}
> +rx_ret_irq:
> +		writel_relaxed(MGR_INT_RX_MSG_RCVD, dev->base +
> +			       MGR_INT_CLR);
> +		/**
> +		 * Guarantee that CLR bit write goes through
> +		 * before exiting
> +		 */

"Ensure ordering of CLR bit write with subsequent writes" although I'm
wondering how useful this is...

> +		mb();
> +		if (q_rx)
> +			queue_work(dev->rxwq, &dev->wd);
> +
> +		ret = IRQ_HANDLED;
> +	}
> +	return ret;
> +}
> +
> +static int msm_xfer_msg(struct slim_controller *ctrl, struct slim_msg_txn *txn,
> +			void *pbuf)
> +{
> +	struct msm_slim_ctrl *dev = slim_get_ctrldata(ctrl);
> +	u32 *head = (u32 *)pbuf;
> +	u8 *puc = (u8 *)pbuf;
> +	u8 la = txn->la;
> +
> +	/* HW expects length field to be excluded */
> +	txn->rl--;
> +
> +	if (txn->dt == SLIM_MSG_DEST_LOGICALADDR)
> +		*head = SLIM_MSG_ASM_FIRST_WORD(txn->rl, txn->mt, txn->mc, 0,
> +						la);
> +	else
> +		*head = SLIM_MSG_ASM_FIRST_WORD(txn->rl, txn->mt, txn->mc, 1,
> +						la);

Put "dt" (whatever that is?!) in a variable and then do this line once,
saves you from the line break.

> +
> +	if (txn->dt == SLIM_MSG_DEST_LOGICALADDR)
> +		puc += 3;
> +	else
> +		puc += 2;
> +
> +	if (txn->mt == SLIM_MSG_MT_CORE && slim_tid_txn(txn->mt, txn->mc))
> +		*(puc++) = txn->tid;
> +
> +	if ((txn->mt == SLIM_MSG_MT_CORE) &&
> +		((txn->mc >= SLIM_MSG_MC_REQUEST_INFORMATION &&
> +		txn->mc <= SLIM_MSG_MC_REPORT_INFORMATION) ||
> +		(txn->mc >= SLIM_MSG_MC_REQUEST_VALUE &&
> +		 txn->mc <= SLIM_MSG_MC_CHANGE_VALUE))) {
> +		*(puc++) = (txn->ec & 0xFF);
> +		*(puc++) = (txn->ec >> 8) & 0xFF;
> +	}
> +
> +	if (txn->msg && txn->msg->wbuf)
> +		memcpy(puc, txn->msg->wbuf, txn->msg->num_bytes);
> +
> +	return msm_slim_queue_tx(dev, head, txn->rl, MGR_TX_MSG);
> +}
> +
> +static int msm_set_laddr(struct slim_controller *ctrl,
> +				struct slim_eaddr *ead, u8 laddr)
> +{
> +	struct msm_slim_ctrl *dev = slim_get_ctrldata(ctrl);
> +	u8 buf[7];
> +	int ret;
> +	struct slim_val_inf msg = {0};
> +
> +	DEFINE_SLIM_EDEST_TXN(txn, SLIM_MSG_MC_ASSIGN_LOGICAL_ADDRESS,
> +			      10, laddr, &msg);
> +
> +	/* Enumeration address */
> +	buf[0] = (u8)(ead->manf_id >> 8);
> +	buf[1] = (u8)(ead->manf_id & 0xFF);
> +	buf[2] = (u8) (ead->prod_code >> 8);
> +	buf[3] = (u8) (ead->prod_code & 0xFF);
> +	buf[4] = ead->dev_index;
> +	buf[5] = ead->instance;
> +
> +	/* Logical address for this EA */
> +	buf[6] = laddr;

This would be easier to deal with in the form of:

struct foo {
	__le16 manf_id;
	__le16 prod_code;
	u8 dev_idx;
	u8 instance;
	u8 laddr;
};

And it doesn't look like a "buf", it looks like a packet of some
specific type, so it could be given a better name.

> +
> +	/**
> +	 * Retries are needed since bus may lose sync when multiple devices
> +	 * are coming up and reporting present
> +	 */

Is this a todo? I'm not sure how this relates to the code.

> +	msg.wbuf = buf;
> +	msg.num_bytes = 7;
> +
> +	ret = slim_processtxn(&dev->ctrl, &txn);
> +
> +	if (ret)
> +		dev_err(dev->dev, "set LA:0x%x failed:ret:%d\n",
> +				  laddr, ret);
> +	return ret;
> +}
> +
> +static void msm_slim_rxwq(struct work_struct *work)
> +{
> +	u8 buf[40];

40? Are you perhaps trying to say SLIM_MSGQ_BUF_LEN?

> +	u8 mc, mt, len;
> +	int i, ret;
> +	struct msm_slim_ctrl *dev = container_of(work, struct msm_slim_ctrl,
> +						 wd);
> +
> +	while ((slim_return_rx(&dev->ctrl, buf)) != -ENODATA) {
> +		len = buf[0] & 0x1F;
> +		mt = (buf[0] >> 5) & 0x7;
> +		mc = buf[1];

How about describing this like:

struct some_pkt {
	u8 len:5;
	u8 mt:3;
	u8 mc;

	__le16 manf_id;
	__le16 prod_code;
	u8 dev_idx;
	u8 instance;
};

But perhaps manf_id and prod_code are big endian here? I'm getting
confused from this code.

> +		if (mt == SLIM_MSG_MT_CORE &&
> +			mc == SLIM_MSG_MC_REPORT_PRESENT) {
> +			u8 laddr;
> +			struct slim_eaddr ea;
> +			u8 e_addr[6];
> +
> +			for (i = 0; i < 6; i++)
> +				e_addr[i] = buf[7-i];
> +
> +			ea.manf_id = (u16)(e_addr[5] << 8) | e_addr[4];
> +			ea.prod_code = (u16)(e_addr[3] << 8) | e_addr[2];
> +			ea.dev_index = e_addr[1];
> +			ea.instance = e_addr[0];
> +			ret = slim_assign_laddr(&dev->ctrl, &ea, &laddr, false);
> +			if (ret)
> +				dev_err(dev->dev, "assign laddr failed:%d\n",
> +					ret);
> +		} else {
> +			dev_err(dev->dev, "unexpected message:mc:%x, mt:%x\n",
> +				mc, mt);

The idiomatic way is to deal with errors first and then you don't have
to indent the normal code path.

> +
> +		}
> +
> +	}
> +}
> +
> +static void msm_slim_prg_slew(struct platform_device *pdev,
> +				struct msm_slim_ctrl *dev)
> +{
> +	void __iomem *slew_reg;
> +
> +	/* SLEW RATE register for this slimbus */
> +	dev->slew_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,

This is a local variable...

> +						     "slew");
> +	if (!dev->slew_mem) {
> +		dev_warn(&pdev->dev, "no slimbus slew resource\n");
> +		return;
> +	}
> +

It's idiomatic to do:

	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "slew");
	slew_reg = devm_ioremap_resource(&pdev->dev, res);
	if (IS_ERR(slew_reg))
		...


> +	slew_reg = devm_ioremap(&pdev->dev, dev->slew_mem->start,
> +				resource_size(dev->slew_mem));
> +	if (!slew_reg) {
> +		dev_err(dev->dev, "slew register mapping failed");

Is this not a problem? Is it okay to silently discard this error.

> +		release_mem_region(dev->slew_mem->start,
> +					resource_size(dev->slew_mem));
> +		dev->slew_mem = NULL;
> +		return;
> +	}
> +	writel_relaxed(1, slew_reg);
> +	/* Make sure slimbus-slew rate enabling goes through */

This is not what wmb() does. If you want to ensure that it's written do
a readback.

> +	wmb();

There's no reason to keep the slew register mapped beyond this function,
so you could drop the devm_ and iounmap() slew_reg here again.


If there's a reason to touch this in the future, then keep track of
slew_reg rather than the slew_mem...

> +}
> +
> +static int msm_slim_probe(struct platform_device *pdev)
> +{
> +	struct msm_slim_ctrl *dev;

"dev" is not the best name for this (dev->dev?!)

> +	struct slim_controller *ctrl;
> +	struct resource *slim_mem;
> +	struct resource *irq;
> +	struct clk *hclk, *rclk;

Why the odd names?

> +	int ret;
> +
> +	hclk = devm_clk_get(&pdev->dev, "iface_clk");
> +	if (IS_ERR(hclk))
> +		return PTR_ERR(hclk);
> +
> +	rclk = devm_clk_get(&pdev->dev, "core_clk");
> +	if (IS_ERR(rclk)) {
> +		/* unlikely that this is probe-defer */

Do this properly.

> +		dev_err(&pdev->dev, "rclk get failed:%ld\n", PTR_ERR(rclk));
> +		return PTR_ERR(rclk);
> +	}
> +
> +	ret = clk_set_rate(rclk, SLIM_ROOT_FREQ);
> +	if (ret) {
> +		dev_err(&pdev->dev, "ref-clock set-rate failed:%d\n", ret);
> +		return ret;
> +	}
> +
> +	slim_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");

Move this down to the devm_ioremap() and skip the error check.

> +	if (!slim_mem) {
> +		dev_err(&pdev->dev, "no slimbus physical memory resource\n");
> +		return -ENODEV;
> +	}
> +
> +	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!irq) {
> +		dev_err(&pdev->dev, "no slimbus IRQ resource\n");
> +		return -ENODEV;
> +	}
> +
> +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);

If you allocate this earlier you can reduce the number of local
variables.

> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->hclk = hclk;
> +	dev->rclk = rclk;
> +	ctrl = &dev->ctrl;
> +	dev->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, dev);
> +	slim_set_ctrldata(&dev->ctrl, dev);
> +	dev->base = devm_ioremap(dev->dev, slim_mem->start,
> +				 resource_size(slim_mem));

devm_ioremap_resource()

> +	if (!dev->base) {
> +		dev_err(&pdev->dev, "IOremap failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	dev->ctrl.set_laddr = msm_set_laddr;
> +	dev->ctrl.xfer_msg = msm_xfer_msg;
> +	dev->ctrl.tx.n = MSM_TX_MSGS;
> +	dev->ctrl.rx.n = MSM_RX_MSGS;
> +	dev->ctrl.tx.sl_sz = SLIM_MSGQ_BUF_LEN;
> +	dev->ctrl.rx.sl_sz = SLIM_MSGQ_BUF_LEN;
> +
> +	dev->irq = irq->start;

Use platform_get_irq() instead and you don't need to do this.

> +
> +	INIT_WORK(&dev->wd, msm_slim_rxwq);
> +	dev->rxwq = create_singlethread_workqueue("msm_slim_rx");
> +	if (!dev->rxwq) {
> +		dev_err(dev->dev, "Failed to start Rx WQ\n");
> +		return -ENOMEM;
> +	}
> +
> +	dev->framer.rootfreq = SLIM_ROOT_FREQ >> 3;

Dividing by 8 makes the code readable, compilers will make sure it's
still super fast.

> +	dev->framer.superfreq =
> +		dev->framer.rootfreq / SLIM_CL_PER_SUPERFRAME_DIV8;
> +	dev->ctrl.a_framer = &dev->framer;
> +	dev->ctrl.clkgear = SLIM_MAX_CLK_GEAR;
> +	dev->ctrl.dev.parent = &pdev->dev;
> +	dev->ctrl.dev.of_node = pdev->dev.of_node;
> +
> +	msm_slim_prg_slew(pdev, dev);
> +
> +	ret = devm_request_irq(&pdev->dev, dev->irq, msm_slim_interrupt,
> +				IRQF_TRIGGER_HIGH, "msm_slim_irq", dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "request IRQ failed\n");
> +		goto err_request_irq_failed;
> +	}

At this point you might get interrupts, which I presume will try to
access the registers which you start clocking on the next line. Please
reorder these.

> +
> +	ret = clk_prepare_enable(hclk);
> +	if (ret)
> +		goto err_hclk_enable_failed;
> +
> +	ret = clk_prepare_enable(rclk);
> +	if (ret)
> +		goto err_rclk_enable_failed;

Use the clk_bulk api instead.

> +
> +
> +	ctrl->tx.base = dma_alloc_coherent(&pdev->dev,
> +					   (ctrl->tx.sl_sz * ctrl->tx.n),
> +					   &ctrl->tx.phy, GFP_KERNEL);
> +	if (!ctrl->tx.base) {
> +		ret = -ENOMEM;
> +		goto tx_alloc_failed;
> +	}
> +
> +	ctrl->rx.base = dma_alloc_coherent(&pdev->dev,
> +					   (ctrl->rx.sl_sz * ctrl->rx.n),
> +					   &ctrl->rx.phy, GFP_KERNEL);
> +	if (!ctrl->rx.base) {
> +		ret = -ENOMEM;
> +		goto rx_alloc_failed;
> +	}
> +
> +
> +	/* Register with framework before enabling frame, clock */
> +	ret = slim_register_controller(&dev->ctrl);
> +	if (ret) {
> +		dev_err(dev->dev, "error adding controller\n");
> +		goto err_ctrl_failed;
> +	}
> +
> +	dev->ver = readl_relaxed(dev->base);
> +	/* Version info in 16 MSbits */
> +	dev->ver >>= 16;
> +	/* Component register initialization */
> +	writel_relaxed(1, dev->base + CFG_PORT(COMP_CFG, dev->ver));

Use non-relaxed writel, unless there's a good reason not to.

> +	writel_relaxed((EE_MGR_RSC_GRP | EE_NGD_2 | EE_NGD_1),
> +				dev->base + CFG_PORT(COMP_TRUST_CFG, dev->ver));
> +
> +	writel_relaxed((MGR_INT_TX_NACKED_2 |
> +			MGR_INT_MSG_BUF_CONTE | MGR_INT_RX_MSG_RCVD |
> +			MGR_INT_TX_MSG_SENT), dev->base + MGR_INT_EN);
> +	writel_relaxed(1, dev->base + MGR_CFG);
> +	/*
> +	 * Framer registers are beyond 1K memory region after Manager and/or
> +	 * component registers. Make sure those writes are ordered
> +	 * before framer register writes
> +	 */

Drop this comment and just use a non-relaxed writel for the framer
registration initialization.

> +	wmb();
> +
> +	/* Framer register initialization */
> +	writel_relaxed((1 << INTR_WAKE) | (0xA << REF_CLK_GEAR) |
> +		(0xA << CLK_GEAR) | (1 << ROOT_FREQ) | (1 << FRM_ACTIVE) | 1,
> +		dev->base + FRM_CFG);
> +	/*
> +	 * Make sure that framer wake-up and enabling writes go through
> +	 * before any other component is enabled. Framer is responsible for
> +	 * clocking the bus and enabling framer first will ensure that other
> +	 * devices can report presence when they are enabled
> +	 */
> +	mb();

Drop this mb and use writel()

> +
> +	writel_relaxed(MGR_CFG_ENABLE, dev->base + MGR_CFG);
> +	/*
> +	 * Make sure that manager-enable is written through before interface
> +	 * device is enabled

Dito

> +	 */
> +	mb();
> +	writel_relaxed(1, dev->base + INTF_CFG);
> +	/*
> +	 * Make sure that interface-enable is written through before enabling
> +	 * ported generic device inside MSM manager
> +	 */

Dito

> +	mb();
> +
> +	writel_relaxed(1, dev->base + CFG_PORT(COMP_CFG, dev->ver));
> +	/*
> +	 * Make sure that all writes have gone through before exiting this
> +	 * function
> +	 */

Dito

> +	mb();
> +
> +	dev_dbg(dev->dev, "MSM SB controller is up:ver:0x%x!\n", dev->ver);
> +	return 0;
> +
> +err_ctrl_failed:
> +	dma_free_coherent(&pdev->dev, (ctrl->rx.sl_sz * ctrl->rx.n),
> +			  ctrl->rx.base, ctrl->rx.phy);
> +rx_alloc_failed:
> +	dma_free_coherent(ctrl->dev.parent, (ctrl->tx.sl_sz * ctrl->tx.n),
> +			  ctrl->tx.base, ctrl->tx.phy);
> +tx_alloc_failed:
> +	clk_disable_unprepare(dev->rclk);
> +err_rclk_enable_failed:
> +	clk_disable_unprepare(dev->hclk);
> +
> +err_hclk_enable_failed:
> +err_request_irq_failed:
> +	destroy_workqueue(dev->rxwq);
> +	return ret;
> +}
> +
> +static int msm_slim_remove(struct platform_device *pdev)
> +{
> +	struct msm_slim_ctrl *dev = platform_get_drvdata(pdev);
> +	struct slim_controller *ctrl = to_slim_controller(&pdev->dev);
> +
> +	dma_free_coherent(&pdev->dev, (ctrl->rx.sl_sz * ctrl->rx.n),
> +			  ctrl->rx.base, ctrl->rx.phy);
> +	dma_free_coherent(&pdev->dev, (ctrl->tx.sl_sz * ctrl->tx.n),
> +			  ctrl->tx.base, ctrl->tx.phy);

Don't you at least want to disable irqs before you free this memory?

> +
> +	disable_irq(dev->irq);
> +	clk_disable_unprepare(dev->rclk);
> +	clk_disable_unprepare(dev->hclk);
> +	slim_del_controller(&dev->ctrl);
> +	destroy_workqueue(dev->rxwq);
> +	return 0;
> +}
> +
> +static const struct of_device_id msm_slim_dt_match[] = {
> +	{
> +		.compatible = "qcom,slim",
> +	},
> +	{}
> +};
> +
> +static struct platform_driver msm_slim_driver = {
> +	.probe = msm_slim_probe,
> +	.remove = msm_slim_remove,
> +	.driver	= {
> +		.name = MSM_SLIM_NAME,
> +		.owner = THIS_MODULE,

No "owner"

> +		.of_match_table = msm_slim_dt_match,
> +	},
> +};
> +module_platform_driver(msm_slim_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_VERSION("0.1");

Skip the version, we'll never update it anyways.

> +MODULE_DESCRIPTION("Qualcomm Slimbus controller");
> +MODULE_ALIAS("platform:qcom-slim");

No-one will request the module by this alias, so skip it.

> diff --git a/drivers/slimbus/slim-qcom.h b/drivers/slimbus/slim-qcom.h
> new file mode 100644
> index 0000000..0ad59c3
> --- /dev/null
> +++ b/drivers/slimbus/slim-qcom.h

As far as I can see this information is all local to lim-qcom-ctrl.c, so
put it there.

> @@ -0,0 +1,63 @@
> +/* Copyright (c) 2011-2016, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _SLIM_QCOM_H
> +#define _SLIM_QCOM_H
> +
> +#include <linux/irq.h>
> +#include <linux/workqueue.h>
> +
> +#define QC_MFGID_LSB	0x2
> +#define QC_MFGID_MSB	0x17

Unused.

> +
> +#define SLIM_MSG_ASM_FIRST_WORD(l, mt, mc, dt, ad) \
> +		((l) | ((mt) << 5) | ((mc) << 8) | ((dt) << 15) | ((ad) << 16))
> +
> +#define SLIM_ROOT_FREQ 24576000
> +
> +/* MAX message size over control channel */
> +#define SLIM_MSGQ_BUF_LEN	40
> +#define MSM_TX_MSGS 2
> +#define MSM_RX_MSGS	8
> +
> +#define CFG_PORT(r, v) ((v) ? CFG_PORT_V2(r) : CFG_PORT_V1(r))
> +
> +/* V2 Component registers */
> +#define CFG_PORT_V2(r) ((r ## _V2))
> +#define	COMP_CFG_V2		4
> +#define	COMP_TRUST_CFG_V2	0x3000
> +
> +/* V1 Component registers */
> +#define CFG_PORT_V1(r) ((r ## _V1))
> +#define	COMP_CFG_V1		0
> +#define	COMP_TRUST_CFG_V1	0x14
> +
> +/* Resource group info for manager, and non-ported generic device-components */
> +#define EE_MGR_RSC_GRP	(1 << 10)
> +#define EE_NGD_2	(2 << 6)
> +#define EE_NGD_1	0
> +
> +struct msm_slim_ctrl {
> +	struct slim_controller  ctrl;
> +	struct slim_framer	framer;
> +	struct device		*dev;
> +	void __iomem		*base;
> +	struct resource		*slew_mem;
> +	int			irq;
> +	struct workqueue_struct *rxwq;
> +	struct work_struct	wd;
> +	struct clk		*rclk;
> +	struct clk		*hclk;
> +	u32			ver;

"ver" is only used within probe(), use a local variable instead.

> +};
> +
> +#endif

Regards,
Bjorn
