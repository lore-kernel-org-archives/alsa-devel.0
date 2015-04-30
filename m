From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 4/7] ASoC: intel - add Skylake HDA
	platform driver
Date: Thu, 30 Apr 2015 15:12:21 +0530
Message-ID: <20150430094221.GM3521@localhost>
References: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
 <1430250870-3169-5-git-send-email-vinod.koul@intel.com>
 <s5hy4lbf75l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 941222625ED
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 11:41:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy4lbf75l.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 29, 2015 at 02:31:02PM +0200, Takashi Iwai wrote:
> At Wed, 29 Apr 2015 01:24:27 +0530,
> Vinod Koul wrote:
> > 
> > +static struct snd_soc_dai_driver soc_hda_platform_dai[] = {
> > +{
> > +	.name = "System Pin",
> > +	.ops = &hda_pcm_dai_ops,
> > +	.playback = {
> > +		.stream_name = "System Playback",
> > +		.channels_min = HDA_MONO,
> > +		.channels_max = HDA_STEREO,
> > +		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_8000,
> > +		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +	},
> > +	.capture = {
> > +		.stream_name = "System Capture",
> > +		.channels_min = HDA_MONO,
> > +		.channels_max = HDA_STEREO,
> > +		.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_16000,
> > +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
> 
> Is it really S24_LE?  It's packed in lower 3 bytes of 4 bytes format.
Yup, we do use S24_LE, thats very common on our DSP based systems

> 
> > +	},
> > +},
> > +{
> > +	.name = "Deepbuffer Pin",
> > +	.ops = &hda_pcm_dai_ops,
> > +	.playback = {
> > +		.stream_name = "Deepbuffer Playback",
> > +		.channels_min = HDA_STEREO,
> > +		.channels_max = HDA_STEREO,
> > +		.rates = SNDRV_PCM_RATE_48000,
> > +		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +	},
> > +},
> > +{
> > +	.name = "LowLatency Pin",
> > +	.ops = &hda_pcm_dai_ops,
> > +	.playback = {
> > +		.stream_name = "Low Latency Playback",
> > +		.channels_min = HDA_STEREO,
> > +		.channels_max = HDA_STEREO,
> > +		.rates = SNDRV_PCM_RATE_48000,
> > +		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +	},
> 
> Are there no S32_LE support at all for all dais?
No, just 16 and 24 bits :)

-- 
~Vinod
