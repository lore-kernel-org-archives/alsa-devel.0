From: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Subject: Re: Choosing the sysclk in simple-card looks broken to
	me.
Date: Sun, 10 Aug 2014 14:42:23 -0400
Message-ID: <CAKON4OxvoLBiq64t6Oh1i3CgA=Zy5DU7xYEe2kkpVdWkXMmqsg@mail.gmail.com>
References: <CAKON4Oxusv_VuHNgbum1wBBz_N_V-a11N_rPu8m-rLFYAcQ_sQ@mail.gmail.com>
 <20140810105405.GW17528@sirena.org.uk>
 <CAKON4OzhSFJ4-cGkbr10LNorb+ihi6gqm1V4-YhTMHq8kmcWGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 7617E261B31
 for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2014 20:42:24 +0200 (CEST)
Received: by mail-lb0-f170.google.com with SMTP id l4so3329955lbv.15
 for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2014 11:42:24 -0700 (PDT)
In-Reply-To: <CAKON4OzhSFJ4-cGkbr10LNorb+ihi6gqm1V4-YhTMHq8kmcWGg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, zengzm.kernel@gmail.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

This should fix it to use the output clocks, but does it break any of
the other DTS using simple-audio?

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 03a7fdc..8c4b267 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -116,6 +116,7 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
 {
  struct device_node *node;
  struct clk *clk;
+ const char *clk_name = NULL;
  int ret;

  /*
@@ -156,11 +157,14 @@ asoc_simple_card_sub_parse_of(struct device_node *np,
      "system-clock-frequency",
      &dai->sysclk);
  } else {
- clk = of_clk_get(node, 0);
- if (!IS_ERR(clk))
- dai->sysclk = clk_get_rate(clk);
+ of_property_read_string(node, "clock-output-names", &clk_name);
+ if (clk_name) {
+ clk = of_clk_get_by_name(node, clk_name);
+ if (!IS_ERR(clk)) {
+ dai->sysclk = clk_get_rate(clk);
+ }
+ }
  }
-
  return 0;
 }


On Sun, Aug 10, 2014 at 8:34 AM, jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> On Sun, Aug 10, 2014 at 6:54 AM, Mark Brown <broonie@kernel.org> wrote:
>> On Sat, Aug 09, 2014 at 08:08:45PM -0400, jonsmirl@gmail.com wrote:
>>
>>> The problem is in asoc_simple_card_sub_parse_of()
>>> in the else case..
>>
>>> } else {
>>> clk = of_clk_get(node, 0);
>>> if (!IS_ERR(clk))
>>> dai->sysclk = clk_get_rate(clk);
>>> }
>>
>>> This is picking up the input clocks to the devices.  On the cpu-dai
>>> you want to pick up the ouput mclk (my first input clock is an 80Mhz
>>> bus clock).  My IIS output clock is: clock-output-names = "mclk0";
>>
>>> Setting clocks="" doesn't work either, it also picks up the input clock.
>>
>> I'm sorry but I'm having an awfully hard time working out what you are
>> trying to say in this mail.  When you say things like "you want to pick
>> up the ouput mclk" it's really not clear what any of that means - why do
>> you want to pick it and what is it being picked for?
>
> Inside simple audio card,  __asoc_simple_card_dai_init() calls
> snd_soc_dai_set_sysclk(). So where is it getting the clock values used
> in __asoc_simple_card_dai_init()?
>
> Here is my DTS for my cpu-dai...
>
> iis0: iis@01c22400 {
>   #clock-cells = <0>;
>   #sound-dai-cells = <0>;
>   compatible = "allwinner,sun7i-a20-iis";
>   reg = <0x01C22400 0x40>;
>   interrupts = <0 16 4>;
>   clocks = <&apb0_gates 3>, <&i2s0_clk>;
>   clock-names = "apb", "iis";
>   clock-output-names = "mclk0";
>   dmas = <&dma 0 3>, <&dma 0 3>;
>   dma-names = "rx", "tx";
>   status = "disabled";
> };
>
> This unit has three clocks.
> apb - bus input 80Mhz to run the unit
> iis - a programable input from a system PLL
> mclk0 - a clock that is output to the MCLK pin
>
> This is my codec
>
> sgtl5000: sgtl5000@a {
>    compatible = "fsl,sgtl5000";
>    reg = <0x0a>;
>    clocks = <&iis0>;
>
>    #sound-dai-cells = <0>;
>    VDDA-supply = <&reg_vcc3v3>;
>    VDDIO-supply = <&reg_vcc3v3>;
> };
>
> It has single input clock
> clocks (unnamed) - it is wired to the MCLK pin
>
> My simple audio card section...
>
> sound {
>   compatible = "simple-audio-card";
>   simple-audio-card,format = "i2s";
>   simple-audio-card,mclk-fs = <256>;
>
>   simple-audio-card,cpu {
>     sound-dai = <&iis0>;
>   };
>
>   simple-audio-card,codec {
>     sound-dai = <&sgtl5000>;
>    };
> };
>
> Now look at what simple_card_dai_link_of() does. It parse this section
> and then calls asoc_simple_card_sub_parse_of() for each of the two
> DAI's.
>
> Now look look at what asoc_simple_card_sub_parse_of() does when it
> parses each of those subnodes.  It looks up the first input clock off
> from both of those nodes and saves it as dai->sysclk. Then in
> __asoc_simple_card_dai_init() it pokes those values back into my
> driver via snd_soc_dai_set_sysclk().
>
> So on the first node.
>  simple-audio-card,cpu {
>     sound-dai = <&iis0>;
>   };
> It goes over to the iis driver and gets rate from the first input
> clock for iis0 - apb (80Mhz) and sets this back into my driver via
> snd_soc_dai_set_sysclk().
>
> On the second node
>   simple-audio-card,codec {
>     sound-dai = <&sgtl5000>;
>    };
> Then it does a getrate() on the first input clock for sgtl5000. But
> that clock has not been initialized yet. And then it sets the value
> back in via snd_soc_dai_set_sysclk().
>
> ------
>
> The problem is that asoc_simple_card_sub_parse_of() is doing getrate()
> on input clocks when it should be doing it on output clocks.
>
> So in my case, iis has a single output clock 'mclk0'. simple can
> getrate() on it and then set the rate back in via
> snd_soc_dai_set_sysclk(). Codec has no output clocks so it does
> nothing with sysclk.
>
>
>
>
>
>>
>>> But then simple goes and tries to set both system clocks - my 80Mhz
>>> bus clock and the 22.5 true sysclk. And my cpu-dai barfs when it is
>>> passed a 80Mhz sysclk.
>>
>> Naturally...  this does suggest you're doing something wrong but like I
>> say I really don't understand what's going on.  What does your system
>> look like, what are you trying to get it to do and how are you going
>> about that?
>
>
>
> --
> Jon Smirl
> jonsmirl@gmail.com



-- 
Jon Smirl
jonsmirl@gmail.com
