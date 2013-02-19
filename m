From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/4 v6] ASoC: fsi: enable .of_xlate_dai_name on struct
 snd_soc_dai_driver
Date: Tue, 19 Feb 2013 14:00:19 -0700
Message-ID: <5123E7E3.9080303@wwwdotorg.org>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <87vcazyxr1.wl%kuninori.morimoto.gx@renesas.com>
 <20130127035943.GJ4650@opensource.wolfsonmicro.com>
 <87vcag3hcj.wl%kuninori.morimoto.gx@renesas.com>
 <20130129014808.GC4748@opensource.wolfsonmicro.com>
 <87sj5k3f83.wl%kuninori.morimoto.gx@renesas.com>
 <87obg8z4u4.wl%kuninori.morimoto.gx@renesas.com>
 <5107FF97.1070601@wwwdotorg.org>
 <87halz82bm.wl%kuninori.morimoto.gx@renesas.com>
 <51097F0F.2030501@wwwdotorg.org>
 <87halw7sij.wl%kuninori.morimoto.gx@renesas.com>
 <5110349D.3050308@wwwdotorg.org>
 <87ehgvrs1h.wl%kuninori.morimoto.gx@renesas.com>
 <87bobzrry6.wl%kuninori.morimoto.gx@renesas.com>
 <511963F8.5020107@wwwdotorg.org>
 <87bobqf5yq.wl%kuninori.morimoto.gx@renesas.com>
 <511C22E2.60701@wwwdotorg.org>
 <87obfnofsx.wl%kuninori.morimoto.gx@renesas.com>
 <511C6A1B.9000507@wwwdotorg.org>
 <874nhfv5mb.wl%kuninori.morimoto.gx@renesas.com>
 <8738wzuu9g.wl%kuninori.morimoto.gx@renesas.com>
 <87y5ertfl7.wl%kuninori.morimoto.gx@renes as.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <87y5ertfl7.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 02/14/2013 02:22 AM, Kuninori Morimoto wrote:
> fsi driver can be used from simple-card driver
> which requires .of_xlate_dai_name.
> 
> This patch supports .of_xlate_dai_name.

> diff --git a/Documentation/devicetree/bindings/sound/renesas,fsi.txt b/Documentation/devicetree/bindings/sound/renesas,fsi.txt

The change to this file looks sane.

> diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c

> @@ -1861,6 +1861,7 @@ static struct snd_soc_dai_driver fsi_soc_dai[] = {
>  			.channels_max	= 2,
>  		},
>  		.ops = &fsi_dai_ops,
> +		.of_xlate_dai_name = snd_soc_common_of_xlate_dai_name,
>  	},

Hmm. I think that the .of_xlate_dai_name should be something related to
the object (e.g. CODEC) that contains the DAIs, rather than the DAIs
themselves. The intent is to ask some object (e.g. CODEC) which of its
DAIs is represented by the DT DAI specifier, not to ask each DAI whether
it is represented by that particular DT DAI specifier.

Aside from that, I'd expect the patch above to be something more like:

const char *fsi_xlate_dai_name(struct snd_soc_dai *dai,
				const struct of_phandle_args *args)
{
	switch (args[0]) {
	case 0:
		return fsi_soc_dai[0].name;
	case 1:
		return fsi_soc_dai[1].name;
	default:
		return NULL;
	}
}

@@ -1861,6 +1861,7 @@ static struct snd_soc_dai_driver fsi_soc_dai[] = {
 			.channels_max	= 2,
 		},
 		.ops = &fsi_dai_ops,
+		.of_xlate_dai_name = fsi_xlate_dai_name,
 	},

(although further modified according to my error handling comments before).
