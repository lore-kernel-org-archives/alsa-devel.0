From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: cs4271.c: adapt to error handling
 introduced in snd_soc_update_bits()
Date: Fri, 21 Jan 2011 18:29:55 +0000
Message-ID: <20110121182955.GE22414@opensource.wolfsonmicro.com>
References: <1295634449.16460.117.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F2196103B3F
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 19:29:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295634449.16460.117.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 21, 2011 at 09:27:29PM +0300, Alexander wrote:

> -	return snd_soc_update_bits(codec, CS4271_DACCTL,
> -		CS4271_DACCTL_DEM_MASK, val);
> +	i = snd_soc_update_bits(codec, CS4271_DACCTL, CS4271_DACCTL_DEM_MASK, val);
> +	if (i < 0)
> +		return i;
> +	return 0;

It'd seem a bit more tasteful to declare a 'ret' variable rather than
reusing i as you do here and in another hunk.

>  static int cs4271_soc_resume(struct snd_soc_codec *codec)
>  {
> +	int ret;
>  	/* Restore codec state */
> -	snd_soc_cache_sync(codec);
> +	ret = snd_soc_cache_sync(codec);
> +	if (ret < 0)
> +		return ret;

This isn't connected to snd_soc_update_bits()....
