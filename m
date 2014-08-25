From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCHv2 5/5] ASoC: fsl-sai: rename
 big_endian_data to is_msb_first.
Date: Mon, 25 Aug 2014 02:04:46 +0000
Message-ID: <b938ef9cd0df48e985a91c931f6052e6@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1408421693-9929-1-git-send-email-Li.Xiubo@freescale.com>
 <1408421693-9929-6-git-send-email-Li.Xiubo@freescale.com>
 <20140825015053.GB26651@Alpha>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 by alsa0.perex.cz (Postfix) with ESMTP id 36F162616C9
 for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2014 04:04:57 +0200 (CEST)
In-Reply-To: <20140825015053.GB26651@Alpha>
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
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "timur@tabi.org" <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Nicolin Chen [mailto:nicoleotsuka@gmail.com]
> Sent: Monday, August 25, 2014 9:51 AM
> To: Xiubo Li-B47053
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; mark.rutland@arm.com;
> timur@tabi.org; devicetree@vger.kernel.org
> Subject: Re: [PATCHv2 5/5] ASoC: fsl-sai: rename big_endian_data to
> is_msb_first.
> 
> On Tue, Aug 19, 2014 at 12:14:53PM +0800, Xiubo Li wrote:
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >  Documentation/devicetree/bindings/sound/fsl-sai.txt | 8 ++++----
> >  sound/soc/fsl/fsl_sai.c                             | 6 +++---
> >  sound/soc/fsl/fsl_sai.h                             | 2 +-
> >  3 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > index aed1f21..e25ef38 100644
> > --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> > @@ -20,9 +20,9 @@ Required properties:
> >    See ../pinctrl/pinctrl-bindings.txt for details of the property values.
> >  - big-endian: Boolean property, required if all the SAI device registers
> >    are big-endian rather than little-endian.
> > -- big-endian-data: If this property is absent, the little endian mode will
> > -  be in use as default, or the big endian mode will be in use for all the
> > -  fifo data.
> > +- msb-first: Configures whether the LSB or the MSB is transmitted first for
> > +  the fifo data. If this property is absent, the LSB is transmitted first
> as
> > +  default, or the MSB is transmitted first.
> >  - fsl,sai-synchronous-rx: This is a boolean property. If present,
> indicating
> >    that SAI will work in the synchronous mode (sync Tx with Rx) which means
> >    both the transimitter and receiver will send and receive data by
> following
> > @@ -53,5 +53,5 @@ sai2: sai@40031000 {
> >  	      dmas = <&edma0 0 VF610_EDMA_MUXID0_SAI2_TX>,
> >  		   <&edma0 0 VF610_EDMA_MUXID0_SAI2_RX>;
> >  	      big-endian;
> > -	      big-endian-data;
> > +	      msb-first;
> >  };
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index a6eb784..4e48431 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -175,7 +175,7 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai
> *cpu_dai,
> >  	bool tx = fsl_dir == FSL_FMT_TRANSMITTER;
> >  	u32 val_cr2 = 0, val_cr4 = 0;
> >
> > -	if (!sai->big_endian_data)
> > +	if (!sai->is_msb_first)
> >  		val_cr4 |= FSL_SAI_CR4_MF;
> 
> IIRC, MF stands for 'MSB First' but the condition is !is_msb_first..
> 

Yes, I will fix this.

> And also we can't not simply inverse the condition here since those
> platforms without the original 'big_endian_data' property will be
> broken unless they add the new 'is_msb_first' into the DT bindings,
> which is, however, a violation due to breaking the old bindings.
> 
> So I guess is_lsb_first might be better here?
>
> And actually, Xiubo, what's your purpose to add this patch? I can't
> see any commit comments to explain the reason. So could you please
> say something about it?
> 
> Thanks
> Nicolin

Months ago, the hardware team needed to do some IP test based LS1 needing
this to be added to the driver. And for now there is hasn't any other reason
for this yet.


Thanks,

BRs
Xiubo
