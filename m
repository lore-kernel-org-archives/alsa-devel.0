From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Request for comments for SND_SOC_IMX_WM8731
Date: Fri, 24 Oct 2014 10:20:29 -0200
Message-ID: <CAOMZO5AXhj-r4v-sR6Rp_ywD85M07W06r551vMq0r6juE+Tmgg@mail.gmail.com>
References: <CAB-pspcgsa3-YgBfk-5TUoyfEN0pbBHtqCUrzyaQdCA-QNHt1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CC5E260559
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 14:20:30 +0200 (CEST)
Received: by mail-la0-f48.google.com with SMTP id gi9so2508250lab.21
 for <alsa-devel@alsa-project.org>; Fri, 24 Oct 2014 05:20:29 -0700 (PDT)
In-Reply-To: <CAB-pspcgsa3-YgBfk-5TUoyfEN0pbBHtqCUrzyaQdCA-QNHt1Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Bennett <jbscience87@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Aaron Kling <webgeek1234@gmail.com>, Igor Grinberg <grinberg@compulab.co.il>, Valentin Raevsky <valentin@compulab.co.il>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 24, 2014 at 2:42 AM, Jonathan Bennett <jbscience87@gmail.com> wrote:
> This patch is a continuation of my work on supporting the Utilite devices on
> the vanilla kernel. I've modified the code slightly to conform to
> established practice. Namely instead of using src-port and ext-port, we use
> mux-int-port and mux-ext-port.
>
> This driver has support for putting the codec in either master mode or slave
> mode. So far I've only had success with using slave mode. For trying to
> submit for kernel inclusion, should I strip out the code for codec master

Yes, just add codec slave support then.

> mode? As a kernel dev noob, any other comments are welcome.

Some suggestions:
- Run ./scripts/checkpatch on your patch and fix all the reported
errors/warnings
- Add the maintainers on Cc (Mark Brown, Nicolin Chen)
- In the subject, use something like: ASoC: fsl: Add support for
imx-wm8731 and a proper commit message
- Send the patch via git send-email

More comments below:

> +config SND_SOC_IMX_WM8731
> + tristate "SoC Audio support for i.MX boards with wm8731
> + depends on OF && I2C
> + select SND_SOC_WM8731
> + select SND_SOC_IMX_PCM_DMA
> + select SND_SOC_IMX_AUDMUX
> + select SND_SOC_FSL_SSI
> + select SND_SOC_FSL_UTILS

You can remove this UTILS option.

> +static int wm8731_mst_mode_init(struct imx_wm8731_data *data)
> +{
> + long rate;
> + struct clk *new_parent;
> + struct clk *ssi_clk;
> + struct i2c_client *codec_dev = data->codec_dev;
> +
> + new_parent = devm_clk_get(&codec_dev->dev, "cko2");
> + if (IS_ERR(new_parent)) {
> + pr_err("Could not get \"cko2\" clock \n");
> + return PTR_ERR(new_parent);
> + }
> +
> + ssi_clk = devm_clk_get(&codec_dev->dev, "cko");
> + if (IS_ERR(ssi_clk)) {
> + pr_err("Could not get \"cko\" clock \n");
> + return PTR_ERR(ssi_clk);

I am not sure that adding the clock handling here is the correct approach.

The dts you use looks like:

   codec: wm8731@1a {
      compatible = "wlf,wm8731";
      reg = <0x1a>;
      clocks = <&clks 173>, <&clks 158>, <&clks 201>, <&clks 200>;
      clock-names = "pll4", "imx-ssi.1", "cko", "cko2";
      AVDD-supply = <&reg_3p3v>;
      HPVDD-supply = <&reg_3p3v>;
      DCVDD-supply = <&reg_3p3v>;
      DBVDD-supply = <&reg_3p3v>;

,which does not match the current bindings for the wm8731. The wm8731
driver could be extended to handle the clocks if needed, instead of
handling them via machine driver.

> +static int imx_hifi_hw_params_slv_mode(struct snd_pcm_substream *substream,
> +       struct snd_pcm_hw_params *params)
> +{
> + struct snd_soc_pcm_runtime *rtd = substream->private_data;
> + struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> + struct snd_soc_dai *codec_dai = rtd->codec_dai;
> + struct snd_soc_card *card = codec_dai->card;
> + struct imx_wm8731_data *data = snd_soc_card_get_drvdata(card);
> +
> + u32 dai_format;
> + snd_pcm_format_t sample_format;
> + unsigned int channels;
> + unsigned int tx_mask, rx_mask;
> + unsigned int sampling_rate;
> + unsigned int div_2, div_psr, div_pm;
> + int ret;
> +
> + sampling_rate = params_rate(params);
> + sample_format = params_format(params);
> +
> + channels = params_channels(params);
> + printk("%s:%s  sampling rate = %u  channels = %u \n", __FUNCTION__,

pr_debug here?

> + div_2 = 0;
> + div_psr = 0;
> + switch (sampling_rate) {
> + case 8000:
> + // 1x1x12

No // style comments. Comments should use teh /* bla bla bla */ style.

> +static int imx_wm8731_probe(struct platform_device *pdev)
> +{
> + struct device_node *ssi_np, *codec_np;
> + struct platform_device *ssi_pdev;
> + struct imx_priv *priv = &card_priv;
> + struct i2c_client *codec_dev;
> + struct imx_wm8731_data *data;
> + unsigned int src_port, ext_port;
> + unsigned int ssi_mode;
> + const char *ssi_mode_str;
> +
> + int ret;
> +
> + priv->pdev = pdev;
> +
> + ssi_np = of_parse_phandle(pdev->dev.of_node, "ssi-controller", 0);
> + codec_np = of_parse_phandle(pdev->dev.of_node, "audio-codec", 0);
> + if (!ssi_np || !codec_np) {
> + dev_err(&pdev->dev, "phandle missing or invalid\n");
> + ret = -EINVAL;
> + goto fail;

No need for jumping to 'fail', just return the error directly. Same on
the other locations.

> + }
> +
> + ssi_pdev = of_find_device_by_node(ssi_np);
> + if (!ssi_pdev) {
> + dev_err(&pdev->dev, "failed to find SSI platform device\n");
> + ret = -EINVAL;
> + goto fail;
> + }
> +
> + codec_dev = of_find_i2c_device_by_node(codec_np);
> + if (!codec_dev || !codec_dev->dev.driver) {
> + dev_err(&pdev->dev, "failed to find codec platform device\n");
> + ret = -EINVAL;
> + goto fail;
> + }
> +
> + data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> + if (!data) {
> + ret = -ENOMEM;
> + goto fail;
> + }
> +
> + card_priv.data = data;
> +
> + data->codec_dev = codec_dev;
> +
> + data->dai.name = "HiFi";
> + data->dai.stream_name = "HiFi";
> + data->dai.codec_dai_name = "wm8731-hifi";
> + data->dai.codec_of_node = codec_np;
> + data->dai.cpu_dai_name = dev_name(&ssi_pdev->dev);
> + data->dai.platform_of_node = ssi_np;
> + data->dai.ops = &imx_hifi_ops;
> + data->dai.init = &imx_wm8731_init;
> +
> + ret = of_property_read_u32(pdev->dev.of_node, "mux-int-port", &src_port);
> + if (ret) {
> + dev_err(&pdev->dev, "failed to get \"mux-int-port\" value\n");
> + ret = -EINVAL;
> + goto fail;
> + }
> +
> + ret = of_property_read_u32(pdev->dev.of_node, "mux-ext-port", &ext_port);
> + if (ret) {
> + dev_err(&pdev->dev, "failed to get \"mux-ext-port\" value\n");
> + ret = -EINVAL;
> + goto fail;
> + }
> +
> + ret = of_property_read_string(ssi_np, "fsl,mode", &ssi_mode_str);
> + if (ret) {
> + dev_err(&pdev->dev, "failed to get \"fsl,mode\" value\n");
> + ret = -EINVAL;
> + goto fail;
> + }
> +
> + ssi_mode = strcmp(ssi_mode_str, "i2s-master");
> +
> + if (ssi_mode) {
> + /* Master Mode */
> + imx_audmux_config_mst_mode(src_port, ext_port);
> + wm8731_mst_mode_init(data);
> + data->clock_enable = wm8731_mst_mode_clock_enable;
> + imx_hifi_ops.hw_params = imx_hifi_hw_params_mst_mode;
> + imx_hifi_ops.startup = imx_hifi_startup_mst_mode;
> + } else {
> + /* Slave Mode */
> + imx_audmux_config_slv_mode(src_port, ext_port);
> + wm8731_slv_mode_init(data);
> + data->clock_enable = wm8731_slv_mode_clock_enable;
> + imx_hifi_ops.hw_params = imx_hifi_hw_params_slv_mode;
> + imx_hifi_ops.startup = imx_hifi_startup_slv_mode;
> + }
> +
> + data->card.dev = &pdev->dev;
> + ret = snd_soc_of_parse_card_name(&data->card, "model");
> + if (ret)
> + goto fail;
> +
> + ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");

> + if (ssi_np)
> + of_node_put(ssi_np);

of_node_put can handle NULL, so no need for the if test.

> +
> + if (codec_np)
> + of_node_put(codec_np);

Same here.
