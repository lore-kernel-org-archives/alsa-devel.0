From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH 4/4] ASoC: spdif: Add Vybird and LS1+
 compatibles support.
Date: Fri, 4 Apr 2014 00:40:33 +0000
Message-ID: <139a7614a5a54aebaadc505564fed34e@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1396516257-25354-1-git-send-email-Li.Xiubo@freescale.com>
 <1396516257-25354-5-git-send-email-Li.Xiubo@freescale.com>
 <CAOMZO5DPbzK6_M=jzFGMKv1CFRd2xOYSEfyAUNi-XgKo17553Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0140.outbound.protection.outlook.com [207.46.163.140])
 by alsa0.perex.cz (Postfix) with ESMTP id A8879265566
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 02:40:58 +0200 (CEST)
In-Reply-To: <CAOMZO5DPbzK6_M=jzFGMKv1CFRd2xOYSEfyAUNi-XgKo17553Q@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

> Subject: Re: [alsa-devel] [PATCH 4/4] ASoC: spdif: Add Vybird and LS1+
> compatibles support.
> 
> On Thu, Apr 3, 2014 at 6:10 AM, Xiubo Li <Li.Xiubo@freescale.com> wrote:
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >  sound/soc/fsl/fsl_spdif.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
> > index 173553c..5c958ca 100644
> > --- a/sound/soc/fsl/fsl_spdif.c
> > +++ b/sound/soc/fsl/fsl_spdif.c
> > @@ -1186,6 +1186,8 @@ static int fsl_spdif_probe(struct platform_device
> *pdev)
> >
> >  static const struct of_device_id fsl_spdif_dt_ids[] = {
> >         { .compatible = "fsl,imx35-spdif", },
> > +       { .compatible = "fsl,vybird-spdif", },
> 
> I think you mean vybrid ;-)
> 
Well yes, you are right.

I will follow GuangYu's advice in another mail.

Thanks,

Brs
Xiubo
