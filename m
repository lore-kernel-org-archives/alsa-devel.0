From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] ASoC: cs4271: claim reset GPIO in bus
	probe function
Date: Wed, 19 Feb 2014 17:17:42 +0100
Message-ID: <5304D926.7070505@zonque.org>
References: <1392815154-24728-1-git-send-email-zonque@gmail.com>
 <993D86A8-0838-4A12-9BF7-F7BC1564F355@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id C6922265A4E
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 17:17:43 +0100 (CET)
In-Reply-To: <993D86A8-0838-4A12-9BF7-F7BC1564F355@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "subaparts@yandex.ru" <subaparts@yandex.ru>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On 02/19/2014 05:08 PM, Austin, Brian wrote:
>> On Feb 19, 2014, at 7:06, "Daniel Mack" <zonque@gmail.com> wrote:

>> -    if (gpio_nreset >= 0)
>> -        if (devm_gpio_request(codec->dev, gpio_nreset, "CS4271 Reset"))
>> -            gpio_nreset = -EINVAL;
>> -    if (gpio_nreset >= 0) {
>> +    if (gpio_is_valid(cs4271->gpio_nreset)) {
>>        /* Reset codec */
>> -        gpio_direction_output(gpio_nreset, 0);
>> +        gpio_direction_output(cs4271->gpio_nreset, 0);
>>        udelay(1);
>> -        gpio_set_value(gpio_nreset, 1);
>> +        gpio_set_value(cs4271->gpio_nreset, 1);
>>        /* Give the codec time to wake up */
>>        udelay(1);
>>    }
>
> Since your moving all the GPIO reset code into a new function that's
> called from the bus probes why not put the reset in there as well?

Because I want the codec to stay in reset until it is actually used, and
the machine drivers builds the DAI link.


Daniel
