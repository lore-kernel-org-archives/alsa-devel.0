From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_sai: fix no frame clk in master
 mode
Date: Wed, 12 Aug 2015 15:59:15 +0800
Message-ID: <20150812075914.GC21786@shlinux2>
References: <2ec370890aca1bf5e8b796d7ebbfc95a0161980e.1439345935.git.zidan.wang@freescale.com>
 <20150812035317.GA3194@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0112.outbound.protection.outlook.com [157.56.110.112])
 by alsa0.perex.cz (Postfix) with ESMTP id AF995260438
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 11:10:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150812035317.GA3194@Asurada-CZ80>
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
Cc: alsa-devel@alsa-project.org, timur@tabi.org, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 11, 2015 at 08:53:25PM -0700, Nicolin Chen wrote:
> On Wed, Aug 12, 2015 at 10:25:45AM +0800, Zidan Wang wrote:
> > After several open/close sai test with ctrl+c, there will be I/O error.
> > The SAI can't work anymore, can't recover. There will be no frame clock.
> > With adding the software reset in trigger stop, the issue can be fixed.
> 
> It doesn't look like a decent fix to me. Is it the only fix that
> IC team suggests? And why put this reset in the trigger function.
> Your MEGA fast patch has already included a software reset in the
> PM runtime functions. When dealing with CTRL+C test cases, that
> software reset should have worked as well.
> 
The MEGA fast patch add the suspend/resume function, but CTRL+C will not trigger suspend/resume function.
When CTRL+C, it will trigger stop and software reset SAI.
IC team suggest us to rest it, but I don't know if it's the only fix.

Best Regards,
Zidan Wang

> Nicolin
> 
> > Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 5c737f1..6a947dc 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -504,6 +504,13 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
> >  					   FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
> >  			regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
> >  					   FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
> > +
> > +			/* Software Reset for both Tx and Rx */
> > +			regmap_write(sai->regmap, FSL_SAI_TCSR, FSL_SAI_CSR_SR);
> > +			regmap_write(sai->regmap, FSL_SAI_RCSR, FSL_SAI_CSR_SR);
> > +			/* Clear SR bit to finish the reset */
> > +			regmap_write(sai->regmap, FSL_SAI_TCSR, 0);
> > +			regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
> >  		}
> >  		break;
> >  	default:
> > -- 
> > 1.9.1
> > 
