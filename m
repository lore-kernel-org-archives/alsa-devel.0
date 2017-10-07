From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [Patch v6 3/7] slimbus: qcom: Add Qualcomm Slimbus controller
 driver
Date: Sat, 7 Oct 2017 09:45:39 +0200
Message-ID: <20171007074539.mdvl5nw66it67l3g@latitude>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
 <20171006155136.4682-4-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7wf6ioxfgxxknq4p"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171006155136.4682-4-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org, sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org


--7wf6ioxfgxxknq4p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 06, 2017 at 05:51:32PM +0200, srinivas.kandagatla@linaro.org wr=
ote:
> From: Sagar Dharia <sdharia@codeaurora.org>
>=20
> This controller driver programs manager, interface, and framer
> devices for Qualcomm's slimbus HW block.
> Manager component currently implements logical address setting,
> and messaging interface.
> Interface device reports bus synchronization information, and framer
> device clocks the bus from the time it's woken up, until clock-pause
> is executed by the manager device.
>=20
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt |  43 ++
>  drivers/slimbus/Kconfig                            |   9 +
>  drivers/slimbus/Makefile                           |   3 +
>  drivers/slimbus/slim-qcom-ctrl.c                   | 594 +++++++++++++++=
++++++
>  drivers/slimbus/slim-qcom.h                        |  63 +++
>  5 files changed, 712 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-c=
trl.txt
>  create mode 100644 drivers/slimbus/slim-qcom-ctrl.c
>  create mode 100644 drivers/slimbus/slim-qcom.h
>=20
> diff --git a/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt=
 b/Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
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
> + - #address-cells - refer to Documentation/devicetree/bindings/slimbus/b=
us.txt
> + - #size-cells	- refer to Documentation/devicetree/bindings/slimbus/bus.=
txt
> +
> + - reg : Offset and length of the register region(s) for the device
> + - reg-names : Register region name(s) referenced in reg above
> +	 Required register resource entries are:
> +	 "ctrl": Physical adderess of controller register blocks

s/adderess/address/

> + - compatible : should be "qcom,<SOC-NAME>-slim" for SOC specific compat=
ible or
> + 		"qcom,slim" if using generic qcom SLIM IP.
> + - interrupts : Interrupt number used by this controller
> + - clocks : Interface and core clocks used by this slimbus controller
> + - clock-names : Required clock-name entries are:
> +	"iface_clk" : Interface clock for this controller
> +	"core_clk" : Interrupt for controller core's BAM
[...]

> +static irqreturn_t msm_slim_interrupt(int irq, void *d)
> +{
> +	struct msm_slim_ctrl *dev =3D d;
> +	u32 stat =3D readl_relaxed(dev->base + MGR_INT_STAT);
> +	int err =3D 0, ret =3D IRQ_NONE;
> +
> +	if (stat & MGR_INT_TX_MSG_SENT || stat & MGR_INT_TX_NACKED_2) {
> +		if (stat & MGR_INT_TX_MSG_SENT)
> +			writel_relaxed(MGR_INT_TX_MSG_SENT,
> +				       dev->base + MGR_INT_CLR);
> +		if (stat & MGR_INT_TX_NACKED_2) {
> +			u32 mgr_stat =3D readl_relaxed(dev->base + MGR_STATUS);
> +			u32 mgr_ie_stat =3D readl_relaxed(dev->base +
> +							MGR_IE_STAT);
> +			u32 frm_stat =3D readl_relaxed(dev->base + FRM_STAT);
> +			u32 frm_cfg =3D readl_relaxed(dev->base + FRM_CFG);
> +			u32 frm_intr_stat =3D readl_relaxed(dev->base +
> +							  FRM_INT_STAT);
> +			u32 frm_ie_stat =3D readl_relaxed(dev->base +
> +							FRM_IE_STAT);
> +			u32 intf_stat =3D readl_relaxed(dev->base + INTF_STAT);
> +			u32 intf_intr_stat =3D readl_relaxed(dev->base +
> +							   INTF_INT_STAT);
> +			u32 intf_ie_stat =3D readl_relaxed(dev->base +
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
> +			err =3D -ENOTCONN;
> +		}
> +		/**

This isn't really a kerneldoc comment=E2=80=A6

> +		 * Guarantee that interrupt clear bit write goes through before
> +		 * signalling completion/exiting ISR
> +		 */
> +		mb();
> +		slim_return_tx(&dev->ctrl, err);
> +		ret =3D IRQ_HANDLED;
> +	}
> +	if (stat & MGR_INT_RX_MSG_RCVD) {
> +		u8 mc, mt;
> +		u8 len, i;
> +		u32 *rx_buf, pkt[10];
> +		bool q_rx =3D false;
> +
> +		pkt[0] =3D readl_relaxed(dev->base + MGR_RX_MSG);
> +		mt =3D (pkt[0] >> 5) & 0x7;
> +		mc =3D (pkt[0] >> 8) & 0xff;
> +		len =3D pkt[0] & 0x1F;
> +		dev_dbg(dev->dev, "RX-IRQ: MC: %x, MT: %x\n", mc, mt);
> +
> +		/**

ditto

> +		 * this message cannot be handled by ISR, so
> +		 * let work-queue handle it
> +		 */
> +		if (mt =3D=3D SLIM_MSG_MT_CORE &&
> +			mc =3D=3D SLIM_MSG_MC_REPORT_PRESENT)
> +			rx_buf =3D (u32 *)slim_get_rx(&dev->ctrl);
> +		else
> +			rx_buf =3D pkt;
> +
> +		if (rx_buf =3D=3D NULL) {
> +			dev_err(dev->dev, "dropping RX:0x%x due to RX full\n",
> +						pkt[0]);
> +			goto rx_ret_irq;
> +		}
> +
> +		rx_buf[0] =3D pkt[0];
> +		for (i =3D 1; i < ((len + 3) >> 2); i++) {
> +			rx_buf[i] =3D readl_relaxed(dev->base + MGR_RX_MSG +
> +						(4 * i));
> +			dev_dbg(dev->dev, "reading data: %x\n", rx_buf[i]);
> +		}
> +
> +		switch (mc) {
> +			u8 *buf, la;
> +			u16 ele;
> +
> +		case SLIM_MSG_MC_REPORT_PRESENT:
> +			q_rx =3D true;
> +			break;
> +		case SLIM_MSG_MC_REPLY_INFORMATION:
> +		case SLIM_MSG_MC_REPLY_VALUE:
> +			slim_msg_response(&dev->ctrl, (u8 *)(rx_buf + 1),
> +					  (u8)(*rx_buf >> 24), (len - 4));
> +			break;
> +		case SLIM_MSG_MC_REPORT_INFORMATION:
> +			buf =3D (u8 *)rx_buf;
> +			la =3D buf[2];
> +			ele =3D (u16)buf[4] << 4;
> +
> +			ele |=3D ((buf[3] & 0xf0) >> 4);
> +			/**

ditto

> +			 * report information is most likely loss of
> +			 * sync or collision detected in data slots
> +			 */
> +			dev_err(dev->dev, "LA:%d report inf ele:0x%x\n",
> +				la, ele);
> +			for (i =3D 0; i < len - 5; i++)
> +				dev_err(dev->dev, "bit-mask:%x\n",
> +					buf[i+5]);
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

ditto

> +		 * Guarantee that CLR bit write goes through
> +		 * before exiting
> +		 */
> +		mb();
> +		if (q_rx)
> +			queue_work(dev->rxwq, &dev->wd);
> +
> +		ret =3D IRQ_HANDLED;
> +	}
> +	return ret;
> +}
[...]
> +static int msm_set_laddr(struct slim_controller *ctrl,
> +				struct slim_eaddr *ead, u8 laddr)
> +{
> +	struct msm_slim_ctrl *dev =3D slim_get_ctrldata(ctrl);
> +	u8 buf[7];
> +	int ret;
> +	struct slim_val_inf msg =3D {0};
> +
> +	DEFINE_SLIM_EDEST_TXN(txn, SLIM_MSG_MC_ASSIGN_LOGICAL_ADDRESS,
> +			      10, laddr, &msg);
> +
> +	/* Enumeration address */
> +	buf[0] =3D (u8)(ead->manf_id >> 8);
> +	buf[1] =3D (u8)(ead->manf_id & 0xFF);
> +	buf[2] =3D (u8) (ead->prod_code >> 8);
> +	buf[3] =3D (u8) (ead->prod_code & 0xFF);
> +	buf[4] =3D ead->dev_index;
> +	buf[5] =3D ead->instance;
> +
> +	/* Logical address for this EA */
> +	buf[6] =3D laddr;
> +
> +	/**

ditto

> +	 * Retries are needed since bus may lose sync when multiple devices
> +	 * are coming up and reporting present
> +	 */
> +	msg.wbuf =3D buf;
> +	msg.num_bytes =3D 7;
> +
> +	ret =3D slim_processtxn(&dev->ctrl, &txn);
> +
> +	if (ret)
> +		dev_err(dev->dev, "set LA:0x%x failed:ret:%d\n",
> +				  laddr, ret);
> +	return ret;
> +}
[...]
> +static void msm_slim_prg_slew(struct platform_device *pdev,
> +				struct msm_slim_ctrl *dev)
> +{
> +	void __iomem *slew_reg;
> +
> +	/* SLEW RATE register for this slimbus */
> +	dev->slew_mem =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						     "slew");
> +	if (!dev->slew_mem) {
> +		dev_warn(&pdev->dev, "no slimbus slew resource\n");
> +		return;
> +	}
> +
> +	slew_reg =3D devm_ioremap(&pdev->dev, dev->slew_mem->start,
> +				resource_size(dev->slew_mem));

How often will the driver program a slew rate?

If it's often, you'll have a "soft" memory leak over the life time of a
SLIM controller instance, because the mappings for slew_reg will
accumulate in the driver instance's devm area until they are all freed
in the end (If I'm reading the code correctly). I think you'll either
have to unmap slew_reg when this function returns (and not use devm), or
cache slew_reg so that subsequent calls to msm_slim_prg_slew won't
create more mappings.

> +	if (!slew_reg) {
> +		dev_err(dev->dev, "slew register mapping failed");
> +		release_mem_region(dev->slew_mem->start,
> +					resource_size(dev->slew_mem));
> +		dev->slew_mem =3D NULL;
> +		return;
> +	}
> +	writel_relaxed(1, slew_reg);
> +	/* Make sure slimbus-slew rate enabling goes through */
> +	wmb();
> +}
> +
> +static int msm_slim_probe(struct platform_device *pdev)
> +{
> +	struct msm_slim_ctrl *dev;
> +	struct slim_controller *ctrl;
> +	struct resource *slim_mem;
> +	struct resource *irq;
> +	struct clk *hclk, *rclk;
> +	int ret;
> +
> +	hclk =3D devm_clk_get(&pdev->dev, "iface_clk");
> +	if (IS_ERR(hclk))
> +		return PTR_ERR(hclk);
> +
> +	rclk =3D devm_clk_get(&pdev->dev, "core_clk");
> +	if (IS_ERR(rclk)) {
> +		/* unlikely that this is probe-defer */
> +		dev_err(&pdev->dev, "rclk get failed:%ld\n", PTR_ERR(rclk));
> +		return PTR_ERR(rclk);
> +	}
> +
> +	ret =3D clk_set_rate(rclk, SLIM_ROOT_FREQ);
> +	if (ret) {
> +		dev_err(&pdev->dev, "ref-clock set-rate failed:%d\n", ret);
> +		return ret;
> +	}
> +
> +	slim_mem =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl");
> +	if (!slim_mem) {
> +		dev_err(&pdev->dev, "no slimbus physical memory resource\n");
> +		return -ENODEV;
> +	}
> +
> +	irq =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!irq) {
> +		dev_err(&pdev->dev, "no slimbus IRQ resource\n");
> +		return -ENODEV;
> +	}
> +
> +	dev =3D devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	dev->hclk =3D hclk;
> +	dev->rclk =3D rclk;
> +	ctrl =3D &dev->ctrl;
> +	dev->dev =3D &pdev->dev;
> +	platform_set_drvdata(pdev, dev);
> +	slim_set_ctrldata(&dev->ctrl, dev);
> +	dev->base =3D devm_ioremap(dev->dev, slim_mem->start,
> +				 resource_size(slim_mem));
> +	if (!dev->base) {
> +		dev_err(&pdev->dev, "IOremap failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	dev->ctrl.set_laddr =3D msm_set_laddr;
> +	dev->ctrl.xfer_msg =3D msm_xfer_msg;
> +	dev->ctrl.tx.n =3D MSM_TX_MSGS;
> +	dev->ctrl.rx.n =3D MSM_RX_MSGS;
> +	dev->ctrl.tx.sl_sz =3D SLIM_MSGQ_BUF_LEN;
> +	dev->ctrl.rx.sl_sz =3D SLIM_MSGQ_BUF_LEN;
> +
> +	dev->irq =3D irq->start;
> +
> +	INIT_WORK(&dev->wd, msm_slim_rxwq);
> +	dev->rxwq =3D create_singlethread_workqueue("msm_slim_rx");
> +	if (!dev->rxwq) {
> +		dev_err(dev->dev, "Failed to start Rx WQ\n");
> +		return -ENOMEM;
> +	}
> +
> +	dev->framer.rootfreq =3D SLIM_ROOT_FREQ >> 3;
> +	dev->framer.superfreq =3D
> +		dev->framer.rootfreq / SLIM_CL_PER_SUPERFRAME_DIV8;
> +	dev->ctrl.a_framer =3D &dev->framer;
> +	dev->ctrl.clkgear =3D SLIM_MAX_CLK_GEAR;
> +	dev->ctrl.dev.parent =3D &pdev->dev;
> +	dev->ctrl.dev.of_node =3D pdev->dev.of_node;
> +
> +	msm_slim_prg_slew(pdev, dev);
> +
> +	ret =3D devm_request_irq(&pdev->dev, dev->irq, msm_slim_interrupt,
> +				IRQF_TRIGGER_HIGH, "msm_slim_irq", dev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "request IRQ failed\n");
> +		goto err_request_irq_failed;
> +	}
> +
> +	ret =3D clk_prepare_enable(hclk);
> +	if (ret)
> +		goto err_hclk_enable_failed;
> +
> +	ret =3D clk_prepare_enable(rclk);
> +	if (ret)
> +		goto err_rclk_enable_failed;
> +
> +
> +	ctrl->tx.base =3D dma_alloc_coherent(&pdev->dev,
> +					   (ctrl->tx.sl_sz * ctrl->tx.n),
> +					   &ctrl->tx.phy, GFP_KERNEL);

Use dmam_alloc_coherent?

> +	if (!ctrl->tx.base) {
> +		ret =3D -ENOMEM;
> +		goto tx_alloc_failed;
> +	}
> +
> +	ctrl->rx.base =3D dma_alloc_coherent(&pdev->dev,
> +					   (ctrl->rx.sl_sz * ctrl->rx.n),
> +					   &ctrl->rx.phy, GFP_KERNEL);

ditto

> +	if (!ctrl->rx.base) {
> +		ret =3D -ENOMEM;
> +		goto rx_alloc_failed;
> +	}
> +
> +
> +	/* Register with framework before enabling frame, clock */
> +	ret =3D slim_register_controller(&dev->ctrl);
> +	if (ret) {
> +		dev_err(dev->dev, "error adding controller\n");
> +		goto err_ctrl_failed;
> +	}
> +
> +	dev->ver =3D readl_relaxed(dev->base);
> +	/* Version info in 16 MSbits */
> +	dev->ver >>=3D 16;
> +	/* Component register initialization */
> +	writel_relaxed(1, dev->base + CFG_PORT(COMP_CFG, dev->ver));
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
> +
> +	writel_relaxed(MGR_CFG_ENABLE, dev->base + MGR_CFG);
> +	/*
> +	 * Make sure that manager-enable is written through before interface
> +	 * device is enabled
> +	 */
> +	mb();
> +	writel_relaxed(1, dev->base + INTF_CFG);
> +	/*
> +	 * Make sure that interface-enable is written through before enabling
> +	 * ported generic device inside MSM manager
> +	 */
> +	mb();
> +
> +	writel_relaxed(1, dev->base + CFG_PORT(COMP_CFG, dev->ver));
> +	/*
> +	 * Make sure that all writes have gone through before exiting this
> +	 * function
> +	 */
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


Thanks,
Jonathan Neusch=C3=A4fer

--7wf6ioxfgxxknq4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJZ2IYbAAoJEAgwRJqO81/bvA8P/irqjJ4X8xjU/b7EsPGqEcI7
JxT0eMpzcNQBPzFrQPghiuBN77tk1p90JysFmkejJ50h68thvqAgIW5Btwjy38Ye
/8iksWbRwtS3mcUNGI78ZQv2cpc1fFtBeQEwIUPih5J6rEfdiAh8LNr+4Zj6q4Nk
+oILiAV+pusWppOEnLwmhlYvYBC3PoPlYzJz2AS64hHhAtKDxiarL2yu59OSlrW2
P7I7Ba3YaZl9EXqlhuYaNMmbU93tuORuMpwRRAhRHgfdiV/Wzyu2FWRfyTViCi2m
kJGPofd73YtJvCI7R5Czg0asfOfyiWeE3ESjf8Gtpv7USK904P9gNtjso4OIpSq9
QfimhkdUHVbkkoXHbWJ3dCEtVBmdh3F5wyNYuQFMbZr/SsTGl08VQApMZlZiV92o
+sUSrKwYXTgjpXlIUpyvGh5QWgo53rIBNCxncgALNg8hIFTPZfdKyGhs/RRbj4h8
wvD31JrqjHvekGPa2eDcrRUFnKaK+s6mas8aNZBOINykyHTV+1hrIY3NMmrjUL14
vzmUhWBsoUV6iLOdaVMHIazkphAq0soA5/1wEu9da98dUrVMXPGMRz/wc59SB0If
A3bkv4ghzCvtC6p2M9NN/IlIgbIMIuPpytv167vWewMFzqMl9wAWqRIUwdn3hLXP
PTCOlDMn2kSBkKLUPBIF
=TyoC
-----END PGP SIGNATURE-----

--7wf6ioxfgxxknq4p--
