From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/8] ASoC: fsi: modify wrong value setting
	order of TDM
Date: Mon, 12 Jul 2010 10:00:14 +0100
Message-ID: <20100712090014.GC21840@rakim.wolfsonmicro.main>
References: <w3pr5j9dz2s.wl%kuninori.morimoto.gx@renesas.com>
	<w3pk4p1dz0f.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B80402413B
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jul 2010 11:00:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3pk4p1dz0f.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 12, 2010 at 02:56:17PM +0900, Kuninori Morimoto wrote:
> channel size should be set before setting register value

So, this looks like a bug fix which should go into 2.6.35 but...

>  	case SH_FSI_FMT_TDM:
> -		data = CR_TDM | (fsi->chan - 1);
>  		fsi->chan = is_play ?
>  			SH_FSI_GET_CH_O(flags) : SH_FSI_GET_CH_I(flags);
> +		data = CR_TDM | (fsi->chan - 1);
>  		break;

...it depends on your earlier patch to change the CR_ macros which is
just a coding style tweak and so should wait for 2.6.36.

When preparing patches it's good to separate out things like cleanups
and new features from bug fixes - the bug fixes we want to get into the
next release if possible, but other things are supposed to wait for the
next kernel development cycle.
