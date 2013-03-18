From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 47/53] ASoC: switch over to use
 snd_soc_register_component() on tegra30 i2s
Date: Mon, 18 Mar 2013 09:39:14 -0600
Message-ID: <51473522.8000603@wwwdotorg.org>
References: <87txo96xiu.wl%kuninori.morimoto.gx@renesas.com>
 <87y5dl43n7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E43D265360
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2013 16:45:19 +0100 (CET)
In-Reply-To: <87y5dl43n7.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Simon <horms@verge.net.au>, Liam Girdwood <liam.r.girdwood@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/18/2013 12:34 AM, Kuninori Morimoto wrote:

> diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c

> +static const struct snd_soc_component_driver tegra30_i2s_component = {
> +	.name		= "tegra30-i2s",

For all the Tegra files, that should really be:

	.name		= DRV_NAME,

>From a brief grep, the same comment /might/ apply to omap/omap-hdmi.c
and fsl/mpc5200_psc_ac97.c.

But aside from that, these patches look fine.
