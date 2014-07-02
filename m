From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [alsa-devel] [PATCH v3] ASoC: tas2552: Support TI TAS2552 Amplifier
Date: Wed, 2 Jul 2014 10:02:38 -0500
Message-ID: <53B41F0E.90107@ti.com>
References: <1404307852-10456-1-git-send-email-dmurphy@ti.com> <53B40D55.6000602@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53B40D55.6000602@zonque.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>, linux-sound@vger.kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Daniel
Thanks for the review

On 07/02/2014 08:47 AM, Daniel Mack wrote:
> Hi Dan,
>
> On 07/02/2014 03:30 PM, Dan Murphy wrote:
>> +	if (np) {
>> +		data->power_gpio = of_get_named_gpio(np, "enable-gpio", 0);
>> +	} else if (pdata) {
>> +		data->power_gpio = pdata->enable_gpio;
>> +	} else {
>> +		dev_err(dev, "Platform or dev tree data not set\n");
>> +		return -ENODEV;
>> +	}
> New code for GPIO handling should use the new gpiod interface.
> See include/linux/gpio/consumer.h, or the sta350 codec driver.

OK good catch.  I will look into it.

Does the gpiod interface handle both pdata as well as dt?

> For that to work, you also need to rename the property to
> 'enable-gpios', even though there's only one.

I am looking for that restriction in the code.  But don't see it.
Will dig some more here.

>
>
> Daniel
>


-- 
------------------
Dan Murphy
