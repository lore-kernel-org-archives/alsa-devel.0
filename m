From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 1/3] ALSA: core: let low-level driver or
 userspace disable rewinds
Date: Tue, 16 May 2017 13:10:03 +0530
Message-ID: <20170516074003.GB25195@subhransu-desktop>
References: <1494896518-23399-1-git-send-email-subhransu.s.prusty@intel.com>
 <1494896518-23399-2-git-send-email-subhransu.s.prusty@intel.com>
 <s5hk25h1h5p.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 520E3266834
 for <alsa-devel@alsa-project.org>; Tue, 16 May 2017 09:53:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk25h1h5p.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 16, 2017 at 07:53:38AM +0200, Takashi Iwai wrote:
> On Tue, 16 May 2017 03:01:56 +0200,
> Subhransu S. Prusty wrote:
> > 
> > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > 
> > Add new hw_params flag to explicitly tell driver that rewinds will never
> > be used. This can be used by low-level driver to optimize DMA operations
> > and reduce power consumption. Use this flag only when data written in
> > ring buffer will never be invalidated, e.g. any update of appl_ptr is
> > final.
> > 
> > Note that the update of appl_ptr include both a read/write data
> > operation as well as snd_pcm_forward() whose behavior is not modified.
> > 
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > ---
> >  include/sound/pcm.h         | 1 +
> >  include/uapi/sound/asound.h | 1 +
> >  sound/core/pcm_native.c     | 8 ++++++++
> >  3 files changed, 10 insertions(+)
> > 
> > diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> > index 361749e60799..a2682c5f5b72 100644
> > --- a/include/sound/pcm.h
> > +++ b/include/sound/pcm.h
> > @@ -368,6 +368,7 @@ struct snd_pcm_runtime {
> >  	unsigned int rate_num;
> >  	unsigned int rate_den;
> >  	unsigned int no_period_wakeup: 1;
> > +	unsigned int no_rewinds:1;
> >  
> >  	/* -- SW params -- */
> >  	int tstamp_mode;		/* mmap timestamp is updated */
> > diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> > index fd41697cb4d3..c697ff90450d 100644
> > --- a/include/uapi/sound/asound.h
> > +++ b/include/uapi/sound/asound.h
> > @@ -365,6 +365,7 @@ struct snd_pcm_info {
> >  #define SNDRV_PCM_HW_PARAMS_NORESAMPLE	(1<<0)	/* avoid rate resampling */
> >  #define SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER	(1<<1)	/* export buffer */
> >  #define SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP	(1<<2)	/* disable period wakeups */
> > +#define SNDRV_PCM_HW_PARAMS_NO_REWINDS	        (1<<3)	/* disable rewinds */
> >  
> >  struct snd_interval {
> >  	unsigned int min, max;
> > diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> > index 13dec5ec93f2..35dd4ca93f84 100644
> > --- a/sound/core/pcm_native.c
> > +++ b/sound/core/pcm_native.c
> > @@ -566,6 +566,8 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
> >  	runtime->no_period_wakeup =
> >  			(params->info & SNDRV_PCM_INFO_NO_PERIOD_WAKEUP) &&
> >  			(params->flags & SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP);
> > +	runtime->no_rewinds =
> > +		(params->flags & SNDRV_PCM_HW_PARAMS_NO_REWINDS) ? 1 : 0;
> >  
> >  	bits = snd_pcm_format_physical_width(runtime->format);
> >  	runtime->sample_bits = bits;
> > @@ -2439,6 +2441,9 @@ static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *subst
> >  	if (frames == 0)
> >  		return 0;
> >  
> > +	if (runtime->no_rewinds)
> > +		return 0;
> 
> I'd return an error here, because it is a clear error -- you declared
> that you won't do it but you did.

This is done based on the suggestion from Pierre:

"This forces the application to both set the NOREWIND flag 
and change the error handling code on a rewind, when the latter point is 
unnecessary. if no rewind is performed then there is no harm."

> 
> Also, I wonder whether we should add FORWARD disablement flag as
> well.  It's not needed in your case, yes, but FORWARD and REWIND
> operations are usually paired.

Either ways is ok for us. Please suggest the approach.

Regards,
Subhransu
> 
> 
> thanks,
> 
> Takashi

-- 
