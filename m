From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 8/13] Intel SST sound card driver
Date: Mon, 3 Aug 2009 12:45:08 +0530
Message-ID: <98769532B4BB14429434178695419EAE5F76AC7D@bgsmsx501.gar.corp.intel.com>
References: <1246604775-12960-1-git-send-email-vinod.koul@intel.com>
	<20090704105743.GD10490@sirena.org.uk>
	<98769532B4BB14429434178695419EAE5BBC230C@bgsmsx501.gar.corp.intel.com>
	<20090707114227.GD14393@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5BC0AF65@bgsmsx501.gar.corp.intel.com>
	<20090708094619.GA7420@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F2A3EBB@bgsmsx501.gar.corp.intel.com>
	<20090717101804.GD3439@rakim.wolfsonmicro.main>
	<98769532B4BB14429434178695419EAE5F76A259@bgsmsx501.gar.corp.intel.com>
	<20090801094626.GA7979@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F8D62461A
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 09:16:48 +0200 (CEST)
In-Reply-To: <20090801094626.GA7979@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I tried but still finding the same issue...the probe function and the related functions are as follows... please let me know if you see any issues

___________

/* Driver Init/exit functionalities */
/**
* snd_intelmad_pcm- to setup pcm for the card
* @card:  pointer to the sound card structure
*@intelmaddata: pointer to internal context
* This function is called from probe function to set up pcm params and functions
*/
static int __devinit snd_intelmad_pcm(struct snd_card *card,
				struct snd_intelmad *intelmaddata)
{
	struct snd_pcm *pcm;
	int i, ret_val = 0;
	char name[32] = INTEL_MAD;

	WARN_ON(!card);
	WARN_ON(!intelmaddata);

	for (i = 0; i < MAX_DEVICES; i++) {
		ret_val = snd_pcm_new(card, name, i, PLAYBACK_COUNT,
				CAPTURE_COUNT, &pcm);
		if (0 != ret_val)
			break;
		/* setup the ops for playback and capture streams */
		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
				&snd_intelmad_playback_ops);
		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
				&snd_intelmad_capture_ops);
		/* setup private data which can be retrieved when required */
		pcm->private_data = intelmaddata;
		pcm->info_flags = 0;
		strncpy(pcm->name, card->shortname, strlen(card->shortname));
		/* allocate dma pages for ALSA stream operations */
		snd_pcm_lib_preallocate_pages_for_all(pcm,
			SNDRV_DMA_TYPE_CONTINUOUS,
			snd_dma_continuous_data(GFP_KERNEL),
			MIN_BUFFER, MAX_BUFFER);
	}
	return ret_val;
}
/**
* snd_intelmad_mixer- to setup mixer settings of the card
*@intelmaddata: pointer to internal context
* This function is called from probe function to set up mixer controls
*/
static int __devinit snd_intelmad_mixer(struct snd_intelmad *intelmaddata)
{
	struct snd_card *card = NULL;
	unsigned int idx;
	int ret_val = 0;
	char *mixername = "IntelMAD Controls";

	WARN_ON(!intelmaddata);

	card = intelmaddata->card;

	strncpy(card->mixername, mixername, strlen(mixername));
	/* add all widget controls and expose the same */
	for (idx = 0; idx < ARRAY_SIZE(snd_intelmad_controls); idx++) {
		ret_val = snd_ctl_add(card,
				snd_ctl_new1(&snd_intelmad_controls[idx],
				intelmaddata));
		sst_dbg("mixer[idx]=%d added \n", idx);
		if (ret_val) {
			sst_err("adding of control failed index = %d\n", idx);
			break;
		}
	}
	return ret_val;
}
static int __devinit snd_intelmad_register_irq(
					struct snd_intelmad *intelmaddata)
{
	int ret_val = 0;
	u32 regbase = AUDINT_BASE, regsize = 8;

	/* interpret irq field */
	sst_dbg("irq = 0x%x\n", intelmaddata->irq);

	if ((intelmaddata->irq) & PMIC_SOUND_IRQ_TYPE_MASK) {
		/* irq -> GPE_ID */
		intelmaddata->irq = intelmaddata->irq &
				(~PMIC_SOUND_IRQ_TYPE_MASK);
		sst_dbg("gpe = 0x%x\n", intelmaddata->irq);
		ret_val = request_gpe(intelmaddata->irq,
				(gpio_function_t)snd_intelmad_intr_handler,
				intelmaddata, 0);
		if (ret_val) {
			sst_dbg("cannot register gpe\n");
			return ret_val;
		}

	} else {
		/* irq -> system irq */
		ret_val = request_irq(intelmaddata->irq,
					snd_intelmad_intr_handler,
					IRQF_SHARED, DRIVER_NAME,
					intelmaddata);
		if (ret_val) {
			sst_dbg("cannot register IRQ\n");
			return ret_val;
		}
	}

	intelmaddata->int_base = ioremap_nocache(regbase, regsize);
	return ret_val;
}

static int __devinit snd_intelmad_sst_register(
			struct snd_intelmad *intelmaddata)
{
	int ret_val;
	struct sc_reg_access pmic_reg = {0,};

	pmic_reg.reg_addr = 0;
	ret_val = sst_sc_reg_access(&pmic_reg, PMIC_READ, 1);

	if (ret_val)
		return ret_val;

	vendor_id = pmic_reg.value & (MASK2|MASK1|MASK0);
	sst_info("orginal reg n extrated vendor id  = 0x%x %d\n",
		pmic_reg.value, vendor_id);
	if (vendor_id < 0 || vendor_id > 2) {
		sst_err("vendor card not supported!!\n");
		return -EIO;
	}
	intelmaddata->sstdrv_ops->module_name = SST_CARD_NAMES;
	intelmaddata->sstdrv_ops->vendor_id = vendor_id;
	intelmaddata->sstdrv_ops->scard_ops = &v[vendor_id];

	/* registering with SST driver to get access to SST APIs to use */
	ret_val = register_sst_card(intelmaddata->sstdrv_ops);
	if (ret_val) {
		sst_err("sst card registration failed\n");
		return ret_val;
	}

	vendor_id = intelmaddata->sstdrv_ops->vendor_id;
	intelmaddata->pmic_status = PMIC_UNINIT;
	return ret_val;
}

/**
* snd_intelmad_create- called from probe to create a snd device
*@intelmaddata :  pointer to the internal context
*@card :  pointer to the sound card
* This function is called when driver module is started
*/
static int __devinit snd_intelmad_create(
		struct snd_intelmad *intelmaddata,
		struct snd_card *card)
{
	int ret_val;
	static struct snd_device_ops ops = {
		.dev_free =	snd_intelmad_dev_free,
	};

	WARN_ON(!intelmaddata);
	WARN_ON(!card);
	/* ALSA api to register for the device */
	ret_val = snd_device_new(card, SNDRV_DEV_LOWLEVEL, intelmaddata, &ops);
	return ret_val;
}
	
/**
* snd_intelmad_jack- to setup jack settings of the card
*@intelmaddata: pointer to internal context
* This function is called from probe function to set up mixer controls
*/
static int __devinit snd_intelmad_jack(struct snd_intelmad *intelmaddata)
{
	struct snd_jack *jack;
	int retval;

	jack = &intelmaddata->jack[0];
	retval = snd_jack_new(intelmaddata->card, "Headphone",
				SND_JACK_HEADPHONE, &jack);
	if (retval < 0)
		return retval;
	jack->private_data = jack;
	snd_jack_report(jack, jack->type);

	jack = &intelmaddata->jack[1];
	retval = snd_jack_new(intelmaddata->card, "Headset",
				SND_JACK_HEADSET, &jack);
	if (retval < 0)
		return retval;
	jack->private_data = jack;
	snd_jack_report(jack, jack->type);

	return retval;
}

/**
* snd_intelmad_probe- function registred for init
*@spi :  pointer to the spi device context
* This function is called when the device is initialized
*/
int __devinit snd_intelmad_probe(struct spi_device *spi)
{
	struct snd_card *card;
	int ret_val = 0;
	struct snd_intelmad *intelmaddata;

	sst_dbg("called \n");

	/* allocate memory for saving internal context and working */
	intelmaddata = kzalloc(sizeof(*intelmaddata), GFP_KERNEL);
	if (NULL == intelmaddata)
		return -ENOMEM;

	/* allocate memory for LPE API set */
	intelmaddata->sstdrv_ops = kzalloc(sizeof(struct intel_sst_card_ops),
					GFP_KERNEL);
	if (!intelmaddata->sstdrv_ops) {
		sst_err("mem alloctn fail \n");
		kfree(intelmaddata);
		return -ENOMEM;
	}

	/* create a card instance with ALSA framework */
	ret_val = snd_card_create(card_index, card_id, THIS_MODULE, 0, &card);
	if (ret_val) {
		sst_err("snd_card_create fail \n");
		goto free_allocs;
	}

	intelmaddata->spi = spi;
	intelmaddata->irq = spi->irq;
	dev_set_drvdata(&spi->dev, intelmaddata);
	intelmaddata->card = card;
	intelmaddata->card_id = card_id;
	intelmaddata->card_index = card_index;
	strncpy(card->driver, INTEL_MAD, strlen(INTEL_MAD));
	strncpy(card->shortname, INTEL_MAD, strlen(INTEL_MAD));


	ret_val = snd_intelmad_pcm(card, intelmaddata);
	if (ret_val) {
		sst_err("snd_intelmad_pcm failed\n");
		goto free_allocs;
	}

	ret_val = snd_intelmad_mixer(intelmaddata);
	if (ret_val) {
		sst_err("snd_intelmad_mixer failed\n");
		goto free_allocs;
	}

	ret_val = snd_intelmad_jack(intelmaddata);
	if (ret_val) {
		sst_err("snd_intelmad_jack failed\n");
		goto free_allocs;
	}

#ifdef REG_IRQ
	ret_val = snd_intelmad_register_irq(intelmaddata);
	if (ret_val) {
		sst_err("snd_intelmad_register_irq fail\n");
		goto free_allocs;
	}
	/*ret_val = snd_intelmad_register_netlink();
		if (ret_val) {
			sst_dbg("...complete\n");
			return ret_val;
	}*/
#endif

	/* internal function call to register device with ALSA */
	ret_val = snd_intelmad_create(intelmaddata, card);
	if (ret_val) {
		sst_err("snd_intelmad_create failed\n");
		goto free_allocs;
	}
	card->private_data = &intelmaddata;
	snd_card_set_dev(card, &spi->dev);
	ret_val = snd_card_register(card);
	if (ret_val)
		goto free_allocs;


	intelmaddata->sstdrv_ops->module_name = SST_CARD_NAMES;
	/* registering with LPE driver to get access to SST APIs to use */
	ret_val = snd_intelmad_sst_register(intelmaddata);
	if (!ret_val) {
		ret_val = intelmaddata->sstdrv_ops->scard_ops->init_card();
		intelmaddata->pmic_status = PMIC_INIT;
		sst_dbg("...complete\n");
		return ret_val;
	}

	sst_err("registering with LPE failed \n");

free_allocs:
	/* TODO: unregister IRQ */
	sst_err("probe failed\n");
	/* snd_card_free(card); */
	kfree(intelmaddata->sstdrv_ops);
	kfree(intelmaddata);
	return ret_val;
}

Thanks,
Harsha.

>-----Original Message-----
>From: Mark Brown [mailto:broonie@sirena.org.uk]
>Sent: Saturday, August 01, 2009 3:16 PM
>To: Harsha, Priya
>Cc: alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] [PATCH] [RFC 8/13] Intel SST sound card driver
>
>On Sat, Aug 01, 2009 at 08:45:31AM +0530, Harsha, Priya wrote:
>> In my probe function, after adding the controls, I added the following
>code
>>
>> 	retval = snd_jack_new(intelmaddata->card, "Headphone",
>> 				SND_JACK_HEADPHONE, &jack);
>
>> But I do not see any jacks in /dev/input.... Am I missing anything?
>
>It's hard to say without seeing the whole driver but you do need to
>create the jack before you instantiate the sound card - it will be
>created along with all the other controls and PCMs.
