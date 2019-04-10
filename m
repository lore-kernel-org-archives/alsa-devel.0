From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH V2] ASoC: fsl_esai: replace fall-through
	with break
Date: Tue, 9 Apr 2019 20:53:17 -0700
Message-ID: <20190410035317.GA3032@Asurada>
References: <46e9b55edb223894392a90c7cdb6241a43cb9cff.1554864022.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB979F8068A
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 05:53:23 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id z9so659215pgu.10
 for <alsa-devel@alsa-project.org>; Tue, 09 Apr 2019 20:53:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46e9b55edb223894392a90c7cdb6241a43cb9cff.1554864022.git.shengjiu.wang@nxp.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "timur@kernel.org" <timur@kernel.org>, "gustavo@embeddedor.com" <gustavo@embeddedor.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 10, 2019 at 02:42:45AM +0000, S.j. Wang wrote:
> case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be independent of
> each other, so replace fall-through with break.
> 
> Fixes: 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
> Changes in v2
> - fix the fixes tag.
> 
>  sound/soc/fsl/fsl_esai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> index c7410bbfd2af..bad0dfed6b68 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -251,7 +251,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
>  		break;
>  	case ESAI_HCKT_EXTAL:
>  		ecr |= ESAI_ECR_ETI;
> -		/* fall through */
> +		break;
>  	case ESAI_HCKR_EXTAL:
>  		ecr |= esai_priv->synchronous ? ESAI_ECR_ETI : ESAI_ECR_ERI;
>  		break;
> -- 
> 1.9.1
> 
