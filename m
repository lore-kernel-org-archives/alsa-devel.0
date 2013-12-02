From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: soc_compress: Add set_metadata
Date: Mon, 2 Dec 2013 11:55:07 +0000
Message-ID: <20131202115507.GA10409@opensource.wolfsonmicro.com>
References: <20131125101648.GA1818@opensource.wolfsonmicro.com> <20131128061943.GS8834@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20131128061943.GS8834@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 28, 2013 at 11:49:43AM +0530, Vinod Koul wrote:
> On Mon, Nov 25, 2013 at 10:16:48AM +0000, Richard Fitzgerald wrote:
> > 
> > Pass the set_metadata() calls through to the codec driver.
> > 
> > Signed-off-by: Zhao Weijia <weijia.zhao@capelabs.com>
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > ---
> >  sound/soc/soc-compress.c |   18 +++++++++++++++++-
> >  1 files changed, 17 insertions(+), 1 deletions(-)
> > 
> > diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
> > index 53c9ecd..186802b 100644
> > --- a/sound/soc/soc-compress.c
> > +++ b/sound/soc/soc-compress.c
> > @@ -318,6 +318,21 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
> >  	mutex_unlock(&rtd->pcm_mutex);
> >  	return 0;
> >  }
> > +static int soc_compr_set_metadata(struct snd_compr_stream *cstream,
> > +			struct snd_compr_metadata *metadata)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
> > +	struct snd_soc_platform *platform = rtd->platform;
> > +
> > +	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
> > +
> > +	if (platform->driver->compr_ops && platform->driver->compr_ops->set_metadata)
> > +		 platform->driver->compr_ops->set_metadata(cstream, metadata);
> > +
> > +	mutex_unlock(&rtd->pcm_mutex);
> > +	return 0;
> > +}
> > +
> >  
> >  static int soc_compr_copy(struct snd_compr_stream *cstream,
> >  			  char __user *buf, size_t count)
> > @@ -372,7 +387,8 @@ static struct snd_compr_ops soc_compr_ops = {
> >  	.pointer	= soc_compr_pointer,
> >  	.ack		= soc_compr_ack,
> >  	.get_caps	= soc_compr_get_caps,
> > -	.get_codec_caps = soc_compr_get_codec_caps
> > +	.get_codec_caps = soc_compr_get_codec_caps,
> > +	.set_metadata = soc_compr_set_metadata,
> Sorry am confused by this and the patch description? The set_metadata call
> exists so how is this propogating to codec? Also which tree has this been
> generated against?
> 
> --
> ~Vinod
> -- 

My fault. I was sure I checked against broonie's for-next and these function were missing, but I must have checked 
against something old. Patch abandoned!
