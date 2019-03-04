From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC 2/3] ASoC: hdmi-codec: add support for
	bclk_ratio
Date: Mon, 4 Mar 2019 19:32:49 +0200
Message-ID: <2ba53826-3f74-87d7-dd5c-07d5b3e586c9@ti.com>
References: <20190222212619.ghxly3eb6dx7p2ut@shell.armlinux.org.uk>
 <E1gxILm-0004MX-Kb@rmk-PC.armlinux.org.uk>
 <520b346f-a874-790d-61ec-fb4ac67ad046@ti.com>
 <20190301123629.GC7429@sirena.org.uk>
 <CAGngYiUNFc9N82duW1kwzx-dY3dk=1Sw9QffqpocoP=xz9OdVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA968F896CE
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2019 18:32:55 +0100 (CET)
In-Reply-To: <CAGngYiUNFc9N82duW1kwzx-dY3dk=1Sw9QffqpocoP=xz9OdVw@mail.gmail.com>
Content-Language: en-GB
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sven Van Asbroeck <thesven73@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org

On 04/03/2019 18:59, Sven Van Asbroeck wrote:
> On Fri, Mar 1, 2019 at 7:36 AM Mark Brown <broonie@kernel.org> wrote:
>>
>>
>> As Russell outlined there's quite a bit of hopeful assumption in how
>> ASoC handles the mapping of memory formats onto wire formats which works
>> almost all the time but not always and definitely not through robust
>> design
> 
> Yes, many of the painful tradeoffs in this discussion would go away, if the
> alsa negotiation infrastructure was 'bclk_ratio aware'.
> 
> They say that a 100-line patch is often better than 1000 words. To help kick-
> start a discussion, I offer a simple patch which adds bclk_ratio to
> hw_params, which lets alsa 'negotiate' it the same way as the format,
> channels, etc.
> 
> Obviously this is completely flawed, as it exposes bclk_ratio to userspace thru
> snd_pcm_hw_params. Userspace has no business even knowing about this on-wire
> property.
> 
> It may be flawed in a lot of other ways I can't see rn :)
> 
> As far as a flawed suggestion goes, it seems to behave quite well on my system.
> The bclk_ratio is nicely constrained within the cpu and codec's supported
> ranges and rules, and the lowest supported value is picked before hw_params()
> gets called. Which is at least channels * sample_width.
> 
> Would there be a way to hide the bclk_ratio from userspace?
> 
> Is it even worth taking this forward? How likely is it for alsa components
> to care about the bclk_ratio? Maybe this is a tda998x one-off?
> 

I am not the right person say if this should be taken forward.

However, if we are going forward, I think we need to add bclk_rate to
snd_pcm_hw_params too, since the available bclks affects the choice of
bclk_ratios that are available. For instance if the bclk is generated
from static clock with a simple divider then following equatios should
always be satisfied:

bclk_rate = clk_source_rate / clk_divider, where clk_divider = 0, 1, ..n
sample_rate = bclk_rate / bclk_ratio

The good news is that snd_pcm_hw_rule_add() should be able to cope with
such cross dependencies.

BR,
Jyri

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
