From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: writing an alsa driver
Date: Thu, 28 May 2015 14:21:34 +0100
Message-ID: <1432819294.2726.33.camel@loki>
References: <20150521145232.GA12157@dellaz> <20150523163221.GA936@asus>
 <s5h7fruecx4.wl-tiwai@suse.de> <20150527085440.GA4445@dellaz>
 <1432752116.8235.25.camel@loki> <20150527201320.GA309@asus>
 <1432812668.2726.18.camel@loki> <20150528125325.GA418@asus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 43EBC266094
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 15:21:37 +0200 (CEST)
In-Reply-To: <20150528125325.GA418@asus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michele Curti <michele.curti@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-05-28 at 14:53 +0200, Michele Curti wrote:
> On Thu, May 28, 2015 at 12:31:08PM +0100, Liam Girdwood wrote:
> > 
> > > [    2.000642] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
> > 
> > We are seeing a lot of these. Can you confirm whether this driver has
> > probed ? If not can you see it's ACPI ID listed
> > under /sys/bus/acpi/devices. 
> > 
> > If it's not probing, it may also have a different ACPI ID compared to
> > the reference driver. You may have to add an entry to sst-acpi.c i.e.
> > 
> > static struct sst_acpi_mach baytrail_machines[] = {
> > 	{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
> > 	{ "193C9890", "byt-max98090", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
> > 	{}
> > };
> > 
> > Liam
> >
> 
> Yes I already added an element in this list, I wrote:
> 
> static struct sst_acpi_mach baytrail_machines[] = {
> 	{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
> 	{ "10EC5648", "byt-rt5645", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
> 	{ "193C9890", "byt-max98090", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
> 	{}
> };
> 
> because in the i2c bus i saw:
> [zio@asus linux-next]$ ls /sys/bus/acpi/devices/ | grep 10EC
> 10EC5648:00

> 
> 
> About the probe, if I understood what you mean, the driver fails to probe
> because of the DSP boot timeout.
> 
> The probe function is called, I added some debug: 
> 
> static int sst_byt_pcm_dev_probe(struct platform_device *pdev)
> {
> 	struct sst_pdata *sst_pdata = dev_get_platdata(&pdev->dev);
> 	int ret;
> 
> 	ret = sst_byt_dsp_init(&pdev->dev, sst_pdata);
> 	if (ret < 0) {
> 		pr_info("sst_byt_pcm_dev_probe failed dsp init\n");
> 		return -ENODEV;
> 	}
> 
> 	ret = snd_soc_register_platform(&pdev->dev, &byt_soc_platform);
> 	if (ret < 0) {
> 		pr_info("sst_byt_pcm_dev_probe failed register platform\n");
> 		goto err_plat;
> 	}
> 
> 	ret = snd_soc_register_component(&pdev->dev, &byt_dai_component,
> 					 byt_dais, ARRAY_SIZE(byt_dais));
> 	if (ret < 0) {
> 		pr_info("sst_byt_pcm_dev_probe failed register component\n");
> 		goto err_comp;
> 	}
> 
> 	return 0;
> 
> err_comp:
> 	snd_soc_unregister_platform(&pdev->dev);
> err_plat:
> 	sst_byt_dsp_free(&pdev->dev, sst_pdata);
> 	return ret;
> }
> 
> and in dmesg I got:
> 
> [zio@asus ~]$ dmesg | grep probe
> [    1.794754] sst_byt_pcm_dev_probe failed dsp init
> 

Ok, so the DSP FW has been loaded but the FW is failing to boot. The FW
is just copied with memcpy() from the host to the DSP memory. Some
things to check :-

1) Does the DSP have a valid IRQ number and handler. The IRQ is used to
signal FW boot has completed.

2) Can you verify the FW data copied with memcpy by reading it back from
DSP memory. The DSP device may be in D3 here...

3) can you send the output of sst_byt_dump_shim() when boot fails.

Liam
