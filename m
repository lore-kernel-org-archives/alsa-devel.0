From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/8] ASoC: fsi: modify format area
	definition on flags
Date: Mon, 12 Jul 2010 09:54:19 +0100
Message-ID: <20100712085419.GB21840@rakim.wolfsonmicro.main>
References: <w3pr5j9dz2s.wl%kuninori.morimoto.gx@renesas.com>
	<w3ppqytdz12.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CF74424679
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jul 2010 10:54:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3ppqytdz12.wl%kuninori.morimoto.gx@renesas.com>
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

On Mon, Jul 12, 2010 at 02:55:53PM +0900, Kuninori Morimoto wrote:
> +#define SH_FSI_FMT_MONO_DELAY	(2 << 0)
> +#define SH_FSI_FMT_PCM		(3 << 0)
> +#define SH_FSI_FMT_I2S		(4 << 0)
> +#define SH_FSI_FMT_TDM		(5 << 0)
> +#define SH_FSI_FMT_TDM_DELAY	(6 << 0)

Wouldn't it be clearer to just define these as straight numbers?
