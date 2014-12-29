From: Zidan Wang <B50113@freescale.com>
Subject: RE: [alsa-devel][PATCH v4] ASoC: wm8960: Let wm8960 codec driver
 manage its own MCLK
Date: Mon, 29 Dec 2014 10:59:08 +0000
Message-ID: <BN3PR0301MB125132692CD535B9AC1795A98D510@BN3PR0301MB1251.namprd03.prod.outlook.com>
References: <1418103916-31295-1-git-send-email-b50113@freescale.com>
 <20141222181045.GH17800@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141222181045.GH17800@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "lars@metafoo.de" <lars@metafoo.de>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I am so sorry for missing this letter. 
You are right. When PM is disabled, the codec will not work. But there are also some codecs enable mclk in PM, such as wm8962, cs42xx8.
And some codecs enable codec mclk in i2c probe(), startup() and set_bias_level(). It makes me confused.	
Can you tell me what's the general idiom to enable mclk. Thanks.


Best Regards,
Zidan

-----Original Message-----
From: Mark Brown [mailto:broonie@kernel.org] 
Sent: Tuesday, December 23, 2014 2:11 AM
To: Wang Zidan-B50113
Cc: lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.de; lars@metafoo.de; ckeepax@opensource.wolfsonmicro.com; Xiubo Li-B47053; patches@opensource.wolfsonmicro.com; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel][PATCH v4] ASoC: wm8960: Let wm8960 codec driver manage its own MCLK

On Tue, Dec 09, 2014 at 01:45:16PM +0800, Zidan Wang wrote:

> @@ -1002,6 +1005,13 @@ static int wm8960_i2c_probe(struct i2c_client *i2c,
>  	if (wm8960 == NULL)
>  		return -ENOMEM;
>  
> +	wm8960->mclk = devm_clk_get(&i2c->dev, "codec_mclk");
> +
> +	if (IS_ERR(wm8960->mclk)) {
> +		if (PTR_ERR(wm8960->mclk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +	}
> +
>  	wm8960->regmap = devm_regmap_init_i2c(i2c, &wm8960_regmap);
>  	if (IS_ERR(wm8960->regmap))
>  		return PTR_ERR(wm8960->regmap);
> @@ -1041,6 +1051,9 @@ static int wm8960_i2c_probe(struct i2c_client 
> *i2c,
>  
>  	i2c_set_clientdata(i2c, wm8960);
>  
> +	pm_runtime_enable(&i2c->dev);
> +	pm_request_idle(&i2c->dev);
> +
>  	ret = snd_soc_register_codec(&i2c->dev,
>  			&soc_codec_dev_wm8960, &wm8960_dai, 1);
>  

This isn't going to work if PM is disabled (which is still a valid configuration).  The general idiom for this is that the driver should start up with everything powered up then let runtime idle turn things off if they're not required.  That way if runtime PM is disabled then the system will still work as everything will just stay powered on all the time.
