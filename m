From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: add generic dt-card support
Date: Fri, 23 Jan 2015 14:56:04 +0100
Message-ID: <54C252F4.9000504@metafoo.de>
References: <cover.1421868426.git.moinejf@free.fr>	<d0c66c2e2f200119f9990fa52a503b1a4af6238f.1421868426.git.moinejf@free.fr>	<54C0088F.9070609@metafoo.de>	<20150122090723.50ac0156@armhf>	<54C14EB3.8080305@metafoo.de> <20150123131554.623003f9@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150123131554.623003f9@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 01/23/2015 01:15 PM, Jean-Francois Moine wrote:
[...]
> The DT should describe the hardware, and the simple-card mixes hardware
> and software.
> For example, the kirkwood controller may create 2 CPU DAIs. With the
> simple-card, the DT contains a number to reference these DAIs (for
> example, implicitly, <audio1 0> references the I2S output). So, what if
> the controller creates only one DAI, or, what if the FreeBSD/OpenBSD/..
> driver does not set the same references to these DAIs?
> The graph of port fixes this problem.

Even with the simple-card bindings there are no software specific bits. The 
DAI that is referenced in your example is the physical DAI as it exists in 
the hardware. Which DAI maps to which specifier is defined in the devicetree 
bindings definition for the hardware unit.

>
> More: a simple audio card may easily be created from a graph of ports
> as the simple-card does, but by the audio-controller (sorry, I also
> forgot the kirkwood patch for this in my previous patch request).
> In case of complex cards, the links and properties of this graph may
> also be used by board specific card devices.
>
>> One issue is how to deal with multi-point-to-multi-point links. I2S/TDM is a
>> bus and can have more than one reader/writer.
>>
>> The second issue is how to describe the clock and frame master
>> relationships. Multiple different buses can share the same clock and frame
>> generator. E.g. typically the capture and playback stream are linked in this
>> way.
>
> The ports and endpoints may contain properties to describe these
> configurations. Complex cases should be handled by specific card
> builders.

Could you describe in detail what a card builder is and how to decide when 
and how a card builder is executed?

>
>> How are we going to handle bus specific properties. Properties which are
>> neither a property of either of the endpoints on the link, but of the link
>> itself.
>
> This is already the case for the bus types of the kirkwood controller,
> I2S or S/PDIF. Such properties may appear in either local or remote
> port, or in both.
>
>>> BTW, the graph of port should also contain pieces of the audio specific
>>> hardware information as the ones found in the simple-card (clock,
>>> GPIO, ...). This information could be written as generic device node
>>> properties. i.e without any prefix.
>>>
>>> I was also wondering about some of these properties, as widgets and
>>> routing. They seem to be software information and Linux specific.
>>> Must these properties appear in the DTs?
>>
>> Well last time I checked the speaker on my board was hardware not software
>> and wasn't Linux specific either ;) Those widgets and routing represent the
>> (typically analog) audio fabric on the board and are part of the hardware
>> description. This is not even ASoC or devicetree specific, e.g. HDA uses a
>> similar concept where the BIOS provides a description of which pins of the
>> audio CODEC is connected to which speaker, microphone, etc. And especially
>> on embedded boards the audio fabric can become quite complex.
>
> OK. I looked if the widgets and routes could also be described in a
> graph, but, it complexifies the syntax. So, this information could have
> the same syntax as in the simple-card.

Yea, using the graph syntax for the analog pins would result in a lot of 
boiler-plate.

>
> On the other hand, where would this information appear in the graph?
> As I understood, on card creation, the widgets and routes, which appear
> at the card level, redefine the CPU and CODEC DAI definitions.

What do you mean by "redefine the CPU and CODEC DAI definitions".

>
> With a DT graph, each CPU/CODEC would know exactly the widgets and
> routes it has to define.

Which widgets/routes do you mean?

>
>> Your example is a relative simple one where you do not have any additional
>> audio fabric on the board itself.
>
> Right, and that's why I'd be glad to have quickly something in the
> kernel. More properties could be added later as there would be requests.

I'd agree if this was some kind of kernel internal stuff, but this is 
creating ABI and we have to maintain it forever. Rushing this in without 
proper discussion and consideration of the more complex use-cases is in my 
opinion not a good idea.

- Lars
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
