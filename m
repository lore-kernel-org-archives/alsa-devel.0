From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 2/9] JIVE: Add ASoC audio support
Date: Wed, 4 Mar 2009 14:57:02 +0000
Message-ID: <20090304145700.GG433@sirena.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
	<20090304005138.373218569@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AA05C1037EF
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 15:57:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090304005138.373218569@fluff.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 12:49:27AM +0000, Ben Dooks wrote:

> +static int jive_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec *codec = rtd->socdev->codec;
> +
> +	snd_soc_dapm_enable_pin(codec, "Headphone Jack");
> +	snd_soc_dapm_enable_pin(codec, "Internal Speaker");
> +	snd_soc_dapm_enable_pin(codec, "Line In");
> +
> +	snd_soc_dapm_sync(codec);
> +
> +	return 0;
> +}

As previously mentioned this function should be removed: the default
state of pins is that they're enabled and you never disable these pins
so there will be no effect.

> +	/* These endpoints are not being used. */
> +	snd_soc_dapm_disable_pin(codec, "LINPUT2");
> +	snd_soc_dapm_disable_pin(codec, "RINPUT2");
> +	snd_soc_dapm_disable_pin(codec, "LINPUT3");
> +	snd_soc_dapm_disable_pin(codec, "RINPUT3");
> +	snd_soc_dapm_disable_pin(codec, "OUT3");
> +	snd_soc_dapm_disable_pin(codec, "MONO");

Should be snd_soc_dapm_nc_pin().

> +	printk("JIVE WM8750 Audio support\n");

Should have KERN_INFO or use pr_info().
