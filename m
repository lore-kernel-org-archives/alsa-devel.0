From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: soc-pcm: Only do
 snd_soc_dai_digital_mute() in hw_free()
Date: Tue, 3 Dec 2013 23:26:06 +0800
Message-ID: <20131203152606.GD8609@MrMyself>
References: <1386062166-29634-1-git-send-email-b42378@freescale.com>
 <20131203150423.GW27568@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 556B7261A1B
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 16:45:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131203150423.GW27568@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 03, 2013 at 03:04:23PM +0000, Mark Brown wrote:
> On Tue, Dec 03, 2013 at 05:16:06PM +0800, Nicolin Chen wrote:
> 
> > @@ -689,7 +684,7 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
> >  	struct snd_soc_platform *platform = rtd->platform;
> >  	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> >  	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> > -	struct snd_soc_codec *codec = rtd->codec;
> > +	bool playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 1 : 0;
> 
> Please don't use the ternery operator, you could've just used the result
> of the comparison directly here.

Oh, a bad habit. Thank you for teaching me this.

> 
> >  	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
> >  
> > @@ -707,7 +702,8 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
> >  	}
> >  
> >  	/* apply codec digital mute */
> > -	if (!codec->active)
> > +	if ((playback && codec_dai->playback_active == 1) ||
> > +			(!playback && codec_dai->capture_active == 1))
> >  		snd_soc_dai_digital_mute(codec_dai, 1, substream->stream);
> 
> This is a bit confusing to read due to the strange indentation (the
> second line is massively indented with respect to the first line for
> some reason).  This hunk also ought to be split out as a separate patch
> since it's a bug fix.

I'll refine the indentation and split the patch into two.

Thank you indeed.
Nicolin Chen
