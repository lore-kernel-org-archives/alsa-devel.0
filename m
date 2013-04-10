From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
 multichannel playback
Date: Wed, 10 Apr 2013 13:08:14 +0200
Message-ID: <5165481E.2000200@topic.nl>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
 <513616F7.2020201@gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D3ED@DBDE01.ent.ti.com>
 <20130306105713.GF4896@opensource.wolfsonmicro.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D448@DBDE01.ent.ti.com>
 <5139936D.9080001@topic.nl>
 <B5906170F1614E41A8A28DE3B8D121433ED40278@DBDE01.ent.ti.com>
 <513D96EE.9070003@topic.nl>
 <B5906170F1614E41A8A28DE3B8D121433ED4049D@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040206060408070600050009"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob10.myregisteredsite.com
 (atl4mhob10.myregisteredsite.com [209.17.115.48])
 by alsa0.perex.cz (Postfix) with ESMTP id D223B265F46
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 13:08:17 +0200 (CEST)
Received: from mail.hostingplatform.com ([10.30.71.207])
 by atl4mhob10.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r3AB8F1F023600
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 07:08:15 -0400
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED4049D@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040206060408070600050009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 03/11/2013 09:56 AM, Bedia, Vaibhav wrote:
> On Mon, Mar 11, 2013 at 14:03:50, Mike Looijmans wrote:
>>
>> I'll post the code, but it's based on a 2.6.37 kernel and it's tailored
>> to "my" platform, with numerous changes to clock settings and such. So
>> don't expect it to be useful. It's only interesting as an "example" or
>> for illustrating the general idea, but entirely useless for inclusion in
>> mainstream.
>
> Thanks. In my opinion any proof of concept will be good to get some
> discussion going on this topic.

It has been way to long since I last replied, and there's still much to do.

Anyway, I attached the "multiplex" codec source code. The multiplex 
assumes that all its child codecs share the same (cpu) dai and that the 
dai is capable of handling multiple codecs (either using TDM or multiple 
pins, or whatever combination). The machine part must take care of 
forwarding the "mask" setting of the multiplexer and translate it to 
something the CPU DAI understands.
(If the codecs do not share the DAI, you don't need the multiplexer...)

The multiplex only supports capture.

To use it, compile it in (change Kconfig) and have the board file 
register codecs with the multiplexer. The multiplexer creates a mixer 
switch control for each codec. To use a set of codecs, set their switch 
to "on" (which is default) and record from the multiplex codec. The 
multiplex will control the codecs.

Codecs can also be used without the multiplex in between, no change there.

See it as a proof of concept. It works fine for me...

Mike.

--------------040206060408070600050009
Content-Type: text/x-csrc;
 name="multiplex.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="multiplex.c"

/*
*/

#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <linux/pm.h>
#include <linux/platform_device.h>
#include <linux/cdev.h>
#include <linux/slab.h>

#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/soc.h>
#include <sound/soc-dapm.h>
#include <sound/initval.h>
#include <sound/tlv.h>

#include "multiplex.h"

#define MULTIPLEX_INPUT_SELECT	0x10

struct multiplex_priv {
	struct snd_soc_dai **dai_list;
	unsigned int* active_codec_mask;
	struct snd_kcontrol_new dapm_mixer_inputs[MULTIPLEX_MAX_NR_CODECS];
	struct soc_mixer_control dapm_mixer_inputs_private[MULTIPLEX_MAX_NR_CODECS];
	struct snd_soc_dapm_widget dapm_mixer;
};


static int multiplex_write(struct snd_soc_codec *codec, unsigned int reg,
				unsigned int val)
{
	struct multiplex_priv *multiplex = snd_soc_codec_get_drvdata(codec);

	/*printk(KERN_WARNING "%s (reg=0x%x, val=0x%x)\n", __FUNCTION__, reg, val);*/
	switch(reg)
	{
		case MULTIPLEX_INPUT_SELECT:
			*multiplex->active_codec_mask = val;
			return 0;
	}
	return 0;
}

static unsigned int multiplex_read(struct snd_soc_codec *codec, unsigned int reg)
{
	struct multiplex_priv *multiplex = snd_soc_codec_get_drvdata(codec);

	/*printk(KERN_WARNING "%s (reg=0x%x)\n", __FUNCTION__, reg);*/
	switch(reg)
	{
		case MULTIPLEX_INPUT_SELECT:
			return *multiplex->active_codec_mask;
	}
	return 0;
}

static const struct snd_kcontrol_new input_mixer_controls[] = {
	SOC_DAPM_SINGLE("Switch 0", MULTIPLEX_INPUT_SELECT, 0, 1, 0),
	SOC_DAPM_SINGLE("Switch 1", MULTIPLEX_INPUT_SELECT, 1, 1, 0),
	SOC_DAPM_SINGLE("Switch 2", MULTIPLEX_INPUT_SELECT, 2, 1, 0),
	SOC_DAPM_SINGLE("Switch 3", MULTIPLEX_INPUT_SELECT, 3, 1, 0),
	SOC_DAPM_SINGLE("Switch 4", MULTIPLEX_INPUT_SELECT, 4, 1, 0),
	SOC_DAPM_SINGLE("Switch 5", MULTIPLEX_INPUT_SELECT, 5, 1, 0),
	SOC_DAPM_SINGLE("Switch 6", MULTIPLEX_INPUT_SELECT, 6, 1, 0),
};


static const struct snd_soc_dapm_widget multiplex_dapm_widgets[] = {
	SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
	SND_SOC_DAPM_INPUT("IN"),
};

static const struct snd_soc_dapm_route multiplex_dapm_routes[] = {
/*	{"Input Mixer", "Switch 0", "IN"},
	{"Input Mixer", "Switch 1", "IN"},
	{"Input Mixer", "Switch 2", "IN"},
	{"Input Mixer", "Switch 3", "IN"},
	{"Input Mixer", "Switch 4", "IN"},
	{"Input Mixer", "Switch 5", "IN"},
	{"Input Mixer", "Switch 6", "IN"},*/
	{"ADC", NULL, "Input Mixer"},
};

static int multiplex_set_dai_sysclk(struct snd_soc_dai *dai,
                                int clk_id, unsigned int freq, int dir)
{
	struct snd_soc_codec *codec = dai->codec;
	struct multiplex_priv *multiplex = snd_soc_codec_get_drvdata(codec);
	unsigned int active_codec_mask = *multiplex->active_codec_mask;
	unsigned int i;
	int ret;

	printk(KERN_DEBUG "%s(%d, %u)", __func__, clk_id, freq);

	for (i = 0; multiplex->dai_list[i] != NULL; ++i)
	{
		if (active_codec_mask & BIT(i))
		{
			struct snd_soc_dai *codec_dai =  multiplex->dai_list[i];
			if (codec_dai->driver->ops->set_sysclk) {
				ret = codec_dai->driver->ops->set_sysclk(codec_dai, clk_id, freq, dir);
				if (ret < 0) {
					printk(KERN_ERR "multiplex: can't set codec %s sysclk\n",
						codec_dai->name);
					return ret;
				}
			}
		}
	}

	return 0; /* We don't care */
}

static int multiplex_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
{
	/* We only support I2S, just check if that's set and do nothing */
	if ((fmt & SND_SOC_DAIFMT_MASTER_MASK) != SND_SOC_DAIFMT_CBM_CFM)
		return -EINVAL;
	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_I2S)
		return -EINVAL;

	return 0;
}

static int multiplex_hw_params(struct snd_pcm_substream *substream,
			     struct snd_pcm_hw_params *params,
			     struct snd_soc_dai *dai)
{
	struct snd_soc_codec *codec = dai->codec;
	struct multiplex_priv *multiplex = snd_soc_codec_get_drvdata(codec);
	unsigned int active_codec_mask = *multiplex->active_codec_mask;
	unsigned int i;
	int ret;

	for (i = 0; multiplex->dai_list[i] != NULL; ++i)
	{
		if (active_codec_mask & BIT(i))
		{
			struct snd_soc_dai *codec_dai =  multiplex->dai_list[i];
			if (codec_dai->driver->ops->hw_params) {
				ret = codec_dai->driver->ops->hw_params(substream, params, codec_dai);
				if (ret < 0) {
					printk(KERN_ERR "multiplex: can't set codec %s hw params\n",
						codec_dai->name);
					return ret;
				}
			}
		}
	}

	return 0;
}


static void multiplex_shutdown(struct snd_pcm_substream *substream,
				 struct snd_soc_dai *dai)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_codec *codec = rtd->codec;
	struct multiplex_priv *multiplex = snd_soc_codec_get_drvdata(codec);
	unsigned int active_codec_mask = *multiplex->active_codec_mask;
	unsigned int i;
	struct snd_soc_pcm_runtime rtd_fake;
	const char* stream_name = rtd->codec_dai->driver->capture.stream_name;

	printk(KERN_DEBUG "%s (%s)\n", __func__, stream_name);

	/* snd_soc_dapm_stream_event only uses the "codec" field of the
	 * rtd struct, that's why this trick works */
	rtd_fake.pcm = rtd->pcm;
	rtd_fake.platform = rtd->platform;
	rtd_fake.codec_dai = rtd->codec_dai;
	rtd_fake.cpu_dai = rtd->cpu_dai;


	for (i = 0; multiplex->dai_list[i] != NULL; ++i)
	{
		if (active_codec_mask & BIT(i))
		{
			struct snd_soc_dai *codec_dai =  multiplex->dai_list[i];
			rtd_fake.codec = codec_dai->codec;
			/* Send shutdown event first (just like core) */
			if (codec_dai->driver->ops->shutdown) {
				codec_dai->driver->ops->shutdown(substream, codec_dai);
			}
			/* Tell DAPM we don't need the path any longer */
			snd_soc_dapm_stream_event(&rtd_fake, stream_name, SND_SOC_DAPM_STREAM_STOP);
		}
	}
}

static int multiplex_mute(struct snd_soc_dai *dai, int mute)
{
	struct snd_soc_codec *codec = dai->codec;
	struct multiplex_priv *multiplex = snd_soc_codec_get_drvdata(codec);
	unsigned int active_codec_mask = *multiplex->active_codec_mask;
	unsigned int i;
	int ret = 0;

	for (i = 0; multiplex->dai_list[i] != NULL; ++i)
	{
		if (active_codec_mask & BIT(i))
		{
			struct snd_soc_dai *codec_dai =  multiplex->dai_list[i];
			if (codec_dai->driver->ops->digital_mute) {
				int r =codec_dai->driver->ops->digital_mute(codec_dai, mute);
				if (r != 0)
					ret = r;
			}
		}
	}

	return ret;
}


static int multiplex_prepare(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct multiplex_priv *multiplex = snd_soc_codec_get_drvdata(rtd->codec);
	unsigned int active_codec_mask = *multiplex->active_codec_mask;
	unsigned int i;
	const char* stream_name = rtd->codec_dai->driver->capture.stream_name;
	struct snd_soc_pcm_runtime rtd_fake;

	printk(KERN_DEBUG "%s (%s)\n", __func__, stream_name);

	/* snd_soc_dapm_stream_event only uses the "codec" field of the
	 * rtd struct, that's why this trick works */
	rtd_fake.pcm = rtd->pcm;
	rtd_fake.platform = rtd->platform;
	rtd_fake.codec_dai = rtd->codec_dai;
	rtd_fake.cpu_dai = rtd->cpu_dai;

	for (i = 0; multiplex->dai_list[i] != NULL; ++i)
	{
		if (active_codec_mask & BIT(i))
		{
			struct snd_soc_codec *client =  multiplex->dai_list[i]->codec;
			if (!client)
			{
				printk(KERN_WARNING "multiplex: No CODEC for %d\n", i);
				continue;
			}
			rtd_fake.codec = client;
			snd_soc_dapm_stream_event(&rtd_fake, stream_name, SND_SOC_DAPM_STREAM_START);
		}
	}

	return 0;
}


#define MULTIPLEX_RATES	(SNDRV_PCM_RATE_KNOT | SNDRV_PCM_RATE_8000_96000)
#define MULTIPLEX_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE \
			 | SNDRV_PCM_FMTBIT_S20_3LE \
			 | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE \
			 | SNDRV_PCM_FMTBIT_S32_LE \
			 )

static struct snd_soc_dai_ops multiplex_ops = {
	.set_sysclk = multiplex_set_dai_sysclk,
	.hw_params = multiplex_hw_params,
	.shutdown = multiplex_shutdown,
	.digital_mute = multiplex_mute,
	.set_fmt = multiplex_set_dai_fmt,
	.prepare = multiplex_prepare,
};

static struct snd_soc_dai_driver multiplex_dais[] = {
	{
	.name = "multiplex-adc",
	.capture = {
		    .stream_name = "Capture",
		    .channels_min = 2,
		    .channels_max = 2 * MULTIPLEX_MAX_NR_CODECS,
		    .rates = MULTIPLEX_RATES,
		    .rate_min = 8000,
		    .rate_max = 51200,
		    .formats = MULTIPLEX_FORMATS,},
	.ops = &multiplex_ops,
	.symmetric_rates = 1,
	},
};

static int multiplex_probe(struct snd_soc_codec *codec)
{
	struct multiplex_priv *multiplex = snd_soc_codec_get_drvdata(codec);
	unsigned int i;
	unsigned int num_children;

	codec->idle_bias_off = 1;

	/* Add some default routes for DAPM so that it knows we're ready to go */
	snd_soc_dapm_new_controls(codec, multiplex_dapm_widgets,
				ARRAY_SIZE(multiplex_dapm_widgets));
	for (i = 0; multiplex->dai_list[i] != NULL; ++i)
	{
		printk(KERN_DEBUG "multiplex %d: dai=%s codec=%s\n", i, multiplex->dai_list[i]->name, multiplex->dai_list[i]->codec->name);
		multiplex->dapm_mixer_inputs_private[i].reg = MULTIPLEX_INPUT_SELECT;
		multiplex->dapm_mixer_inputs_private[i].shift = i;
		multiplex->dapm_mixer_inputs_private[i].rshift = i;
		multiplex->dapm_mixer_inputs_private[i].max = 1;
		multiplex->dapm_mixer_inputs_private[i].platform_max = 1;
		multiplex->dapm_mixer_inputs_private[i].invert = 0;
		multiplex->dapm_mixer_inputs[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
		multiplex->dapm_mixer_inputs[i].name = (char*)multiplex->dai_list[i]->codec->name;
		multiplex->dapm_mixer_inputs[i].info = snd_soc_info_volsw;
		multiplex->dapm_mixer_inputs[i].get = snd_soc_dapm_get_volsw;
		multiplex->dapm_mixer_inputs[i].put = snd_soc_dapm_put_volsw;
		multiplex->dapm_mixer_inputs[i].private_value = (unsigned long)&multiplex->dapm_mixer_inputs_private[i];
	}
	num_children = i;
	multiplex->dapm_mixer.id = snd_soc_dapm_mixer_named_ctl; /* or 'snd_soc_dapm_mixer' for a prefix*/
	multiplex->dapm_mixer.name = "Input Mixer";
	multiplex->dapm_mixer.reg = SND_SOC_NOPM;
	multiplex->dapm_mixer.shift = 0;
	multiplex->dapm_mixer.invert = 0;
	multiplex->dapm_mixer.kcontrols = multiplex->dapm_mixer_inputs;
	multiplex->dapm_mixer.num_kcontrols = num_children;
	snd_soc_dapm_new_controls(codec, &multiplex->dapm_mixer, 1);
	/* Set up route for switch (Input Mixer must exist when we do this) */
	for (i = 0; multiplex->dai_list[i] != NULL; ++i)
	{
		struct snd_soc_dapm_route this_route =
			{"Input Mixer", multiplex->dai_list[i]->codec->name, "IN"};
		snd_soc_dapm_add_routes(codec, &this_route, 1);
	}
	snd_soc_dapm_add_routes(codec, multiplex_dapm_routes,
				ARRAY_SIZE(multiplex_dapm_routes));
	snd_soc_dapm_enable_pin(codec, "IN");
	snd_soc_dapm_new_widgets(codec);
	return 0;
}


static struct snd_soc_codec_driver soc_codec_dev_multiplex = {
	.read = multiplex_read,
	.write = multiplex_write,
	.probe = multiplex_probe,
};

static __devinit int multiplex_platform_probe(struct platform_device *pdev)
{
	struct multiplex_priv *multiplex;
	int ret;
	struct multiplex_platform_data *pdata = pdev->dev.platform_data;

	multiplex = kzalloc(sizeof(struct multiplex_priv), GFP_KERNEL);
	if (multiplex == NULL)
		return -ENOMEM;

	multiplex->dai_list = pdata->dai_list;
	multiplex->active_codec_mask = pdata->active_mask;

	platform_set_drvdata(pdev, multiplex);

	ret = snd_soc_register_codec(&pdev->dev,
			&soc_codec_dev_multiplex, multiplex_dais, ARRAY_SIZE(multiplex_dais));
	if (ret < 0)
		kfree(multiplex);
	return ret;
}

static __devexit int multiplex_platform_remove(struct platform_device *pdev)
{
	snd_soc_unregister_codec(&pdev->dev);
	kfree(platform_get_drvdata(pdev));
	return 0;
}

static struct platform_driver multiplex_codec_driver = {
	.driver = {
			.name = "multiplex-codec",
			.owner = THIS_MODULE,
	},
	.probe = multiplex_platform_probe,
	.remove = __devexit_p(multiplex_platform_remove),
};

static int __init multiplex_modinit(void)
{
	int ret;
	ret = platform_driver_register(&multiplex_codec_driver);
	return ret;
}
module_init(multiplex_modinit);

static void __exit multiplex_exit(void)
{
	platform_driver_unregister(&multiplex_codec_driver);
}
module_exit(multiplex_exit);

MODULE_DESCRIPTION("ASoC multiplex codec driver");
MODULE_AUTHOR("Mike Looijmans");
MODULE_LICENSE("GPL");
MODULE_ALIAS("platform:multiplex-codec");

--------------040206060408070600050009
Content-Type: text/x-chdr;
 name="multiplex.h"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="multiplex.h"


#define MULTIPLEX_MAX_NR_CODECS	8

struct multiplex_platform_data {
	struct snd_soc_dai **dai_list;
	unsigned int* active_mask;
};

--------------040206060408070600050009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040206060408070600050009--
