From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add TXx9 AC link controller
	driver	(v2)
Date: Mon, 18 May 2009 15:23:05 +0100
Message-ID: <20090518142305.GE1629@sirena.org.uk>
References: <1242655812-11155-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 19EBE103826
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 16:23:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1242655812-11155-1-git-send-email-anemo@mba.ocn.ne.jp>
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

On Mon, May 18, 2009 at 11:10:12PM +0900, Atsushi Nemoto wrote:

> +static int txx9aclc_ac97_probe(struct platform_device *pdev,
> +			       struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct txx9aclc_soc_device *dev =
> +		container_of(socdev, struct txx9aclc_soc_device, soc_dev);
> +	struct platform_device *aclc_pdev = dev->aclc_pdev;
> +	struct resource *r;
> +	int err;
> +	int irq;
> +
> +	dev->irq = -1;
> +	irq = platform_get_irq(aclc_pdev, 0);

This isn't what I meant by moving the resources to the DAI and DMA
drivers.  You have moved the calls to read the resources to these
drivers (which is good) but the resources are still being obtained from
the main ASoC device rather than by themselves from the device code.

There aren't too many platforms using this approach yet but take a look
at the way the pxa2xx-ac97 driver deals with registering the DAI (it
doesn't do anything with resources ATM) - you want to be registering
your DAI and grabbing the resources from a platform driver probe like it
does.
