From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: clean up spi cache read/write
	functions
Date: Mon, 20 Dec 2010 17:29:20 +0000
Message-ID: <20101220172919.GB2531@rakim.wolfsonmicro.main>
References: <s5hei9czeep.wl%tiwai@suse.de>
	<20101220152709.GJ26706@rakim.wolfsonmicro.main>
	<s5h4oa8zbe4.wl%tiwai@suse.de> <s5h1v5czb5m.wl%tiwai@suse.de>
	<s5hzks0xwjy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DFDB6244C9
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 18:29:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hzks0xwjy.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 20, 2010 at 05:01:53PM +0100, Takashi Iwai wrote:

> +#ifdef CONFIG_SPI_MASTER
> +static int do_spi_write(struct spi_device *spi, u8 *msg, int len)
> +{

This looks a lot like the standard spi_write() function now.  Which we
probably should've been using anyway but hey ho...
