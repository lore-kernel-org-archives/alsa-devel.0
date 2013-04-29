From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: compress: fix the states to check
	for allowing	read
Date: Mon, 29 Apr 2013 10:29:00 +0100
Message-ID: <20130429092900.GA17019@opensource.wolfsonmicro.com>
References: <1367136322-24531-1-git-send-email-vinod.koul@intel.com>
 <s5hmwsh1ztj.wl%tiwai@suse.de> <20130429084531.GJ24632@intel.com>
 <s5hehdt1ymt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66388261A08
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 11:29:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hehdt1ymt.wl%tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 29, 2013 at 11:20:42AM +0200, Takashi Iwai wrote:
> At Mon, 29 Apr 2013 14:15:31 +0530,
> Vinod Koul wrote:
> > 
> > On Mon, Apr 29, 2013 at 10:55:04AM +0200, Takashi Iwai wrote:
> > > At Sun, 28 Apr 2013 13:35:22 +0530,
> > > Vinod Koul wrote:
> > > > 
> > > > for reading compressed data, we need to allow when we are paused, draining or
> > > > stopped.
> > > > 
> > > > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > > > Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > > > Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > > > 
> > > > ---
> > > >  sound/core/compress_offload.c |   10 ++++++++--
> > > >  1 files changed, 8 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> > > > index a0bc47f..5389b9a 100644
> > > > --- a/sound/core/compress_offload.c
> > > > +++ b/sound/core/compress_offload.c
> > > > @@ -311,8 +311,14 @@ static ssize_t snd_compr_read(struct file *f, char __user *buf,
> > > >  	stream = &data->stream;
> > > >  	mutex_lock(&stream->device->lock);
> > > >  
> > > > -	/* read is allowed when stream is running */
> > > > -	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
> > > > +	/* read is allowed when stream is running, paused, draining and setup
> > > > +	 * (yes setup is state which we transistion to after stop, so if user
> > > > +	 * wants to read data after stop we allow that
> > > > +	 */
> > > > +	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING ||
> > > > +			stream->runtime->state != SNDRV_PCM_STATE_DRAINING ||
> > > > +			stream->runtime->state != SNDRV_PCM_STATE_PAUSED ||
> > > > +			stream->runtime->state != SNDRV_PCM_STATE_SETUP) {
> > > >  		retval = -EBADFD;
> > > 
> > > Aren't they "&&"?
> > Yup :(
> > > 
> > > Maybe better to use switch for avoiding such a trivial error...
> > I started with switch and then didnt want to code for all the PCM_STATES... but
> > yes that makes more sense, i will send that right away.
> 
> You can code like
> 	switch (stream->runtime->state) {
> 	case SNDRV_PCM_STATE_RUNNING:
> 	case SNDRV_PCM_STATE_DRAINING:
> 	case SNDRV_PCM_STATE_PAUSED:
> 	case SNDRV_PCM_STATE_SETUP:
> 		break; /* OK */
> 	default:
> 		retval = -EBADFD;
> 		break;
> 	}
> 
> 
> > Is it okay if this get in for 3.10...
> 
> Yes.  It's just a damn simple fix.
> 
> 
> thanks,
> 
> Takashi


Ok with me too.
(You beat me to it with this fix)
