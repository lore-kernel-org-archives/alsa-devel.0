From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 1/4] ASoC: wm9713: add binding for WM9713 codec
Date: Sat, 20 Feb 2016 23:24:02 +0100
Message-ID: <878u2fxbp9.fsf@belgarion.home>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
	<20160220171459.GA18327@sirena.org.uk> <871t87z1gz.fsf@belgarion.home>
	<20160220195925.GF18327@sirena.org.uk> <87twl3xgud.fsf@belgarion.home>
	<20160220211659.GG18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160220211659.GG18327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> (Mark Brown's message of
	"Sun, 21 Feb 2016 06:16:59 +0900")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> On Sat, Feb 20, 2016 at 09:32:58PM +0100, Robert Jarzmik wrote:
>> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:
>> > On Sat, Feb 20, 2016 at 07:22:04PM +0100, Robert Jarzmik wrote:
>> I will. By now I fail to see how this will help in the wm9713 probing and
>> detection ...
>
> It will eumerate the AC'97 bus by itself and does not need the CODEC to
> be described.
I think I still don't get it.

So let's rephrase it another way : how will the function wm9713_probe() be
called, ie. what is the possible function backtrace leading to that call ?

>> Until I make the try, here is what I have as a device-tree extract in [1],
>> which is my candidate for sound/soc/pxa/zylonite.c replacement.. If we
>> conclude that wm9713 shouldn't be in device-tree, then I'm curious how the
>> DAI bindings (simple-audio-card,dai-link*) should be handled.
>
> They should be created as a function of enumerating the CODEC.  If you
> use the genric AC'97 stuff it doesn't use ASoC at all and this happens
> as a side effect.
I don't get that either. For me sound/soc/pci/ac97/ac97_codec.c is PCI specific,
not generic, so what is "generic AC'97 stuff" ? I will never be able to use it
as on my platforms CONFIG_PCI=n.

Do you have a devicetree example somewhere, with (ac97 host, audio codec) pair I
can have a look at to understand ?

Cheers.

-- 
Robert
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
