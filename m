From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/3] ASoC: add
	snd_soc_of_get_port_dai_name()
Date: Wed, 13 Feb 2013 21:37:47 -0700
Message-ID: <511C6A1B.9000507@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <50E71618.8090302@wwwdotorg.org>
 <20130104193712.GN4627@opensource.wolfsonmicro.com>
 <87y5fvyy18.wl%kuninori.morimoto.gx@renesas.com>
 <87vcazyxr1.wl%kuninori.morimoto.gx@renesas.com>
 <20130127035943.GJ4650@opensource.wolfsonmicro.com>
 <87vcag3hcj.wl%kuninori.morimoto.gx@renesas.com>
 <20130129014808.GC4748@opensource.wolfsonmicro.com>
 <87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>
 <87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>
 <5107FF97.1070601@wwwdotorg.org>
 <87halz82bm.wl%kuninori.morimoto.gx@renesas.com>
 <51097F0F.2030501@wwwdotorg.org>
 <87halw7sij.wl%kuninori.morimoto.gx@renesas.com>
 <5110349D.3050308@wwwdotorg.org>
 <87ehgvrs1h.wl%kuninori.morimoto.gx@renesas.com>
 <87bobzrry6.wl%kuninori.morimoto.gx@renesas.com>
 <511963F8.5020107@wwwdotorg.org>
 <87bobqf5yq.wl%kuninori.morimoto.gx@renesas.com>
 <511C22E2.60701@wwwdotorg.org>
 <87obfnofsx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B2502650EA
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 05:37:50 +0100 (CET)
In-Reply-To: <87obfnofsx.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/13/2013 06:16 PM, Kuninori Morimoto wrote:
> 
> Hi Stephen
> 
> Thank you for your explain.
> I think I could understand, but not 100%.
> 
>> Well, any driver that could be used with it will need to implement the
>> .of_xlate() callback. The simple-audio code would still be 100%
>> independent from any CPU or CODEC, since of_xlate would be a standard
>> interface/API that any CPU or CODEC driver could implement, and any ASoC
>> machine driver could call.
> (snip)
>> Yes, .of_xlate() wouldn't have to be implemented by the WM8903 CODEC
>> driver for the tegra-wm8903 machine driver to use the WM8903 CODEC.
>> However, if it /was/ implemented, it wouldn't stop tegra-wm8903 from
>> working. And later, it may help unify all the simple Tegra machine
>> drivers into one, since they could also become CODEC-independent, and
>> hence become unified (or at least mostly unified) code.
> 
> I guess, this .of_xlate should has "public" interface for all drivers,
> not simple-card special.

Yes exactly. And this means that it always returns a particular type of
object, not something different depending on who calls it; this is
relevant to the discussion below.

> Now, simple-card needs "dai name" from struct of_phandle_args.

Yes.

> This .of_xlate can be used from other driver if there is such kind of driver.
> Now, as example, I assumed this "other driver" needs something other data pointer from .of_xlate here.

Well, .of_xlate is /defined/ as taking the of_phandle_args and returning
the DAI name that the of_phandle_args represents. If there's ever a need
to translate some of_phandle_args to something else, that should be a
different function.

To that end, perhaps calling the function .of_xlate_dai_name might be
more future-proof; if we ever needed to translate say a CODEC widget
name, we could add a separate .of_xlate_widget_name function to do that
later, with zero effect on the .of_xlate_dai_name function.

> Then can .of_xlate has *void pointer for return ?

I think it would always return a string; the function parameter would be
"char **dai_name".

> In my check, the parameter of .of_xlate in gpio_chip and pmw has "driver specific" parameter.

It shouldn't. A GPIO driver's .of_xlate should /always/ take an
of_phandle_args, and translate it to a Linux (or perhaps chip-relative)
GPIO number, plus Linux GPIO flags. There should be nothing
driver-specific about the data it returns. The format of the device tree
cells that represent that data can be driver- (really, DT binding-)
specific; the whole point of the .of_xlate function is to translate that
binding-specific format into some standard internal Linux format.

> My pseudo code now is below.
> But is this correct ??
> 
> simple-card  OF has <&device port>  : of_phandle_args will be used as "port" spec
> other driver OF has <xxxx yyy zzz>  : of_phandle_args will be used as "something" spec
> 
> -- asoc --
> struct snd_soc_dai_driver {
>        ...
>        int (*of_xlate)(struct snd_soc_dai_driver    *driver,
>                        const struct of_phandle_args *spec,  // driver specific spec
>                        void                         *data); // for return data

As I mentioned above, that last parameter should be "char **dai_name",
and the function name probably of_xlate_dai_name.

>        ...
> }
> 
> -- MULTI .of_xlate support codec driver ---
> 
> #ifdef CONFIG_ASOC_SIMPLE_AUDIO_OF

No need to the ifdef; just provide a single definition which does one thing.

> int codec_of_xlate(struct snd_soc_dai_driver    *driver,
>                    const struct of_phandle_args *portspec,
>                    void                         *data);
> {
>         /*
>          * for simple-card which needs "dai name"
>          *
>          * of_phandle_args is used as "port" spec
>          */
>         *data = port_to_dai_name(portspec);

Yes, that's about right. Given how simple the implementation of
port_to_dai_name() is, I would simply write the code directly in the
implementation of of_xlate(). I assume you were writing pseudo-code
simply to avoid spelling out the implementation though.

>         return 0;
> }
> #elif  CONFIG_OTHER_DIRVER_IT_NEEDS_xxx_POINTER_OF
> int codec_of_xlate(struct snd_soc_dai_driver    *driver,
>                    const struct of_phandle_args *something_spec,
>                    void                         *data);
> {
>         /*
>          * for "other" driver which needs something pointer
>          *
>          * of_phandle_args is used as "something" spec
>          */
>         *data = something_necessary_pointer(something_spec);
>         return 0;
> }
> #else
> #define codec_of_xlate() NULL
> #endif
> 
> struct snd_soc_dai_driver  codec_driver = {
>        ...
>        .of_xlate = codec_of_xlate,
>        ...
> }
