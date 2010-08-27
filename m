From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/6] ASoC: ad1980: remove unneeded	function
	declaration
Date: Fri, 27 Aug 2010 19:12:11 +0100
Message-ID: <20100827181211.GC30429@sirena.org.uk>
References: <1282655384-13357-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1282655384-13357-3-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E0F2F1038A2
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 20:12:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1282655384-13357-3-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Sonic Zhang <sonic.zhang@analog.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 24, 2010 at 03:09:41PM +0200, Uwe Kleine-K??nig wrote:

Please remember to CC maintainers on patches.  This looks OK, I've CCed
in Liam.

> Signed-off-by: Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>
> ---
>  sound/soc/codecs/ad1980.c |    5 -----
>  1 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
> index c1550b8..82267e5 100644
> --- a/sound/soc/codecs/ad1980.c
> +++ b/sound/soc/codecs/ad1980.c
> @@ -33,11 +33,6 @@
>  
>  #include "ad1980.h"
>  
> -static unsigned int ac97_read(struct snd_soc_codec *codec,
> -	unsigned int reg);
> -static int ac97_write(struct snd_soc_codec *codec,
> -	unsigned int reg, unsigned int val);
> -
>  /*
>   * AD1980 register cache
>   */
> -- 
> 1.7.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
