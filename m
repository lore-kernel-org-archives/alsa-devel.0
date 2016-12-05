From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 11/14] ASoC: add simple-graph-card document
Date: Mon, 5 Dec 2016 16:58:02 -0600
Message-ID: <20161205225802.ye4tcjwpjmarbfxh@rob-hp-laptop>
References: <87k2bowckx.wl%kuninori.morimoto.gx@renesas.com>
 <874m2swcbx.wl%kuninori.morimoto.gx@renesas.com>
 <20161202135048.tzvrv7pzv2dubcy3@rob-hp-laptop>
 <87lgvvw92p.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87lgvvw92p.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Guennadi <g.liakhovetski@gmx.de>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Linux-DT <devicetree@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 04, 2016 at 11:48:49PM +0000, Kuninori Morimoto wrote:
> 
> Hi Rob, Mark
> 
> > > +++ b/Documentation/devicetree/bindings/sound/simple-graph-card.txt
> > > @@ -0,0 +1,67 @@
> > > +Simple-Graph-Card:
> > 
> > There's nothing simple about this. graph-audio-card or audio-card-graph.
> 
> I have no objection about naming, but this is one of simple-xxx-card series.
> And, this is very simple from ALSA SoC point of view...
> 
> > > +rcar_sound {
> > > +	...
> > > +	port {
> > > +		compatible = "asoc-simple-graph-card";
> > 
> > Do you have an example where you'd have multiple ports? If not, this 
> > should go up a level.
> 
> ALSA SoC needs 3 type of driver, CPU/Codec/Card. But HW is SoC <-> Codec.
> Thus, "CPU" side DT needs to call "Card" portion, and ALSA SoC needs to
> select Card type (graph-audio-card, graph-scu-card, etc, etc....).
> Above it for it.
> 
> 	SoC {
> 		compatible = "cpu_driver_compatible_name";
> 		...
> 		port {
> 			compatible = "card_driver_compatible_name";
> 			...
> 		};
> 	};
> 
> Here, SoC driver "cpu_driver_compatible_name" will handle CPU and its
> each port settings. And it will probes "card_driver_compatible_name".
> "card_driver_compatible_name" will connect CPU <-> Codec via ALSA SoC.

Don't design bindings around what ASoC wants and don't explain it in 
terms of how ALSA works. Design bindings in a way that reflects the h/w.

This explanation seems completely wrong to me. It seems like you are 
abusing OF graph to just create 2 instances of a simple-card which would 
be working around some ASoC limitation.

I'd expect the top level node to be the card node that knows how to find 
all the components. The graph should reflect the data flow. For example, 
the data goes to audio DSP to I2S host to codec to amp. 

Rob
