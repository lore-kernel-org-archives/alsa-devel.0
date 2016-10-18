From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH 0/23] ASoC: add OF graph base simple-card
Date: Tue, 18 Oct 2016 09:10:30 +0200
Message-ID: <20161018091030.ed9eea657480f6a20bcfea81@free.fr>
References: <87shrv4c8x.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87shrv4c8x.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-Kernel <linux-kernel@vger.kernel.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Guennadi <g.liakhovetski@gmx.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Oct 2016 08:30:49 +0000
Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> wrote:

> These are OF graph base simple-card patch-set.
>  1) -  3) : simple-scu-card cleanup
>  4) - 10) : soc-core prepare for OF graph card
> 11) - 17) : OF graph new feature
> 18) - 23) : OF graph base simple-card
> 
> I posted 11) - 17) OF graph new feature patches before, and then Rob requested
> about usecase. 18) - 23) can be usecase for it.
>  1) - 10) are independent (= Mark)
> 11) - 17) are independent (= Rob)
> 18) - 23) are depends on 1) - 10) and 11) - 17) (= Mark)
>  
> Kuninori Morimoto (23):
>        1) ASoC: simple-scu-card: code sync: follow to simple family style
>        2) ASoC: simple-scu-card: code sync: rename asoc_simple_card_priv
>        3) ASoC: simple-scu-card: code sync: tidyup props/link naming
>        4) ASoC: soc-core: adjust for graph on snd_soc_of_parse_card_name
>        5) ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_simple_widgets
>        6) ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_routing
>        7) ASoC: soc-core: adjust for graph on snd_soc_of_parse_audio_prefix
>        8) ASoC: soc-core: snd_soc_get_dai_name() become non static
>        9) ASoC: simple-card-utils: remove unnecessary cpu/codec pointer check
>       10) ASoC: simple-card-utils: adjust for graph on asoc_simple_card_parse_card_name
>       11) Documentation: of: add type property
>       12) of_graph: add of_graph_get_remote_endpoint()
>       13) of_graph: add of_graph_port_type_is()
>       14) of_graph: add of_graph_get_port_parent()
>       15) of_graph: add of_graph_get_top_port()
>       16) of_graph: add for_each_of_port() / for_each_of_endpoint_in_port()
>       17) of_graph: add of_graph_get_endpoint_count()
>       18) ASoC: simple-card-utils: add asoc_simple_card_parse_graph_dai()
>       19) ASoC: simple-card-utils: add asoc_simple_card_try_to_probe_graph_card()
>       20) ASoC: add simple-graph-card document
>       21) ASoC: add simple-graph-card support
>       22) ASoC: add simple-graph-scu-card document
>       23) ASoC: add simple-graph-scu-card support
	[snip]

Hi Kuninori,

The patches 11..17 put trivial functions in the OF core. As they are
used by only a few systems, it would be better to define them as
macros, or in a module or in the simple-card-utils.

-- 
Ken ar c'hentañ	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
