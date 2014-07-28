From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: ASoC: Device tree binding to dummy codec
Date: Mon, 28 Jul 2014 12:33:57 -0400
Message-ID: <CAKON4OzrDeEbjzAgpB7f3NYcXGegUnF2+Hb1QZeZYKwztctkvg@mail.gmail.com>
References: <CAKON4Oynu5HE-jDETrNRBY3dYtwuh6XmOgyDOQuc4jmCzmNhNg@mail.gmail.com>
 <53D5ECA7.5090106@metafoo.de>
 <20140728112055.GM17528@sirena.org.uk>
 <CAKON4OzXfq+gDLdzs0VYh+X+4RBU=2Nds45P7+kBd+02eY+zHA@mail.gmail.com>
 <CAKON4Owhhw6WvJBvZC6KYpS+rtvbPymAqEb1+4iZ=e6OokGeng@mail.gmail.com>
 <20140728162715.GZ17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id C514C265125
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 18:33:58 +0200 (CEST)
Received: by mail-lb0-f171.google.com with SMTP id l4so5918552lbv.2
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 09:33:58 -0700 (PDT)
In-Reply-To: <20140728162715.GZ17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 28, 2014 at 12:27 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 28, 2014 at 09:49:27AM -0400, jonsmirl@gmail.com wrote:
>
>> codec: codec@01c22c00 {
>>    compatible = "allwinner,sun7i-a20-codec";
>>    reg = <0x01c22c00 0x40>;
>>    interrupts = <0 30 4>;
>>    clocks = <&pll2 0>, <&apb0_gates 0>, <&codec_clk>;
>>    clock-names = "pll", "apb", "codec";
>>    dmas = <&dma 0 19>, <&dma 0 19>;
>>    dma-names = "rx", "tx";
>>    widgets = "Mic1 Jack", "Headphone Jack";
>>    external-amp = <&max9768>
>>    status = "okay";
>> };
>
>> If external amp is missing I just bind to my internal dummy-codec.
>
> No, the CODEC that's in the device should be there all the time - it's
> just the same as connecting an external amp to any other device,
> describe the hardware in the SoC the same way all the time and then
> connect any attached devices to it.

Allwinner has named their on-chip audio interface 'codec'. This codec
just has two FIFOs hooked to the DAC/ADC. I coded everything in the
CPU-DAI and left the CODEC-DAI empty.

So what do you want the device tree to look like?
Example with no external amp.
Example with external amp.

-- 
Jon Smirl
jonsmirl@gmail.com
