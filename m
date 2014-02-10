From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: fsl-esai: fix ESAI TDM slot setting
Date: Mon, 10 Feb 2014 16:15:05 +0800
Message-ID: <20140210081504.GA16574@MrMyself>
References: <1392014837-22308-1-git-send-email-Li.Xiubo@freescale.com>
 <20140210075031.GA16453@MrMyself>
 <5e5bb7d466fc4197939379273f11c4b6@BY2PR03MB505.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5e5bb7d466fc4197939379273f11c4b6@BY2PR03MB505.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li-B47053 <Li.Xiubo@freescale.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 10, 2014 at 04:24:43PM +0800, Xiubo Li-B47053 wrote:
> Sorry, my misunderstanding about your comment.
> 
> Please ignore the last mail.
> 
> I will send v2 of this patch.

No, you don't need to.

Just rechecked it with RM. Your patch is correct.

I forgot I used A's WIDTH intentionally at the first place.

TSMA-> [15:0]
TSMB-> [31:16] -> higher 16bits.

Thus its shift should be corresponding to A's WIDTH.

The patch is fine. Acked.

Thank you.

> > > > diff --git a/sound/soc/fsl/fsl_esai.h b/sound/soc/fsl/fsl_esai.h
> > > > index 9c9f957..75e1403 100644
> > > > --- a/sound/soc/fsl/fsl_esai.h
> > > > +++ b/sound/soc/fsl/fsl_esai.h
> > > > @@ -322,7 +322,7 @@
> > > >  #define ESAI_xSMB_xS_SHIFT	0
> > > >  #define ESAI_xSMB_xS_WIDTH	16
> > > >  #define ESAI_xSMB_xS_MASK	(((1 << ESAI_xSMB_xS_WIDTH) - 1) <<
> > > ESAI_xSMB_xS_SHIFT)
> > > > -#define ESAI_xSMB_xS(v)		(((v) >> ESAI_xSMA_xS_WIDTH) &
> > > ESAI_xSMA_xS_MASK)
> > > > +#define ESAI_xSMB_xS(v)		(((v) >> ESAI_xSMA_xS_WIDTH) &
> > > ESAI_xSMB_xS_MASK)
> > >
> > > It should use ESAI_xSMB_xS_WIDTH.
> > >
> > 
> > Well, the ESAI_xSMB_xS_WIDTH is 0x0010(16), and ESAI_xSMB_xS_MASK will
> > be 0xFFFF.
> > 
> > 
> > 
> > Thanks,
> > 
> > --
> > Best Regards,
> > Xiubo
