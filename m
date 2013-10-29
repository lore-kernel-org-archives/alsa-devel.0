From: Vishal Agrawal <visagrawal@gmail.com>
Subject: Re: [PATCH - alsa-lib] pcm/ioplug: Add mutex in
	snd_pcm_ioplug_hw_ptr_update
Date: Tue, 29 Oct 2013 17:23:30 +0530
Message-ID: <CAKGKwYq3OnSocO9pZprMRp+yjLFTDqS3_+EMMnZ9ig6W+hGJWw@mail.gmail.com>
References: <CAKGKwYpB0BHUnPWuBH3H_agG0xF=gFoGk-siw-segP8Zk1NMFw@mail.gmail.com>
 <s5hvc0guznr.wl%tiwai@suse.de>
 <CAKGKwYpWDFZiH1SzKSSgFu=zss2UYMuX7-gZN=DjTXSeGr1=6g@mail.gmail.com>
 <s5hob68uwh4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 57E8C2608D8
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 12:53:33 +0100 (CET)
Received: by mail-wg0-f49.google.com with SMTP id x12so7936282wgg.4
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 04:53:31 -0700 (PDT)
In-Reply-To: <s5hob68uwh4.wl%tiwai@suse.de>
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

Hi Takashi,

Thanks again.
So basically it means ALSA APIs are not thread safe?

In the http://www.alsa-project.org/main/index.php/SMP_Design its mentioned
that -
"The snd_*_open() calls are thread safe. The use of returned handles must
be serialized in the application using own locking scheme. Standalone (not
handle related) functions in alsa-lib should be fully thread safe."

I could not understand what are "Standalone (not handle related) functions"?
Can you please give me an example? My understanding was apart from
snd_*_open() and snd_*_close() all other functions are thread safe.

Thanks,
Vishal Agrawal




On Tue, Oct 29, 2013 at 5:20 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 29 Oct 2013 17:09:38 +0530,
> Vishal Agrawal wrote:
> >
> > Hi Takashi,
> >
> > Thanks for the reply.
> > I saw the race between "delay" and "avail_update" function.
> > >From GStreamer stack these two function gets called from different
> threads.
> >
> > Caller is calling two different function here it doesn't know about race
> > condition.
> > And this race condition doesn't happen with HW plug-in, Its only with
> > ioplug plug-in.
>
> It doesn't justify to put the hack in ioplug plugin.
>
> The similar problem may happen in every plugin; i.e. calling these two
> in different threads aren't guaranteed to work without protection in
> the caller side.
>
>
> Takashi
>
> > Thanks,
> > Vishal Agrawal
> >
> >
> > On Tue, Oct 29, 2013 at 4:12 PM, Takashi Iwai <tiwai@suse.de> wrote:
> >
> > > At Tue, 29 Oct 2013 15:52:16 +0530,
> > > Vishal Agrawal wrote:
> > > >
> > > > Function snd_pcm_ioplug_hw_ptr_update can be called from many
> threads, we
> > > > need to protect the hw_ptr. I came across this issue with GStreamer
> and
> > > > Jackd. Function will be called from the thread doing snd_pcm_write
> and
> > > > another would be to get the playback position for the track bar.
> > > >
> > > > Change in itself is very minimum, but it took me a lot of time to
> debug.
> > >
> > > We'd like to avoid mutex in the alsa-lib code as much as possible.
> > > In which code paths did you get the race?  In general, the code paths
> > > involved with hw_ptr_update() are known to be thread-unsafe, so it's
> > > the responsibility of the caller side to protect the race.
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> > >
> > > >
> > > > Thanks,
> > > > Vishal Agrawal
> > > > [1.2  <text/html; ISO-8859-1 (quoted-printable)>]
> > > >
> > > > [2 0001-pcm-ioplug-Add-mutex-in-snd_pcm_ioplug_hw_ptr_update.patch
> > > <text/x-patch; US-ASCII (base64)>]
> > > > From b826b1f28c50bd4a414cf50751be4ac74b4e4174 Mon Sep 17 00:00:00
> 2001
> > > > From: Vishal Agrawal <visagrawal@gmail.com>
> > > > Date: Mon, 28 Oct 2013 18:01:14 +0530
> > > > Subject: [PATCH - alsa-lib] pcm/ioplug: Add mutex in
> > > >  snd_pcm_ioplug_hw_ptr_update
> > > >
> > > > snd_pcm_ioplug_hw_ptr_update() can be called from different
> > > > threads, it needs to be protected by mutex
> > > >
> > > > Signed-off-by: Vishal Agrawal <visagrawal@gmail.com>
> > > >
> > > > diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
> > > > index a90c844..23dbee3 100644
> > > > --- a/src/pcm/pcm_ioplug.c
> > > > +++ b/src/pcm/pcm_ioplug.c
> > > > @@ -26,6 +26,7 @@
> > > >   *
> > > >   */
> > > >
> > > > +#include <pthread.h>
> > > >  #include "pcm_local.h"
> > > >  #include "pcm_ioplug.h"
> > > >  #include "pcm_ext_parm.h"
> > > > @@ -47,12 +48,15 @@ typedef struct snd_pcm_ioplug_priv {
> > > >       snd_htimestamp_t trigger_tstamp;
> > > >  } ioplug_priv_t;
> > > >
> > > > +static pthread_mutex_t hw_ptr_mutex = PTHREAD_MUTEX_INITIALIZER;
> > > > +
> > > >  /* update the hw pointer */
> > > >  static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
> > > >  {
> > > >       ioplug_priv_t *io = pcm->private_data;
> > > >       snd_pcm_sframes_t hw;
> > > >
> > > > +     pthread_mutex_lock(&hw_ptr_mutex);
> > > >       hw = io->data->callback->pointer(io->data);
> > > >       if (hw >= 0) {
> > > >               unsigned int delta;
> > > > @@ -64,6 +68,7 @@ static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t
> > > *pcm)
> > > >               io->last_hw = hw;
> > > >       } else
> > > >               io->data->state = SNDRV_PCM_STATE_XRUN;
> > > > +     pthread_mutex_unlock(&hw_ptr_mutex);
> > > >  }
> > > >
> > > >  static int snd_pcm_ioplug_info(snd_pcm_t *pcm, snd_pcm_info_t *info)
> > > > --
> > > > 1.7.9.5
> > > >
> > >
> > [2  <text/html; ISO-8859-1 (quoted-printable)>]
> >
>
