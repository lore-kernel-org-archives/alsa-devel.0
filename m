From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: mc13783: add mixer controls
Date: Wed, 09 Oct 2013 17:21:40 +0200
Message-ID: <52557484.1070808@metafoo.de>
References: <1381330904-26389-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id BB5A0261603
 for <alsa-devel@alsa-project.org>; Wed,  9 Oct 2013 17:19:43 +0200 (CEST)
In-Reply-To: <1381330904-26389-1-git-send-email-s.trumtrar@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/09/2013 05:01 PM, Steffen Trumtrar wrote:
> [...]
> +
> +static const struct soc_enum mc13783_enum_asp =
> +	SOC_ENUM_SINGLE(MC13783_AUDIO_RX0, 4, ARRAY_SIZE(mc13783_alsp),
> +			mc13783_alsp);
> +
> +static const struct soc_enum mc13783_enum_alsp =
> +	SOC_ENUM_SINGLE(MC13783_AUDIO_RX0, 7, ARRAY_SIZE(mc13783_alsp),
> +			mc13783_alsp);
> +
> +static const struct soc_enum mc13783_enum_ahs =
> +	SOC_ENUM_SINGLE(MC13783_AUDIO_RX0, 11, ARRAY_SIZE(mc13783_ahs),
> +			mc13783_ahs);
> +
> +static const struct soc_enum mc13783_enum_arxout =
> +	SOC_ENUM_SINGLE(MC13783_AUDIO_RX0, 17, ARRAY_SIZE(mc13783_ahs),
> +			mc13783_ahs);
> +
> +static const struct soc_enum mc13783_enum_codec =
> +	SOC_ENUM_SINGLE(MC13783_AUDIO_RX1, 4, ARRAY_SIZE(mc13783_alsp),
> +			mc13783_alsp);

For bonus points use SOC_ENUM_SINGLE_DECL(...) ;)

- Lars
