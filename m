From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 07/11] ALSA: hda - add generic functions to
 set hdac stream params
Date: Tue, 14 Apr 2015 10:08:49 +0530
Message-ID: <20150414043849.GH2963@intel.com>
References: <1428842178-7105-1-git-send-email-subhransu.s.prusty@intel.com>
 <1428842178-7105-8-git-send-email-subhransu.s.prusty@intel.com>
 <s5h6190p745.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 67D672652E6
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 06:43:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h6190p745.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 13, 2015 at 02:04:10PM +0200, Takashi Iwai wrote:
> At Sun, 12 Apr 2015 18:06:14 +0530,
> Subhransu S. Prusty wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > This will be used by hda controller driver to
> > setup stream params in prepare. This function will
> > setup the bdl and periods.
> > 
> > Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  include/sound/hdaudio.h |  2 ++
> >  sound/hda/hdac_stream.c | 29 +++++++++++++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
> > index 5fc6d81..1f9f4ec 100644
> > --- a/include/sound/hdaudio.h
> > +++ b/include/sound/hdaudio.h
> > @@ -364,6 +364,8 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
> >  			  unsigned int streams);
> >  void snd_hdac_stream_timecounter_init(struct hdac_stream *azx_dev,
> >  				      unsigned int streams);
> > +int snd_set_hdac_stream_params(struct hdac_stream *azx_dev,
> > +				 unsigned int format_val);
> >  
> >  /*DSP loader functions */
> >  int snd_hdac_load_dsp_prepare(struct hdac_stream *azx_dev, unsigned int format,
> > diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
> > index 394fd15..ce25f8f 100644
> > --- a/sound/hda/hdac_stream.c
> > +++ b/sound/hda/hdac_stream.c
> > @@ -472,6 +472,35 @@ void snd_hdac_stream_sync(struct hdac_stream *azx_dev, bool start,
> >  }
> >  EXPORT_SYMBOL_GPL(snd_hdac_stream_sync);
> >  
> > +int snd_set_hdac_stream_params(struct hdac_stream *azx_dev,
> > +				 unsigned int format_val)
> 
> I'd name it a bit more consistently, e.g. snd_hdac_stream_set_format()
> or snd_hdac_stream_set_params() or so.
Ah thats a bad miss on our side, will fix in next rev
> 
> > +{
> > +
> > +	unsigned int bufsize, period_bytes;
> > +	struct snd_pcm_substream *substream = azx_dev->substream;
> > +	struct snd_pcm_runtime *runtime = substream->runtime;
> 
> I would do a NULL check for substream to be sure.
sure...

-- 
~Vinod
