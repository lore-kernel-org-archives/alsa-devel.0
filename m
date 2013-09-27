From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ASoC: generic: Add generic DT based simple codec
Date: Thu, 26 Sep 2013 21:57:30 -0500
Message-ID: <CAL_JsqKmfurrCqEYRNqcLRZMU-VjPin2dvK1Q6CMcK4i=+x-8w@mail.gmail.com>
References: <20130919105437.75e0f0a3@armhf>
	<5240B07C.6080404@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5240B07C.6080404-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 23, 2013 at 4:19 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> On 09/19/2013 02:54 AM, Jean-Francois Moine wrote:
>> This patch adds a simple sound codec which is described by the DT.
>> This codec may be used when no specific codec action is needed.
>
>> diff --git a/Documentation/devicetree/bindings/sound/simple-codec.txt b/Documentation/devicetree/bindings/sound/simple-codec.txt
>
>> +Device-Tree bindings for the simple codec
>> +
>> +Required properties:
>> +- compatible: should be "linux,simple-codec".
>
> We shouldn't have any Linux-specific bindings. It might be reasonable to
> define a binding for a "simple CODEC", but there's no reason it should
> be Linux-specific.

Further, just define the type of codec h/w. If linux can use its
simple-codec driver for it, then add a match table entry for said
codec. Then the DT is future proof when you decide the simple driver
doesn't really work for that h/w.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
