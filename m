From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: another locking issue with nonatomic ops?
Date: Tue, 16 Feb 2016 22:10:08 +0530
Message-ID: <20160216164008.GY19598@localhost>
References: <20160216153711.GW19598@localhost> <s5h8u2k7ifz.wl-tiwai@suse.de>
 <20160216161043.GX19598@localhost> <s5h37ss7h8f.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 839D92606C3
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 17:36:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h37ss7h8f.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 16, 2016 at 05:27:44PM +0100, Takashi Iwai wrote:
> On Tue, 16 Feb 2016 17:10:43 +0100,
> Vinod Koul wrote:
> > 
> > On Tue, Feb 16, 2016 at 05:01:36PM +0100, Takashi Iwai wrote:
> > > On Tue, 16 Feb 2016 16:37:11 +0100,
> > > Vinod Koul wrote:
> > > > 
> > > > 
> > > > Hi Takashi,
> > > > 
> > > > We found another issue with non atomic ops.
> > > > 
> > > > This occurs when we have snd_pcm_do_prepare being invoked which acquires
> > > > the lock snd_pcm_link_rwsem twice, first in snd_pcm_common_ioctl1, and then again in
> > > > dpcm_dapm_stream_event. Normally this is fine, but if we have another stream
> > > > get closed in between two read accesses we get stuck.
> > > > 
> > > > First thread:
> > > > 
> > > > [  419.657259] AudioOut_2      D ffff8800704a3a60     0  3691      1	0x20020004
> > > > [  419.665946]  ffff8800704a3a60 00000000704a3a60 ffff88006d1fddd0 ffffffff8252ffd8
> > > > [  419.674678]  ffff8800704a4000 ffffffff8252ffc0 ffffffffffffffff ffffffff8252ffd8
> > > > [  419.683513]  0000000000000000 ffff8800704a3a80 ffffffff81ca2987 ffffffffffffffff
> > > > [  419.683574] Call Trace:
> > > > [  419.692290]  [<ffffffff81ca2987>] schedule+0x37/0x90
> > > > [  419.692306]  [<ffffffff81ca6f6d>] rwsem_down_read_failed+0xdd/0x130
> > > > [  419.701050]  [<ffffffff814df454>] call_rwsem_down_read_failed+0x14/0x30
> > > > [  419.709758]  [<ffffffff810e793b>] ? down_read_nested+0x5b/0x70
> > > > [  419.709805]  [<ffffffff81adfda9>] ? snd_pcm_stream_lock+0xa9/0x120
> > > > [  419.723012]  [<ffffffff81adfda9>] snd_pcm_stream_lock+0xa9/0x120
> > > > 
> > > > < ============     2nd Read lock is acquired here, without releasing previous one.
> > > > 
> > > > [  419.723026]  [<ffffffff81adfe4c>] snd_pcm_stream_lock_irq+0x2c/0x30
> > > > [  419.731801]  [<ffffffff81b01f5e>] ? dpcm_dapm_stream_event+0xbe/0xd0
> > > > [  419.740565]  [<ffffffff81b0079c>] dpcm_set_fe_update_state+0x3c/0xb0
> > > > [  419.749252]  [<ffffffff81b04514>] dpcm_fe_dai_prepare+0xc4/0x150
> > > > [  419.749301]  [<ffffffff81adf7eb>] snd_pcm_do_prepare+0x1b/0x30
> > > > [  419.758083]  [<ffffffff81adf3bf>] snd_pcm_action_single+0x2f/0x70
> > > > [  419.766897]  [<ffffffff81ca6827>] ? down_read+0x47/0x60
> > > > [  419.766962]  [<ffffffff81adf577>] ? snd_pcm_action_nonatomic+0x27/0x80
> > > > [  419.775565]  [<ffffffff81adf5c6>] snd_pcm_action_nonatomic+0x76/0x80
> > > > 
> > > > < ============     1st Read lock is acquired here
> > > > 
> > > > [  419.784419]  [<ffffffff81ae2c62>] snd_pcm_common_ioctl1+0x802/0xd30
> > > > [  419.784495]  [<ffffffff81ae332b>] snd_pcm_playback_ioctl1+0x19b/0x280
> > > > [  419.793106]  [<ffffffff81230915>] ? __fget+0x5/0x210
> > > > [  419.801943]  [<ffffffff81ae3dca>] snd_pcm_ioctl_compat+0x41a/0x770
> > > > [  419.801959]  [<ffffffff81230915>] ? __fget+0x5/0x210
> > > > [  419.810793]  [<ffffffff8126d670>] compat_SyS_ioctl+0xd0/0x13b0
> > > > [  419.819491]  [<ffffffff81ca7bc4>] ? do_nanosleep+0x94/0x190
> > > > [  419.819535]  [<ffffffff810eb696>] ? trace_hardirqs_on_caller+0x16/0x210
> > > > [  419.828306]  [<ffffffff814df4f8>] ? trace_hardirqs_on_thunk+0x17/0x19
> > > > [  419.837104]  [<ffffffff81cabf0e>] sysenter_dispatch+0x7/0x1f
> > > > 
> > > > 
> > > > Second thread:
> > > > [  419.543062] mediaserver     D ffff880170957cd8     0  3690      1	0x20020004
> > > > [  419.543191]  ffff880170957cd8 0000000070957cd8 ffff88006de49ad0 ffffffff8252ffd8
> > > > [  419.551920]  ffff880170958000 ffff88006de49ad0 ffffffff8252ffc0 ffffffff00000001
> > > > [  419.560555]  ffffffff8252ffd8 ffff880170957cf8 ffffffff81ca2987 ffffffff8252ffc0
> > > > [  419.569368] Call Trace:
> > > > [  419.569392]  [<ffffffff81ca2987>] schedule+0x37/0x90
> > > > [  419.578026]  [<ffffffff81ca71f5>] rwsem_down_write_failed+0x235/0x450
> > > > [  419.586884]  [<ffffffff81ca7005>] ? rwsem_down_write_failed+0x45/0x450
> > > > [  419.586941]  [<ffffffff814df483>] call_rwsem_down_write_failed+0x13/0x20
> > > > [  419.595620]  [<ffffffff81ca689f>] ? down_write+0x5f/0x80
> > > > 
> > > > < ============     Write lock acquired here. If this occurs between two read
> > > > lock's then it's hangs
> > > 
> > > So what's wrong?  The two read locks are still running, and
> > > snd_pcm_release() waits until these two read locks are freed.
> > > The read double-locks are fine, and it's intended behavior.
> > 
> > Yes that is true
> > 
> > > The problem is apparently not there, but somewhere else.
> > > Any other thread or call involved?
> > 
> > The second backtrace above is the 2nd thread which does down_write. That
> > gets hung as 1st read lock is acquired. Since write gets higer priorty, 2nd
> > read is also stuck and we are in deadlock.
> > 
> > down_read (1st acquired)
> > 					down_write (waiting due to down_read)
> > down_read( 2nd,,, stuck)
> 
> Hmm, so down_read() takes care of the pending down_write()?
> Then it's a problem.  Maybe the limitation of the current rwsem
> implementation.

Yes that is how things seem right now.
> 
> Does the patch below work?  It's suboptimal, just a proof of concept.

Okay will try first thing tomorrow and let you know.

> ---
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index fadd3eb8e8bb..8b45edd218a4 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -1813,7 +1813,8 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
>  		res = -ENOMEM;
>  		goto _nolock;
>  	}
> -	down_write(&snd_pcm_link_rwsem);
> +	while (!down_write_trylock(&snd_pcm_link_rwsem))
> +		cpu_relax();
>  	write_lock_irq(&snd_pcm_link_rwlock);
>  	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN ||
>  	    substream->runtime->status->state != substream1->runtime->status->state ||
> @@ -1860,7 +1861,8 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
>  	struct snd_pcm_substream *s;
>  	int res = 0;
>  
> -	down_write(&snd_pcm_link_rwsem);
> +	while (!down_write_trylock(&snd_pcm_link_rwsem))
> +		cpu_relax();
>  	write_lock_irq(&snd_pcm_link_rwlock);
>  	if (!snd_pcm_stream_linked(substream)) {
>  		res = -EALREADY;

-- 
~Vinod
