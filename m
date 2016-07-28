From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] Question about struct snd_soc_dai() ::
 cpu_dai->codec
Date: Thu, 28 Jul 2016 22:33:31 +0200
Message-ID: <579A6C1B.2060904@metafoo.de>
References: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
 <20160727032111.GY9681@localhost> <s5hh9bb7he6.wl-tiwai@suse.de>
 <20160727172125.GF9681@localhost> <20160727180456.GQ11806@sirena.org.uk>
 <s5h1t2f6jdm.wl-tiwai@suse.de> <20160727182233.GV11806@sirena.org.uk>
 <s5hpopy6dbi.wl-tiwai@suse.de> <20160728034643.GH9681@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160728034643.GH9681@localhost>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On 07/28/2016 05:46 AM, Vinod Koul wrote:
> On Wed, Jul 27, 2016 at 10:22:41PM +0200, Takashi Iwai wrote:
>> On Wed, 27 Jul 2016 20:22:33 +0200,
>> Mark Brown wrote:
>>>
>>> On Wed, Jul 27, 2016 at 08:11:49PM +0200, Takashi Iwai wrote:
>>>
>>>> I'm wondering whether it's a better option to block the unbind
>>>> behavior, either in driver base (allowing to return an error) or in
>>>> the sound side (waiting in remove() until the sane point). 
>>>
>>> That's certainly going to be a lot easier and part of the reason it's
>>> never been looked at much is that (unlike USB) there's very little
>>> reason why an ASoC sound card would ever be hotplugged - even in
>>> development these days the normal development flow involves rebooting.
> 
> I agree, it makese no sense for devices to be hotplugged. And for
> developement flows people can do rmmond and insmod. That works fine!

I don't agree. In my opinion hot-plug is an essential feature of a
modern device driver framework and if ASoC wants to claim to fall in
this category we ought to support it. Hotplug is something that always
pops up sooner or later. E.g. if someone puts a ASoC supported CODEC on
a hot-pluggable device (maybe USB) we don't want to duplicate the code,
but be able to reuse.

One area that e.g. requires hot-plug/-unplug and were ASoC supported
devices are used is embedded development boards that support shields and
devicetree overlays. Like e.g. RPI and similar.

The reason why we don't support hot-unplug in ASoC at the moment is
because it is not trivial to implement and nobody has cared enough yet.

But if somebody wants to and has the resources to implement this we
should not discourage this.

I'd very much prefer to have proper hot-plug support instead of
prohibiting unbinding even on systems that do not require hot-plug
support normally. It's a much cleaner solution.

- Lars
