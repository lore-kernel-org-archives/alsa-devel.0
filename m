From: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Subject: Re: [PATCH 3/5] media: i2c: Add TDA1997x HDMI receiver driver
Date: Wed, 22 Nov 2017 20:49:09 -0800
Message-ID: <CAJ+vNU2_b+pRFXJE2Dv6DUAwZBfNFP-ZEjku5q4kggPwawnk4A@mail.gmail.com>
References: <1510253136-14153-1-git-send-email-tharvey@gateworks.com>
 <1510253136-14153-4-git-send-email-tharvey@gateworks.com> <20171115155204.yhqjocdm32qunllx@rob-hp-laptop>
 <CAJ+vNU0NuNjZePQBaxWHT4HtYGxZJ_DUSvuHvb6wAFDGA_xX9A@mail.gmail.com> <20171116043059.azaqjfbjeo4rlaon@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171116043059.azaqjfbjeo4rlaon@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans Verkuil <hansverk-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>
Cc: linux-media <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Steve Longerbeam <slongerbeam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 15, 2017 at 8:30 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Nov 15, 2017 at 10:31:14AM -0800, Tim Harvey wrote:
>> On Wed, Nov 15, 2017 at 7:52 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > On Thu, Nov 09, 2017 at 10:45:34AM -0800, Tim Harvey wrote:
>> >> Add support for the TDA1997x HDMI receivers.
>> >>
>> >> Cc: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
>> >> Signed-off-by: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
>> >> ---
>> >> v3:
>> >>  - use V4L2_DV_BT_FRAME_WIDTH/HEIGHT macros
>> >>  - fixed missing break
>> >>  - use only hdmi_infoframe_log for infoframe logging
>> >>  - simplify tda1997x_s_stream error handling
>> >>  - add delayed work proc to handle hotplug enable/disable
>> >>  - fix set_edid (disable HPD before writing, enable after)
>> >>  - remove enabling edid by default
>> >>  - initialize timings
>> >>  - take quant range into account in colorspace conversion
>> >>  - remove vendor/product tracking (we provide this in log_status via infoframes)
>> >>  - add v4l_controls
>> >>  - add more detail to log_status
>> >>  - calculate vhref generator timings
>> >>  - timing detection fixes (rounding errors, hswidth errors)
>> >>  - rename configure_input/configure_conv functions
>> >>
>> >> v2:
>> >>  - implement dv timings enum/cap
>> >>  - remove deprecated g_mbus_config op
>> >>  - fix dv_query_timings
>> >>  - add EDID get/set handling
>> >>  - remove max-pixel-rate support
>> >>  - add audio codec DAI support
>> >>  - change audio bindings
>> >> ---
>> >>  drivers/media/i2c/Kconfig            |    9 +
>> >>  drivers/media/i2c/Makefile           |    1 +
>> >>  drivers/media/i2c/tda1997x.c         | 3485 ++++++++++++++++++++++++++++++++++
>> >>  include/dt-bindings/media/tda1997x.h |   78 +
>> >
>> > This belongs with the binding documentation patch.
>> >
>>
>> Rob,
>>
>> Thanks - missed that. I will move it for v4.
>>
>> Regarding your previous comment to the v2 series:
>> > The rest of the binding looks fine, but I have some reservations about
>> > this. I think this should be common probably. There's been a few
>> > bindings for display recently that deal with the interface format. Maybe
>> > some vendor property is needed here to map a standard interface format
>> > back to pin configuration.
>>
>> I take it this is not an 'Ack' for the bindings?
>>
>> Which did you feel should be made common? I admit I was surprised
>> there wasn't a common binding for audio bus format (i2s|spdif) but if
>> you were referring to the video data that would probably be much more
>> complicated.
>
> The video data. Either you have to try to come up with some way to map
> color components to signals/pins (and even cycles) or you just enumerate
> the formats and keep adding to them when new ones appear. There's h/w
> that allows the former, but in the end you have to interoperate, so
> enumerating the formats is probably enough.
>
>> I was hoping one of the media/driver maintainers would respond to your
>> comment with thoughts as I'm not familiar with a very wide variety of
>> receivers.
>
> I am hoping, too.
>
> Rob

Hans,

Do you have any comment here regarding Rob's hope that there could be
some generic properties created for video port bindings? Anyone else
you know of who should chime in here?

The TDA1997x allows mapping its internal video output bus to its
physical pin in a fairly flexible way. I don't know how unique this is
to other chips.

Regards,

Tim
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
