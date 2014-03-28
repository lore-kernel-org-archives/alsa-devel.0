From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH v2] ASoC: sta350: Add codec driver
Date: Fri, 28 Mar 2014 10:25:34 +0100
Message-ID: <5335400E.5010003@zonque.org>
References: <1395950176-15184-1-git-send-email-zonque@gmail.com>
 <53353A39.3040006@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id F3FAA2654D7
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 10:25:35 +0100 (CET)
In-Reply-To: <53353A39.3040006@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, neumann@teufel.de, brandau@gmx.de
List-Id: alsa-devel@alsa-project.org

Hi Lars,

On 03/28/2014 10:00 AM, Lars-Peter Clausen wrote:
>> +	if (ret < 0)
>> +		return ret;
>> +#endif
>> +
>> +	/* GPIOs */
>> +	if (gpio_is_valid(sta350->gpio_nreset)) {
>> +		ret = devm_gpio_request_one(&i2c->dev, sta350->gpio_nreset,
>> +					    GPIOF_OUT_INIT_HIGH,
>> +					    "ST350 Reset");
> 
> New code should use the GPIO descriptor API. See 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/gpio/consumer.h

Interesting new interface, missed that. Thanks for the pointer!

I changed all your remarks locally, but I'd like to give it a quick
test. Will send v3 once I have confidence :)


Daniel
