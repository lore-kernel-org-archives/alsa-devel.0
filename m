From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] How to post cleanup patches ?
Date: Wed, 3 Aug 2016 21:20:16 +0200
Message-ID: <c52dc535-1f9f-007c-34a9-d7adbec1f58d@metafoo.de>
References: <87k2fy8xy5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87k2fy8xy5.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 08/03/2016 03:12 AM, Kuninori Morimoto wrote:
> 
> Hi Mark
> 
> Now codec driver and component driver has duplicated callback function,
> and snd_soc_register_codec() just copied it to component side.
> 
> 	int snd_soc_register_codec(xxx) {
> 		...
>  
> 		if (codec_drv->controls) {
> 			codec->component.controls = codec_drv->controls;
> 			codec->component.num_controls = codec_drv->num_controls;
> 		}
> 		if (codec_drv->dapm_widgets) {
> 			codec->component.dapm_widgets = codec_drv->dapm_widgets;
> 			codec->component.num_dapm_widgets = codec_drv->num_dapm_widgets;
> 		}
> 		if (codec_drv->dapm_routes) {
> 			codec->component.dapm_routes = codec_drv->dapm_routes;
> 			codec->component.num_dapm_routes = codec_drv->num_dapm_routes;
> 		}
> 		...
> 	}
> 
> I think we can cleanup this duplicated function, similar things happen on
> .probe, .remove, and platform side too.
> 
> I would like to post cleanup patches for these.
> As 1st step, remove codec duplicate callback.
> 
> But my concern is that you hate big-patch-set, and it is almost 70 patches.
> Can I post these patches to ML ? or should I use git pull request ? or I shouldn't post ?

I left this step out on purpose during the componentization of
snd_soc_codec. Simply because it is a huge amount of code churn for very
little gain. If you want to do it, go ahead, but I don't think it is worth
the effort at this point.

I think of this as the final cleanup step once everything else is in place.
E.g. there are lots of CODEC drivers that don't actually need anything CODEC
specific, except that we need to know that it is a CODEC so we which
direction the capture and playback streams of the DAI go. If we can come up
with a generic to represent the DAI streams we could convert all these
drivers directly from snd_soc_codec_driver to snd_soc_component_driver.

I'd much rather see this conversion to be part of such an effort.
