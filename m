From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core: Support transparent
	CODEC<->CODEC DAI links
Date: Mon, 16 Apr 2012 15:59:38 +0100
Message-ID: <1334588378.2255.1.camel@odin>
References: <1334342704-21495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BFE91041A4
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 16:59:44 +0200 (CEST)
Received: by wibhr17 with SMTP id hr17so4736570wib.10
	for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2012 07:59:40 -0700 (PDT)
In-Reply-To: <1334342704-21495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-04-13 at 19:45 +0100, Mark Brown wrote:

> +
> +	/* We only support a single source and sink, pick the first */
> +	source_p = list_first_entry(&w->sources, struct snd_soc_dapm_path,
> +				    list_sink);
> +	sink_p = list_first_entry(&w->sinks, struct snd_soc_dapm_path,
> +				  list_source);
> +

I assume the intention here is to have a graph like

some widget --> DAI widget -> DAI link widget -> DAI widget --> some
widget ?

Acked-by: Liam Girdwood <lrg@ti.com>
