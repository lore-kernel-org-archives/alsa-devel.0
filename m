From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3 01/14] ASoC: SOF: Add Sound Open
	Firmware driver core
Date: Wed, 12 Dec 2018 22:42:30 +0200
Message-ID: <CAEnQRZCErG3MGpMG229Lmcf38tmS_MQeo9Z5-Egd0vSGzt6W-w@mail.gmail.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211212318.28644-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, andriy.shevchenko@intel.com, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, alan@linux.intel.com, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks a lot Pierre, Liam and all the people at Intel for does such a great job
with this project!

Few comments inline:

<snip>

> +/* SOF probe type */
> +enum sof_device_type {
> +       SOF_DEVICE_PCI = 0,
> +       SOF_DEVICE_APCI,
> +       SOF_DEVICE_SPI

Maybe comma after last element here? We have at least one more: SOF_DEVICE_DT.

> +static int sof_probe(struct platform_device *pdev)
> +{
> +       struct snd_sof_pdata *plat_data = dev_get_platdata(&pdev->dev);
> +       struct snd_sof_dev *sdev;
> +       const char *drv_name;
> +       const void *mach;
> +       int size;
> +       int ret;
> +
> +       sdev = devm_kzalloc(&pdev->dev, sizeof(*sdev), GFP_KERNEL);
> +       if (!sdev)
> +               return -ENOMEM;
> +
> +       dev_dbg(&pdev->dev, "probing SOF DSP device....\n");
> +
> +       /* initialize sof device */
> +       sdev->dev = &pdev->dev;
> +       sdev->parent = plat_data->dev;
> +       if (plat_data->type == SOF_DEVICE_PCI)
> +               sdev->pci = container_of(plat_data->dev, struct pci_dev, dev);
> +       sdev->ops = plat_data->machine->pdata;
> +
> +       sdev->pdata = plat_data;
> +       sdev->first_boot = true;
> +       INIT_LIST_HEAD(&sdev->pcm_list);
> +       INIT_LIST_HEAD(&sdev->kcontrol_list);
> +       INIT_LIST_HEAD(&sdev->widget_list);
> +       INIT_LIST_HEAD(&sdev->dai_list);
> +       INIT_LIST_HEAD(&sdev->route_list);
> +       dev_set_drvdata(&pdev->dev, sdev);
> +       spin_lock_init(&sdev->ipc_lock);
> +       spin_lock_init(&sdev->hw_lock);
> +
> +       /* set up platform component driver */
> +       snd_sof_new_platform_drv(sdev);
> +
> +       /* set default timeouts if none provided */
> +       if (plat_data->desc->ipc_timeout == 0)
> +               sdev->ipc_timeout = TIMEOUT_DEFAULT_IPC;
> +       else
> +               sdev->ipc_timeout = plat_data->desc->ipc_timeout;
> +       if (plat_data->desc->boot_timeout == 0)
> +               sdev->boot_timeout = TIMEOUT_DEFAULT_BOOT;
> +       else
> +               sdev->boot_timeout = plat_data->desc->boot_timeout;
> +
> +       /* probe the DSP hardware */
> +       ret = snd_sof_probe(sdev);

Something looks fishy here.

I couldn't find this function's definition anywhere in the first
patch which means that after first patch the code doesn't compile :D.

For bisection reasons would be great if the code compiles after each patch.

<snip>

> +       /* now register audio DSP platform driver and dai */
> +       ret = snd_soc_register_component(&pdev->dev,  &sdev->plat_drv,
> +                                        sdev->ops->drv,
> +                                        sdev->ops->num_drv);
> +       if (ret < 0) {
> +               dev_err(sdev->dev,
> +                       "error: failed to register DSP DAI driver %d\n", ret);
> +               goto comp_err;

This goes to snd_soc_unregister_component which is not really needed because
the component didn't register succcesfully.

<snd>

> +comp_err:
> +       snd_soc_unregister_component(&pdev->dev);
> +       snd_sof_free_topology(sdev);

It is not very clear to me where does the snd_sof_load_topology it is called
so that there is a need to free it here.

> +static int sof_remove(struct platform_device *pdev)
> +{
> +       struct snd_sof_dev *sdev = dev_get_drvdata(&pdev->dev);
> +       struct snd_sof_pdata *pdata = sdev->pdata;
> +
> +       if (pdata && !IS_ERR(pdata->pdev_mach))
> +               platform_device_unregister(pdata->pdev_mach);
> +
> +       snd_soc_unregister_component(&pdev->dev);
> +       snd_sof_fw_unload(sdev);
> +       snd_sof_ipc_free(sdev);
> +       snd_sof_free_debug(sdev);
> +       snd_sof_free_trace(sdev);
> +       snd_sof_remove(sdev);

There is no snd_sof_free_topology here. Which means that either this
call is not needed in the
probe function or it is missing from here.

> +void snd_sof_shutdown(struct device *dev)
> +{
> +}
> +EXPORT_SYMBOL(snd_sof_shutdown);

I would avoid this empty function calls for the moment.
Will add it later when there is a need for it.

<snip>

> +/*
> + * SOF Device Level.
> + */
> +struct snd_sof_dev {
> +       struct device *dev;
> +       struct device *parent;
> +       spinlock_t ipc_lock;    /* lock for IPC users */
> +       spinlock_t hw_lock;     /* lock for HW IO access */
> +       struct pci_dev *pci;
> +
> +       /* ASoC components */
> +       struct snd_soc_component_driver plat_drv;
> +
> +       /* DSP firmware boot */
> +       wait_queue_head_t boot_wait;
> +       u32 boot_complete;
> +       u32 first_boot;
> +
> +       /* DSP HW differentiation */
> +       struct snd_sof_pdata *pdata;
> +       const struct snd_sof_dsp_ops *ops;
> +       struct sof_intel_hda_dev *hda;  /* for HDA based DSP HW */

Just a design question. Is it ok to hold SOC specific data here? For example on
arm there is no HDA but there is some other DAI. Would it be ok for me to just
add it here?

thanks,
Daniel.
