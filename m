From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 5/5] ASoC: simple-card: add Device Tree
	support
Date: Fri, 04 Jan 2013 10:49:12 -0700
Message-ID: <50E71618.8090302@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <87sj6t484z.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E7F02625FB
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2013 18:49:18 +0100 (CET)
In-Reply-To: <87sj6t484z.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/25/2012 11:53 PM, Kuninori Morimoto wrote:
> Support for loading the simple-card module via devicetree.
> It requests platform/codec driver's DT blob for probing.

This binding proposal should be sent to
devicetree-discuss@lists.ozlabs.org; that's where all DT bindings are
dicussed.

> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt

> +Required properties:
> +for simple-card
> +- compatible			: "asoc,simple-card"

I don't think "asoc," is a good vendor prefix; DT should strive to
describe the hardware, not a particular OS's driver structure.

Perhaps "simple-audio" would be better.

> +- simple,asoc,name		: simple card name

What is "simple,asoc,"? I've never seen properties with two vendor
prefixes before... Perhaps "simple-audio," would be better.

What kind of name? Perhaps "simple-audio,model" would be better, and
more consistent with the use of the word "model" in other audio-related
DT bindings? Describe it as "user-visible card name"?

> +- simple,asoc,cpu		: phandle for platform

"cpu" isn't a very good name; it couuld mean anything. "platform" is an
ASoC-specific term. I think this would be better written as:

simple-audio,cpu-audio-controller : phandle of the CPU's audio controller

or perhaps:

simple-audio,cpu-port : phandle of the CPU's audio port

or since I assume this binding assumes I2S rather than say AC'97 or
SlimBus, perhaps:

simple-audio,i2c-controller : phandle of the CPU's I2S controller

> +- simple,asoc,codec		: phandle for codec

CODEC should be capitalized in the plain-text description (but not DT
property name). Same for DAI below.

> +for platform
> +- simple,asoc,dai		: dai name
> +
> +for codec
> +- simple,asoc,dai		: dai name
> +- simple,asoc,name		: codec name

Why are names needed? The existing audio-related DT bindings don't put
any names into the device tree; everything binds with phandles.

> +both platform/codec
> +- simple,asoc,daifmt,fmt		: see snd_soc_of_parse_daifmt()
> +- simple,asoc,daifmt,clock		: see snd_soc_of_parse_daifmt()
> +- simple,asoc,daifmt,bitclock_inversion	: see snd_soc_of_parse_daifmt()
> +- simple,asoc,daifmt,bitclock_master	: see snd_soc_of_parse_daifmt()
> +- simple,asoc,daifmt,frame_inversion	: see snd_soc_of_parse_daifmt()
> +- simple,asoc,daifmt,frame_master	: see snd_soc_of_parse_daifmt()

DT bindings should be self-contained, i.e. they should describe
everything required to write the device tree (with the possible
exception of referring to other existing manuals or documentation for
the HW). In particular, they shouldn't refer to code in some specific
OS. As such, please explain what all those mean here.

It is more typical to use - not _ as a word separator in DT property names.

"bitclock_master" doesn't really describe who is the master. Perhaps
"cpu-bitclk-master"?

What is "clock"?

> +- simple,asoc,sysclk			: system clock rate

"clock-frequency" rather than "sysclk" would be more consistent with
other bindings.

> +Example:
> +
> +fsi_ak4642 {
> +	compatible = "asoc,simple-card";
> +
> +	simple,asoc,name = "FSI2A-AK4648";
> +	simple,asoc,cpu = <&sh_fsi2>;
> +	simple,asoc,codec = <&ak4648>;
> +};
> +
> +&i2c0 {
> +	ak4648: ak4648@0x12 {
> +		compatible = "asahi-kasei,ak4648";
> +		reg = <0x12>;
> +
> +		simple,asoc,dai = "ak4642-hifi";
> +		simple,asoc,name = "ak4642-codec.0-0012";
> +		simple,asoc,daifmt,fmt = "left_j";
> +		simple,asoc,daifmt,bitclock_master;
> +		simple,asoc,daifmt,frame_master;
> +		simple,asoc,sysclk = <11289600>;
> +	};
> +};
> +
> +&sh_fsi2 {
> +	simple,asoc,dai = "fsia-dai";
> +	simple,asoc,daifmt,fmt = "left_j";
> +};

Oh, I see. Nothing in the text above implies that the DAI format
properties would exist in the CODEC and I2S controller nodes. That's
rather an imposition on the DT bindings for the CODEC and I2S
controller; the individual bindings for those devices should define all
the properties that go into those nodes, and those devices won't always
be used with a "simple" sound card. It feels to me like the DAI
configuration properties should be part of the sound node, not the
I2S/CODEC nodes.
