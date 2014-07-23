From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_sai: Reset FIFOs after
	disabling TE/RE
Date: Wed, 23 Jul 2014 17:52:32 +0800
Message-ID: <20140723095229.GA25639@MrMyself>
References: <cover.1405603108.git.nicoleotsuka@gmail.com>
 <9ef07dc9cc98b19e3f81f8374617605bf0d9faeb.1405603108.git.nicoleotsuka@gmail.com>
 <20140718101810.GA15150@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 974D92655E4
 for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2014 12:03:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140718101810.GA15150@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, b42378@freescale.com, b02247@freescale.com, linux-kernel@vger.kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Sir,

I found this two patches are merged into for-next branch, although I haven't
got the 'applied' email. 

Is that possible for you to drop this one? If not, I'll send another patch
to fix this.

Thank you,
Nicolin

On Fri, Jul 18, 2014 at 06:18:12PM +0800, Nicolin Chen wrote:
> Mark,
> 
> 	Please disregard this single patch. 
> 
> On Thu, Jul 17, 2014 at 09:21:37PM +0800, Nicolin Chen wrote:
> > SAI will not clear their FIFOs after disabling TE/RE. Therfore, the driver
> > should take care the task so as not to let useless data remain in the FIFO.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index c5a0e8a..b10dbd8 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -371,10 +371,13 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
> >  
> >  		/* Check if the opposite FRDE is also disabled */
> >  		if (!(tx ? rcsr & FSL_SAI_CSR_FRDE : tcsr & FSL_SAI_CSR_FRDE)) {
> > +			/* Disable both directions and reset their FIFOs */
> >  			regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
> > -					   FSL_SAI_CSR_TERE, 0);
> > +					   FSL_SAI_CSR_TERE | FSL_SAI_CSR_FR,
> > +					   FSL_SAI_CSR_FR);
> >  			regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
> > -					   FSL_SAI_CSR_TERE, 0);
> > +					   FSL_SAI_CSR_TERE | FSL_SAI_CSR_FR,
> > +					   FSL_SAI_CSR_FR);
> 
> 
> The FR should be set _after_ clear TERE, not at the same time because it
> still may have tiny possibility to remain data.
> 
> I'll send another version later for this patch.
> 
> The other patch for isr() should be still fine.
> 
> Thank you,
> Nicolin
> 
> >  		}
> >  		break;
> >  	default:
> > -- 
> > 1.8.4
> > 
