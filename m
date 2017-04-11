From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] dt-bindings: Document STM32 I2S bindings
Date: Tue, 11 Apr 2017 11:02:57 -0500
Message-ID: <CAL_Jsq+bsh8Byow4poT7cdpLY_skb7QxbzkAmj4q7Cf6Z88GWA@mail.gmail.com>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com> <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170411143250.3r7ys3rjshtxgaee-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Arnaud POULIQUEN <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 11, 2017 at 9:32 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Apr 10, 2017 at 02:48:32PM -0500, Rob Herring wrote:
>> On Thu, Apr 06, 2017 at 05:40:35PM +0200, olivier moysan wrote:
>
>> > +Required properties:
>> > +  - compatible: Must be "st,stm32h7-i2s"
>> > +  - #sound-dai-cells: Must be 1. (one parameter)
>> > +    This parameter allows to specify CPU DAI index in soundcard CPU dai link.
>> > +   index 0: playback DAI
>> > +   index 1: capture DAI
>> > +   index 2: full duplex DAI
>
>> Is this still needed for graph-card?
>
> The graph card is blocked on your review...

Maybe if there were more reviewers it would move faster. I don't know
ASoC that well.

> I'm also not clear how
> without something like this we'd be able to identify a specific DAI
> within a device if we don't have a way of identifying them.

Isn't that what the graph does? "dais" points to a list of ports which
are the specific DAIs whether there are multiple ones in a single
device or multiple devices with a single DAI each.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
