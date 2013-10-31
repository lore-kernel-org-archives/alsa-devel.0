From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4] ALSA: compress: fix drain calls
 blocking	other compress functions
Date: Thu, 31 Oct 2013 12:48:14 +0530
Message-ID: <20131031071814.GF18788@intel.com>
References: <1382612851-18058-1-git-send-email-vinod.koul@intel.com>
 <1383149607-25745-1-git-send-email-vinod.koul@intel.com>
 <s5hwqktj3c1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id D5534265605
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 09:12:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwqktj3c1.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 31, 2013 at 08:40:14AM +0100, Takashi Iwai wrote:
> At Wed, 30 Oct 2013 21:43:27 +0530,
> Vinod Koul wrote:
> > 
> > The drain and drain_notify callback were blocked by low level driver untill the
> > draining was complete. Due to this being invoked with big fat mutex held, others
> > ops like reading timestamp, calling pause, drop were blocked.
> > 
> > So to fix this we add a new snd_compr_drain_notify() API. This would be required
> > to be invoked by low level driver when drain or partial drain has been completed
> > by the DSP. Thus we make the drain and partial_drain callback as non blocking
> > and driver returns immediately after notifying DSP.
> > The waiting is done while relasing the lock so that other ops can go ahead.
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > CC: stable@vger.kernel.org
> > ---
> > v4:
> >  move pr_err -> pr_debug to avoid spamming kernel log
> >  make wait in drain interruptible
> > v3:
> >  call snd_compr_drain_notify from compress_stop()
> >  rename draining -> drain_wake
> >  add some comments on state transistion after drain
> > v2:
> >  fix the 80 line warn
> >  move the state change to compress_drain()
> > 
> > 
> >  include/sound/compress_driver.h |   13 +++++++++
> >  sound/core/compress_offload.c   |   55 ++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 65 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
> > index 9031a26..e723935 100644
> > --- a/include/sound/compress_driver.h
> > +++ b/include/sound/compress_driver.h
> > @@ -48,6 +48,8 @@ struct snd_compr_ops;
> >   *	the ring buffer
> >   * @total_bytes_transferred: cumulative bytes transferred by offload DSP
> >   * @sleep: poll sleep
> > + * @wait: drain wait queue
> > + * @drain_wake: condition for drain wake
> >   */
> >  struct snd_compr_runtime {
> >  	snd_pcm_state_t state;
> > @@ -59,6 +61,8 @@ struct snd_compr_runtime {
> >  	u64 total_bytes_available;
> >  	u64 total_bytes_transferred;
> >  	wait_queue_head_t sleep;
> > +	wait_queue_head_t wait;
> 
> I took a look back at the code, and now wonder why you can't use the
> same wait queue (sleep) for drain?  PCM code uses the same waitqueue.
> 
> > +	unsigned int drain_wake;
> 
> Also, drain_wake can be omitted by checking the runtime state
> instead, e.g.
> 	wait_event_interruptible(runtime->sleep,
> 				 runtime->state != SNDRV_PCM_STATE_DRAINING);
> 
> while snd_compr_drain_notify() would be
> 
> static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
> {
> 	stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> 	wake_up(&stream->runtime->sleep);
> }
> 
> (And, if we still use drain_wake, it can be better bool instead of
> unsigned int.)
Hmmm, it started out thinking we can reuse the existing sleep but then went
ahead with a new one. I will test the changes and update this

--
~Vinod
