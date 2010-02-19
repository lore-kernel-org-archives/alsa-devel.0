From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v3 1/3] ASoC: OMAP: data_type and sync_mode
 configurable in audio dma
Date: Fri, 19 Feb 2010 14:16:05 +0000
Message-ID: <1266588965.3236.54.camel@odin>
References: <2256F256009DAA4CBE661E9F41EAC84B8F94A4EF@dlee01.ent.ti.com>
	<1266575725.3236.4.camel@odin>
	<20100219160348.ef4a3ce6.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by alsa0.perex.cz (Postfix) with ESMTP id 25DEF103981
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 15:16:13 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id e21so65222fga.2
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 06:16:12 -0800 (PST)
In-Reply-To: <20100219160348.ef4a3ce6.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>, "Candelaria Villareal,
	Jorge" <jorge.candelaria@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-02-19 at 16:03 +0200, Jarkko Nikula wrote:
> On Fri, 19 Feb 2010 10:35:25 +0000
> Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> 
> > > @@ -156,11 +158,7 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
> > >  		return 0;
> > >  
> > >  	memset(&dma_params, 0, sizeof(dma_params));
> > > -	/*
> > > -	 * Note: Regardless of interface data formats supported by OMAP McBSP
> > > -	 * or EAC blocks, internal representation is always fixed 16-bit/sample
> > > -	 */
> > 
> > Perhaps this should be rewritten to reflect mcbsp and mcpdm users rather
> > than deleted.
> > 
> I'm fine with the deletion. AFAIK there is no public specs for the EAC
> (at least not for the OMAP2420) so I see this comment only confusing
> (I wrote it) and a person who would write DAI driver for the EAC most
> probably has accesses to the specs.
> 

Ok, that's fine. 

Jorge, now it's only patch 2/3 requiring a little work.

Liam 

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
