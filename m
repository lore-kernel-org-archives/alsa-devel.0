From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC][PATCH 2/2 v3] ASoC: simple-card: add Device
	Tree support
Date: Wed, 30 Jan 2013 13:14:07 -0700
Message-ID: <51097F0F.2030501@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <87sj6t484z.wl%kuninori.morimoto.gx@renesas.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C8EB2650FD
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 21:14:12 +0100 (CET)
In-Reply-To: <87halz82bm.wl%kuninori.morimoto.gx@renesas.com>
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

On 01/30/2013 02:09 AM, Kuninori Morimoto wrote:
> Support for loading the simple-card module via devicetree.
> It requests cpu/codec information for probing.

> diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt

> +Simple-Card:
> +
> +Required properties:
> +
> +- compatible			: "simple-audio"
> +- simple-audio,card-name	: simple-audio card name
> +- simple-audio,format		: see below
> +
> +Optional properties:
> +
> +- simple-audio,bitclock-inversion
> +- simple-audio,frame-inversion
> +
> +CPU / CODEC DAI is represented as a sub-node.
> +Then, sub-node name should be "simple-audio,cpu" or "simple-audio,codec".

Why require sub-nodes? it seem over-complex.

> +Required subnode properties:
> +- simple-audio,dev		: phandle for CPU/CODEC
> +
> +Optional subnode properties:
> +
> +- simple-audio,dai-name			: simple-audio CPU/CODEC DAI name

OK, I see those two are CPU-/CODEC-specific. However, you could easily
just have different property names for the two.

I assume you didn't like my idea of not putting the DAI names into the
DT, but using extra arguments after the phandles instead? Doing so would
be more alike most existing DT bindings.

> +- simple-audio,system-clock-frequency	: system clock rate
> +- simple-audio,frame-master
> +- simple-audio,bitclock-master

Aren't those a property of the CPU<->CODEC link, hence the clock
frequency is identical, and the two "master" properties are the inverse
of each-other in between CPU and CODEC. Specifying these right in the
top-level node seems simpler.
