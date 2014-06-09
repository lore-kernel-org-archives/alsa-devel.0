From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Fix integer overflow when
 calculating divisors
Date: Tue, 10 Jun 2014 01:26:32 +0800
Message-ID: <20140609172630.GA7715@MrMyself>
References: <1402330603-16547-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 by alsa0.perex.cz (Postfix) with ESMTP id A752426517E
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 19:26:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1402330603-16547-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 09, 2014 at 07:16:43PM +0300, Anssi Hannula wrote:
> The calculation code does
> u64 = (u32 - u32) * 100000;
> 
> The 64 bits are of no help here as the type is casted only after the
> multiplication, and therefore the result may overflow, possibly causing
> inoptimal or wrong clock setup in an unfortunate case (the maximum
> result value of the first substraction is currently 47999).
> 
> Fix the code to cast before multiplication.
> 
> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> Cc: Nicolin Chen <Guangyu.Chen@freescale.com>

Acked-by: Nicolin Chen <Guangyu.Chen@freescale.com>

Thank you so much :)
Nicolin

> ---
>  sound/soc/fsl/fsl_spdif.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> index b912d45a2a4c..0bd9136279a2 100644
> --- a/sound/soc/fsl/fsl_spdif.c
> +++ b/sound/soc/fsl/fsl_spdif.c
> @@ -1076,7 +1076,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
>  				goto out;
>  			} else if (arate / rate[index] == 1) {
>  				/* A little bigger than expect */
> -				sub = (arate - rate[index]) * 100000;
> +				sub = (u64)(arate - rate[index]) * 100000;
>  				do_div(sub, rate[index]);
>  				if (sub >= savesub)
>  					continue;
> @@ -1086,7 +1086,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
>  				spdif_priv->txrate[index] = arate;
>  			} else if (rate[index] / arate == 1) {
>  				/* A little smaller than expect */
> -				sub = (rate[index] - arate) * 100000;
> +				sub = (u64)(rate[index] - arate) * 100000;
>  				do_div(sub, rate[index]);
>  				if (sub >= savesub)
>  					continue;
> -- 
> 1.8.4.5
> 
