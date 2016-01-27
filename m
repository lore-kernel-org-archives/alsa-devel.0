From: Damien Horsley <Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC V2 1/2] ASoC: img: Add binding document for Pistachio audio
 card
Date: Wed, 27 Jan 2016 17:13:09 +0000
Message-ID: <56A8FAA5.1000907@imgtec.com>
References: <1453818867-16322-1-git-send-email-Damien.Horsley@imgtec.com>
 <1453818867-16322-2-git-send-email-Damien.Horsley@imgtec.com>
 <20160127145756.GR6042@sirena.org.uk> <56A8DFBC.6070007@imgtec.com>
 <20160127160057.GA25316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160127160057.GA25316-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, James Hartley <james.hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 27/01/16 16:00, Mark Brown wrote:
> On Wed, Jan 27, 2016 at 03:18:20PM +0000, Damien Horsley wrote:
>> On 27/01/16 14:57, Mark Brown wrote:
>>> On Tue, Jan 26, 2016 at 02:34:26PM +0000, Damien Horsley wrote:
> 
>>>> +  - clock-names : Includes the following entries:
>>>> +        "audio_pll"  The audio PLL
>>>> +        "i2s_mclk"   The i2s reference clock
>>>> +                     Also connected to i2s_out_0_mclk output
>>>> +        "dac_mclk"   Dac reference clock. Connected to i2s_dac_clk output
> 
>>> Why are these (especially the dac_mclk and i2s_mclk) properties of the
>>> card and not of the drivers for the respective devices?
> 
>> Due to the shared nature of these clocks. Individual components cannot
>> be responsible for controlling these as this could break configurations
>> for other components that are sharing the clocks. Only the card driver
>> has visibility of all of the components and their requirements.
> 
> You're talking about the code that decides what rates to set the clock
> at, not where the properties are placed in the DT.
> 
>> i2s_mclk and dac_mclk can be used by both the i2s in and i2s out paths
>> on some boards
> 
> Multiple devices can reference the same clock.
> 

audio_pll is referenced exclusively by the card device

i2s_mclk and dac_mclk can also be referenced by other devices. The i2s
out controller references i2s_mclk, and codec devices can reference
i2s_mclk/dac_mclk dependent on their system clock requirements

without a reference to i2s_mclk and dac_mclk in the card driver, it
would not be possible to control the divisors and gates for these clocks
in the following cases:

Simplistic codecs that do not have drivers

Codec drivers that do not call clk_set_rate and clk_enable/clk_disable
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
