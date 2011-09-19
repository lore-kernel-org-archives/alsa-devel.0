From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/17] ASoC: twl6040: Lower the initial
	gains
Date: Mon, 19 Sep 2011 12:00:06 +0100
Message-ID: <20110919110006.GH23727@opensource.wolfsonmicro.com>
References: <1316090379-30760-1-git-send-email-peter.ujfalusi@ti.com>
	<1316090379-30760-8-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 275FA249C5
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Sep 2011 13:00:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316090379-30760-8-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org, Samuel Ortiz <samuel.ortiz@intel.com>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 15, 2011 at 03:39:29PM +0300, Peter Ujfalusi wrote:
> The default gains on outputs/inputs are set to 0dB.
> To be able to handle pop noise better, we need to lower
> the gains on controls, where it is possible.

It looks like what you really want to do here is implement support
having PGAs able to cache the gain the user has set but hold the gain at
zero while the PGA is disabled.  This would be generally useful, a lot
of older parts liked to have the PGAs muted when powering them.

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/codecs/twl6040.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
> index 987d9c9..1f6068b 100644
> --- a/sound/soc/codecs/twl6040.c
> +++ b/sound/soc/codecs/twl6040.c
> @@ -269,6 +269,13 @@ static void twl6040_init_chip(struct snd_soc_codec *codec)
>  	/* No imput selected for microphone amplifiers */
>  	twl6040_write_reg_cache(codec, TWL6040_REG_MICLCTL, 0x18);
>  	twl6040_write_reg_cache(codec, TWL6040_REG_MICRCTL, 0x18);
> +
> +	/* Lower the gains */
> +	twl6040_write_reg_cache(codec, TWL6040_REG_HSGAIN, 0xff);
> +	twl6040_write_reg_cache(codec, TWL6040_REG_EARCTL, 0x1e);
> +	twl6040_write_reg_cache(codec, TWL6040_REG_HFLGAIN, 0x1d);
> +	twl6040_write_reg_cache(codec, TWL6040_REG_HFRGAIN, 0x1d);
> +	twl6040_write_reg_cache(codec, TWL6040_REG_LINEGAIN, 0);
>  }
>  
>  static void twl6040_restore_regs(struct snd_soc_codec *codec)
> -- 
> 1.7.6.1
> 
