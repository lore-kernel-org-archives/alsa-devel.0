From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: AUDIO: Split WM8750 IO routines from core for SPI
Date: Mon, 23 Jun 2008 15:42:17 +0100
Message-ID: <20080623144217.GD9318@sirena.org.uk>
References: <20080623115406.920274505@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 39C6B248CC
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 16:42:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080623115406.920274505@fluff.org.uk>
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
Cc: alsa-devel@alsa-project.org, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 23, 2008 at 12:54:07PM +0100, Ben Dooks wrote:
> Add SPI support to the WM8750 ASoC codec by splitting
> the I2C out of the WM8750 codec and adding an standard
> SPI driver to the system.

This looks good.  My only substantial concern with it is that it means
that this driver isn't consistent with the other codec drivers since
there are now three modules built for it - one for the core and one for
each bus type.  Would it be possible to integrate the SPI support into
the main WM8750 driver or are there substantial drawbacks from doing
that?  The main thing is ending up loading SPI when it's not needed but
I'm not sure how big a cost that is or if there's anything else?

Also (very minor, but it'll get picked up on):

> -static int wm8750_suspend(struct platform_device *pdev, pm_message_t state)
> +int wm8750_suspend(struct platform_device *pdev, pm_message_t state)
>  {
>  	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
>  	struct snd_soc_codec *codec = socdev->codec;
> @@ -760,7 +759,9 @@ static int wm8750_suspend(struct platfor
>  	return 0;
>  }
>  
> -static int wm8750_resume(struct platform_device *pdev)
> +EXPORT_SYMBOL_GPL(wm8750_suspend);

checkpatch will want there to be no space between the function and the
EXPORT_SYMBOL_GPL() for it.
