From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v2] ASoC: imx-wm8958: add imx-wm8958
 machine driver
Date: Tue, 1 Mar 2016 01:06:16 -0800
Message-ID: <20160301090615.GA4738@Asurada-CZ80>
References: <6f90780124a7f5bf31452623fdf04225873fc711.1456457898.git.zidan.wang@freescale.com>
 <20160226205208.GA25515@Asurada-Nvidia>
 <AM3PR04MB1412F6FB7E5107BBA3AB9B559ABB0@AM3PR04MB1412.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id E06F2261504
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 10:06:23 +0100 (CET)
Received: by mail-pf0-f194.google.com with SMTP id w128so10523359pfb.2
 for <alsa-devel@alsa-project.org>; Tue, 01 Mar 2016 01:06:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AM3PR04MB1412F6FB7E5107BBA3AB9B559ABB0@AM3PR04MB1412.eurprd04.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@nxp.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

It looks like you replied me off the maillist. So I just add
the maillist and related TO/CCs back.

On Tue, Mar 01, 2016 at 05:43:22AM +0000, Zidan Wang wrote:
> On Fri, Feb 26, 2016 at 11:42:42AM +0800, Zidan Wang wrote:
> > This is the initial imx-wm8958 device-tree-only machine driver working 
> > with fsl_sai driver. This sound card has three dai link, HIFI, VOICE 
> > and BT dai. HIFI dai link will support codec master and slave mode.
> > VOICE an BT dai link have dummy cpu dai, and just support codec master 
> > mode.
> 
> Why VOICE and BT are using dummy cpu dai? Where can I find the schematics
> for wm8958 from NXP website?
> [Wang Zidan-B50113] I have attached the schematics for wm8958. In our
> release, we can't support VOICE and BT, and just using AIF1. But in
> order to upstream, I add the voice and bt dai.

The way to support the other two AIFs are not very graceful -- looks
like you will have to hard code the CPU DAIs in the driver.

I personally suggest you to use fsl-asoc-card. Since the Codec IC
provides three DAIs. And in the schematics, you do have three DAI
links. It sounds plausible to me that we might treat these three
DAI links as three different cards. Then use different compatible
names: "imx-audio-wm8958-aif1" and so on. And each one can also
has ASRC back-end support.

If you really have big trouble to integrate it into fsl-asoc-card
(not 100% sure if the 3 cards methodology is totally feasible),  I
will be okay with a dedicated driver for wm8958. But you will need
to refine the DT binding to support three CPU DAIs in my opinion.

> > +static u32 imx_wm8958_rates[] = { 8000, 16000, 32000, 48000 };
> > +
> > +static struct snd_pcm_hw_constraint_list imx_wm8958_rate_constraints = {
> > +	.count = ARRAY_SIZE(imx_wm8958_rates),
> > +	.list = imx_wm8958_rates,
> > +};
> 
> Where are these rate constraints coming from?
> [Wang Zidan-B50113] these rates are restricted by the SAI MCLK.

If the SAI MCLK runs at a different rate, it would be invalid.
So there should be at least two constraints depending on the
MCLK rate.

And I think it might be better to have this in the SAI driver
as a refinement since the current driver only errors out for
those unsupported rates.

> > +	if (id == HIFI_DAI) {
> > +		/*
> > +		 * Set GPIO1 pin function to reserve, so that DAC1 and ADC1
> > +		 * using shared LRCLK from DACLRCK1.
> > +		 */
> > +		snd_soc_update_bits(codec, WM8994_GPIO_1, 0x1f, 0x2);
> 
> I don't see any reverse operation against this GPIO configuration here.
> So is it really an operation that has to be done every hw_params()?
> 
> > +	} else if (id == VOICE_DAI) {
> > +		/*
> > +		 * Set GPIO6 pin function to reserve, so that DAC2 and ADC2
> > +		 * using shared LRCLK from DACLRCK2.
> > +		 */
> > +		snd_soc_update_bits(codec, WM8994_GPIO_6, 0x1f, 0x2);
> 
> Same here.

Actually I just took a look at the DT binding doc of WM8994.
It supports GPIO configurations in the codec DT nodes. So
you may not need to do these over here at all.

> > +static int imx_wm8958_set_bias_level_post(struct snd_soc_card *card,
> > +				     struct snd_soc_dapm_context *dapm,
> > +				     enum snd_soc_bias_level level) {
> > +	switch (level) {
> > +	case SND_SOC_BIAS_OFF:
> > +		if (card->dapm.bias_level == SND_SOC_BIAS_STANDBY)
> > +			for (i = 0; i < WM8958_MCLK_MAX; i++) {
> > +				if (!IS_ERR(data->mclk[i]))
> > +					clk_disable_unprepare(data->mclk[i]);
> 
> The set_bias() funcs are merely en/disabling mclk.
> Would be possible to do it in the codec driver?
> [Wang Zidan-B50113] It can be moved to codec driver,
> but the wm8994 driver can support wm8958 wm8994 wm1811 codec,
> it's hard for me to do like that, and I also can't test them.

Sending a patch to the maillist is a way to let people be aware
of the change and then test it. The driver maintainer will review
it and give you feedback. If it really causes compatible issues,
you can then limit the code for wm8958 only.

> > +static struct snd_soc_dai_link imx_wm8958_dai_link[] = {
> > +	[BT_DAI] =	{
> > +			.name = "Bluetooth",
> > +			.stream_name = "Bluetooth",
> > +			.cpu_dai_name = "snd-soc-dummy-dai",
> > +			.codec_name = "wm8994-codec",
> > +			.codec_dai_name = "wm8994-aif3",
> > +			.platform_name = "snd-soc-dummy",
> > +			.ignore_pmdown_time = 1,
> > +	},
> 
> A little curious...how is the BT gonna work for you?
> [Wang Zidan-B50113] I have not test the BT dai. The BT is directly
> connect to AIF3, when AIF3 receive date from BT, it will route the
> date to AIF1 or AIF2. And the date from AIF1 and AIF2 can also route
> to AIF3 to BT. So we just need to set the amixer setting to open the
> audio route.

Sounds interesting. So the Codec totally becomes a router. If
this design can not be supported by using three cards via the
fsl-asoc-card, you may continue this driver as I can see the
situation here. But I encourage you to try that first so as to
avoid duplicated code/driver.
