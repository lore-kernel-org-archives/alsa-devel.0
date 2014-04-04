From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH 2/4] ASoC: esai: Add Vybird and LS1+
	compatibles support.
Date: Fri, 4 Apr 2014 00:46:48 +0000
Message-ID: <2bbf377bb23449b59909d52c05b18aad@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1396516257-25354-1-git-send-email-Li.Xiubo@freescale.com>
 <1396516257-25354-3-git-send-email-Li.Xiubo@freescale.com>
 <20140403111911.GB32081@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0212.outbound.protection.outlook.com [207.46.163.212])
 by alsa0.perex.cz (Postfix) with ESMTP id 781C7265566
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 02:47:01 +0200 (CEST)
In-Reply-To: <20140403111911.GB32081@MrMyself>
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
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "timur@tabi.org" <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org


> Subject: Re: [PATCH 2/4] ASoC: esai: Add Vybird and LS1+ compatibles support.
> 
> On Thu, Apr 03, 2014 at 05:10:55PM +0800, Xiubo Li wrote:
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >  sound/soc/fsl/fsl_esai.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
> > index 8efc89e..b84951b 100644
> > --- a/sound/soc/fsl/fsl_esai.c
> > +++ b/sound/soc/fsl/fsl_esai.c
> > @@ -818,6 +818,8 @@ static int fsl_esai_probe(struct platform_device *pdev)
> >
> >  static const struct of_device_id fsl_esai_dt_ids[] = {
> >  	{ .compatible = "fsl,imx35-esai", },
> > +	{ .compatible = "fsl,vybird-esai", },
> 
> vybird or vybrid?
> 
> > +	{ .compatible = "fsl,ls1+-esai", },
> 
> Does ls1 differ vybrid on esai part? If not, it should be enough to use
> vybrid for both of them, just like imx6q and imx6dl can also use imx35
> compatible.
> 

Just like the imx series as you described, and that looks nice.

Thanks,

> Thanks,
> Nicolin
> 
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, fsl_esai_dt_ids);
> > --
> > 1.8.4
> >
> >
