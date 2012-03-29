From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: sgtl5000: Convert mic bias to a
	supply widget
Date: Thu, 29 Mar 2012 22:11:59 +0800
Message-ID: <20120329141156.GE19506@S2101-09.ap.freescale.net>
References: <1332964426-8480-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20120329052410.GA19506@S2101-09.ap.freescale.net>
	<20120329105646.GB3668@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4781110448C
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 16:12:04 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so1534618yhn.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 07:12:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120329105646.GB3668@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Zeng Zhaoming <zengzm.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 29, 2012 at 11:56:46AM +0100, Mark Brown wrote:
> On Thu, Mar 29, 2012 at 01:24:13PM +0800, Shawn Guo wrote:
> > On Wed, Mar 28, 2012 at 08:53:45PM +0100, Mark Brown wrote:
> 
> > > -	SND_SOC_DAPM_MICBIAS_E("Mic Bias", SGTL5000_CHIP_MIC_CTRL, 8, 0,
> > > -				mic_bias_event,
> > > -				SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
> > > +	SND_SOC_DAPM_SUPPLY("Mic Bias", SGTL5000_CHIP_MIC_CTRL, 8, 0,
> > > +			    mic_bias_event,
> > > +			    SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
> 
> > It breaks my capture testing.
> 
> Well, any capture testing that uses mic bias shouldn't work in mainline
> anyway - there's no hookup in the machine driver.
> 
> > I'm not sure these two macros are equivalent, since they have different
> > .id assignment.  To quickly confirm the problem, I have the capture
> > back to work with the following change.
> 
> You'll need to change the hookup in your machine to adapt to the change
> of widget type - see the previous conversions that have been done in git
> history for examples.  No device tree bindings should be using old style
> mic bias hookups.

Yes, with the proper machine driver adaption, it works now.
Thanks, Mark.

Tested-by: Shawn Guo <shawn.guo@linaro.org>

-- 
Regards,
Shawn
