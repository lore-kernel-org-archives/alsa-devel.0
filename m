From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ASoC: Add WM8903 CODEC driver
Date: Tue, 26 Aug 2008 15:28:56 +0200
Message-ID: <20080826152856.01187982@hyperion.delvare>
References: <1219752327-5704-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id B1AEF24702
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 15:29:02 +0200 (CEST)
In-Reply-To: <1219752327-5704-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Tue, 26 Aug 2008 13:05:27 +0100, Mark Brown wrote:
> The WM8903 is a high performance ultra-low power stereo CODEC optimised
> for portable audio applications.  Features include:
> 
>     * 5mW power consumption for DAC to headphone playback
>     * Stereo DAC SNR 96dB typical, THD -86dB typical
>     * Stereo ADC SNR 93dB typical, THD -80dB typical
>     * Up to 3 single ended inputs per stereo channel
>     * Up to 2 pseudo differential inputs per stereo channel
>     * Up to 1 fully differential mic input per stereo channel
>     * Digital Dynamic Range Controller (compressor/limiter)
>     * Digital sidetone mixing
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/Kconfig  |    4 +
>  sound/soc/codecs/Makefile |    2 +
>  sound/soc/codecs/wm8903.c | 1813 +++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/wm8903.h | 1463 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 3282 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/codecs/wm8903.c
>  create mode 100644 sound/soc/codecs/wm8903.h

Here are minor issues I spotted in the i2c part of your driver:

> (...)
> +static int wm8903_i2c_probe(struct i2c_client *i2c,
> +			    const struct i2c_device_id *id)
> +{
> +	struct snd_soc_device *socdev = wm8903_socdev;
> +	struct snd_soc_codec *codec = socdev->codec;
> +	int ret;
> +
> +	i2c_set_clientdata(i2c, codec);
> +	codec->control_data = i2c;
> +
> +	ret = wm8903_init(socdev);
> +	if (ret < 0)
> +		dev_err(&i2c->dev, "Device initialisation failed\n");
> +
> +	return ret;
> +}
> +
> +static int wm8903_i2c_remove(struct i2c_client *client)
> +{
> +	struct snd_soc_codec *codec = i2c_get_clientdata(client);
> +	kfree(codec->reg_cache);
> +	return 0;
> +}
> +
> +/* i2c codec control layer */
> +static const struct i2c_device_id wm8903_i2c_id[] = {
> +       { "wm8903", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, wm8903_i2c_id);
> +
> +static struct i2c_driver wm8903_i2c_driver = {
> +	.driver = {
> +		.name = "WM8903",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe    = wm8903_i2c_probe,
> +	.remove   = wm8903_i2c_remove,
> +	.id_table = wm8903_i2c_id,
> +};
> +
> +static struct i2c_client *wm8903_i2c_device;

I know that I am the one who came up with this idea, but on second
thought, wm8903_i2c_device will always be equal to
wm8903_socdev->codec->control_data, so we can easily do without it.

> +
> +static int wm8903_probe(struct platform_device *pdev)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct wm8903_setup_data *setup;
> +	struct snd_soc_codec *codec;
> +	struct wm8903_priv *wm8903;
> +	struct i2c_board_info board_info;
> +	struct i2c_adapter *adapter;
> +	int ret = 0;
> +
> +	setup = socdev->codec_data;
> +
> +	if (!setup->i2c_address) {
> +		dev_err(&pdev->dev, "No codec address provided\n");
> +		return -ENODEV;
> +	}
> +
> +	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
> +	if (codec == NULL)
> +		return -ENOMEM;
> +
> +	wm8903 = kzalloc(sizeof(struct wm8903_priv), GFP_KERNEL);
> +	if (wm8903 == NULL) {
> +		ret = -ENOMEM;
> +		goto err_codec;
> +	}
> +
> +	codec->private_data = wm8903;
> +	socdev->codec = codec;
> +	mutex_init(&codec->mutex);
> +	INIT_LIST_HEAD(&codec->dapm_widgets);
> +	INIT_LIST_HEAD(&codec->dapm_paths);
> +
> +	wm8903_socdev = socdev;
> +
> +	codec->hw_write = (hw_write_t)i2c_master_send;
> +	ret = i2c_add_driver(&wm8903_i2c_driver);
> +	if (ret != 0) {
> +		dev_err(&pdev->dev, "can't add i2c driver");

Missing \n at end of string (looks like many other drivers have this
problem - I found 11 other cases under sound/soc, I can send a patch
fixing these if you want.)

> +		goto err_priv;
> +	} else {
> +		memset(&board_info, 0, sizeof(board_info));
> +		strlcpy(board_info.type, "wm8903", I2C_NAME_SIZE);
> +		board_info.addr = setup->i2c_address;
> +
> +		adapter = i2c_get_adapter(setup->i2c_bus);
> +		if (!adapter) {
> +			dev_err(&pdev->dev, "Can't get I2C bus %d\n",
> +				setup->i2c_bus);
> +			goto err_adapter;

You are jumping to the error path but ret has value 0. This means that
the function returns success when you really mean failure, and trouble
is likely to arise after that.

> +		}
> +
> +		wm8903_i2c_device = i2c_new_device(adapter, &board_info);
> +		i2c_put_adapter(adapter);
> +		if (wm8903_i2c_device == NULL) {
> +			dev_err(&pdev->dev,
> +				"I2C driver registration failed\n");
> +			ret = -ENODEV;
> +			goto err_adapter;
> +		}
> +	}
> +
> +	return ret;
> +
> +err_adapter:
> +	i2c_del_driver(&wm8903_i2c_driver);
> +err_priv:
> +	kfree(codec->private_data);
> +err_codec:
> +	kfree(codec);
> +	return ret;
> +}

-- 
Jean Delvare
