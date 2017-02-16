From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH] ALSA: x86: Fix spinlock usage in the
	trigger callback
Date: Thu, 16 Feb 2017 16:46:16 +0200
Message-ID: <20170216144616.GB31595@intel.com>
References: <20170215191550.8790-1-ville.syrjala@linux.intel.com>
 <s5hefyzw3p7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EDA5266D6B
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 15:46:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hefyzw3p7.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 15, 2017 at 10:21:08PM +0100, Takashi Iwai wrote:
> On Wed, 15 Feb 2017 20:15:50 +0100,
> ville.syrjala@linux.intel.com wrote:
> > =

> > From: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> > =

> > Simply doing 'xset dpms force off' while playback is active seems
> > sufficient to anger lockdep [1]. And it's of course correct that it's
> > not safe to use regular spin_lock() outside the irq handler when
> > the irq handler also wants to acquire the same lock. I believe the
> > trigger callback can get called from both irq and non-irq context,
> > so we need to to use spin_lock_irqsave() & co. here.
> =

> No, it's just because I used snd_pcm_stop() wrongly.  A proper fix
> patch is already in the queue I'm going to submit right now:
>   [PATCH 2/8] ALSA: x86: Use snd_pcm_stop_xrun() for connection /
>     disconnection paths

OK, cool. I'll have to try this again once I see that land somewhere.

>  =

> =

> thanks,
> =

> Takashi
> =

> =

> =

> > =

> > The whole locking here looks somewhat suspicious, but I don't feel
> > like digging into further, so here's just the minimal fix.
> > =

> > [1]
> > [  168.303913] [drm:ilk_audio_codec_disable [i915]] Disable audio codec=
 on port B, pipe B
> > [  168.306245] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [  168.311110] [ INFO: inconsistent lock state ]
> > [  168.315975] 4.10.0-rc8-ffrd+ #698 Tainted: G        W
> > [  168.322198] ---------------------------------
> > [  168.327062] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
> > [  168.333773] kworker/2:1/44 [HC0[0]:SC0[0]:HE1:SE1] takes:
> > [  168.339802]  (&(&ctx->had_spinlock)->rlock){?.-...}, at: [<ffffffffa=
02c67e0>] had_pcm_trigger+0x60/0x160 [snd_hdmi_lpe_audio]
> > [  168.352449] {IN-HARDIRQ-W} state was registered at:
> > [  168.357901]   __lock_acquire+0x7b2/0x16c0
> > [  168.362378]   lock_acquire+0xba/0x220
> > [  168.366468]   _raw_spin_lock_irqsave+0x47/0x60
> > [  168.371431]   had_substream_get+0x23/0x50 [snd_hdmi_lpe_audio]
> > [  168.377950]   display_pipe_interrupt_handler+0x78/0x1a0 [snd_hdmi_lp=
e_audio]
> > [  168.385828]   __handle_irq_event_percpu+0x3f/0x3a0
> > [  168.391180]   handle_irq_event_percpu+0x24/0x60
> > [  168.396239]   handle_irq_event+0x3a/0x60
> > [  168.400619]   handle_simple_irq+0x79/0xa0
> > [  168.405096]   generic_handle_irq+0x22/0x30
> > [  168.409718]   intel_lpe_audio_irq_handler+0x24/0x80 [i915]
> > [  168.415878]   valleyview_irq_handler+0x1da/0x230 [i915]
> > [  168.421715]   __handle_irq_event_percpu+0x3f/0x3a0
> > [  168.427067]   handle_irq_event_percpu+0x24/0x60
> > [  168.432126]   handle_irq_event+0x3a/0x60
> > [  168.436505]   handle_edge_irq+0x94/0x150
> > [  168.440886]   handle_irq+0xb3/0x190
> > [  168.444781]   do_IRQ+0x69/0x130
> > [  168.448287]   ret_from_intr+0x0/0x19
> > [  168.452280]   cpuidle_enter_state+0xdb/0x360
> > [  168.457047]   cpuidle_enter+0x17/0x20
> > [  168.461136]   call_cpuidle+0x23/0x40
> > [  168.465126]   do_idle+0x18a/0x200
> > [  168.468826]   cpu_startup_entry+0x1d/0x30
> > [  168.473303]   rest_init+0x12c/0x140
> > [  168.477200]   start_kernel+0x402/0x40f
> > [  168.481385]   x86_64_start_reservations+0x2a/0x2c
> > [  168.486640]   x86_64_start_kernel+0xea/0xed
> > [  168.491313]   verify_cpu+0x0/0xfc
> > [  168.495012] irq event stamp: 28481
> > [  168.498810] hardirqs last  enabled at (28481): [<ffffffff8167feac>] =
_raw_spin_unlock_irq+0x2c/0x60
> > [  168.508824] hardirqs last disabled at (28480): [<ffffffff8167fcc8>] =
_raw_spin_lock_irq+0x18/0x60
> > [  168.518645] softirqs last  enabled at (28442): [<ffffffff815d6cf9>] =
neigh_periodic_work+0x219/0x320
> > [  168.528755] softirqs last disabled at (28438): [<ffffffff815d6b19>] =
neigh_periodic_work+0x39/0x320
> > [  168.538767]
> >                other info that might help us debug this:
> > [  168.546052]  Possible unsafe locking scenario:
> > =

> > [  168.552664]        CPU0
> > [  168.555390]        ----
> > [  168.558116]   lock(&(&ctx->had_spinlock)->rlock);
> > [  168.563371]   <Interrupt>
> > [  168.566291]     lock(&(&ctx->had_spinlock)->rlock);
> > [  168.571741]
> >                 *** DEADLOCK ***
> > =

> > [  168.578355] 3 locks held by kworker/2:1/44:
> > [  168.583025]  #0:  ("events"){.+.+.+}, at: [<ffffffff810a467f>] proce=
ss_one_work+0x15f/0x6e0
> > [  168.592357]  #1:  ((&ctx->hdmi_audio_wq)){+.+.+.}, at: [<ffffffff810=
a467f>] process_one_work+0x15f/0x6e0
> > [  168.602959]  #2:  (&ctx->mutex){+.+.+.}, at: [<ffffffffa02c6ee8>] ha=
d_audio_wq+0x48/0x6de [snd_hdmi_lpe_audio]
> > [  168.614145]
> >                stack backtrace:
> > [  168.619011] CPU: 2 PID: 44 Comm: kworker/2:1 Tainted: G        W    =
   4.10.0-rc8-ffrd+ #698
> > [  168.628441] Hardware name: Intel Corp. VALLEYVIEW C0 PLATFORM/BYT-T =
FFD8, BIOS BLAKFF81.X64.0088.R10.1403240443 FFD8_X64_R_2014_13_1_00 03/24/2=
014
> > [  168.643111] Workqueue: events had_audio_wq [snd_hdmi_lpe_audio]
> > [  168.649725] Call Trace:
> > [  168.652448]  dump_stack+0x67/0x90
> > [  168.656149]  print_usage_bug+0x20b/0x210
> > [  168.660530]  mark_lock+0x648/0x6c0
> > [  168.664328]  ? print_shortest_lock_dependencies+0x1d0/0x1d0
> > [  168.670553]  __lock_acquire+0x638/0x16c0
> > [  168.674935]  lock_acquire+0xba/0x220
> > [  168.678929]  ? had_pcm_trigger+0x60/0x160 [snd_hdmi_lpe_audio]
> > [  168.685447]  _raw_spin_lock+0x3f/0x50
> > [  168.689536]  ? had_pcm_trigger+0x60/0x160 [snd_hdmi_lpe_audio]
> > [  168.696054]  had_pcm_trigger+0x60/0x160 [snd_hdmi_lpe_audio]
> > [  168.702383]  snd_pcm_do_stop+0x45/0x50 [snd_pcm]
> > [  168.707545]  snd_pcm_action_single+0x32/0x80 [snd_pcm]
> > [  168.713289]  snd_pcm_action+0x118/0x120 [snd_pcm]
> > [  168.718549]  snd_pcm_stop+0x1a/0x20 [snd_pcm]
> > [  168.723415]  had_audio_wq+0x35e/0x6de [snd_hdmi_lpe_audio]
> > [  168.729545]  process_one_work+0x1eb/0x6e0
> > [  168.734022]  ? process_one_work+0x15f/0x6e0
> > [  168.738693]  worker_thread+0x4f/0x4a0
> > [  168.742781]  ? schedule+0x4a/0x90
> > [  168.746483]  ? preempt_count_sub+0xa6/0x110
> > [  168.751154]  kthread+0x10e/0x150
> > [  168.754757]  ? apply_wqattrs_commit+0x90/0x90
> > [  168.759621]  ? kthread_create_on_node+0x40/0x40
> > [  168.764681]  ? umh_complete+0x30/0x30
> > [  168.768770]  ? call_usermodehelper_exec_async+0x13a/0x150
> > [  168.774802]  ret_from_fork+0x2e/0x40
> > [  168.779412] [drm:intel_disable_pipe [i915]] disabling pipe B
> > =

> > Cc: Takashi Iwai <tiwai@suse.de>
> > Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Signed-off-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> > ---
> >  sound/x86/intel_hdmi_audio.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > =

> > diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
> > index c0a080e5d1f4..2748766b3f25 100644
> > --- a/sound/x86/intel_hdmi_audio.c
> > +++ b/sound/x86/intel_hdmi_audio.c
> > @@ -1154,6 +1154,7 @@ static int had_pcm_hw_free(struct snd_pcm_substre=
am *substream)
> >  static int had_pcm_trigger(struct snd_pcm_substream *substream, int cm=
d)
> >  {
> >  	int retval =3D 0;
> > +	unsigned long flags;
> >  	struct snd_intelhad *intelhaddata;
> >  =

> >  	intelhaddata =3D snd_pcm_substream_chip(substream);
> > @@ -1180,12 +1181,12 @@ static int had_pcm_trigger(struct snd_pcm_subst=
ream *substream, int cmd)
> >  	case SNDRV_PCM_TRIGGER_STOP:
> >  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> >  	case SNDRV_PCM_TRIGGER_SUSPEND:
> > -		spin_lock(&intelhaddata->had_spinlock);
> > +		spin_lock_irqsave(&intelhaddata->had_spinlock, flags);
> >  =

> >  		/* Stop reporting BUFFER_DONE/UNDERRUN to above layers */
> >  =

> >  		intelhaddata->stream_info.running =3D false;
> > -		spin_unlock(&intelhaddata->had_spinlock);
> > +		spin_unlock_irqrestore(&intelhaddata->had_spinlock, flags);
> >  		/* Disable Audio */
> >  		had_enable_audio(intelhaddata, false);
> >  		/* Reset buffer pointers */
> > -- =

> > 2.10.2
> > =


-- =

Ville Syrj=E4l=E4
Intel OTC
