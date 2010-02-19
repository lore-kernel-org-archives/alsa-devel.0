From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v3 1/3] ASoC: OMAP: data_type and sync_mode
 configurable in audio dma
Date: Fri, 19 Feb 2010 16:03:48 +0200
Message-ID: <20100219160348.ef4a3ce6.jhnikula@gmail.com>
References: <2256F256009DAA4CBE661E9F41EAC84B8F94A4EF@dlee01.ent.ti.com>
	<1266575725.3236.4.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.146])
	by alsa0.perex.cz (Postfix) with ESMTP id CD19910396A
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 14:58:23 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 26so194065eyw.0
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 05:58:22 -0800 (PST)
In-Reply-To: <1266575725.3236.4.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "Candelaria Villareal, Jorge" <jorge.candelaria@ti.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Feb 2010 10:35:25 +0000
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> > @@ -156,11 +158,7 @@ static int omap_pcm_prepare(struct snd_pcm_substream *substream)
> >  		return 0;
> >  
> >  	memset(&dma_params, 0, sizeof(dma_params));
> > -	/*
> > -	 * Note: Regardless of interface data formats supported by OMAP McBSP
> > -	 * or EAC blocks, internal representation is always fixed 16-bit/sample
> > -	 */
> 
> Perhaps this should be rewritten to reflect mcbsp and mcpdm users rather
> than deleted.
> 
I'm fine with the deletion. AFAIK there is no public specs for the EAC
(at least not for the OMAP2420) so I see this comment only confusing
(I wrote it) and a person who would write DAI driver for the EAC most
probably has accesses to the specs.


-- 
Jarkko
