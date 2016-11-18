From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] CHROMIUM: ASoC: Intel: boards: Use FS as
 nau8825 sysclk in nau88l25_max98357a machine
Date: Fri, 18 Nov 2016 15:55:06 +0530
Message-ID: <20161118102506.GQ2698@localhost>
References: <1479364515-29019-1-git-send-email-grace.kao@intel.com>
 <20161118052846.GJ2698@localhost>
 <20161118094810.GA1575@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3138A2666AC
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2016 11:15:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20161118094810.GA1575@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Grace Kao <grace.kao@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 18, 2016 at 09:48:10AM +0000, Charles Keepax wrote:
> > > +
> > > +	switch (cmd) {
> > > +	case SNDRV_PCM_TRIGGER_START:
> > > +		ret = snd_soc_dai_set_sysclk(codec_dai,	NAU8825_CLK_FLL_FS, 0,
> > > +			SND_SOC_CLOCK_IN);
> > > +		if (ret < 0)
> > > +			dev_err(codec_dai->dev, "can't set FS clock %d\n", ret);
> > > +		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
> > > +			runtime->rate * 256);
> > > +		if (ret < 0)
> > > +			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
> > > +		break;
> > 
> > starting clock on trigger doesnt sound right to me..
> > 
> 
> Me neither can't trigger be called from an atomic context? In
> which case I would expect operations on an external CODEC to be
> very likely to cause issues.

Not in this case :) We use non atomic triggers.. But that doesnt make this
correct :)

-- 
~Vinod
