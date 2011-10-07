From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/11 RESEND] ASoC: wm8510: Convert to
	snd_soc_write
Date: Fri, 7 Oct 2011 10:57:21 +0100
Message-ID: <20111007095720.GA19080@opensource.wolfsonmicro.com>
References: <1317944619.5579.1.camel@phoenix> <1317944707.5579.3.camel@phoenix>
	<1317955220.7624.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B735103815
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 11:57:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317955220.7624.2.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 07, 2011 at 10:40:20AM +0800, Axel Lin wrote:

> +static void wm8510_sync_cache(struct snd_soc_codec *codec)
> +{
> +	short i;
> +	u16 *cache;
> +
> +	if (!codec->cache_sync)
> +		return;
> +	codec->cache_only = 0;
> +	codec->cache_bypass = 1;
> +	/* restore cache */
> +	cache = codec->reg_cache;
> +	for (i = 0; i < codec->driver->reg_cache_size; i++) {
> +		if (i == WM8510_RESET || cache[i] == wm8510_reg[i])
> +			continue;
> +		snd_soc_write(codec, i, cache[i]);
> +	}
> +	codec->cache_bypass = 0;
> +	codec->cache_sync = 0;

The usual trick for avoiding this is to provide a register default value
for the reset register and then write that value when the chip is reset.
This then means that the write to the reset register is suppressed by
the cache restore code when it skips writes of default registers.

Thanks for doing this work.
