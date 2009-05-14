From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V1 11/13] AC97 driver for mpc5200
Date: Thu, 14 May 2009 12:39:12 +0100
Message-ID: <20090514113912.GI28291@sirena.org.uk>
References: <20090514015729.28145.30483.stgit@terra>
	<20090514015922.28145.58560.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BB2524156
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 13:39:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090514015922.28145.58560.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: grant.likely@secretlab.ca, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 13, 2009 at 09:59:22PM -0400, Jon Smirl wrote:

Looks mostly good but there's a few things that it'd be nice to address:

> +MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
> +MODULE_DESCRIPTION("mpc5200 AC97 module");
> +MODULE_LICENSE("GPL");

Normally this comes at the bottom of the file.

> +#define DRV_NAME "mpc5200-psc-ac97"
> +
> +static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
> +{
> +	struct psc_dma *psc_dma = ac97->private_data;
> +	int timeout;
> +	unsigned int val;
> +
> +	spin_lock(&psc_dma->lock);

Does this need to protect against interrupts?

> +static void psc_ac97_warm_reset(struct snd_ac97 *ac97)
> +{
> +	pr_info("psc_ac97_warm_reset\n");
> +}

Remove this - it's only going to confuse things to provide it if you
can't implement it, anything that actually needs the warm reset is going
to get upset anyway.

> +#ifdef CONFIG_PM
> +static int psc_ac97_suspend(struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}
> +
> +static int psc_ac97_resume(struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}

All the suspend and resume stuff can be removed if there's no
implementation.

> +static int psc_ac97_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int format)
> +{
> +	struct psc_dma *psc_dma = cpu_dai->private_data;
> +	dev_dbg(psc_dma->dev, "psc_ac97_set_fmt(cpu_dai=%p, format=%i)\n",
> +				cpu_dai, format);
> +
> +	return (format == SND_SOC_DAIFMT_AC97) ? 0 : -EINVAL;
> +}

Remove this, there's no need to provide a set_fmt operation for AC97
DAIs.
