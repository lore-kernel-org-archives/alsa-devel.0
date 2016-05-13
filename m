From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH] conf: don't check if config files are up
	to date
Date: Sat, 14 May 2016 04:58:57 +0500
Message-ID: <CAN_LGv24izQ_AzZ8AW_vQetgBG0XBCcfbHf5oSzYx9+jpMkVFw@mail.gmail.com>
References: <1462106622-29461-1-git-send-email-patrakov@gmail.com>
 <s5hvb2npfi2.wl-tiwai@suse.de>
 <417dae20-dfdd-69ce-f928-662be1ef92fc@gmail.com>
 <s5hwpmzbdak.wl-tiwai@suse.de> <s5hd1oq9hm7.wl-tiwai@suse.de>
 <s5hvb2i80e9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 43D06265019
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 01:58:58 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id n129so6526389wmn.1
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 16:58:58 -0700 (PDT)
In-Reply-To: <s5hvb2i80e9.wl-tiwai@suse.de>
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
Cc: Tanu Kaskinen <tanuk@iki.fi>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2016-05-13 20:04 GMT+05:00 Takashi Iwai <tiwai@suse.de>:
> On Fri, 13 May 2016 16:07:12 +0200,
> Takashi Iwai wrote:
>>
>> On Thu, 12 May 2016 15:45:23 +0200,
>> Takashi Iwai wrote:
>> >
>> > On Tue, 10 May 2016 10:40:08 +0200,
>> > Alexander E. Patrakov wrote:
>> > >
>> > > 09.05.2016 17:44, Takashi Iwai wrote:
>> > > > On Sun, 01 May 2016 14:43:42 +0200,
>> > > > Alexander E. Patrakov wrote:
>> > > >> Even if no files have been changed, the config may become outdated
>> > > >> due to hot-plugged devices.
>> > > >>
>> > > >> Note: this patch has a huge potential to crash badly-written applications
>> > > >> that keep config pointers and strings for too long. But I see no other
>> > > >> way to support hot-pluggable devices.
>> > > > Can we opt in this feature, e.g. by enabling it via some new API
>> > > > function?  Enabling this blindly appears too risky.
>> > >
>> > > Hello Takashi,
>> > >
>> > > I have read your remark, and your concern does make sense. However, I
>> > > have some doubts whether any new API is needed, and some suggestions
>> > > for further changes. Here are my ideas.
>> > >
>> > > 1. We already have such API. It is called snd_config_top(),
>> > > snd_config_update_r() and snd_pcm_open_lconf(). Would you accept a
>> > > documentation patch that says that snd_pcm_open cannot deal with
>> > > hot-plugged devices, and directs users to snd_pcm_open_lconf()? Of
>> > > course, this depends on Tanu's willingness to accept conversion to
>> > > snd_pcm_open_lconf() in PulseAudio.
>> >
>> > Yeah, it'd be good to mention there.
>> >
>> > > 2. Even if a user calls snd_pcm_open_lconf(), currently, when
>> > > attempting to figure out the driver, mixer configuration is updated
>> > > with snd_config_update() - i.e. global configuration is updated, and
>> > > this IMHO defeats the point of having a separate configuration. To fix
>> > > the bug, I would need to make sure that the mixer configuration is
>> > > read from the same snd_config_t structure that was passed to
>> > > snd_pcm_open_lconf(). I am not sure about the difficulty of this task.
>> > >
>> > > 3. One of my early attempts of the patch (without the hunk about
>> > > snd_ctl_open_lconf()) was crashing due to bad pointers. Now I realize
>> > > that it is already a bug in alsa-lib - the current code would crash,
>> > > too, if the configuration file has changed between the calls to
>> > > snd_pcm_update() in snd_pcm_open() and in snd_ctl_open() (which is
>> > > called from a hook that determines the driver). Again, I would need to
>> > > make sure that the mixer configuration is read from the same
>> > > snd_config_t structure that was passed to snd_pcm_open_noupdate(), see
>> > > above.
>> >
>> > Right.  The crash doesn't happen so often because the update of config
>> > tree doesn't happen also so often.
>> >
>> > > 4. I still think that the file mtime check in snd_config_update_r does
>> > > not make any sense. It fails to notice changes in included files, as
>> > > well as in the list of plugged-in devices. In other words, it never
>> > > worked except for the initial read, and it's too risky to make it
>> > > actually work as documented. How about making it read the
>> > > configuration from files only on the first call for a given config,
>> > > even if they have changed?
>> >
>> > Yes, that sounds more reasonable as a first move.  It doesn't work
>> > 100% reliably, and if you really want a proper update, you can do it
>> > by calling snd_config_update_free_global() beforehand.
>> >
>> > There is a minimal protection by pthread mutex in conf.c, but it's
>> > only at regenerating the config tree.  We need refcounting by
>> > referrer for a proper protection.  Once after having the refcount
>> > protection, we can safely update the config tree unconditionally.
>>
>> So here is a quick hack.  It adds a simple refcount in snd_config_t.
>> snd_config_update_get() gives a top config with a refcount so that it
>> won't be deleted until disposed by snd_config_put().
>>
>> In this patch, the config update itself is kept in traditional way,
>> i.e. lazy update with mtime check.  For the forced refresh, I added
>> snd_config_refresh() which removes snd_config_global_update so that at
>> the next snd_config_update() will reread properly.  PA can call this
>> function appropriately, e.g. when hotplugged.
>>
>> The patch is just a proof of concept and even untested.  Once when
>> confirmed that it's the way to go, I'll cook up more.
>
> There was a typo indeed.  The revised patch is below.
> aplay worked at least :)  And now it has comments.

I will test it tomorrow.

However, now (it's 04:51 localtime, and I still can't sleep) I can't
understand whether snd_config_refresh() can be called safely at all
when something is playing to a hooks pcm with "ctl_elems" type (and
that use case is important for PulseAudio). Are the names of the
controls copied from the config with something like strdup (then it's
OK), or just point to a live structure that you are about to refresh?

P.S. The same objection, of course, applies to my original patch.

>
>
> Takashi
>
> ---
> diff --git a/include/conf.h b/include/conf.h
> index 087c05dc6bcf..72fd7c06a8d9 100644
> --- a/include/conf.h
> +++ b/include/conf.h
> @@ -94,6 +94,10 @@ int snd_config_update_r(snd_config_t **top, snd_config_update_t **update, const
>  int snd_config_update_free(snd_config_update_t *update);
>  int snd_config_update_free_global(void);
>
> +void snd_config_refresh(void);
> +int snd_config_update_get(snd_config_t **top);
> +void snd_config_put(snd_config_t *top);
> +
>  int snd_config_search(snd_config_t *config, const char *key,
>                       snd_config_t **result);
>  int snd_config_searchv(snd_config_t *config,
> diff --git a/src/conf.c b/src/conf.c
> index f8b7a6686529..1386a38b0b27 100644
> --- a/src/conf.c
> +++ b/src/conf.c
> @@ -434,6 +434,7 @@ static pthread_once_t snd_config_update_mutex_once = PTHREAD_ONCE_INIT;
>  struct _snd_config {
>         char *id;
>         snd_config_type_t type;
> +       int refcount; /* default = 0 */
>         union {
>                 long integer;
>                 long long integer64;
> @@ -1833,6 +1834,10 @@ int snd_config_remove(snd_config_t *config)
>  int snd_config_delete(snd_config_t *config)
>  {
>         assert(config);
> +       if (config->refcount > 0) {
> +               config->refcount--;
> +               return 0;
> +       }
>         switch (config->type) {
>         case SND_CONFIG_TYPE_COMPOUND:
>         {
> @@ -3851,6 +3856,60 @@ int snd_config_update(void)
>         return err;
>  }
>
> +/**
> + * \brief Clear the local config update cache
> + *
> + * This function clears the local config update cache to guarantee that
> + * the next call of #snd_config_update will reread the config files.
> + */
> +void snd_config_refresh(void)
> +{
> +       snd_config_lock();
> +       if (snd_config_global_update)
> +               snd_config_update_free(snd_config_global_update);
> +       snd_config_global_update = NULL;
> +       snd_config_unlock();
> +}
> +
> +/**
> + * \brief Updates #snd_config and take its reference.
> + * \return 0 if #snd_config was up to date, 1 if #snd_config was
> + *         updated, otherwise a negative error code.
> + *
> + * Unlike #snd_config_update, this function increases a reference counter
> + * so that the obtained tree won't be deleted until unreferenced by
> + * #snd_config_put.
> + */
> +int snd_config_update_get(snd_config_t **top)
> +{
> +       int err;
> +
> +       *top = NULL;
> +       snd_config_lock();
> +       err = snd_config_update_r(&snd_config, &snd_config_global_update, NULL);
> +       if (err >= 0) {
> +               *top = snd_config;
> +               if (*top)
> +                       (*top)->refcount++;
> +       }
> +       snd_config_unlock();
> +       return err;
> +}
> +
> +/**
> + * \brief Unreference the config tree.
> + *
> + * Decreases a reference counter of the given config tree.  This is the
> + * counterpart of #snd_config_update_get.
> + */
> +void snd_config_put(snd_config_t *cfg)
> +{
> +       snd_config_lock();
> +       if (cfg)
> +               snd_config_delete(cfg);
> +       snd_config_unlock();
> +}
> +
>  /**
>   * \brief Frees a private update structure.
>   * \param[in] update The private update structure to free.
> diff --git a/src/control/control.c b/src/control/control.c
> index 8a5d530f2674..6078189a6a70 100644
> --- a/src/control/control.c
> +++ b/src/control/control.c
> @@ -968,12 +968,16 @@ static int snd_ctl_open_noupdate(snd_ctl_t **ctlp, snd_config_t *root, const cha
>   */
>  int snd_ctl_open(snd_ctl_t **ctlp, const char *name, int mode)
>  {
> +       snd_config_t *top;
>         int err;
> +
>         assert(ctlp && name);
> -       err = snd_config_update();
> +       err = snd_config_update_get(&top);
>         if (err < 0)
>                 return err;
> -       return snd_ctl_open_noupdate(ctlp, snd_config, name, mode);
> +       err = snd_ctl_open_noupdate(ctlp, top, name, mode);
> +       snd_config_put(top);
> +       return err;
>  }
>
>  /**
> diff --git a/src/hwdep/hwdep.c b/src/hwdep/hwdep.c
> index 5dc791c99189..c8b368fa68a2 100644
> --- a/src/hwdep/hwdep.c
> +++ b/src/hwdep/hwdep.c
> @@ -168,12 +168,16 @@ static int snd_hwdep_open_noupdate(snd_hwdep_t **hwdep, snd_config_t *root, cons
>   */
>  int snd_hwdep_open(snd_hwdep_t **hwdep, const char *name, int mode)
>  {
> +       snd_config_t *top;
>         int err;
> +
>         assert(hwdep && name);
> -       err = snd_config_update();
> +       err = snd_config_update_get(&top);
>         if (err < 0)
>                 return err;
> -       return snd_hwdep_open_noupdate(hwdep, snd_config, name, mode);
> +       err = snd_hwdep_open_noupdate(hwdep, top, name, mode);
> +       snd_config_put(top);
> +       return err;
>  }
>
>  /**
> diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
> index 203e7a52491b..42da2c8a8b55 100644
> --- a/src/pcm/pcm.c
> +++ b/src/pcm/pcm.c
> @@ -2288,12 +2288,16 @@ static int snd_pcm_open_noupdate(snd_pcm_t **pcmp, snd_config_t *root,
>  int snd_pcm_open(snd_pcm_t **pcmp, const char *name,
>                  snd_pcm_stream_t stream, int mode)
>  {
> +       snd_config_t *top;
>         int err;
> +
>         assert(pcmp && name);
> -       err = snd_config_update();
> +       err = snd_config_update_get(&top);
>         if (err < 0)
>                 return err;
> -       return snd_pcm_open_noupdate(pcmp, snd_config, name, stream, mode, 0);
> +       err = snd_pcm_open_noupdate(pcmp, top, name, stream, mode, 0);
> +       snd_config_put(top);
> +       return err;
>  }
>
>  /**
> diff --git a/src/rawmidi/rawmidi.c b/src/rawmidi/rawmidi.c
> index 0c89b8b984b9..d965edaf1f42 100644
> --- a/src/rawmidi/rawmidi.c
> +++ b/src/rawmidi/rawmidi.c
> @@ -305,12 +305,16 @@ static int snd_rawmidi_open_noupdate(snd_rawmidi_t **inputp, snd_rawmidi_t **out
>  int snd_rawmidi_open(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp,
>                      const char *name, int mode)
>  {
> +       snd_config_t *top;
>         int err;
> +
>         assert((inputp || outputp) && name);
> -       err = snd_config_update();
> +       err = snd_config_update_get(&top);
>         if (err < 0)
>                 return err;
> -       return snd_rawmidi_open_noupdate(inputp, outputp, snd_config, name, mode);
> +       err = snd_rawmidi_open_noupdate(inputp, outputp, top, name, mode);
> +       snd_config_put(top);
> +       return err;
>  }
>
>  /**
> diff --git a/src/seq/seq.c b/src/seq/seq.c
> index 4405e68a7fe9..c1aa7981d557 100644
> --- a/src/seq/seq.c
> +++ b/src/seq/seq.c
> @@ -974,12 +974,16 @@ static int snd_seq_open_noupdate(snd_seq_t **seqp, snd_config_t *root,
>  int snd_seq_open(snd_seq_t **seqp, const char *name,
>                  int streams, int mode)
>  {
> +       snd_config_t *top;
>         int err;
> +
>         assert(seqp && name);
> -       err = snd_config_update();
> +       err = snd_config_update_get(&top);
>         if (err < 0)
>                 return err;
> -       return snd_seq_open_noupdate(seqp, snd_config, name, streams, mode, 0);
> +       err = snd_seq_open_noupdate(seqp, top, name, streams, mode, 0);
> +       snd_config_put(top);
> +       return err;
>  }
>
>  /**
> diff --git a/src/timer/timer.c b/src/timer/timer.c
> index a25e4f797ce4..6af6d8224df1 100644
> --- a/src/timer/timer.c
> +++ b/src/timer/timer.c
> @@ -201,12 +201,16 @@ static int snd_timer_open_noupdate(snd_timer_t **timer, snd_config_t *root, cons
>   */
>  int snd_timer_open(snd_timer_t **timer, const char *name, int mode)
>  {
> +       snd_config_t *top;
>         int err;
> +
>         assert(timer && name);
> -       err = snd_config_update();
> +       err = snd_config_update_get(&top);
>         if (err < 0)
>                 return err;
> -       return snd_timer_open_noupdate(timer, snd_config, name, mode);
> +       err = snd_timer_open_noupdate(timer, top, name, mode);
> +       snd_config_put(top);
> +       return err;
>  }
>
>  /**
> diff --git a/src/timer/timer_query.c b/src/timer/timer_query.c
> index 93d2455d07fc..23bf0711aafe 100644
> --- a/src/timer/timer_query.c
> +++ b/src/timer/timer_query.c
> @@ -159,12 +159,16 @@ static int snd_timer_query_open_noupdate(snd_timer_query_t **timer, snd_config_t
>   */
>  int snd_timer_query_open(snd_timer_query_t **timer, const char *name, int mode)
>  {
> +       snd_config_t *top;
>         int err;
> +
>         assert(timer && name);
> -       err = snd_config_update();
> +       err = snd_config_update_get(&top);
>         if (err < 0)
>                 return err;
> -       return snd_timer_query_open_noupdate(timer, snd_config, name, mode);
> +       err = snd_timer_query_open_noupdate(timer, top, name, mode);
> +       snd_config_put(top);
> +       return err;
>  }
>
>  /**



-- 
Alexander E. Patrakov
