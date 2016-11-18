From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] CHROMIUM: ASoC: Intel: boards: Use FS as
 nau8825 sysclk in nau88l25_max98357a machine
Date: Fri, 18 Nov 2016 09:48:10 +0000
Message-ID: <20161118094810.GA1575@localhost.localdomain>
References: <1479364515-29019-1-git-send-email-grace.kao@intel.com>
 <20161118052846.GJ2698@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id D76962666AC
 for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2016 10:47:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20161118052846.GJ2698@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Grace Kao <grace.kao@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 18, 2016 at 10:58:46AM +0530, Vinod Koul wrote:
> On Thu, Nov 17, 2016 at 02:35:15PM +0800, Grace Kao wrote:
> > 256FS sysclk gives the best audio quality per nau8825 datasheet.
> > 
> > Loud headphone pop happens if there is no sysclk during nau8825
> > playback power up sequence. Currently Skylake does not output MCLK/FS
> > when the back-end DAI op hw_param is called, so we cannot switch to
> > MCLK/FS in hw_param. This patch reduces pop by leting nau8825 keep
> > using its internal VCO clock during widget power up sequence, until
> > SNDRV_PCM_TRIGGER_START when MCLK/FS is available.
<snip>
> 
> > +static int skylake_nau8825_trigger(struct snd_pcm_substream *substream, int cmd)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct snd_pcm_runtime *runtime = substream->runtime;
> > +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> > +	int ret = 0;
> > +
> > +	switch (cmd) {
> > +	case SNDRV_PCM_TRIGGER_START:
> > +		ret = snd_soc_dai_set_sysclk(codec_dai,	NAU8825_CLK_FLL_FS, 0,
> > +			SND_SOC_CLOCK_IN);
> > +		if (ret < 0)
> > +			dev_err(codec_dai->dev, "can't set FS clock %d\n", ret);
> > +		ret = snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rate,
> > +			runtime->rate * 256);
> > +		if (ret < 0)
> > +			dev_err(codec_dai->dev, "can't set FLL: %d\n", ret);
> > +		break;
> 
> starting clock on trigger doesnt sound right to me..
> 

Me neither can't trigger be called from an atomic context? In
which case I would expect operations on an external CODEC to be
very likely to cause issues.

Thanks,
Charles
