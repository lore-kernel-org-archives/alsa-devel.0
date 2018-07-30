From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH v2 02/10] mfd: wcd9335: add support to wcd9335 core
Date: Mon, 30 Jul 2018 09:42:23 +0530
Message-ID: <20180730041223.GD3661@vkoul-mobl>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180727121806.18209-3-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 27-07-18, 13:17, Srinivas Kandagatla wrote:
> +obj-$(CONFIG_MFD_WCD9335)	+= wcd9335.o
> +wcd9335-objs			:= wcd9335-core.o
> +

no slimbus objs?

> +static int wcd9335_bring_up(struct wcd9335 *wcd)
> +{
> +	struct regmap *rm = wcd->regmap;
> +	int val, byte0;
> +	int ret = 0;
> +
> +	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_EFUSE_VAL_OUT0, &val);
> +	regmap_read(rm, WCD9335_CHIP_TIER_CTRL_CHIP_ID_BYTE0, &byte0);
> +
> +	if ((val < 0) || (byte0 < 0)) {
> +		dev_err(wcd->dev, "wcd9335 codec version detection fail!\n");
> +		return -EINVAL;
> +	}
> +
> +	if (byte0 == 0x1) {
> +		dev_info(wcd->dev, "wcd9335 codec version is v2.0\n");
> +		wcd->version = WCD9335_VERSION_2_0;
> +		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x01);
> +		regmap_write(rm, WCD9335_SIDO_SIDO_TEST_2, 0x00);
> +		regmap_write(rm, WCD9335_SIDO_SIDO_CCL_8, 0x6F);
> +		regmap_write(rm, WCD9335_BIAS_VBG_FINE_ADJ, 0x65);
> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x5);
> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x7);
> +		regmap_write(rm, WCD9335_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x3);
> +		regmap_write(rm, WCD9335_CODEC_RPM_RST_CTL, 0x3);
> +	} else {
> +		dev_err(wcd->dev, "wcd9335 codec version not supported\n");
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;

we can do return 0 and remove the variable as it is not used anywhere
else.

> +static int wcd9335_slim_probe(struct slim_device *slim)
> +{
> +	struct device *dev = &slim->dev;
> +	struct wcd9335 *wcd;
> +	int ret = 0;
> +
> +	/* Interface device */
> +	if (slim->e_addr.dev_index == 0)
> +		return 0;
> +
> +	wcd = devm_kzalloc(dev, sizeof(*wcd), GFP_KERNEL);
> +	if (!wcd)
> +		return	-ENOMEM;
                      ^^
double space

-- 
~Vinod
