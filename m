From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] S3C64XX I2S: Added machine driver for
	WM8580
Date: Thu, 17 Sep 2009 12:02:42 +0100
Message-ID: <20090917110241.GC30736@rakim.wolfsonmicro.main>
References: <1253163253-10372-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E50C224674
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Sep 2009 13:02:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1253163253-10372-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi <jassi.brar@samsung.com>, ben@trinity.fluff.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 17, 2009 at 01:54:13PM +0900, jassi brar wrote:

> +	/* Exceptions for this CPU-CODEC combination */
> +	case 64000:
> +		rfs = 384;
> +		break;

This needs to explain what the exceptions are for as well, otherwise
anyone working with the code is going to have to work it out from
scratch.

> +/* SMDK64xx Playback widgets */
> +static const struct snd_soc_dapm_widget wm8580_dapm_widgets_pbk[] = {
> +	SND_SOC_DAPM_HP("Front-L/R", NULL),
> +	SND_SOC_DAPM_HP("Center/Sub", NULL),
> +	SND_SOC_DAPM_HP("Rear-L/R", NULL),
> +};

All my previous comments about these and the way they're being
configured still apply.
