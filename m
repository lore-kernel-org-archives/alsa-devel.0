From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] compress: add support for gapless playback
Date: Mon, 11 Feb 2013 05:41:47 -0800
Message-ID: <20130211134147.GG3789@intel.com>
References: <1360585365-16891-1-git-send-email-vinod.koul@intel.com>
 <s5htxpjotmp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 8EC552602AD
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 15:06:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htxpjotmp.wl%tiwai@suse.de>
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
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 11, 2013 at 02:41:18PM +0100, Takashi Iwai wrote:
> At Mon, 11 Feb 2013 04:22:45 -0800,
> Vinod Koul wrote:
> > 
> (snip)
> > --- a/include/uapi/sound/asound.h
> > +++ b/include/uapi/sound/asound.h
> > @@ -271,7 +271,9 @@ typedef int __bitwise snd_pcm_state_t;
> >  #define	SNDRV_PCM_STATE_PAUSED		((__force snd_pcm_state_t) 6) /* stream is paused */
> >  #define	SNDRV_PCM_STATE_SUSPENDED	((__force snd_pcm_state_t) 7) /* hardware is suspended */
> >  #define	SNDRV_PCM_STATE_DISCONNECTED	((__force snd_pcm_state_t) 8) /* hardware is disconnected */
> > -#define	SNDRV_PCM_STATE_LAST		SNDRV_PCM_STATE_DISCONNECTED
> > +#define SNDRV_PCM_STATE_NEXT_TRACK	((__force snd_pcm_state_t) 9) /* stream will move to next track */
> 
> Isn't this better to be set as another flag instead of the trigger
> command?  This changes the runtime->state, and it may make things
> complicated.  For example, what happens if user triggers NEXT_TRACK,
> then PAUSE_PUSH and PAUSE_RELEASE?
hmmm, that makes sense. Also it would make things much easier on all the
transistions

> 
> > +#define SNDRV_PCM_STATE_PARTIAL_DRAIN	((__force snd_pcm_state_t) 10) /* stream is draining partially */
> > +#define	SNDRV_PCM_STATE_LAST		SNDRV_PCM_STATE_PARTIAL_DRAIN
> 
> Well, I'd hesitate to add this for PCM, since there is no counterpart
> for PCM (yet).  Until then, let's avoid touching the PCM API
> definition but only compress API.
If we do above then we may not need this :)

> > +/**
> > + * struct snd_compr_metadata: compressed stream metadata
> > + * @count: number of keys
> > + * @keys: pointer to count keys
> > + */
> > +struct snd_compr_metadata {
> > +	__u32 count;
> > +	struct snd_compr_keyvalue *keys;
> > +};
> 
> Do you really want that?  Then you'll have to provide 32/64bit
> ioctl conversion functions as well.  I wouldn't take that mess but let
> user repeat single key/value ioctls.
Ah, i forgot the damn pointer :-)
> 
> Instead of relying completely on the driver side implementation, you
> can keep a metadata array in snd_compr_stream or snd_compr
> internally.  Then the ioctl handler would be just like:
how do we decide the size of array and what if we have more params in future

> static int compr_stream_set_metadata(struct snd_compr_stream *stream, void __user * arg)
> {
> 	struct snd_compr_keyvalue kv;
> 
> 	if (!stream->ops->set_metadata)
> 		return -ENXIO;
> 	if (copy_from_user(&kv, arg, sizeof(kv)))
> 		return -EFAULT;
> 	if (kv > SNDRV_COMPRESS_METADATA_LAST)
> 		return -EINVAL;
> 	stream->metadata[kv.key] = kv.value;
> 	return stream->ops->set_metadata(stream);
> }
And when do we clear this? metadata for gapless, though a same stream session
gets updated for every track.

Right now I am inlcined to put a single value, and be done with it or update
older structs with bunch of padding for future use :)
> 
> Of course, this assumes that stream->metadata[] is initialized at each
> open properly.
Yes and it cant be cleared later for next track, perhpas we clear it when we get
NEXT_TRACK signalled from user space?

--
~Vinod
