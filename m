From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: ak4642: Add Digital Playback
	Volume control
Date: Wed, 30 Jun 2010 13:59:55 +0100
Message-ID: <20100630125955.GC3634@rakim.wolfsonmicro.main>
References: <w3p1vbq8fod.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5264B2415F
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jun 2010 14:59:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3p1vbq8fod.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 29, 2010 at 04:24:19PM +0900, Kuninori Morimoto wrote:

> +	/* default volume */
> +	ak4642_write(codec, L_DVC, 0x28);
> +	ak4642_write(codec, R_DVC, 0x28);
> +

Unless there is a particular reason to do so we should trust the chip
default volume.  A volume which is sensible in one appolication may not
be appropriate in another (eg, using a different output path or with an
external amplifier).
