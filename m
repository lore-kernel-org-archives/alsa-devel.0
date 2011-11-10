From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: ak4642: add
	ak4642_set_bias_level()
Date: Thu, 10 Nov 2011 11:27:42 +0000
Message-ID: <20111110112741.GC29931@opensource.wolfsonmicro.com>
References: <87y5vsqxiz.wl%kuninori.morimoto.gx@renesas.com>
	<87bosk4cdw.wl%kuninori.morimoto.gx@renesas.com>
	<87aa844ccp.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 474C8103AB8
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 12:27:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87aa844ccp.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 10, 2011 at 12:21:13AM -0800, Kuninori Morimoto wrote:

> +	switch (level) {
> +	case SND_SOC_BIAS_OFF:
> +		snd_soc_write(codec, PW_MGMT1, 0x00);
> +		break;
> +	default:
> +		snd_soc_update_bits(codec, PW_MGMT1, PMVCM, PMVCM);
> +	}

Should have a break; here for coding style.
