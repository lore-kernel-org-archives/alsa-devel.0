From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/4] ASoC: add graph base connection on
	simple-card
Date: Mon, 18 Apr 2016 12:12:48 -0500
Message-ID: <20160418171248.GA18460@rob-hp-laptop>
References: <871t68wxxe.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F811264FF9
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 19:12:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <871t68wxxe.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 14, 2016 at 05:45:41AM +0000, Kuninori Morimoto wrote:
> Hi Mark
> 
> Current simple-card is using "sound-dai" base connection on DT,
> but V4L2 is using graph base connection.
> For example HDMI case, we would like to use both connection.
> To above confusable connection method, and to reuse current resource,
> this patch adds new function, and detect both "sound-dai" and "remote-endpoint"
> on simple-card. like this
> 
> 	sound {
> 		compatible = "simple-audio-card";
> 		...
> 		sndcpu: simple-audio-card,cpu {
> 			sound-dai = <&xxx>;
> 		};
> 		sndcodec: simple-audio-card,codec {
> =>			remote-endpoint = <&out_hdmi>;

This is not valid usage of the graph binding. You are only using half of 
it.

> 		};
> 	};
> 
> 	xxx {
> 		...
> 		ports {
> 			...
> 			port@0 {
> 				reg = <0>;
> 				out_rgb: endpoint {
> 				};
> 			};
> 			port@1 {
> 				reg = <1>;
> =>				out_hdmi: endpoint {
> 				};
> 			};
> 			...
> 		};
> 	};
> 
> Kuninori Morimoto (4):
>       of_graph: add of_graph_get_endpoint_count()
>       ASoC: add of_parse_snd_connection_with_args() for sound-dai/graph connection
>       ASoC: snd_soc_of_get_dai_name() uses of_parse_snd_soc_connection_with_args()
>       ASoC: simple-card: probe both sound-dai and remote-endpoint
> 
>  Documentation/devicetree/bindings/sound/simple-card.txt | 19 +++++++++++++++++++
>  include/linux/of_graph.h                                | 11 +++++++++++
>  include/sound/soc.h                                     |  2 ++
>  sound/soc/generic/simple-card.c                         |  9 ++++++---
>  sound/soc/soc-core.c                                    | 45 +++++++++++++++++++++++++++++++++++++++++++--
>  5 files changed, 81 insertions(+), 5 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
