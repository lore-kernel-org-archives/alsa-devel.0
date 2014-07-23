From: Matt Flax <flatmax@flatmax.org>
Subject: Re: I2S driver for implants
Date: Wed, 23 Jul 2014 21:08:11 +1000
Message-ID: <53CF979B.30702@flatmax.org>
References: <53CF6DD8.3000507@flatmax.org>
 <CA+E=qVfJ47g76=Zzq+smQUR5UY0zRWjV8Aswx5D7AAfdKLPQmA@mail.gmail.com>
 <53CF83CA.3030004@flatmax.org> <9397069.ggOniReSfE@vasilykh-desktop-i5>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail06.adl6.internode.on.net (ipmail06.adl6.internode.on.net
 [150.101.137.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B6D026563F
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 13:08:17 +0200 (CEST)
In-Reply-To: <9397069.ggOniReSfE@vasilykh-desktop-i5>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: vano@ivankiten.com, cw00.choi@samsung.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 23/07/14 19:52, Vasily Khoruzhick wrote:
> On 23 July 2014 19:43:38 Matt Flax wrote:
>> On 23/07/14 18:23, Vasily Khoruzhick wrote:
>>> On Wed, Jul 23, 2014 at 11:10 AM, Matt Flax <flatmax@flatmax.org> wrote:
>>>> Hi there,
>>> Hi Matt,
>>>
>>> I'd suggest you include alsa-devel ML next time (added it to CC)
>>>
>>>> I saw your driver sound/soc/samsung
>>>>
>>>> I am wanting to look into an I2S driver for the Exynos 5250 for eye
>>>> implants.
>>> Driver for I2S in Exynos 5 is already included in mainline kernel.
>>>
>>>> The implants use a serial bus and I am wanting to specify an I2S
>>>> connection
>>>> to them.
>>>>
>>>> In order to do that I would need to write an I2S driver to talk to them.
>>>> Their bit rates are either 300 kbps or 600 kbps.
>>>> They only need I2S and not I2C ... there are not controls, simply serial
>>>> data in and out.
>>> Are you sure that your implants can talk over I2S?
>> Yes, we do/will have custom hardware to reconstruct the required signals
>> from the I2S lines.
>>
>>>> I am wondering if I can do something simple ... I notice that your driver
>>>> doesn't require too much code ...
>>>> Do you think it is possible for me to take a similar approach in writing
>>>> my
>>>> implant driver ?
>>> Don't know, you didn't share much details on your hardware.
>> The hardware requires one I2S output line and one I2S input line + the
>> clock line.
>>
>> You say "Driver for I2S in Exynos 5 is already included in mainline
>> kernel." ... do you mean that all I need is a device tree file to enable
>> it ? If so, then can you please link me to an example device tree ... my
>> assumption is that this I2S device will show up in alsa once the device
>> tree is setup ?
> You'd probably need some codec stub, I'm not sure if it's possible to
> instantiate soundcard with only i2s and without a codec.
Thats fine, I can implement the codec stub. I guess I was originally 
contacting you (and others) to get some pointers on how to do that. Is 
there perhaps a codec stub for some very simple hardware (only I2S) 
which I could use as a reference ? Also would require an example dts 
file ... all for the Exynos.

thanks
Matt

> Regards
> Vasily
>
>>>> Can you give me advice - how to start ?
>>> Start with reading specs and try to understand how your implants work,
>>> then look at existing code and try to adapt it for your usage.
>>> Then clean it up and prepare for submitting into mainline.
>>>
>>>> thanks
>>>> Matt
>>> Regards,
>>> Vasily
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
