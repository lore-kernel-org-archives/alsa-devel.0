From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Question about struct snd_soc_dai() :: cpu_dai->codec
Date: Sat, 30 Jul 2016 06:45:04 +0900
Message-ID: <ab6b5a69-9d36-b4a5-0b8f-10a7dcf1ea40@sakamocchi.jp>
References: <s5hh9bb7he6.wl-tiwai@suse.de> <20160727172125.GF9681@localhost>
 <20160727180456.GQ11806@sirena.org.uk> <s5h1t2f6jdm.wl-tiwai@suse.de>
 <20160727182233.GV11806@sirena.org.uk> <s5hpopy6dbi.wl-tiwai@suse.de>
 <20160728034643.GH9681@localhost> <579A6C1B.2060904@metafoo.de>
 <579AA39B.5030100@sakamocchi.jp>
 <884bd15f-da5e-49f5-73ee-d8173dc0720a@metafoo.de>
 <20160729160702.GK9681@localhost> <s5hy44k41oa.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <s5hy44k41oa.wl-tiwai@suse.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Jul 30 2016 05:41, Takashi Iwai wrote:
>> That still seems a bit fancy hardware :)
>>
>> If we can reasonably support this, I am for it. But not making stuff
>> overtly complex...
> 
> Yes, we don't have to overreact to a dream immediately now.

As I wrote at first, my question is a sidetrack. So you can still
continue the discussion for loadable ALSA SoC part.

In my understanding, one of the aim of ALSA SoC part is to reuse drivers
of audio IPs, typically hardware ADC/DAC (so-called 'codec'). To achieve
this, the ideas of 'DAI' and 'link' are introduced for better
abstraction, additionally to historical 'card' and 'components'.

In a point of 'reuse of codes', I cannot imagine what Lars said for USB
devices, then post the questions.

> We should consider whether it can be shifted to the card-level instead
> before worrying too much about hot-unplug of an ASoC component.  Then
> the whole story becomes far easier.
>
> And, the suppress_bind_attrs flag I suggested is only to suppress the
> sysfs bind/unbind, and doesn't mean to prohibit hotplug itself via the
> bus driver.

In my opinion, the relationship between DAI driver and codec or
component driver is not described as relationship between kernel
modules. The issue cannot be resolved by dependency of loadable modules
and we need to manage the relationship of loaded modules somewhere. In
this meaning, I can understand the idea which Mr.Morimoto described.

But I think it's logically difficult to manage state of sound card; e.g.
disconnect. When one sound card instance consists of instances of
several 'DAI', 'Codecs' and 'Components' (this 'component' is not in
ALSA core contexts[1]) and we try to unload one of them, then which
state the card should be assigned to? Or no 'Codecs' drivers are loaded,
then which state should be assigned to the card?

Additionally, when old Codec driver is unloaded and new Codec driver is
loaded, then what should we do for corresponding PCM character devices
are? Currently, once snd_card_regsiter() is called, we cannot
insert/delete ALSA components such like PCM.


[1] For the context, please refer to 'Writing an ALSA driver'.
http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch02s03.html#basic-flow-constructor-create-other


Regards

Takashi Sakamoto
