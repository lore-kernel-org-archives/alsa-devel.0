From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support for audio
Date: Fri, 9 Jan 2015 12:13:04 +0200
Message-ID: <54AFA9B0.6040405@ti.com>
References: <cover.1420628786.git.moinejf@free.fr>	<0084acea5a3475a77531d6a77483f36d3469111a.1420628786.git.moinejf@free.fr>	<54AE99F5.1010404@ti.com> <20150108174257.557f7ea5@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150108174257.557f7ea5@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 01/08/2015 06:42 PM, Jean-Francois Moine wrote:
> On Thu, 8 Jan 2015 16:53:41 +0200
> Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org> wrote:
>
>>> +  - audio-ports: must contain one or two values selecting the source
>>> +	in the audio port.
>>> +	The source type is given by the corresponding entry in
>>> +	the audio-port-names property.
>>> +
>>
>> This binding does not allow multi channel i2s setups with multiple i2s
>> pins. It would be nice to support that in the DT binding, even if the
>> code is not yet ready for it.
>>
>> How about having these two optional properties instead of audio-ports
>> and audio-port-names:
>>
>> audio-port-i2s: Upto 4 values for selecting pins for i2s port
>> audio-port-spdif: Value for selecting input pin for spdif port
>>
>> Presence of one of the properties would be mandatory and both are allowed.
>>
>> Sorry to notice this only now, but I have not yet looked the drm side
>> changes too closely.
>
>  From Andrew's datasheet, the TDA998x's which are handled by the tda998x
> driver have only 4 input audio pins, the first two ones being either
> S/PDIF or I2s, the last ones being I2S only.
>

AFAIK, SPDIF is always a single pin connection so only one pin needs to 
be selected. But i2s need for pins for full 8 channel output.

> So, the DT description could be reduced to a simple list indexed by
> the pin number (= DAI number) and defining the protocol type.
>
> Examples:
>
> - for the Cubox:
>
> 	audio-inputs = "i2s", "spdif";
>
> - for some other board with I2S on the pins 3 and 4 only:
>
> 	audio-inputs = "none", "none", "i2s", "i2s";
>
> - for a fully wired TDA9983B (no driver yet):
>
> 	audio-inputs = "i2s", "i2s", "i2s", "i2s", "spdif";
>

If you want to go closer to the original paradigm, then how about 
defining following audio-port-names: i2s0, i2s1, i2s2, i2s3, and spdif. 
With this approach we could go with your original binding with only 
minor changes. A binding in your stereo i2s or spdif case would look 
like this:

	audio-ports = <0x04>, <0x03>;
	audio-port-names = "spdif", "i2s0";

A full 8 channel i2s or spdif output would look like this:

	audio-ports = <0x04>, <0x03>, <0x02>, <0x01>, <0x00>;
	audio-port-names = "spdif", "i2s0", "i2s1", "i2s2", "i2s3";


This would also indicate the channel mapping to the audio pins (i2s0 for 
first two channels, i2s1 for 3-4, etc.)

The code could for now just look for "i2s0" and the port names for 
channels 3-8 could be ignored until they are needed.

Best regards,
Jyri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
