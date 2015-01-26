From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: add generic dt-card support
Date: Mon, 26 Jan 2015 12:53:53 +0100
Message-ID: <54C62AD1.2090207@metafoo.de>
References: <cover.1421868426.git.moinejf@free.fr>	<d0c66c2e2f200119f9990fa52a503b1a4af6238f.1421868426.git.moinejf@free.fr>	<54C0088F.9070609@metafoo.de>	<20150122090723.50ac0156@armhf>	<54C14EB3.8080305@metafoo.de>	<20150123131554.623003f9@armhf>	<54C252F4.9000504@metafoo.de>	<20150123193456.276ea512@armhf>	<54C381A7.3020209@metafoo.de> <20150124141820.3793bd47@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150124141820.3793bd47@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 01/24/2015 02:18 PM, Jean-Francois Moine wrote:
> On Sat, 24 Jan 2015 12:27:35 +0100
> Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
>
>> On 01/23/2015 07:34 PM, Jean-Francois Moine wrote:
>>> On Fri, 23 Jan 2015 14:56:04 +0100
>>> Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
>>>
>>>> On 01/23/2015 01:15 PM, Jean-Francois Moine wrote:
>>> There is no first or second output in the kirkwood controller; there
>>> are I2S and S/PDIF outputs. Their hardware controls are done by bits in
>>> the different registers. Then, the driver may define its DAIs in any
>>> order and assign any DAI ID to these DAIs. So, for a given DAI, there
>>> is no relation between its type (I2s or S/PDIF), index in the dai
>>> driver (= asoc component index) and ID.
>>>
>>> In the simple-card DT, the CPU DAI (as the CODEC DAI) is referenced by
>>> a phandle (the audio-controller) and a number which should identify the
>>> DAI. This number is translated to a DAI name thanks to the function
>>> snd_soc_get_dai_name(). This function scans the components and returns
>>> the name of the DAI (component) supported by the audio controller with
>>> the searched number equal to the component index (there is no 'xlate'
>>> function).
>>>
>>> So, with the simple-card, the CPU or CODEC DAI binding (phandle +
>>> number) identifies what the software has put in its table, but not a
>>> hardware entity.
>>
>> Are you talking about the kirkwood driver or about things in general?
>
> I was talking about the kirkwood driver for the I2S and S/PDIF numbers.
> Other drivers may have the same problems.
>
>> What you are saying is not true in general, if it is true for the kirkwood
>> driver than the driver is broken in regards to DT bindings.
>>
>> The specifier that follows after the phandle is hardware specific. This can
>> be any number of integers. And the meaning of this is defined in the
>> bindings specification for that hardware.
>>
>> Many specifications define a binding in which either no specifier needs to
>> be supplied, since there is only a single DAI, or one integer specifier
>> which denotes which DAI is referenced for a multi-DAI controller. In the
>> later case the bindings specification has to state which number maps to
>> which physical DAI. Out of convenience many drivers use the same order as
>> given in the bindings specification for their ASoC DAIs. Which is why the
>> ASoC core provides a standard implementation for translating phandle +
>> specifier to a ASoC DAI. But it is important to remember that the
>> authoritative entity here is the bindings specification and not the driver.
>>
>> If the bindings specification uses a different scheme for referencing the
>> DAIs a custom xlate function needs to be provided by the driver confirms to
>> this specification.
>
> I did not have a look at any other multi-DAI audio CPU/CODEC, so, I can
> be wrong.
>
> All I can say is:
> - the driver is responsible to define its DAIs,
> - it may create them in any order,
> - the index of these DAIs is used in the DT.

The index in the DT needs to match the index that is in the DT 
specification. This does not necessarily have to match the ASoC driver ID. 
But since it makes things easier for the driver a lot of drivers opt for 
using the same IDs as specified in the DT specification.

>
> Then, for you, the DT binding should clearly indicate the relation
> between the specifier that follows the phandle and the hardware DAI.
>
> For the kirkwood audio controller, with a DT as:
>
> 	audio-ports = "spdif", "i2s";
>
> the DT documentation should say:
>
> - option 1: "the DAI specifier is always '0' for I2S and '1' for S/PDIF"
>
> - option 2: "the DAI specifier is the index of the port in the port declaration"
>
> The actual problem is that there is no port definition in the DT for
> the kirkwood audio controller.
>
> On the other side, referencing the DAI by an endpoint nullifies the DAI
> specifier problem: this last one does not exist anymore!
>
>>>> Could you describe in detail what a card builder is and how to decide when
>>>> and how a card builder is executed?
>>>
>>> A card builder is a device which
>>> - scans the graph of ports,
>>> - fills the struct snd_soc_card according to the links between the
>>>     ports and their properties,
>>> - and, eventually, calls snd_soc_register_card().
>>>
>>> The simple card builder, 'dt-card' (maybe a better name would have been
>>> 'graph-card'), acts just like the simple-card except that it does not
>>> appear in the DT. Its creation is done by an audio controller.
>>>
>>> For complex cards, a card builder would be the same as an actual card
>>> driver, but with the capability to know about the board thanks to the
>>> graph of ports. Its creation could be done by a compatible device in
>>> the DT (as actually) or by the unique or a 'master' audio controller.
>>>
>>> A card builder is subject to a PROBE_DEFER after calling
>>> snd_soc_register_card(), so, when it is created by an audio controller,
>>> this last one should have created its own resources.
>>>
>>> An audio controller does the following:
>>> - initialize the hardware and software,
>>> - create the DAIs from:
>>> 	- the graph of ports or
>>> 	- default values
>>> - register these DAIs and
>>> - if the DAIs where created by a graph of port,
>>> 	create the card builder.
>
>> I don't understand how invoking the card builder from the CPU side audio
>> controller driver will work. The audio controller driver does not know what
>> card it is part of, so how does it decide which builder to call, and what
>> happens in the case of multiple CPU side audio controllers involved in the
>> same card. In rare cases there might not even be a CPU side audio controller
>> involved at all.
>
> Each entity referenced in the graph knows each other one and the simple
> dt-card builder works only for one audio controller and one CODEC level
> (each audio link in the graph has the controller as an endpoint).
>
> For more complex cards, a DT information must exist. It can be:
>
> - a board specific sound node:
>
> 	sound {
> 		compatible = "myboard,audio-card";
> 		... card properties ...
> 	};
>
> - a device specific sound node:
>
> 	sound {
> 		compatible = "mydevice,audio-card";
> 		audio-root = <&audio1>;	/* starting point of the graph */
> 		... card properties ...
> 	};
>
> - a generic sound node in the case of multi controllers or multi codec
>    levels (after dt-card extension):
>
> 	sound {
> 		compatible = "linux,dt-card";
> 		audio-root = <&audio1>;	/* starting point of the graph */
> 		... card properties ...
> 	};
>
> For the last case, the creation of the simple dt-card builder could be
> done by a node in the controller, avoiding the DT to have a knowledge
> of this piece of software:
>
> 	&audio1 {
> 		...
> 		audio-card {
> 			... card properties ...
> 		}
> 		port@0 {
> 			...
> 		};
> 		...
> 	};

Is there any advantage to putting the card node inside the controller node 
rather than having it as a separate node?

>
>> I think this is something that needs to be done in the ASoC/ALSA core
>> itself. Create the graph, wait until all endpoints of the graph have been
>> registered and then create the card. Or something similar.
>
> To go further, such a function could fully replace
> snd_soc_register_card()!

Yes, if the graph is strongly connected (which it should be) the framework 
will be able to identify when all components that belong to the graph have 
been registered and is then able to create a card for it.

Are you by chance at FOSDEM? If you are maybe we can sit down for a moment 
and discuss things.

- Lars

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
