From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [EXT] [PATCH V3] ASoC: fsl_esai: Fix missing break
 in switch	statement
Date: Thu, 11 Apr 2019 03:01:59 +0000
Message-ID: <VE1PR04MB6479352259003E1CAF7E7AF0E32F0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <f1b910498324783f39b66a229c4abb80738097de.1554951087.git.shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30056.outbound.protection.outlook.com [40.107.3.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DBF63F80716
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 05:02:02 +0200 (CEST)
In-Reply-To: <f1b910498324783f39b66a229c4abb80738097de.1554951087.git.shengjiu.wang@nxp.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>, "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "gustavo@embeddedor.com" <gustavo@embeddedor.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi
> 
> 
> case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be independent
> of each other, so replace fall-through with break.
> 
> Fixes: 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Cc: <stable@vger.kernel.org>

Forget to add Acked-by: Nicolin Chen <nicoleotsuka@gmail.com> , will send v4, sorry.

> ---
> changes in v3
> - add cc stable
> - change the subject
> 
>  sound/soc/fsl/fsl_esai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c index
> 3623aa9a6f2e..15202a637197 100644
> --- a/sound/soc/fsl/fsl_esai.c
> +++ b/sound/soc/fsl/fsl_esai.c
> @@ -251,7 +251,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai
> *dai, int clk_id,
>                 break;
>         case ESAI_HCKT_EXTAL:
>                 ecr |= ESAI_ECR_ETI;
> -               /* fall through */
> +               break;
>         case ESAI_HCKR_EXTAL:
>                 ecr |= ESAI_ECR_ERI;
>                 break;
> --
