From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: da7210: Add HeadPhone Playback
	Volume control
Date: Tue, 20 Jul 2010 09:37:55 +0100
Message-ID: <20100720083754.GB10222@rakim.wolfsonmicro.main>
References: <w3plj96evqs.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E41232455F
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 10:37:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3plj96evqs.wl%kuninori.morimoto.gx@renesas.com>
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

On Tue, Jul 20, 2010 at 11:24:17AM +0900, Kuninori Morimoto wrote:

> +	/*
> +	 * HeadPhone PlayBack Volume 40 is given here
> +	 * because DA7210 doesn't have default volume.
> +	 */
> +	snd_soc_update_bits(codec, DA7210_HP_L_VOL, 0x3F, 40);
> +	snd_soc_update_bits(codec, DA7210_HP_R_VOL, 0x3F, 40);
> +

I find this very surprising - the chip actually comes up with an
indeterminate value at start?  In any case, if this is required I'd
suggest picking mute as the default value since then there's no chance
that the signal will be excessively loud by default on some systems.
