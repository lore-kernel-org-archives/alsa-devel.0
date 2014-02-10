From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] ASoC: fsl-esai: fix ESAI TDM slot setting
Date: Mon, 10 Feb 2014 08:24:43 +0000
Message-ID: <5e5bb7d466fc4197939379273f11c4b6@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1392014837-22308-1-git-send-email-Li.Xiubo@freescale.com>
 <20140210075031.GA16453@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Sorry, my misunderstanding about your comment.

Please ignore the last mail.

I will send v2 of this patch.

Thanks very much.

> > > diff --git a/sound/soc/fsl/fsl_esai.h b/sound/soc/fsl/fsl_esai.h
> > > index 9c9f957..75e1403 100644
> > > --- a/sound/soc/fsl/fsl_esai.h
> > > +++ b/sound/soc/fsl/fsl_esai.h
> > > @@ -322,7 +322,7 @@
> > >  #define ESAI_xSMB_xS_SHIFT	0
> > >  #define ESAI_xSMB_xS_WIDTH	16
> > >  #define ESAI_xSMB_xS_MASK	(((1 << ESAI_xSMB_xS_WIDTH) - 1) <<
> > ESAI_xSMB_xS_SHIFT)
> > > -#define ESAI_xSMB_xS(v)		(((v) >> ESAI_xSMA_xS_WIDTH) &
> > ESAI_xSMA_xS_MASK)
> > > +#define ESAI_xSMB_xS(v)		(((v) >> ESAI_xSMA_xS_WIDTH) &
> > ESAI_xSMB_xS_MASK)
> >
> > It should use ESAI_xSMB_xS_WIDTH.
> >
> 
> Well, the ESAI_xSMB_xS_WIDTH is 0x0010(16), and ESAI_xSMB_xS_MASK will
> be 0xFFFF.
> 
> 
> 
> Thanks,
> 
> --
> Best Regards,
> Xiubo
