From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add TXx9 AC link controller driver
Date: Thu, 14 May 2009 19:59:46 +0100
Message-ID: <20090514185945.GO28291@sirena.org.uk>
References: <1242312605-2160-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B188103947
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 20:59:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1242312605-2160-1-git-send-email-anemo@mba.ocn.ne.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, ralf@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 14, 2009 at 11:50:04PM +0900, Atsushi Nemoto wrote:

This all looks basically fine - just a few comments below, the main one
being the way you're registering things.

> +#ifdef CONFIG_PM
> +static int txx9aclc_ac97_suspend(struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}
> +
> +static int txx9aclc_ac97_resume(struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}
> +#else
> +#define txx9aclc_ac97_suspend	NULL
> +#define txx9aclc_ac97_resume	NULL
> +#endif

Just remove all this if there's no implementation.

> +static int __init txx9aclc_ac97_init(void)
> +{
> +	return snd_soc_register_dai(&txx9aclc_ac97_dai);
> +}
> +
> +static void __exit txx9aclc_ac97_exit(void)
> +{
> +	snd_soc_unregister_dai(&txx9aclc_ac97_dai);
> +}

Ideally you'd be registering a platform device in your arch code and
then the DAI would only be registered when the device is probed.  This
(and similar stuff for the DMA) would mean that...

> +static int __init txx9aclc_generic_probe(struct platform_device *pdev)
> +{
> +	struct txx9aclc_soc_device *dev = &txx9aclc_generic_soc_device;
> +	struct platform_device *soc_pdev;
> +	struct resource *r;
> +	int ret;
> +	int i;
> +	int irq;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +	dev->irq = irq;

...all this resource stuff wouldn't need to be done by the machine
driver, it'd be done by your DAI and DMA drivers.  That means less
duplication of code for multiple machines both in the machine driver and
in registering the resources along with the platform device.

> +static int __init txx9aclc_soc_platform_init(void)
> +{
> +	return snd_soc_register_platform(&txx9aclc_soc_platform);
> +}
> +
> +static void __exit txx9aclc_soc_platform_exit(void)
> +{
> +	snd_soc_unregister_platform(&txx9aclc_soc_platform);
> +}

Same comment applies here.
