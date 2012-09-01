From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: Davinci: McASP: add support new
 McASP IP Variant
Date: Fri, 31 Aug 2012 17:44:44 -0700
Message-ID: <20120901004443.GB21451@opensource.wolfsonmicro.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-2-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 43160265E1E
 for <alsa-devel@alsa-project.org>; Sat,  1 Sep 2012 02:44:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1346417459-30042-2-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 31, 2012 at 06:20:57PM +0530, Hebbar, Gururaja wrote:

> +			if (dev->version == MCASP_VERSION_3) {
> +				mcasp_clr_bits(dev->base + MCASP_VER3_RFIFOCTL,
>  								FIFO_ENABLE);
> -			mcasp_set_bits(dev->base + DAVINCI_MCASP_RFIFOCTL,
> +				mcasp_set_bits(dev->base + MCASP_VER3_RFIFOCTL,
>  								FIFO_ENABLE);
> +			} else {
> +				mcasp_clr_bits(dev->base +
> +					DAVINCI_MCASP_RFIFOCTL,	FIFO_ENABLE);
> +				mcasp_set_bits(dev->base +
> +					DAVINCI_MCASP_RFIFOCTL,	FIFO_ENABLE);
> +			}

This is all basically OK but it seems like it'd be better if all these
dev->version checks were switch statements.  That way when the hardware
designers get bored and add version 4 of the register map it'll slot in
naturally, and it'll be more clear what the code currently handles.
