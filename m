From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [pulseaudio-discuss] [PATCH] alsa: Disable
 timer-scheduling for PCMs with the BATCH flag
Date: Mon, 9 Dec 2013 13:23:49 +0800
Message-ID: <CAN8cciadcWgXsDajhoyCmZUEmuA9No7OzqdVaanDmkV+j_U7oQ@mail.gmail.com>
References: <1385831244-30750-1-git-send-email-lars@metafoo.de>
 <1386327965.2937.0.camel@tkkaskin-mobl2.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com
 [209.85.223.177])
 by alsa0.perex.cz (Postfix) with ESMTP id E66DD262634
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 06:23:50 +0100 (CET)
Received: by mail-ie0-f177.google.com with SMTP id tp5so5313365ieb.22
 for <alsa-devel@alsa-project.org>; Sun, 08 Dec 2013 21:23:49 -0800 (PST)
In-Reply-To: <1386327965.2937.0.camel@tkkaskin-mobl2.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

2013/12/6 Tanu Kaskinen <tanu.kaskinen@linux.intel.com>

> On Sat, 2013-11-30 at 18:07 +0100, Lars-Peter Clausen wrote:
> > PCM Devices which have the BATCH flag set update the PCM pointer only
> with
> > period size granularity. Using timer based scheduling does not have any
> > advantage in this mode. For one devices which have that flag set usually
> update
> > the position pointer in software after getting the period interrupt. So
> > disabling the period interrupt is not possible for this kind of devices.
> > Furthermore writing to or reading from the buffer slice for the current
> period
> > is not possible since the position inside the buffer is not known. On
> the other
> > hand the tsched algorithm seems to get easily confused for this kind of
> > hardware, which results in garbled audio output. This typically means
> that timer
> > based scheduling needs to be manually disabled on systems with such
> devices.
> > Auto disabling tsched in this case allows these systems to run with the
> default
> > configuration.
> >
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> >  src/modules/alsa/alsa-util.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/src/modules/alsa/alsa-util.c b/src/modules/alsa/alsa-util.c
> > index 75f5858..4b24e47 100644
> > --- a/src/modules/alsa/alsa-util.c
> > +++ b/src/modules/alsa/alsa-util.c
> > @@ -245,6 +245,10 @@ int pa_alsa_set_hw_params(
> >      if (!pa_alsa_pcm_is_hw(pcm_handle))
> >          _use_tsched = false;
> >
> > +    /* The PCM pointer is only updated with period granularity */
> > +    if (snd_pcm_hw_params_is_batch(hwparams))
> > +        _use_tsched = false;
> > +
> >  #if (SND_LIB_VERSION >= ((1<<16)|(0<<8)|24)) /* API additions in 1.0.24
> */
> >      if (_use_tsched) {
> >
>
> Thanks! I applied the patch.
>
> --
>

Are you patch sufficient ?

In alsa-lib , snd_pcm_sw_params_set_avail_min always return zero

int snd_pcm_sw_params_set_avail_min(snd_pcm_t *pcm, snd_pcm_sw_params_t
*params, snd_pcm_uframes_t val)
{
         assert(pcm && params);
         /* Fix avail_min if it's below period size.  The period_size
          * defines the minimal wake-up timing accuracy, so it doesn't
          * make sense to set below that.
          */
         if (val < pcm->period_size)
                 val = pcm->period_size;
         params->avail_min = val;
         return 0;
}


http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/src/modules/alsa/alsa-sink.c?id=26a270a934f0f174f7bd7eb89e85301963721deb

/* We need at last one frame in the used part of the buffer */
- avail_min = (snd_pcm_uframes_t) u->hwbuf_unused_frames + 1;
+ avail_min = (snd_pcm_uframes_t) u->hwbuf_unused / u->frame_size + 1;

do pulseaudio need to keep at least one periods instead of more than 1
frames for those driver which update hwptr in periods ?
