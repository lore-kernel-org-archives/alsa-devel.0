From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Re: Power management state flow in ALSA
Date: Wed, 30 May 2007 16:16:35 +0530
Message-ID: <8d6898730705300346n2a6d4c8by8bd7fe84b273ced3@mail.gmail.com>
References: <8d6898730705292322w2dbf2a2fu4761370c4cc7ea16@mail.gmail.com>
	<s5h8xb6hbzd.wl%tiwai@suse.de>
	<8d6898730705300306g3f32f5e8yad6770a4eee1851a@mail.gmail.com>
	<s5h4pluhajo.wl%tiwai@suse.de>
	<8d6898730705300336l4db252e6pa4b7b257de4ed6eb@mail.gmail.com>
	<s5h1wgyh9yj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AFC224460
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2007 12:46:36 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id j2so890160nzf
	for <alsa-devel@alsa-project.org>; Wed, 30 May 2007 03:46:36 -0700 (PDT)
In-Reply-To: <s5h1wgyh9yj.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It is there in kernel see the file sound/core/pcm_native.c. but it is
static, not exported.


So no driver can call directly, may be only Ioctl.
I got it.


#ifdef CONFIG_PM
/* resume */

static int snd_pcm_pre_resume(struct snd_pcm_substream *substream, int state)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	if (!(runtime->info & SNDRV_PCM_INFO_RESUME))
		return -ENOSYS;
	runtime->trigger_master = substream;
	return 0;
}

static int snd_pcm_do_resume(struct snd_pcm_substream *substream, int state)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	if (runtime->trigger_master != substream)
		return 0;
	/* DMA not running previously? */
	if (runtime->status->suspended_state != SNDRV_PCM_STATE_RUNNING &&
	    (runtime->status->suspended_state != SNDRV_PCM_STATE_DRAINING ||
	     substream->stream != SNDRV_PCM_STREAM_PLAYBACK))
		return 0;
	return substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_RESUME);
}

static void snd_pcm_undo_resume(struct snd_pcm_substream *substream, int state)
{
	if (substream->runtime->trigger_master == substream &&
	    snd_pcm_running(substream))
		substream->ops->trigger(substream, SNDRV_PCM_TRIGGER_SUSPEND);
}

static void snd_pcm_post_resume(struct snd_pcm_substream *substream, int state)
{
	struct snd_pcm_runtime *runtime = substream->runtime;
	snd_pcm_trigger_tstamp(substream);
	if (substream->timer)
		snd_timer_notify(substream->timer, SNDRV_TIMER_EVENT_MRESUME,
				 &runtime->trigger_tstamp);
	runtime->status->state = runtime->status->suspended_state;
	if (runtime->sleep_min)
		snd_pcm_tick_prepare(substream);
}

static struct action_ops snd_pcm_action_resume = {
	.pre_action = snd_pcm_pre_resume,
	.do_action = snd_pcm_do_resume,
	.undo_action = snd_pcm_undo_resume,
	.post_action = snd_pcm_post_resume
};

static int snd_pcm_resume(struct snd_pcm_substream *substream)
{
	struct snd_card *card = substream->pcm->card;
	int res;

	snd_power_lock(card);
	if ((res = snd_power_wait(card, SNDRV_CTL_POWER_D0)) >= 0)
		res = snd_pcm_action_lock_irq(&snd_pcm_action_resume, substream, 0);
	snd_power_unlock(card);
	return res;
}

#else

static int snd_pcm_resume(struct snd_pcm_substream *substream)
{
	return -ENOSYS;
}

#endif /* CONFIG_PM */


On 5/30/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 30 May 2007 16:06:54 +0530,
> Nobin Mathew wrote:
> >
> > Sorry for my blunders.
> >
> > driver resume () is not calling snd_pcm_resume().
>
> As I wrote: *alsa-lib* snd_pcm_resume() function.
> It's no function in the kernel.
>
>
> Takashi
>
> >
> > Suspend only calls snd_pcm_suspend ().
> >
> > I am writing an ASoC driver, where i can place these calls
> >
> > snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
> > snd_pcm_suspend_all(chip->pcm[i]);
> >
> > and snd_power_change_state(card, SNDRV_CTL_POWER_D0);
> >
> >
> > In soc-core.c ?
> >
> >
> >
> > On 5/30/07, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Wed, 30 May 2007 15:36:33 +0530,
> > > Nobin Mathew wrote:
> > > >
> > > > In suspend () the application is dead (freezed state) before ALSA
> > > > driver suspend() is called, so in this there is no way application
> > > > will get to know the SUSPENDED state of driver.
> > > >
> > > >
> > > > In resume () ALSA driver resume () (changes the state of driver) is
> > > > called first and then applications are activated.
> > > >
> > > > So how the application will get to know the SUSPENDED state of driver
> > > > through syscall.No syscall () from ALSA apps(freezed) is happening
> > > > during the SUSPENDED duration of ALSA driver.
> > >
> > > Your app shall issue syscalls sooner or later, otherwise you'll have
> > > no I/O :)
> > >
> > > The concept of the (PCM) resume in ALSA is a passive way.  The driver
> > > does _NOT_ resume streams by itself.  It waits until the app requests
> > > to resume.  This is designed so because usually the hardware cannot be
> > > recovered in 100% identical state as before, and often the app needs
> > > to reset something for the proper restart.
> > >
> > > So, when resume callback is executed and the whole kernel PM thing is
> > > finished, the user-process restarts again.  Then it issues syscalls,
> > > and gets to know to know that the stream is in the suspended state.
> > > Now it calls alsa-lib snd_pcm_resume() function which issues RESUME
> > > ioctl to restart.
> > >
> > >
> > > Takashi
> > >
> > > >
> > > >
> > > >
> > > > On 5/30/07, Takashi Iwai <tiwai@suse.de> wrote:
> > > > > At Wed, 30 May 2007 11:52:31 +0530,
> > > > > Nobin Mathew wrote:
> > > > > >
> > > > > > I am having a doubt regarding ALSA power management.
> > > > > >
> > > > > > My understanding of APM suspend() is like this.
> > > > > >
> > > > > > Freeze the ALSA apps
> > > > > >
> > > > > > Call ALSA driver suspend ()
> > > > > >
> > > > > > in the ALSA suspend() function it saves the current state of substream
> > > > > > and changes the state of substream to SUSPENDED.
> > > > > >
> > > > > > My understanding of APM resume() is like this
> > > > > >
> > > > > > Call ALSA driver resume ()
> > > > > >
> > > > > > Activate the ALSA apps
> > > > > >
> > > > > > In ALSA resume function it restores the saved state of substream.
> > > > > >
> > > > > >
> > > > > > So my question is when ALSA app will get to know the SUSPENDED state
> > > > > > of substream.???
> > > > >
> > > > > When issuing any syscalls.  Then you'll get ESTRPIPE error, which
> > > > > indicitaes the stream is in the SUSPEND state.
> > > > >
> > > > >
> > > > > Takashi
> > > > >
> > > >
> > >
> >
>
