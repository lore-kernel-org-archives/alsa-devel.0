From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add max98095 CODEC driver
Date: Thu, 24 Mar 2011 11:42:11 +0000
Message-ID: <20110324114211.GA26636@opensource.wolfsonmicro.com>
References: <B2150E1E4418E1438554A300EA5040E40DAC511079@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 485411039E9
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2011 12:42:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <B2150E1E4418E1438554A300EA5040E40DAC511079@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 23, 2011 at 08:57:41PM -0700, Peter Hsiang wrote:
> +static inline int rate_value(int rate, u8 *value)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(rate_table); i++) {
> +		if (rate_table[i].rate >= rate) {
> +			*value = rate_table[i].sr;
> +			return 0;
> +		}
> +	}
> +	*value = rate_table[0].sr;
> +	return -EINVAL;
> +}

Not too clear as to why this is an inline function?

> +static int max98095_probe(struct snd_soc_codec *codec)
> +{
> +	struct max98095_priv *max98095 = snd_soc_codec_get_drvdata(codec);
> +	struct max98095_cdata *cdata;
> +	int ret = 0;
> +
> +	codec->cache_sync = 1;
> +	memcpy(codec->reg_cache, max98095_reg, sizeof(max98095_reg));

Keeping your own copy of the cache is rather deprecated.  As Mark
mentioned, you can let the ASoC cache manage your register cache as well
as use snd_soc_cache_sync() for syncing.

Thanks,
Dimitris
