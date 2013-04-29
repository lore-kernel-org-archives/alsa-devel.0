From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ALSA: compress_core: Ensure device is
	stopped when	stream closed
Date: Mon, 29 Apr 2013 10:36:30 +0100
Message-ID: <20130429093630.GB17019@opensource.wolfsonmicro.com>
References: <20130426134706.GA27501@opensource.wolfsonmicro.com>
 <20130426164255.GF24632@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 494ED2619FF
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 11:36:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130426164255.GF24632@intel.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 26, 2013 at 10:12:55PM +0530, Vinod Koul wrote:
> On Fri, Apr 26, 2013 at 02:47:06PM +0100, Richard Fitzgerald wrote:
> > If the stream state is running or paused when device file is
> > closed snd_compr_free() will send a SNDRV_PCM_TRIGGER_STOP
> > to the stream.
> > 
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> > ---
> >  sound/core/compress_offload.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> > 
> > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> > index 91e6bcb..a81c5e4 100644
> > --- a/sound/core/compress_offload.c
> > +++ b/sound/core/compress_offload.c
> > @@ -132,6 +132,11 @@ static int snd_compr_open(struct inode *inode, struct file *f)
> >  static int snd_compr_free(struct inode *inode, struct file *f)
> >  {
> >  	struct snd_compr_file *data = f->private_data;
> > +
> > +	if ((data->stream.runtime->state == SNDRV_PCM_STATE_RUNNING) ||
> > +	    (data->stream.runtime->state == SNDRV_PCM_STATE_PAUSED))
> > +		data->stream.ops->trigger(&data->stream, SNDRV_PCM_TRIGGER_STOP);
> two things:
> 1. I like Mark's idea the switch will make it look better :)
> 2. why do you want to do explicit stop when you are freeing. Esp the Paused
> cases doesnt make sense. Shouldnt the DSP be able to handle this transistion?

Userspace process might be killed, or crash, or just be bugged and we need to
protect against that. Nicer if the framework handles this instead of pushing
the problem down to every codec driver.
