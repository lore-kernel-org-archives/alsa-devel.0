From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: add generic dt-card support
Date: Thu, 22 Jan 2015 20:25:39 +0100
Message-ID: <54C14EB3.8080305@metafoo.de>
References: <cover.1421868426.git.moinejf@free.fr>	<d0c66c2e2f200119f9990fa52a503b1a4af6238f.1421868426.git.moinejf@free.fr>	<54C0088F.9070609@metafoo.de> <20150122090723.50ac0156@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150122090723.50ac0156@armhf>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

On 01/22/2015 09:07 AM, Jean-Francois Moine wrote:
> On Wed, 21 Jan 2015 21:14:07 +0100
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> [...]
>>> +	card->dai_link->dai_fmt =
>>> +		snd_soc_of_parse_daifmt(of_cpu, "dt-audio-card,",
>>> +					NULL, NULL) &
>>> +			~SND_SOC_DAIFMT_MASTER_MASK;
>>
>>
>> This one does not seem to be in the bindings documentation.
>
> Sorry, I forgot to remove it from the patch.

Ah, too bad this was the part I was most interested in. I think that using 
the generic of graph framework as a unified way for expressing non-control 
links is a good idea, whether it be for audio, video or something else.

But I think there are some open questions that need to be address when 
coming up with a specification for audio so we do not have to write yet 
another incompatible DT spec in 3 months time.

One issue is how to deal with multi-point-to-multi-point links. I2S/TDM is a 
bus and can have more than one reader/writer.

The second issue is how to describe the clock and frame master 
relationships. Multiple different buses can share the same clock and frame 
generator. E.g. typically the capture and playback stream are linked in this 
way.

How are we going to handle bus specific properties. Properties which are 
neither a property of either of the endpoints on the link, but of the link 
itself.


>
> BTW, the graph of port should also contain pieces of the audio specific
> hardware information as the ones found in the simple-card (clock,
> GPIO, ...). This information could be written as generic device node
> properties. i.e without any prefix.
>
> I was also wondering about some of these properties, as widgets and
> routing. They seem to be software information and Linux specific.
> Must these properties appear in the DTs?

Well last time I checked the speaker on my board was hardware not software 
and wasn't Linux specific either ;) Those widgets and routing represent the 
(typically analog) audio fabric on the board and are part of the hardware 
description. This is not even ASoC or devicetree specific, e.g. HDA uses a 
similar concept where the BIOS provides a description of which pins of the 
audio CODEC is connected to which speaker, microphone, etc. And especially 
on embedded boards the audio fabric can become quite complex.

Your example is a relative simple one where you do not have any additional 
audio fabric on the board itself.

- Lars
