From: Howard Mitchell <hm@hmbedded.co.uk>
Subject: Re: [PATCH] ASoC:pcm512x: Make PLL lock output
 selectable via device tree.
Date: Mon, 23 Mar 2015 11:14:09 +0000
Message-ID: <550FF581.4000502@hmbedded.co.uk>
References: <1426886563-10936-1-git-send-email-hm@hmbedded.co.uk>
 <20150322162409.GG6643@sirena.org.uk> <550FE05F.6070204@hmbedded.co.uk>
 <105aef6a0e21488d8661d2a2823515d8@EMAIL.axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avasout05.plus.net (avasout05.plus.net [84.93.230.250])
 by alsa0.perex.cz (Postfix) with ESMTP id E399A260568
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 12:16:51 +0100 (CET)
In-Reply-To: <105aef6a0e21488d8661d2a2823515d8@EMAIL.axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>, Mark Brown <broonie@kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "galak@codeaurora.org" <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org



On 23/03/15 11:00, Peter Rosin wrote:
> Howard Mitchell wrote:
>> On 22/03/15 16:24, Mark Brown wrote:
>>> On Fri, Mar 20, 2015 at 09:22:43PM +0000, Howard Mitchell wrote:
>>>
>>>> +	if (pcm512x->pll_lock) {
>>>> +                if (of_property_read_u32(np, "pll-lock", &val) >= 0) {
>>>> +                        if (val > 6) {
>>>> +                                dev_err(dev, "Invalid pll-lock\n");
>>>> +                                ret = -EINVAL;
>>>> +                                goto err_clk;
>>>> +                        }
>>>> +                        pcm512x->pll_lock = val;
>>>> +                }
>>> This breaks existing boards which rely on GPIO 4 being set as the lock
>>> output.  This is very unfortunate since it's a silly thing for the
>>> driver to default to but nontheless we should really continue to support
>>> them - at a guess Peter's board is relying on this, and even if it isn't
>>> someone else's might.
>> I take your point, but the reason I pushed this patch was that I wanted
>> to use GPIO4 for pll-out and unfortunately because the pll-lock
>> configuration is after the pll-out configuration it stomps on it. If I
>> modify the patch to provide a default for pll-lock I will then be
>> obliged to specify pll-lock on another GPIO. The pcm5122 has limited IO
>> so being forced to have a GPIO for pll-lock seems wrong to me. A future
>> user of the device may well decide to use the GPIOs for other purposes
>> and therefore not want a pll-lock signal at all. Surely we should allow
>> for that possibility?
>>
>> Given that Peter has indicated that he'd be happy with this solution and
>> that this code hasn't reached a published kernel would it be reasonable
>> to go ahead with my current patch (happy to clean up the indent issues
>> that Peter pointed out of course)?
> Strongly agreed that we should fix this before it is published (I assumed
> that is was included in 3.19, it felt so long ago that Mark merged it...). My
> preference would be to remove the pll-lock things entirely though. Assuming
> you don't need it for your board of course, but I doubt it from your description.
> I used it to make sure I had understood the chip correctly, that's all.
>
> Cheers,
> Peter
>
I'd be happy to remove it entirely. I only used it as you did as a debug 
tool. Let's see what Mark thinks.....

- Howard
