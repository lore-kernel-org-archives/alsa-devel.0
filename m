From: Ramesh Babu <Ramesh.Babu@intel.com>
Subject: Re: another locking issue with nonatomic ops?
Date: Thu, 18 Feb 2016 15:58:22 +0530
Message-ID: <20160218102822.GA23298@rbabu-desk>
References: <20160216153711.GW19598@localhost> <s5h8u2k7ifz.wl-tiwai@suse.de>
 <20160216161043.GX19598@localhost> <s5h37ss7h8f.wl-tiwai@suse.de>
 <20160216164008.GY19598@localhost>
 <32F4D3A311A1404B92CF923AFF38C3C52E4330EA@BGSMSX104.gar.corp.intel.com>
 <32F4D3A311A1404B92CF923AFF38C3C52E433D9F@BGSMSX104.gar.corp.intel.com>
 <s5ha8mz4fd4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 231E0260476
 for <alsa-devel@alsa-project.org>; Thu, 18 Feb 2016 11:26:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5ha8mz4fd4.wl-tiwai@suse.de>
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 17, 2016 at 02:48:39PM +0100, Takashi Iwai wrote:
> On Wed, 17 Feb 2016 13:41:10 +0100,
> Babu, Ramesh wrote:
> > 
> > I verified the fix and I confirm that it resolved the race 
> > condition issue.
> 
> Good to hear.  Could you try the revised patch below?
> If it still works, give your tested-by tag, so that I can merge to
> upstream.

Yes, patch works well.
Added Tested-by tag in below patch.

> 
> 
> Takashi
> 
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: pcm: Fix rwsem deadlock for non-atomic PCM stream
> 
> A non-atomic PCM stream may take snd_pcm_link_rwsem rw semaphore twice
> in the same code path, e.g. one in snd_pcm_action_nonatomic() and
> another in snd_pcm_stream_lock().  Usually this is OK, but when a
> write lock is issued between these two read locks, the problem
> happens: the write lock is blocked due to the first reade lock, and
> the second read lock is also blocked by the write lock.  This
> eventually deadlocks.
> 
> The reason is the way rwsem manages waiters; it's queued like FIFO, so
> even if the writer itself doesn't take the lock yet, it blocks all the
> waiters (including reads) queued after it.
> 
> As a workaround, in this patch, we replace the standard down_write()
> with an spinning loop.  This is far from optimal, but it's good
> enough, as the spinning time is supposed to be relatively short for
> normal PCM operations, and the code paths requiring the write lock
> aren't called so often.
> 
> Reported-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Ramesh Babu <ramesh.babu@intel.com>
> Cc: <stable@vger.kernel.org> # v3.18+
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/pcm_native.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index fadd3eb8e8bb..9106d8e2300e 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -74,6 +74,18 @@ static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream);
>  static DEFINE_RWLOCK(snd_pcm_link_rwlock);
>  static DECLARE_RWSEM(snd_pcm_link_rwsem);
>  
> +/* Writer in rwsem may block readers even during its waiting in queue,
> + * and this may lead to a deadlock when the code path takes read sem
> + * twice (e.g. one in snd_pcm_action_nonatomic() and another in
> + * snd_pcm_stream_lock()).  As a (suboptimal) workaround, let writer to
> + * spin until it gets the lock.
> + */
> +static inline void down_write_nonblock(struct rw_semaphore *lock)
> +{
> +	while (!down_write_trylock(lock))
> +		cond_resched();
> +}
> +
>  /**
>   * snd_pcm_stream_lock - Lock the PCM stream
>   * @substream: PCM substream
> @@ -1813,7 +1825,7 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
>  		res = -ENOMEM;
>  		goto _nolock;
>  	}
> -	down_write(&snd_pcm_link_rwsem);
> +	down_write_nonblock(&snd_pcm_link_rwsem);
>  	write_lock_irq(&snd_pcm_link_rwlock);
>  	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN ||
>  	    substream->runtime->status->state != substream1->runtime->status->state ||
> @@ -1860,7 +1872,7 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
>  	struct snd_pcm_substream *s;
>  	int res = 0;
>  
> -	down_write(&snd_pcm_link_rwsem);
> +	down_write_nonblock(&snd_pcm_link_rwsem);
>  	write_lock_irq(&snd_pcm_link_rwlock);
>  	if (!snd_pcm_stream_linked(substream)) {
>  		res = -EALREADY;
> -- 
> 2.7.1
> 

-- 
