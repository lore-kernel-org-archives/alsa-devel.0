From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] ASoC: generic: Add generic DT based simple codec
Date: Thu, 26 Sep 2013 17:16:11 -0600
Message-ID: <5244C03B.6060806@wwwdotorg.org>
References: <20130919105437.75e0f0a3@armhf> <5240B07C.6080404@wwwdotorg.org> <20130923232648.GL21013@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130923232648.GL21013-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 09/23/2013 05:26 PM, Mark Brown wrote:
> On Mon, Sep 23, 2013 at 03:19:56PM -0600, Stephen Warren wrote:
>> On 09/19/2013 02:54 AM, Jean-Francois Moine wrote:
> 
>>> +Required properties: +- compatible: should be
>>> "linux,simple-codec".
> 
>> We shouldn't have any Linux-specific bindings. It might be
>> reasonable to define a binding for a "simple CODEC", but there's
>> no reason it should be Linux-specific.
> 
> What's the vendor prefix to use then?  The same thought did occur
> to me but I wasn't sure what to suggest instead.

For other non-vendor-specific/generic bindings, we've simply omitted
the vendor prefix from the compatible value, e.g.: gpio-keys,
i2c-gpio, regulator-fixed, etc.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
