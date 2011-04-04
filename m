From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Fix to avoid compile error
Date: Mon, 4 Apr 2011 05:55:56 +0100
Message-ID: <20110404045556.GA12690@opensource.wolfsonmicro.com>
References: <1301890504-14423-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 37C302436F
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 06:55:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1301890504-14423-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: alsa-devel@alsa-project.org, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 04, 2011 at 01:15:04PM +0900, Seungwhan Youn wrote:

>  	case SND_SOC_I2C:
> +#if defined(CONFIG_I2C) || (defined(CONFIG_I2C_MODULE) && defined(MODULE))
>  		ret = i2c_master_send(codec->control_data, data, len);
> +#endif
>  		break;
>  	case SND_SOC_SPI:
> +#if defined(CONFIG_SPI_MASTER)
>  		ret = do_spi_write(codec->control_data, data, len);
> +#endif
>  		break;

If we're going to ifdef these out we should be ifdefing out the entire
case, not just the operations.  Otherwise if we do manage to end up with
a broken configuration then the code will silently report success which
is broken - the fact that you have to initialise ret is a bad sign.
