From: boozer asm <asmboozer@gmail.com>
Subject: Re: memory leak in mix/pcm_upmix.c mix/pcm_downmix.c!!!
Date: Wed, 30 Aug 2017 16:28:35 +0800
Message-ID: <CAOccgsWgrC65LapcMmBmzNjgNup=z5QXP+=SR3sieYkac26zrQ@mail.gmail.com>
References: <CAOccgsWUyUujUUzeKLwXhgYG+1axUvcWtTpiWmdoZ4WH0rWqUg@mail.gmail.com>
 <s5hk21ltu5h.wl-tiwai@suse.de>
 <CAOccgsV5qoHj8bR5wsPNXieAGhCQM4dtBEWe3jE_NXxYQwcUKg@mail.gmail.com>
 <s5hlgm179ld.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 94FE426706C
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 10:28:37 +0200 (CEST)
Received: by mail-oi0-f67.google.com with SMTP id w10so5037876oie.1
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 01:28:37 -0700 (PDT)
In-Reply-To: <s5hlgm179ld.wl-tiwai@suse.de>
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

not sure what's the best place to call free.
1.
static int snd_pcm_extplug_close(snd_pcm_t *pcm)
{
    extplug_priv_t *ext = pcm->private_data;

    snd_pcm_close(ext->plug.gen.slave);
    clear_ext_params(ext);
    if (ext->data->callback->close)
    {
        ext->data->callback->close(ext->data);
    }
    if (ext->data)
         free(ext->data);
    free(ext);
    return 0;
}

2.
366 static int upmix_close(snd_pcm_extplug_t *ext)
367 {
368     snd_pcm_upmix_t *mix = (snd_pcm_upmix_t *)ext;
369     free(mix->delayline[0]);
370     free(mix->delayline[1]);
          free(mix);
371     return 0;
372 }

3. apply method in alsa-plugins/maemo/alsa-dsp.c:748:static void
alsa_dsp_descructor(void) __attribute__ ((destructor));

with each methods, there are some plugins pcm_ files affected.


2017-08-30 16:17 GMT+08:00 Takashi Iwai <tiwai@suse.de>:

> On Wed, 30 Aug 2017 09:59:59 +0200,
> boozer asm wrote:
> >
> > Hi  Takashi,
> >
> > i think mix is same as ext->data instead ext. ext is of extplug_priv_t *;
> > so it is definitely not mix which is of snd_pcm_upmix_t
> >
> >  33 struct snd_pcm_upmix {
> >  34     snd_pcm_extplug_t ext;
> >
> > typedef struct snd_pcm_extplug_priv {
> >     snd_pcm_plugin_t plug;
> >     snd_pcm_extplug_t *data;
> > between upmix and extplug_priv, there is a gap plug, which forbid ext to
> be
> > converted to mix directly.
> > so free(ext) in snd_pcm_extplug_close does NOT promise it will free mix
> too.
>
> OK, then care to submit patches?
>
>
> thanks,
>
> Takashi
>
