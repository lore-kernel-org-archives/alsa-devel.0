From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 4/7] ASoC: intel - add Skylake HDA
	platform driver
Date: Thu, 30 Apr 2015 16:09:18 +0530
Message-ID: <20150430103918.GO3521@localhost>
References: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
 <1430250870-3169-5-git-send-email-vinod.koul@intel.com>
 <s5hy4lbf75l.wl-tiwai@suse.de> <20150430094221.GM3521@localhost>
 <s5hwq0udjtc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 918142614EE
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 12:38:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwq0udjtc.wl-tiwai@suse.de>
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

On Thu, Apr 30, 2015 at 11:52:47AM +0200, Takashi Iwai wrote:
> > > > +	},
> > > > +},
> > > > +{
> > > > +	.name = "Deepbuffer Pin",
> > > > +	.ops = &hda_pcm_dai_ops,
> > > > +	.playback = {
> > > > +		.stream_name = "Deepbuffer Playback",
> > > > +		.channels_min = HDA_STEREO,
> > > > +		.channels_max = HDA_STEREO,
> > > > +		.rates = SNDRV_PCM_RATE_48000,
> > > > +		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> > > > +	},
> > > > +},
> > > > +{
> > > > +	.name = "LowLatency Pin",
> > > > +	.ops = &hda_pcm_dai_ops,
> > > > +	.playback = {
> > > > +		.stream_name = "Low Latency Playback",
> > > > +		.channels_min = HDA_STEREO,
> > > > +		.channels_max = HDA_STEREO,
> > > > +		.rates = SNDRV_PCM_RATE_48000,
> > > > +		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> > > > +	},
> > > 
> > > Are there no S32_LE support at all for all dais?
> > No, just 16 and 24 bits :)
> 
> Hm, so this restriction remains also for decoupled from DSP?
Yes it is the DSP which is adding this restriction, we do render at 16 and
24 bits only

> All HDA codecs supports 24bit formats (in S32_LE form), but in your
> patch, 24bit format is supported only for System Capture.
This is platform params, the codec support will be in DAI params for the
codec

-- 
~Vinod
