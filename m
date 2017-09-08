From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [alsa-devel] [PATCH 4/6] ASoC: Intel: Skylake: Register clock
 device and ops
Date: Fri, 8 Sep 2017 10:31:21 +0530
Message-ID: <20170908050120.GC19877@subhransu-desktop>
References: <1504794565-19168-1-git-send-email-subhransu.s.prusty@intel.com>
 <1504794565-19168-5-git-send-email-subhransu.s.prusty@intel.com>
 <6e21a038-96d4-b58d-b1c7-ba5a5f32e7a8@linux.intel.com>
 <20170908033135.GB19877@subhransu-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170908033135.GB19877@subhransu-desktop>
Sender: linux-clk-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, harshapriya.n@intel.com, tiwai@suse.de, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, patches.audio@intel.com, broonie@kernel.org, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 08, 2017 at 09:01:36AM +0530, Subhransu S. Prusty wrote:
> On Thu, Sep 07, 2017 at 08:48:38PM -0500, Pierre-Louis Bossart wrote:
> > 
> > 
> > On 09/07/2017 09:29 AM, Subhransu S. Prusty wrote:
> > >From: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
> > >
> > >Create a platform device and register the clock ops. Clock
> > >prepare/unprepare are used to enable/disable the clock as the IPC will be
> > >sent in non-atomic context. The clk set_dma_control IPC structures are
> > >populated during the set_rate callback and IPC is sent to enable the clock
> > >during prepare callback.
> > >
> > [snip]
> > >+
> > >+static int skl_clk_prepare(void *pvt_data, u32 id, unsigned long rate)
> > >+{
> > >+	struct skl *skl = pvt_data;
> > >+	struct skl_clk_rate_cfg_table *rcfg;
> > >+	int vbus_id, clk_type, ret;
> > >+
> > >+	clk_type = skl_get_clk_type(id);
> > >+	if (clk_type < 0)
> > >+		return -EINVAL;
> > >+
> > >+	ret = skl_get_vbus_id(id, clk_type);
> > >+	if (ret < 0)
> > >+		return ret;
> > >+
> > >+	vbus_id = ret;
> > >+
> > >+	rcfg = skl_get_rate_cfg(skl_ssp_clks[id].rate_cfg, rate);
> > >+	if (!rcfg)
> > >+		return -EINVAL;
> > >+
> > >+	ret = skl_send_clk_dma_control(skl, rcfg, vbus_id, clk_type, true);
> > >+
> > >+	return ret;
> > >+}
> > In this patchset, the clocks are configured from the machine driver,
> > and the enable/disable conveniently placed in
> > platform_clock_control() or hw_params(), where the DSP is most
> > likely active.
> > If you expose a clock, codec driver implementers may want to use
> > them directly instead of relying on a machine driver. A number of
> > existing codecs do use the clk API, so there could be a case where a
> > codec driver calls devm_clk_get and clk_prepare_enable(), without
> > any ability to know what state the DSP is in.
> > What happens then if the DSP is in suspend? Does this force it back
> > to D0? Does the virtual clock driver return an error? Or are you
> > using the clk API with some restrictions on when the clock can be
> > configured?
> 
> No, clk enable will not force the DSP to D0. So if the DSP is not active,
> the IPC will timeout and error will be propagated to the caller.

Or may be it makes sense to enable the runtime pm for clk driver so that it
can activate the DSP. I will check this.

> 
> > 
> > Note that I am not against this idea, it's fine, but I'd like more
> > clarity on the assumptions. Thanks!
> 
> I agree. I will add some comments explaining the expectation.
> 
> Thanks
> Subhransu
> 
> > 
> > >+
> > >+static int skl_clk_unprepare(void *pvt_data, u32 id, unsigned long rate)
> > >+{
> > >+	struct skl *skl = pvt_data;
> > >+	struct skl_clk_rate_cfg_table *rcfg;
> > >+	int vbus_id, ret;
> > >+	u8 clk_type;
> > >+
> > >+	clk_type = skl_get_clk_type(id);
> > >+	ret = skl_get_vbus_id(id, clk_type);
> > >+	if (ret < 0)
> > >+		return ret;
> > >+
> > >+	vbus_id = ret;
> > >+
> > >+	rcfg = skl_get_rate_cfg(skl_ssp_clks[id].rate_cfg, rate);
> > >+	if (!rcfg)
> > >+		return -EINVAL;
> > >+
> > >+	return skl_send_clk_dma_control(skl, rcfg, vbus_id, clk_type, false);
> > >+}
> > >+
> > >+static int skl_clk_set_rate(u32 id, unsigned long rate)
> > >+{
> > >+	struct skl_clk_rate_cfg_table *rcfg;
> > >+	u8 clk_type;
> > >+
> > >+	if (!rate)
> > >+		return -EINVAL;
> > >+
> > >+	clk_type = skl_get_clk_type(id);
> > >+	rcfg = skl_get_rate_cfg(skl_ssp_clks[id].rate_cfg, rate);
> > >+	if (!rcfg)
> > >+		return -EINVAL;
> > >+
> > >+	skl_fill_clk_ipc(rcfg, clk_type);
> > >+
> > >+	return 0;
> > >+}
> > >+
> > >+unsigned long skl_clk_recalc_rate(u32 id, unsigned long parent_rate)
> > >+{
> > >+	struct skl_clk_rate_cfg_table *rcfg;
> > >+	u8 clk_type;
> > >+
> > >+	clk_type = skl_get_clk_type(id);
> > >+	rcfg = skl_get_rate_cfg(skl_ssp_clks[id].rate_cfg, parent_rate);
> > >+	if (!rcfg)
> > >+		return 0;
> > >+
> > >+	skl_fill_clk_ipc(rcfg, clk_type);
> > >+
> > >+	return rcfg->rate;
> > >+}
> > >+
> > >  static int skl_machine_device_register(struct skl *skl, void *driver_data)
> > >  {
> > >  	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
> > >@@ -555,10 +682,21 @@ void init_skl_xtal_rate(int pci_id)
> > >  	}
> > >  }
> > >+/*
> > >+ * prepare/unprepare are used instead of enable/disable as IPC will be sent
> > >+ * in non-atomic context.
> > >+ */
> > >+static struct skl_clk_ops clk_ops = {
> > >+	.prepare = skl_clk_prepare,
> > >+	.unprepare = skl_clk_unprepare,
> > >+	.set_rate = skl_clk_set_rate,
> > >+	.recalc_rate = skl_clk_recalc_rate,
> > >+};
> > >+
> > >  static int skl_clock_device_register(struct skl *skl)
> > >  {
> > >  	struct skl_clk_pdata *clk_pdata;
> > >-
> > >+	struct platform_device_info pdevinfo = {NULL};
> > >  	clk_pdata = devm_kzalloc(&skl->pci->dev, sizeof(*clk_pdata),
> > >  							GFP_KERNEL);
> > >@@ -573,10 +711,28 @@ static int skl_clock_device_register(struct skl *skl)
> > >  	/* Query NHLT to fill the rates and parent */
> > >  	skl_get_clks(skl, clk_pdata->ssp_clks);
> > >+	clk_pdata->ops = &clk_ops;
> > >+	clk_pdata->pvt_data = skl;
> > >+
> > >+	/* Register Platform device */
> > >+	pdevinfo.parent = &skl->pci->dev;
> > >+	pdevinfo.id = -1;
> > >+	pdevinfo.name = "skl-ssp-clk";
> > >+	pdevinfo.data = clk_pdata;
> > >+	pdevinfo.size_data = sizeof(*clk_pdata);
> > >+	skl->clk_dev = platform_device_register_full(&pdevinfo);
> > >+	if (IS_ERR(skl->clk_dev))
> > >+		return PTR_ERR(skl->clk_dev);
> > >  	return 0;
> > >  }
> > >+static void skl_clock_device_unregister(struct skl *skl)
> > >+{
> > >+	if (skl->clk_dev)
> > >+		platform_device_unregister(skl->clk_dev);
> > >+}
> > >+
> > >  /*
> > >   * Probe the given codec address
> > >   */
> > >@@ -859,6 +1015,11 @@ static int skl_probe(struct pci_dev *pci,
> > >  	/* check if dsp is there */
> > >  	if (bus->ppcap) {
> > >+		/* create device for dsp clk */
> > >+		err = skl_clock_device_register(skl);
> > >+		if (err < 0)
> > >+			goto out_clk_free;
> > >+
> > >  		err = skl_machine_device_register(skl,
> > >  				  (void *)pci_id->driver_data);
> > >  		if (err < 0)
> > >@@ -890,6 +1051,8 @@ static int skl_probe(struct pci_dev *pci,
> > >  	skl_free_dsp(skl);
> > >  out_mach_free:
> > >  	skl_machine_device_unregister(skl);
> > >+out_clk_free:
> > >+	skl_clock_device_unregister(skl);
> > >  out_nhlt_free:
> > >  	skl_nhlt_free(skl->nhlt);
> > >  out_free:
> > >@@ -940,6 +1103,7 @@ static void skl_remove(struct pci_dev *pci)
> > >  	skl_free_dsp(skl);
> > >  	skl_machine_device_unregister(skl);
> > >  	skl_dmic_device_unregister(skl);
> > >+	skl_clock_device_unregister(skl);
> > >  	skl_nhlt_remove_sysfs(skl);
> > >  	skl_nhlt_free(skl->nhlt);
> > >  	skl_free(ebus);
> > >diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
> > >index f06e98962a0b..df0fcf1bfe40 100644
> > >--- a/sound/soc/intel/skylake/skl.h
> > >+++ b/sound/soc/intel/skylake/skl.h
> > >@@ -57,6 +57,7 @@ struct skl {
> > >  	unsigned int init_done:1; /* delayed init status */
> > >  	struct platform_device *dmic_dev;
> > >  	struct platform_device *i2s_dev;
> > >+	struct platform_device *clk_dev;
> > >  	struct snd_soc_platform *platform;
> > >  	struct nhlt_acpi_table *nhlt; /* nhlt ptr */
> > 
> 
> -- 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-clk" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
