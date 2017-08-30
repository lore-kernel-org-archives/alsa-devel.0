From: boozer asm <asmboozer@gmail.com>
Subject: Re: memory leak in mix/pcm_upmix.c mix/pcm_downmix.c!!!
Date: Wed, 30 Aug 2017 15:59:59 +0800
Message-ID: <CAOccgsV5qoHj8bR5wsPNXieAGhCQM4dtBEWe3jE_NXxYQwcUKg@mail.gmail.com>
References: <CAOccgsWUyUujUUzeKLwXhgYG+1axUvcWtTpiWmdoZ4WH0rWqUg@mail.gmail.com>
 <s5hk21ltu5h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 52CE1266A74
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 10:00:01 +0200 (CEST)
Received: by mail-oi0-f65.google.com with SMTP id t124so4987512oih.0
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 01:00:00 -0700 (PDT)
In-Reply-To: <s5hk21ltu5h.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi  Takashi,

i think mix is same as ext->data instead ext. ext is of extplug_priv_t *;
so it is definitely not mix which is of snd_pcm_upmix_t

 33 struct snd_pcm_upmix {
 34     snd_pcm_extplug_t ext;

typedef struct snd_pcm_extplug_priv {
    snd_pcm_plugin_t plug;
    snd_pcm_extplug_t *data;
between upmix and extplug_priv, there is a gap plug, which forbid ext to be
converted to mix directly.
so free(ext) in snd_pcm_extplug_close does NOT promise it will free mix too.

2017-08-30 15:02 GMT+08:00 Takashi Iwai <tiwai@suse.de>:

> On Wed, 30 Aug 2017 07:51:59 +0200,
> boozer asm wrote:
> >
> > eg.
> > in function:SND_PCM_PLUGIN_DEFINE_FUNC(upmix)
> > 487     mix = calloc(1, sizeof(*mix));
> > 488     if (mix == NULL)
> > 489         return -ENOMEM;
> >
> > mix is allocated here. but at close function, it is not freed, and no
> > __destructor function available to free it.
> >
> > and in alsa-lib/src/pcm/pcm_extplug.c
> > static int snd_pcm_extplug_close(snd_pcm_t *pcm)
> > {
> >     extplug_priv_t *ext = pcm->private_data;
> >
> >     snd_pcm_close(ext->plug.gen.slave);
> >     clear_ext_params(ext);
> >     if (ext->data->callback->close)
> >     {
> >         ext->data->callback->close(ext->data);
> >     }
> >     free(ext);
> >     return 0;
> > }
> > this function does NOT free ext->data.
> > and
> > 366 static int upmix_close(snd_pcm_extplug_t *ext)
> > 367 {
> > 368     snd_pcm_upmix_t *mix = (snd_pcm_upmix_t *)ext;
> > 369     free(mix->delayline[0]);
> > 370     free(mix->delayline[1]);
> > 371     return 0;
> > 372 }
> >
> > and this function does NOT free mix itself.
> >
> > so I think there is memory leak.
>
> It's freed in snd_pcm_extplug_close().
> mix is identical with ext in the case of upmix.
>
>
> Takashi
>
