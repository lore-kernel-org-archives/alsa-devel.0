From: Rob Jones <rob.jones@codethink.co.uk>
Subject: Re: [PATCH 1/5] gpiolib: devres: Introduce the function devm_request_gpio_array
Date: Wed, 09 Jul 2014 13:48:29 +0100
Message-ID: <53BD3A1D.8060401@codethink.co.uk>
References: <cover.1404665589.git.himangi774@gmail.com> <1a1752ce7455bac8f2505a9790da891a830699f5.1404665589.git.himangi774@gmail.com> <53BD2509.6070803@codethink.co.uk> <alpine.DEB.2.10.1407091351530.2375@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.10.1407091351530.2375@hadrien>
Sender: linux-gpio-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Himangi Saraogi <himangi774@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, Philipp Zabel <philipp.zabel@gmail.com>, Paul Parsons <lost.distance@yahoo.com>
List-Id: alsa-devel@alsa-project.org



On 09/07/14 12:52, Julia Lawall wrote:
>
>
> On Wed, 9 Jul 2014, Rob Jones wrote:
>
>> Please note that I submitted a patch on 02/07/14 to create this
>> function which was acked by Linus Walleij on 05/07/14.
>>
>> Great minds think alike, and all that.
>>
>> However, I think that the version I submitted better replicates the
>> original (non devm) functionality, see below.

<snip>

>>> +int devm_gpio_request_array(struct device *dev, const struct gpio *array,
>>> +			    size_t num)
>>> +{
>>> +	int i, err;
>>> +
>>> +	for (i = 0; i < num; i++, array++) {
>>> +		err = devm_gpio_request_one(dev, array->gpio, array->flags,
>>> +					    array->label);
>>> +		if (err)
>>> +			return err;
>>
>> The failure path in the version I submitted frees up any already
>> allocated gpios on the first failure.
>
> Himangi first proposed doing that, but I thought it was not really in the
> spirit of devm functions, which is to leave that implicit.  No strong
> opinion on the matter, though.
>

Interestingly, we came at it from the other direction: I originally
didn't have the unwind in and our internal review guys suggested that
it was in the original function so putting it in would:

1. make this a better analogue of the original
2. help avoid deadlocks
3. allow the driver to retry, perhaps requesting reduced functionality.

> julia
>

<snip>

-- 
Rob Jones
Codethink Ltd
mailto:rob.jones@codethink.co.uk
tel:+44 161 236 5575
