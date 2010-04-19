From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC - Support for multiple components
Date: Mon, 19 Apr 2010 17:25:14 +0100
Message-ID: <1271694314.3208.426.camel@odin>
References: <1271686144.3208.305.camel@odin>
	<p2nfa686aa41004190815i38a4e670v34df390ef877973c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f218.google.com (mail-bw0-f218.google.com
	[209.85.218.218])
	by alsa0.perex.cz (Postfix) with ESMTP id 55C20247BE
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 18:25:28 +0200 (CEST)
Received: by bwz10 with SMTP id 10so5061036bwz.4
	for <alsa-devel@alsa-project.org>; Mon, 19 Apr 2010 09:25:28 -0700 (PDT)
In-Reply-To: <p2nfa686aa41004190815i38a4e670v34df390ef877973c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: vbarinov <vbarinov@embeddedalley.com>, alsa-devel <alsa-devel@alsa-project.org>, Sascha Hauer <s.hauer@pengutronix.de>, Joonyoung Shim <jy0922.shim@samsung.com>, mano@roarinelk.homelinux.net, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, dg@emlix.com, Sedji Gaouaou <sedji.gaouaou@atmel.com>, "kyungmin.park" <kyungmin.park@samsung.com>, "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, ben-linux <ben-linux@fluff.org>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Timur Tabi <timur@freescale.com>, anemo@mba.ocn.ne.jp
List-Id: alsa-devel@alsa-project.org

Hi Grant,

On Mon, 2010-04-19 at 09:15 -0600, Grant Likely wrote:
> On Mon, Apr 19, 2010 at 8:09 AM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> > Currently ASoC is designed around a single CODEC and a single platform
> > DMA engine in every sound card instance. This is fine for most embedded
> > devices but current smart phone and STB designs are starting to outgrow
> > this architecture.
> >
> > I'm currently working on adding ASoC support for multiple different
> > CODECs and Platforms (DMA, Audio Engines) into a single sound card
> > instance. This work will allow ASoC to support N CODECs and N platforms
> > per sound card instance and also allow better integration of audio
> > components from GSM MODEMs, BT, FM transceivers and PCM DSPs.
> >
> > I've now split each ASoC component (i.e. DMA, CODEC, DAI) into driver
> > and device structures. This now means each ASoC component is a regular
> > kernel device and can have private device data and platform_data. It
> > should also provide better support for open firmware and flattened
> > device tree.
> >
> > I've CC'ed folks on this mail who have either contributed or maintain
> > ASoC architecture code. Please have a look at your architecture and test
> > if you can. I only have access to OMAP and pxa3xx hardware and as such
> > have only tested the changes on these two architectures only. I'd
> > appreciated anyone else testing on the other architectures too.
> >
> > The changes are all purely mechanical to component registration and
> > component private data only. However, some architectures (txx9, imx,
> > s3c) required some extra effort to use the device model as they had (to
> > varying degrees) coupled their DMA and DAI code more tightly. The fsl
> > platform also required extra work around the open firmware interface.
> > Grant/Timur do we still need soc-of-simple now that all components are
> > regular devices ?
> >
> > The code is in my topic/multi-component branch here :-
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git
> 
> Hi Liam,
> 
> This is definitely a step in the right direction.  All of the OF ASoC
> stuff is definitely a hack to work around the lack of separate devices
> & drivers in the ASoC subsystem.  I'll take a look through, but some
> more information would help a lot.  Can you write a description of the
> device model that you're using for the ASoC linkage?  Here are some of
> the questions I have:
> 
> - What bus type is used for codec and platform (dai) device
> registrations?  (okay, 'platform' is really confusing here because of
> the dual meaning with Linux driver core.  I'm going to use 'dai' in
> this email instead from now on.  It might not be the best term, but it
> at least it isn't ambiguous.)

The ASoC 'bus' type hasn't changed with this patch. The fabric/machine
driver still describes how the audio card is configured.

> - What does the device hierarchy look like (what is the parent device
> for each of the codec and devices)?
> - Related to that, how are things like i2c codecs handled?  By rights,
> there will be an i2c device registered under the i2c bus device for
> the control interface.  How will this relate to the ASoC model?

I2C/SPI codecs can now register with the driver core as I2C/SPI drivers.
e.g. the I2C/SPI device probe registers the ASoC device :-

struct snd_soc_codec_driver soc_codec_dev_wm8731 = {
	.name = "WM8731",
	.probe = 	wm8731_probe,
	.remove = 	wm8731_remove,
	.suspend = 	wm8731_suspend,
	.resume =	wm8731_resume,
	.owner = THIS_MODULE,
	.set_bias_level = wm8731_set_bias_level,
	.reg_cache_size = sizeof(wm8731_reg),
	.reg_cache_default = wm8731_reg,
};
EXPORT_SYMBOL_GPL(soc_codec_dev_wm8731);

#if defined(CONFIG_SPI_MASTER)
static int __devinit wm8731_spi_probe(struct spi_device *spi)
{
	struct wm8731_priv *wm8731;
	int ret;

	wm8731 = kzalloc(sizeof(struct wm8731_priv), GFP_KERNEL);
	if (wm8731 == NULL)
		return -ENOMEM;

	wm8731->control_data = spi;
	wm8731->control_type = SND_SOC_SPI;
	spi_set_drvdata(spi, wm8731);

	ret = snd_soc_register_codec(&spi->dev, spi->chip_select,
			&soc_codec_dev_wm8731, &wm8731_dai, 1);
	if (ret < 0)
		kfree(wm8731);
	return ret;
}

static int __devexit wm8731_spi_remove(struct spi_device *spi)
{
	snd_soc_unregister_codec(&spi->dev, spi->chip_select);
	kfree(spi_get_drvdata(spi));
	return 0;
}

static struct spi_driver wm8731_spi_driver = {
	.driver = {
		.name	= "wm8731",
		.bus	= &spi_bus_type,
		.owner	= THIS_MODULE,
	},
	.probe		= wm8731_spi_probe,
	.remove		= __devexit_p(wm8731_spi_remove),
};
#endif /* CONFIG_SPI_MASTER */

#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
static __devinit int wm8731_i2c_probe(struct i2c_client *i2c,
				      const struct i2c_device_id *id)
{
	struct wm8731_priv *wm8731;
	int ret;

	wm8731 = kzalloc(sizeof(struct wm8731_priv), GFP_KERNEL);
	if (wm8731 == NULL)
		return -ENOMEM;

	i2c_set_clientdata(i2c, wm8731);
	wm8731->control_data = i2c;
	wm8731->control_type = SND_SOC_I2C;

	ret =  snd_soc_register_codec(&i2c->dev, i2c->addr,
			&soc_codec_dev_wm8731, &wm8731_dai, 1);
	if (ret < 0)
		kfree(wm8731);
	return ret;
}

static __devexit int wm8731_i2c_remove(struct i2c_client *client)
{
	snd_soc_unregister_codec(&client->dev, client->addr);
	kfree(i2c_get_clientdata(client));
	return 0;
}

static const struct i2c_device_id wm8731_i2c_id[] = {
	{ "wm8731", 0 },
	{ }
};
MODULE_DEVICE_TABLE(i2c, wm8731_i2c_id);

static struct i2c_driver wm8731_i2c_driver = {
	.driver = {
		.name = "WM8731 I2C Codec",
		.owner = THIS_MODULE,
	},
	.probe =    wm8731_i2c_probe,
	.remove =   __devexit_p(wm8731_i2c_remove),
	.id_table = wm8731_i2c_id,
};
#endif

static int __init wm8731_modinit(void)
{
	int ret = 0;
#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
	ret = i2c_add_driver(&wm8731_i2c_driver);
	if (ret != 0) {
		printk(KERN_ERR "Failed to register WM8731 I2C driver: %d\n",
		       ret);
	}
#endif
#if defined(CONFIG_SPI_MASTER)
	ret = spi_register_driver(&wm8731_spi_driver);
	if (ret != 0) {
		printk(KERN_ERR "Failed to register WM8731 SPI driver: %d\n",
		       ret);
	}
#endif
	return ret;
}
module_init(wm8731_modinit);

static void __exit wm8731_exit(void)
{
#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
	i2c_del_driver(&wm8731_i2c_driver);
#endif
#if defined(CONFIG_SPI_MASTER)
	spi_unregister_driver(&wm8731_spi_driver);
#endif
}
module_exit(wm8731_exit);

So the arch/board driver would register an I2C/SPI device for the codec
(with any platform data) and initiate the I2C/SPI codec probe(). This in
turn registers the ASoC component device with the ASoC core so it can be
asoc_probed() when it's sibling component devices are registered (the
last part is pretty much the same as the current version). The only
difference now is that our component is a core device and passes in it's
device upon ASoC component registration.

> - None of the drivers appear to include struct device_driver; which
> tells me that they don't use the driver core binding model.  How do
> drivers get bound to devices?  Why does the ASoC code create an driver
> interface instead of using the core code (what does the core code not
> provide)?

ASoC doesn't fully use the driver model for components in this changeset
(or at all) due to the complex relationships between the individual
components for probing() and for control of PM operations (i.e. we cant
have pops and clicks at suspend). 

This is not to say ASoC wont use the full driver model for components in
the future. This work is an important step on the way to achieving this
aim. 

> - What code is responsible for performing the codec and dai driver
> registrations?

Please see above WM8713 codec driver code snippet for full use.

int snd_soc_register_codec(struct device *dev, int id,
		struct snd_soc_codec_driver *codec_drv,
		struct snd_soc_dai_driver *dai_drv, int num_dai);
void snd_soc_unregister_codec(struct device *dev, int id);

Registers and unregisters our codec and DAI devices. It also registers
the codec and DAI ASoC 'driver' too.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
