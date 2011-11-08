From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/5] ASoC: ak4642: add ak4648 support
Date: Tue, 8 Nov 2011 11:01:36 +0000
Message-ID: <20111108110135.GE25591@opensource.wolfsonmicro.com>
References: <87y5vsqxiz.wl%kuninori.morimoto.gx@renesas.com>
	<87sjm0qxgo.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4341D24378
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 12:01:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87sjm0qxgo.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Nov 06, 2011 at 10:05:15PM -0800, Kuninori Morimoto wrote:

> +#define AK4642_CACHEREGNUM	(0x24 + 1)
> +#define AK4648_CACHEREGNUM	(0x27 + 1)

> +	/*
> +	 * fixup register cache
> +	 * each ak464x have a slightly different value
> +	 */
> +	for (i = 0; i < chip->reg_fix_size; i++)
> +		ak4642_write_reg_cache(codec,
> +				       chip->reg_fix[i].reg,
> +				       chip->reg_fix[i].val);

This won't work properly when resyncing the cache as the driver will
think that these are non-default values.  Given how small the register
maps are just have different default tables, it's not worth the effort
of doing anything more complex.
