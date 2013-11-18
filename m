From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4] ASoC: simple-card: add Device Tree support
Date: Mon, 18 Nov 2013 08:12:06 -0600
Message-ID: <CAL_JsqKLd4CbfD6PifXrwWxbyJqnvAViYkXQ63TBniQBPPzp4g@mail.gmail.com>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
	<87txharb3o.wl%kuninori.morimoto.gx@renesas.com>
	<8738oiog00.wl%kuninori.morimoto.gx@renesas.com>
	<20131003104248.GI27287@sirena.org.uk>
	<87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
	<20131024171758.GA2461@kartoffel>
	<87iowm9jwv.wl%kuninori.morimoto.gx@renesas.com>
	<20131115155028.GE24831@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131115155028.GE24831-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 15, 2013 at 9:50 AM, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org> wrote:
> On Fri, Oct 25, 2013 at 03:14:20AM +0100, Kuninori Morimoto wrote:
>> Support for loading the simple-card module via DeviceTree.
>> It requests CPU/CODEC information.
>>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>> ---
>> v3 -> v4
>>
>>  - explain detail of each properties on simple-card.txt
>>  - fixup odd examples on simple-card.txt
>>  - remove "simple-card,card-name". create it from cpu/codec name
>>  - use of_get_child_by_name()
>>  - remove odd pointer info from dev_dbg()
>>  - remove subnode format which are no longer needed
>>
>> This is based on asoc/topic/simple branch
>>
>>  .../devicetree/bindings/sound/simple-card.txt      |   73 +++++++++
>>  sound/soc/generic/simple-card.c                    |  156 +++++++++++++++++++-
>>  2 files changed, 223 insertions(+), 6 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/sound/simple-card.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
>> new file mode 100644
>> index 0000000..4871e91
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/simple-card.txt
>> @@ -0,0 +1,73 @@
>> +Simple-Card:
>> +
>> +Simple-Card specifies audio DAI connection of SoC <-> codec.
>> +
>> +Required properties:
>> +
>> +- compatible                         : "simple-audio"

Still not really a fan of this generic name. Can we define in the
description above what simple means.

>> +
>> +Optional properties:
>> +
>> +- simple-audio,format                        : CPU/CODEC common audio format.
>> +                                     "i2s", "right_j", "left_j" , "dsp_a"
>> +                                     "dsp_b", "ac97", "pdm", "msb", "lsb"
>> +Required subnodes:
>> +
>> +- simple-audio,cpu                   : CPU   sub-node
>> +- simple-audio,codec                 : CODEC sub-node
>> +
>> +Required CPU/CODEC subnodes properties:
>> +
>> +- sound-dai                          : phandle and port of CPU/CODEC
>
> Is there a class binding for audio devices this derives from?
>
>> +
>> +Optional CPU/CODEC subnodes properties:
>
> Do these all apply to both sub-nodes?
>
>> +- frame-master                               : bool property. add this if subnode was frame master
>> +- bitclock-master                    : bool property. add this if subnode was bitclock master
>
> s/was/is/
>
>> +- bitclock-inversion                 : bool property. add this if subnode has clock inversion
>> +- frame-inversion                    : bool property. add this if subnode has frame inversion
>> +- clocks / system-clock-frequency    : specify subnode's clock if needed.
>> +                                       it can be specified via "clocks" if system has clock node,
>> +                                          or "system-clock-frequency" if system doesn't have it.
>
> What does "if system doesn't have it" mean? If it doesn't have a clock,
> how does said non-existent clock have a frequency?
>
> It would be possible to use a fixed-clock in place of
> system-clock-frequency, which would make the binding more consistent and
> the driver simpler, at the cost of making the dt marginally more
> complex.

Just plain "clock-frequency" is fairly standard, so please use that
instead. Unless there is need for a fixed-clock to be routed to
several nodes, then I think using the more simple clock-frequency here
is fine.

Can both sub-nodes really have different clocks? Seems like that would
exceed the definition of simple.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
