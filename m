From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [PATCH v1 8/9] ASoC: hdac_hda: add asoc extension
 for legacy HDA codec drivers
Date: Mon, 26 Feb 2018 10:11:44 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579B2A211@BGSMSX104.gar.corp.intel.com>
References: <1519373550-2545-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1519373550-2545-9-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hmv00ggc4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D9C1B267A3F
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 11:12:50 +0100 (CET)
In-Reply-To: <s5hmv00ggc4.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Takashi Iwai [mailto:tiwai@suse.de]
>Sent: Friday, February 23, 2018 3:48 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; broonie@kernel.org;
>liam.r.girdwood@linux.intel.com; pierre-louis.bossart@linux.intel.com; Koul,
>Vinod <vinod.koul@intel.com>; Patches Audio <patches.audio@intel.com>
>Subject: Re: [PATCH v1 8/9] ASoC: hdac_hda: add asoc extension for legacy HDA
>codec drivers
>
>On Fri, 23 Feb 2018 09:12:29 +0100,
>Rakesh Ughreja wrote:
>>
>> +static int hdac_hda_codec_probe(struct snd_soc_codec *codec)
>> +{
>> +	struct hdac_hda_priv *hda_pvt = snd_soc_codec_get_drvdata(codec);
>> +	struct snd_soc_dapm_context *dapm =
>> +			snd_soc_component_get_dapm(&codec-
>>component);
>> +	struct hdac_device *hdev = &hda_pvt->codec.core;
>> +	struct hda_codec *hcodec = &hda_pvt->codec;
>> +	struct hdac_ext_link *hlink = NULL;
>> +	hda_codec_patch_t patch;
>> +	int ret, i = 0;
>> +	u16 codec_mask;
>> +
>> +	hda_pvt->scodec = codec;
>> +	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
>> +	if (!hlink) {
>> +		dev_err(&hdev->dev, "hdac link not found\n");
>> +		return -EIO;
>> +	}
>> +
>> +	ret = snd_hdac_ext_bus_link_get(hdev->bus, hlink);
>
>So this is the essential part for the ext-hda stuff.  But...
>
>> +
>> +	udelay(1000);
>> +	do {
>> +		codec_mask = snd_hdac_chip_readw(hdev->bus, STATESTS);
>> +		if (codec_mask)
>> +			break;
>> +		i++;
>> +		udelay(100);
>> +	} while (i < 100);
>> +
>> +	if (!codec_mask) {
>> +		dev_err(&hdev->dev, "No codecs found after link reset\n");
>> +		return -EIO;
>> +	}
>> +
>> +	snd_hdac_chip_writew(hdev->bus, STATESTS, STATESTS_INT_MASK);
>
>Why do you need this?  The callback gets called by the HD-audio
>controller driver and it already should have checked the codec mask
>bits.

With the multiple link support on the same HDA controller, when the link
gets turned ON immediately codec may not indicate its presence. As per
the HDA spec, it may take up to 521uSec before the codec responds.

In the legacy HDA the link was turned ON/OFF only during CRST time, but
now it can happen anytime.

>
>
>> +	ret = snd_hda_codec_device_new(hcodec->bus,
>> +			codec->component.card->snd_card, hdev->addr,
>hcodec);
>> +	if (ret < 0) {
>> +		dev_err(codec->dev, "failed to create hda codec %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * snd_hda_codec_new1 decrements the usage count and so get the pm
>> +	 * count else the device will be powered off
>> +	 */
>> +	pm_runtime_get_noresume(&hdev->dev);
>> +
>> +	hcodec->bus->card = dapm->card->snd_card;
>> +
>> +	patch = (hda_codec_patch_t)hcodec->preset->driver_data;
>> +	if (patch) {
>> +		ret = patch(hcodec);
>> +		if (ret < 0) {
>> +			dev_err(codec->dev, "patch failed %d\n", ret);
>> +			return ret;
>> +		}
>> +	} else {
>> +		dev_dbg(&hdev->dev, "no patch file found\n");
>> +	}
>> +
>> +	ret = snd_hda_codec_set_name(hcodec, hcodec->preset->name);
>> +	if (ret < 0) {
>> +		dev_err(codec->dev, "name failed %s\n", hcodec->preset-
>>name);
>> +		return ret;
>> +	}
>> +
>> +	ret = snd_hdac_regmap_init(&hcodec->core);
>> +	if (ret < 0) {
>> +		dev_err(codec->dev, "regmap init failed\n");
>> +		return ret;
>> +	}
>
>The regmap and the codec name must be initialized before calling the
>patch (i.e. the real probe stuff).

Okay.

>
>> +
>> +	ret = snd_hda_codec_parse_pcms(hcodec);
>> +	if (ret < 0) {
>> +		dev_err(&hdev->dev, "unable to map pcms to dai %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = snd_hda_codec_build_controls(hcodec);
>> +	if (ret < 0) {
>> +		dev_err(&hdev->dev, "unable to create controls %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	hcodec->core.lazy_cache = true;
>> +
>> +	/*
>> +	 * hdac_device core already sets the state to active and calls
>> +	 * get_noresume. So enable runtime and set the device to suspend.
>> +	 * pm_runtime_enable is also called during codec registeration
>> +	 */
>> +	pm_runtime_put(&hdev->dev);
>> +	pm_runtime_suspend(&hdev->dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int hdac_hda_codec_remove(struct snd_soc_codec *codec)
>> +{
>> +	struct hdac_hda_priv *hda_pvt = snd_soc_codec_get_drvdata(codec);
>> +	struct hdac_device *hdev = &hda_pvt->codec.core;
>> +	struct hdac_ext_link *hlink = NULL;
>> +
>> +	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
>> +	if (!hlink) {
>> +		dev_err(&hdev->dev, "hdac link not found\n");
>> +		return -EIO;
>> +	}
>> +
>> +	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
>> +	pm_runtime_disable(&hdev->dev);
>> +
>> +	return 0;
>> +}
>
>.... and I see no proper error paths there, and some cleanups seem
>missing, too.

Surely, I can correct it. Do you mind giving some more hints.

>
>Now I think what you need is rather not to open-code again the mostly
>same procedure from hda_codec_driver_probe() / _remove(), but to let
>hda_codec_driver_probe() and remove() skip some unnecessary steps for
>the ext codec (e.g. registration), in addition to the hlink setup.

I think you gave this suggestion in the last series and I tried that [1].
But I think we didn't conclude on that. So let's do it now.

All the functions exception regmap_init which are called in the 
hda_codec_driver_probe requies snd_card and I don't have that until
machine driver creates it. So we will end up in skipping/not calling all the
functions except the regmap_init(). 

If that looks okay to you, I can do that.

>
>That is, hda_codec_driver_probe() would be like:
>
>static int hda_codec_driver_probe(struct device *dev)
>{
>	....
>
> 	if (WARN_ON(!codec->preset))
> 		return -EINVAL;
>
>	if (bus->core.ext_ops) {
>		if (!WARN_ON(bus->core.ext_ops->probe))
>			return -EINVAL;
>		/* register hlink */
>		err = bus->core.ext_ops->probe(&codec->core);
>		if (err < 0)
>			return err;
>	}
>
>	err = snd_hda_codec_set_name(codec, codec->preset->name);
>	if (err < 0)
>		goto error;
>	err = snd_hdac_regmap_init(&codec->core);
>	if (err < 0)
>		goto error;
>	.....
>
>	if (!bus->core.ext_ops &&
>	    codec->card->registered) {
>		err = snd_card_register(codec->card);
>		if (err < 0)
>		....
>	}
>
>	codec->core.lazy_cache = true;
>	return 0;
>
> error_module:
>	....
>}
>
>static int hda_codec_driver_remove(struct device *dev)
>{
>	struct hda_codec *codec = dev_to_hda_codec(dev);
>	int err;
>
>	if (codec->patch_ops.free)
>		codec->patch_ops.free(codec);
>	snd_hda_codec_cleanup_for_unbind(codec);
>	if (codec->bus->core.ext_ops && codec->bus->core.ext_ops->remove)
>		codec->bus->core.ext_ops->remove(&codec->core);
>	module_put(dev->driver->owner);
>	return 0;
>}
>
>... and looking at this, we may rather add the hlink add/remove to
>hdac_bus_ops, instead of defining a new ops struct, too.

Are you talking about these two (snd_hdac_ext_bus_link_put and 
snd_hdac_ext_bus_link_get) functions to put as call backs into
hdac_bus_ops ?

Regards,
Rakesh

[1] https://www.spinics.net/lists/alsa-devel/msg72062.html
