From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH] ASoC: wm8962: Correct the bit offset to
 enable mono speaker output
Date: Fri, 8 Aug 2014 16:20:44 +0800
Message-ID: <20140808082043.GB6333@MrMyself>
References: <1407412549-14983-1-git-send-email-nicoleotsuka@gmail.com>
 <20140807165836.GL17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0211.outbound.protection.outlook.com [207.46.163.211])
 by alsa0.perex.cz (Postfix) with ESMTP id E56902654A6
 for <alsa-devel@alsa-project.org>; Fri,  8 Aug 2014 10:40:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140807165836.GL17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, b02247@freescale.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>, B18700@freescale.com, ckeepax@opensource.wolfsonmicro.com, rf@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 07, 2014 at 05:58:36PM +0100, Mark Brown wrote:
> On Thu, Aug 07, 2014 at 07:55:49PM +0800, Nicolin Chen wrote:
> > As WM8962 datasheet describes for SPK_MONO bit of R51: When SPK_MONO
> > is set to '1', both speakers output the signal from the left channel.
> 
> > So for mono speaker widget, we shall enable Left Channel whose enable
> > bit is 6 instead of 7 (Right Channel).
> > 
> > This patches just simply corrects the bit offset.
> 
> >  		   spkmixl, ARRAY_SIZE(spkmixl)),
> >  SND_SOC_DAPM_MUX_E("Speaker PGA", WM8962_PWR_MGMT_2, 4, 0, &spkoutl_mux,
> >  		   out_pga_event, SND_SOC_DAPM_POST_PMU),
> > -SND_SOC_DAPM_PGA("Speaker Output", WM8962_CLASS_D_CONTROL_1, 7, 0, NULL, 0),
> > +SND_SOC_DAPM_PGA("Speaker Output", WM8962_CLASS_D_CONTROL_1, 6, 0, NULL, 0),
> >  SND_SOC_DAPM_OUTPUT("SPKOUT"),
> >  };
> 
> Someone who's name I'd need to look up submitted an identical fix off
> list recently - I checked the datasheet and it seems that in mono mode
> the speaker output actually wants both left and right channels active so
> there is a bug here but this isn't the fix.

I rechecked the datasheet and found that the hardware needs to tie
both outputs and enable both bits. So the patch should be invalid.

But our customer reported that they did try to set both SPKOUTR_ENA
and SPKOUTL_ENA bits in mono mode but the sound is lousy. If setting
SPKOUTR_ENA alone, the speaker has no sound. Only setting SPKOUTL_ENA
bit get the correct speaker output in mono mode.

And I just confirmed with our engineer who supports the customer
that they are using the correct hardware design as the datasheet
suggests. So I'm wondering if there's any other part we're missing.

Thank you
Nicolin
