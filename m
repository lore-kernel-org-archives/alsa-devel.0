From: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [EXT] Re: [PATCH V1] ASoC: fsl_esai: replace
 fall-through with break
Date: Tue, 9 Apr 2019 02:54:19 +0000
Message-ID: <VE1PR04MB6479C16BB1C92E1AE291BB12E32D0@VE1PR04MB6479.eurprd04.prod.outlook.com>
References: <66c117128f300b0ec5f278f538412789c78b60a6.1554715589.git.shengjiu.wang@nxp.com>
 <38a6d36e-0f8e-fe3d-202b-30371042e248@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr20065.outbound.protection.outlook.com [40.107.2.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5AA78F80765
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 04:54:21 +0200 (CEST)
In-Reply-To: <38a6d36e-0f8e-fe3d-202b-30371042e248@embeddedor.com>
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

Hi Gustavo

> 
> 
> On 4/8/19 4:28 AM, S.j. Wang wrote:
> > case ESAI_HCKT_EXTAL and case ESAI_HCKR_EXTAL should be
> independent of
> > each other, so replace fall-through with break.
> >
> If this is correct, then you should use the following "Fixes" tag instead,
> which is the one that introduced the bug:
> 
> Fixes: 43d24e76b698 ("ASoC: fsl_esai: Add ESAI CPU DAI driver")
> 
> > Fixes: 16bbeb2b43c3 ("ASoC: fsl_esai: Mark expected switch
> > fall-through")
> >
>         ^^^^
> because this didn't change any functionality.

Ok, this will be updated.

> 
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_esai.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c index
> > c7410bbfd2af..bad0dfed6b68 100644
> > --- a/sound/soc/fsl/fsl_esai.c
> > +++ b/sound/soc/fsl/fsl_esai.c
> > @@ -251,7 +251,7 @@ static int fsl_esai_set_dai_sysclk(struct
> snd_soc_dai *dai, int clk_id,
> >               break;
> >       case ESAI_HCKT_EXTAL:
> >               ecr |= ESAI_ECR_ETI;
> 
> Also, you should use a simple assignment operator "=" instead of "|=" in
> both cases.

The result is same for "=" and "|=", because there is "ecr = 0" in beginning of
This function. 

> 
> > -             /* fall through */
> > +             break;
> >       case ESAI_HCKR_EXTAL:
> >               ecr |= esai_priv->synchronous ? ESAI_ECR_ETI : ESAI_ECR_ERI;
> >               break;
> >
> 
> Thanks
> --
> Gustavo
