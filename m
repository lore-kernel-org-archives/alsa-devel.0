From: "Girdwood, Liam" <lrg@ti.com>
Subject: Re: [PATCH] sound/soc/kirkwood/kirkwood-i2s.c: fix
	trivial build regression
Date: Mon, 12 Sep 2011 05:56:42 +0100
Message-ID: <CABS+qY00Bsr1DJaLMyqcS1XAzFjj0kbdsZgxUuBnAQj33ALNkg@mail.gmail.com>
References: <1313820761-12042-1-git-send-email-julia@diku.dk>
	<3099701.CcMbBAJgz4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog110.obsmtp.com (na3sys009aog110.obsmtp.com
	[74.125.149.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 901F92413B
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 06:56:44 +0200 (CEST)
Received: by qyl16 with SMTP id 16so785148qyl.1
	for <alsa-devel@alsa-project.org>; Sun, 11 Sep 2011 21:56:42 -0700 (PDT)
In-Reply-To: <3099701.CcMbBAJgz4@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@suse.de>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <julia@diku.dk>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

On 11 September 2011 19:07, Arnd Bergmann <arnd@arndb.de> wrote:

> A fix merged in 3.1-rc2 introduced a small regression, this should get it
> to build again.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> On Saturday 20 August 2011 08:12:38 Julia Lawall wrote:
> > From: Julia Lawall <julia@diku.dk>
> >
> > Adjust the goto to jump to the error handling code that includes kfree.
> >
>
> /home/arnd/linux-arm/sound/soc/kirkwood/kirkwood-i2s.c: In function
> 'kirkwood_i2s_dev_probe':
> /home/arnd/linux-arm/sound/soc/kirkwood/kirkwood-i2s.c:427:3: error: label
> 'error_alloc' used but not defined
>
> diff --git a/sound/soc/kirkwood/kirkwood-i2s.c
> b/sound/soc/kirkwood/kirkwood-i2s.c
> index 8f16cd3..d0bcf3f 100644
> --- a/sound/soc/kirkwood/kirkwood-i2s.c
> +++ b/sound/soc/kirkwood/kirkwood-i2s.c
> @@ -424,7 +424,7 @@ static __devinit int kirkwood_i2s_dev_probe(struct
> platform_device *pdev)
>        if (!priv->mem) {
>                dev_err(&pdev->dev, "request_mem_region failed\n");
>                err = -EBUSY;
> -               goto error_alloc;
> +               goto err_alloc;
>        }
>
>        priv->io = ioremap(priv->mem->start, SZ_16K);
>

Acked-by: Liam Girdwood <lrg@ti.com>
