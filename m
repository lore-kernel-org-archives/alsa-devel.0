From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: cs4271: free reset gpio in
	cs4271_remove()
Date: Wed, 19 Feb 2014 12:43:24 +0100
Message-ID: <530498DC.9060103@metafoo.de>
References: <1392808032-25756-1-git-send-email-zonque@gmail.com>
 <20140219111529.GI2669@sirena.org.uk> <53049467.60106@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-148.synserver.de
 [212.40.185.148])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CBB22652E6
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 12:43:10 +0100 (CET)
In-Reply-To: <53049467.60106@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: brian.austin@cirrus.com, Mark Brown <broonie@kernel.org>, subaparts@yandex.ru, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

On 02/19/2014 12:24 PM, Daniel Mack wrote:
> On 02/19/2014 12:15 PM, Mark Brown wrote:
>> On Wed, Feb 19, 2014 at 12:07:12PM +0100, Daniel Mack wrote:
>>
>>> +	if (gpio_is_valid(cs4271->gpio_nreset)) {
>>>   		/* Set codec to the reset state */
>>>   		gpio_set_value(cs4271->gpio_nreset, 0);
>>> +		devm_gpio_free(codec->dev, cs4271->gpio_nreset);
>>> +	}
>>
>> If it's being requested as a managed resource shouldn't it be being
>> freed automatically?
>>
>
> Nope, as the module itself will not go away necessarily. I hit the bug
> when unloading and reloading the machine driver. cs4271_probe(codec)
> will fail to acquire and drive the reset line, and the codec stays in reset.
>

In my opinion a better solution is to move the requesting of the GPIO from 
the CODEC probe() function to the SPI/I2C probe() functions. Actually it 
looks as if most of the code (if not all) in the CODEC probe() function 
should be done when the driver is probed.

- Lars
