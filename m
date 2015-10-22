From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_sai: Constify rate
	constraints
Date: Thu, 22 Oct 2015 11:58:38 -0700
Message-ID: <20151022185837.GB4614@Asurada-CZ80>
References: <1445503403-22934-1-git-send-email-lars@metafoo.de>
 <1445503403-22934-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id B32A426683C
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 20:58:44 +0200 (CEST)
Received: by pasz6 with SMTP id z6so93883987pas.2
 for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 11:58:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1445503403-22934-3-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 22, 2015 at 10:43:23AM +0200, Lars-Peter Clausen wrote:
> The rate constraints in this driver are shared between all device
> instances. It should not be (and is not) modified at runtime, so make them
> const.
> 
> While we are at it also change the type of the rates array from u32 to
> unsigned int. While both resolve to the same type, u32 is usually used to
> empathize that the value is for a 32-bit hardware register or similar which
> makes it slightly confusing in this context.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_sai.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 784725b..38505f3 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -27,13 +27,13 @@
>  #define FSL_SAI_FLAGS (FSL_SAI_CSR_SEIE |\
>  		       FSL_SAI_CSR_FEIE)
>  
> -static u32 fsl_sai_rates[] = {
> +static const unsigned int fsl_sai_rates[] = {
>  	8000, 11025, 12000, 16000, 22050,
>  	24000, 32000, 44100, 48000, 64000,
>  	88200, 96000, 176400, 192000
>  };
>  
> -static struct snd_pcm_hw_constraint_list fsl_sai_rate_constraints = {
> +static const struct snd_pcm_hw_constraint_list fsl_sai_rate_constraints = {
>  	.count = ARRAY_SIZE(fsl_sai_rates),
>  	.list = fsl_sai_rates,
>  };
> -- 
> 2.1.4
> 
