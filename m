From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH v2 6/6] ARM: DaVinci: ASoC:
	Introduce	platform driver model for dm644x, dm355
Date: Thu, 16 Apr 2009 13:55:26 +0100
Message-ID: <20090416125526.GQ16318@sirena.org.uk>
References: <1239921933-27045-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 793EF24378
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 14:55:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239921933-27045-1-git-send-email-naresh@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Naresh Medisetty <naresh@ti.com>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 16, 2009 at 06:45:33PM -0400, Naresh Medisetty wrote:

> +static struct platform_driver davinci_asoc_driver = {
> +	.probe		= davinci_i2s_probe,
> +	.remove		= davinci_i2s_remove,
> +	.driver		= {
> +		.name	= "davinci-asoc",
> +		.owner	= THIS_MODULE,
> +	},

I suspect that this isn't the best name for the driver - it should
probably be something like davinci-mcasp or possibly davinci-mcasp-audio
or similar.  This isn't the only possible audio device on the DaVinci
(there's an I2S device already) and more may be added in the future.

Other than that this looks OK.
