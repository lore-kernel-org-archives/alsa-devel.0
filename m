From: boozer asm <asmboozer@gmail.com>
Subject: Re: memory leak in mix/pcm_upmix.c mix/pcm_downmix.c!!!
Date: Wed, 30 Aug 2017 13:55:20 +0800
Message-ID: <CAOccgsX93oB0K3tuj+Q9yCGz3q1S4rFeY_-Jgo-Qh4GX6t1N6Q@mail.gmail.com>
References: <CAOccgsWUyUujUUzeKLwXhgYG+1axUvcWtTpiWmdoZ4WH0rWqUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f43.google.com (mail-oi0-f43.google.com
 [209.85.218.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 20D05266C52
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 07:55:21 +0200 (CEST)
Received: by mail-oi0-f43.google.com with SMTP id k77so43844789oib.2
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 22:55:21 -0700 (PDT)
In-Reply-To: <CAOccgsWUyUujUUzeKLwXhgYG+1axUvcWtTpiWmdoZ4WH0rWqUg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

i notice some ioplug plugin does free. but most extplug plugin do NOT free
pointer  allocated at open function.

2017-08-30 13:51 GMT+08:00 boozer asm <asmboozer@gmail.com>:

> eg.
> in function:SND_PCM_PLUGIN_DEFINE_FUNC(upmix)
> 487     mix = calloc(1, sizeof(*mix));
> 488     if (mix == NULL)
> 489         return -ENOMEM;
>
> mix is allocated here. but at close function, it is not freed, and no
> __destructor function available to free it.
>
> and in alsa-lib/src/pcm/pcm_extplug.c
> static int snd_pcm_extplug_close(snd_pcm_t *pcm)
> {
>     extplug_priv_t *ext = pcm->private_data;
>
>     snd_pcm_close(ext->plug.gen.slave);
>     clear_ext_params(ext);
>     if (ext->data->callback->close)
>     {
>         ext->data->callback->close(ext->data);
>     }
>     free(ext);
>     return 0;
> }
> this function does NOT free ext->data.
> and
> 366 static int upmix_close(snd_pcm_extplug_t *ext)
> 367 {
> 368     snd_pcm_upmix_t *mix = (snd_pcm_upmix_t *)ext;
> 369     free(mix->delayline[0]);
> 370     free(mix->delayline[1]);
> 371     return 0;
> 372 }
>
> and this function does NOT free mix itself.
>
> so I think there is memory leak.
>
>
