From: Peter Chan <peter.chan@freescale.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: wm8962: Correct the bit offset to
 enable mono speaker output
Date: Fri, 8 Aug 2014 09:55:43 +0000
Message-ID: <39712b9fd56546f8a943d605230a2f18@BL2PR03MB371.namprd03.prod.outlook.com>
References: <1407412549-14983-1-git-send-email-nicoleotsuka@gmail.com>
 <20140807165836.GL17528@sirena.org.uk> <20140808082043.GB6333@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140808082043.GB6333@MrMyself>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>, Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "shengjiu.wang@freescale.com" <shengjiu.wang@freescale.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

I have a question about the wm8962 mono speaker mode. In SPK_MONO description at table 73, it says "When SPK_MONO is enabled, both speakers output the signal from the left channel". Does it mean only the left channel control the output in mono speaker mode?

Thanks,
Peter

-----Original Message-----
From: Nicolin Chen [mailto:Guangyu.Chen@freescale.com] 
Sent: Friday, August 08, 2014 4:21 PM
To: Mark Brown
Cc: Nicolin Chen; alsa-devel@alsa-project.org; tiwai@suse.de; patches@opensource.wolfsonmicro.com; Wang Shengjiu-B02247; lgirdwood@gmail.com; linux-kernel@vger.kernel.org; CHAN Peter-B18700; ckeepax@opensource.wolfsonmicro.com; rf@opensource.wolfsonmicro.com
Subject: Re: [alsa-devel] [PATCH] ASoC: wm8962: Correct the bit offset to enable mono speaker output

On Thu, Aug 07, 2014 at 05:58:36PM +0100, Mark Brown wrote:
> On Thu, Aug 07, 2014 at 07:55:49PM +0800, Nicolin Chen wrote:
> > As WM8962 datasheet describes for SPK_MONO bit of R51: When SPK_MONO 
> > is set to '1', both speakers output the signal from the left channel.
> 
> > So for mono speaker widget, we shall enable Left Channel whose 
> > enable bit is 6 instead of 7 (Right Channel).
> > 
> > This patches just simply corrects the bit offset.
> 
> >  		   spkmixl, ARRAY_SIZE(spkmixl)),  SND_SOC_DAPM_MUX_E("Speaker 
> > PGA", WM8962_PWR_MGMT_2, 4, 0, &spkoutl_mux,
> >  		   out_pga_event, SND_SOC_DAPM_POST_PMU), 
> > -SND_SOC_DAPM_PGA("Speaker Output", WM8962_CLASS_D_CONTROL_1, 7, 0, 
> > NULL, 0),
> > +SND_SOC_DAPM_PGA("Speaker Output", WM8962_CLASS_D_CONTROL_1, 6, 0, 
> > +NULL, 0),
> >  SND_SOC_DAPM_OUTPUT("SPKOUT"),
> >  };
> 
> Someone who's name I'd need to look up submitted an identical fix off 
> list recently - I checked the datasheet and it seems that in mono mode 
> the speaker output actually wants both left and right channels active 
> so there is a bug here but this isn't the fix.

I rechecked the datasheet and found that the hardware needs to tie both outputs and enable both bits. So the patch should be invalid.

But our customer reported that they did try to set both SPKOUTR_ENA and SPKOUTL_ENA bits in mono mode but the sound is lousy. If setting SPKOUTR_ENA alone, the speaker has no sound. Only setting SPKOUTL_ENA bit get the correct speaker output in mono mode.

And I just confirmed with our engineer who supports the customer that they are using the correct hardware design as the datasheet suggests. So I'm wondering if there's any other part we're missing.

Thank you
Nicolin
