From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] compress: add support for gapless playback
Date: Wed, 13 Feb 2013 22:33:22 +0530
Message-ID: <20130213170322.GA7777@intel.com>
References: <1360771234-13006-1-git-send-email-vinod.koul@intel.com>
 <s5hzjz8upzo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id ABDE4265248
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2013 18:04:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hzjz8upzo.wl%tiwai@suse.de>
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

On Wed, Feb 13, 2013 at 05:40:11PM +0100, Takashi Iwai wrote:
> At Wed, 13 Feb 2013 08:00:34 -0800,
> Vinod Koul wrote:
> > 
> > +static int
> > +snd_compr_get_metadata(struct snd_compr_stream *stream, unsigned long arg)
> > +{
> > +	struct snd_compr_metadata *metadata;
> > +	int retval;
> > +
> > +	if (!stream->ops->get_metadata)
> > +		return -ENXIO;
> > +
> > +	metadata = kmalloc(sizeof(*metadata), GFP_KERNEL);
> 
> There is no merit to use kmalloc just for two integers at all.
> Simply put on stack:
> 	struct snd_compr_metadata metdata;
> 	if (copy_from_user(&metadata, (void __user *)arg, sizeof(metadata)))
> 	...
while doing this I had thought on this, but my laziness got better of me :(
> 
> Ditto for snd_compr_set_metadata().
> 
> > +static int snd_compr_partial_drain(struct snd_compr_stream *stream)
> > +{
> > +	int retval;
> > +	if (stream->runtime->state == SNDRV_PCM_STATE_PREPARED ||
> > +			stream->runtime->state == SNDRV_PCM_STATE_SETUP)
> > +		return -EPERM;
> > +	/* stream can be drained only when next track has been signalled */
> > +	if (stream->next_track == false)
> > +		return -EPERM;
> > +
> > +	retval = stream->ops->trigger(stream, SND_COMPR_TRIGGER_PARTIAL_DRAIN);
> > +	if (retval)
> > +		pr_err("Partial drain returned failure\n");
> 
> I don't think it's good to spew errors.
ok
> 
> Also, the initialization of new stream fields is missing in other
> places like prepare callback?  Otherwise the values will retain.
The stream is created at open. Since it used kzalloc, these variables would be
init to false.

--
~Vinod
