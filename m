From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v4] ASoC: simple-card: add Device Tree support
Date: Wed, 20 Nov 2013 08:20:19 -0600
Message-ID: <CAL_Jsq+ZsrU5S6B_V8ruLK141LxTR2fd9Re5EWmp47LY+ALDow@mail.gmail.com>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
	<87txharb3o.wl%kuninori.morimoto.gx@renesas.com>
	<8738oiog00.wl%kuninori.morimoto.gx@renesas.com>
	<20131003104248.GI27287@sirena.org.uk>
	<87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
	<20131024171758.GA2461@kartoffel>
	<87iowm9jwv.wl%kuninori.morimoto.gx@renesas.com>
	<20131115155028.GE24831@e106331-lin.cambridge.arm.com>
	<CAL_JsqKLd4CbfD6PifXrwWxbyJqnvAViYkXQ63TBniQBPPzp4g@mail.gmail.com>
	<87li0ldso8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87li0ldso8.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 18, 2013 at 8:36 PM, Kuninori Morimoto
<kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
>
> Hi Rob, Mark
>
>> >> +Required properties:
>> >> +
>> >> +- compatible                         : "simple-audio"
>>
>> Still not really a fan of this generic name. Can we define in the
>> description above what simple means.
>
> So, how about "simple-audio-card" ?

That's missing my point. First, I think you should be defining the
actual h/w in the DT and doing the mapping of that to a simple audio
driver in the kernel. Otherwise how do you fix some quirk on a
particular platform later on without updating the DTB? I'm fine with
this being the default compatible string, but you should also require
a more specific name. Perhaps it is just <soc>-simple-audio or
<board>-simple-audio.

Second, you need to define in this binding document what simple means.
What properties of the audio subsystem make it simple? The h/w has and
doesn't have what? How do I decide if my platform can or should use
this binding?

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
