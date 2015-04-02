From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: Re: ASoC: cs4271: init/timing problem
Date: Thu, 02 Apr 2015 09:56:48 +0200
Message-ID: <551CF640.5010203@gmail.com>
References: <551A5FC9.4010109@gmail.com>
 <alpine.DEB.2.10.1503311600000.13828@heelrod-desktop>
 <551BC102.6010403@gmail.com> <551BCE01.2070007@gmail.com>
 <9FF9C0F5-716B-4F31-AFAC-17B1C8991AB8@cirrus.com>
 <551C10B8.5080409@gmail.com>
 <alpine.DEB.2.10.1504011206320.13828@heelrod-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A8F9261685
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 09:56:50 +0200 (CEST)
Received: by wgbdm7 with SMTP id dm7so77005166wgb.1
 for <alsa-devel@alsa-project.org>; Thu, 02 Apr 2015 00:56:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.10.1504011206320.13828@heelrod-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On 01.04.2015 19:08, Brian Austin wrote:
>>>> I just lowered the clock-frequency to 50 kHz and I face the same
>>>> problem, but it very much depends on the hardware. On some devices I
>>>> don't face the problem at all and on others I can reproduce it very
>>>> reliable. If I add a mdelay(20), or use the loop I postet earlier, the
>>>> issue is gone on all devices.
>>> Are there any other devices on the I2C bus? Lets take this off the ALSA list until there
>>> is a determination that it is an ASoC issue which it does not appear to be right now.
>>
>> Well I think it is. There is a delay needed in sound/soc/codec/cs4271.c
>> at line 569, in certain cases, because the call to regmap_update_bits on
>> line 570 fails sometimes. If I add a delay of a few us on line 569, the
>> call never fails.
>>
>> But let me just send in a patch so we really know what we are talking
>> about, then.
>>
> can you try something like this?
> 
> gpio_direction_output(cs4271->gpio_nreset, 0);
> -udelay(1);
> gpio_set_value(cs4271->gpio_nreset, 1);
> /* Give the codec time to wake up */
> -udelay(1);
> 
> gpio_direction_output(cs4271->gpio_nreset, 0);
> +mdelay(1);
> gpio_set_value(cs4271->gpio_nreset, 1);
> /* Give the codec time to wake up */
> +mdelay(1);
> 
> See if that helps instead of adding another delay.

Works perfect for me. Tested on different devices without any problems.
If you agree on that, I'll send in a patch.
