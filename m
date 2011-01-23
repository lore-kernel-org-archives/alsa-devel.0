From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: EDB93xx machine sound driver with
	CS4271
Date: Sun, 23 Jan 2011 00:05:53 +0000
Message-ID: <20110123000553.GA22878@opensource.wolfsonmicro.com>
References: <1295649882.1561.32.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C00AE1037FB
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 01:05:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1295649882.1561.32.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Sverdlin <subaparts@yandex.ru>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 22, 2011 at 01:44:42AM +0300, Alexander Sverdlin wrote:

>  arch/arm/mach-ep93xx/edb93xx.c |   54 +++++++++++++++

This should be split into a separate patch and CCed to the relevant
maintainers for review.

> +static struct spi_board_info edb93xx_spi_board_info[] = {
> +	{
> +		.modalias	= "cs4271-codec",

Gah, missed this.  We ought to renamen the CODEC driver to drop the
-codec suffix from the name registered for SPI.
