From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [EXT] Re: [PATCH V2] ASoC: fsl_esai: replace
 fall-through with break
Date: Thu, 11 Apr 2019 02:48:25 +0000
Message-ID: <VE1PR04MB6479B21F67A8989072035BF6E32F0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <46e9b55edb223894392a90c7cdb6241a43cb9cff.1554864022.git.shengjiu.wang@nxp.com>
 <b68a4e3a-8568-0c6e-aa3a-947e62e4f0f5@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10053.outbound.protection.outlook.com [40.107.1.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC80DF80716
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2019 04:48:27 +0200 (CEST)
In-Reply-To: <b68a4e3a-8568-0c6e-aa3a-947e62e4f0f5@embeddedor.com>
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
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "timur@kernel.org" <timur@kernel.org>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

Hi

> 
> 
> On 4/9/19 9:42 PM, S.j. Wang wrote:
> > case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be independent
> of
> > each other, so replace fall-through with break.
> >
> I think you should change the subject line to:
> 
> fix missing break in switch statement
> 
> ...because you are fixing a bug, and it's important to put emphasis on that in
> the subject line.
> 
> Also, notice that this bug has been out there for more than 5 years now, so
> you should also tag this for stable.
> 
> Thanks
> --
> Gustavo
>

Ok, will send v3.

 
> 
> > Fixes: 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> > Changes in v2
> > - fix the fixes tag.
> >
> >  sound/soc/fsl/fsl_esai.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c index
> > c7410bbfd2af..bad0dfed6b68 100644
> > --- a/sound/soc/fsl/fsl_esai.c
> > +++ b/sound/soc/fsl/fsl_esai.c
> > @@ -251,7 +251,7 @@ static int fsl_esai_set_dai_sysclk(struct snd_soc_dai
> *dai, int clk_id,
> >               break;
> >       case ESAI_HCKT_EXTAL:
> >               ecr |= ESAI_ECR_ETI;
> > -             /* fall through */
> > +             break;
> >       case ESAI_HCKR_EXTAL:
> >               ecr |= esai_priv->synchronous ? ESAI_ECR_ETI : ESAI_ECR_ERI;
> >               break;
> >
