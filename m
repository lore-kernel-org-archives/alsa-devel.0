From: Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v9 1/4] drm/i2c: tda998x: Add DT support for audio
Date: Fri, 09 Jan 2015 13:58:37 +0000
Message-ID: <54AFDE8D.3000504@arm.com>
References: <cover.1420628786.git.moinejf@free.fr> <0084acea5a3475a77531d6a77483f36d3469111a.1420628786.git.moinejf@free.fr> <54AE99F5.1010404@ti.com> <20150108174257.557f7ea5@armhf> <54AFA9B0.6040405@ti.com> <20150109123036.4bc4bbf6@armhf> <20150109114529.GH12302@n2100.arm.linux.org.uk> <20150109135401.5b270d46@armhf> <20150109130725.GN12302@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150109130725.GN12302-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 01/09/15 13:07, Russell King - ARM Linux wrote:
> On Fri, Jan 09, 2015 at 01:54:01PM +0100, Jean-Francois Moine wrote:
>> On Fri, 9 Jan 2015 11:45:29 +0000
>> Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
>>> I think we need to understand exactly how the 998x map I2S inputs to the
>>> HDMI channels to avoid making a mistake with the binding; remember, the
>>> binding isn't something that can be easily "bug fixed" at a later date
>>> as anything we come up with now has to be supported long term by the
>>> kernel.
>>
>> The DT describes the hardware configuration.
> 
> You're missing my point.
> 
> How does the driver know which of the I2S pins to enable in I2S mode?

[snip]

> My question is: how do we know which I2S inputs to enable, or are
> you suggesting that all I2S inputs should be enabled if operating in
> I2S mode irrespective of whether they may be active?
> 

Isn't it the case that for I2S:

* Word Select (WS) is always required to disambiguate left/right. So WS need
  not be specified in any device tree configuration.

* The audio inputs depend on a particular board but at least one is 
  required.  Fortunately, the TDA998x devices have all the same pin/input
  numbering so they /could/ be described as i2s0, i2s1, i2s2 and i2s3 as 
  per J-F's earlier email.  But tt isn't clear from my reading of the 
  TDA19988 datasheet (for example) whether one can skip channels (so
  does channel 0 always have to be present?).  If the channels must
  be enabled from 0 then one could simply specify the number of inputs.
  (The datasheets that I have don't indicate whether there's any 
  channel remapping performed internally by the TDA998x).

* What the driver does need to take account of is the number of inputs
  that are active so that the sound CODEC can be properly configured.


	Andrew


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
