From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Using snd_pcm_set_params() on a capture handle
Date: Mon, 26 Oct 2015 23:26:03 +0800
Message-ID: <CAN8ccibw4HrMp7RZYQpsSYRFc02=0pOXBj+XwCj4eUueLAfcpA@mail.gmail.com>
References: <20151025174442.b318e489f0568566a4b82908@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f178.google.com (mail-ob0-f178.google.com
 [209.85.214.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 352DF2606B5
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 16:26:05 +0100 (CET)
Received: by obbwb3 with SMTP id wb3so146037525obb.0
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 08:26:04 -0700 (PDT)
In-Reply-To: <20151025174442.b318e489f0568566a4b82908@mega-nerd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Erik de Castro Lopo <mle+la@mega-nerd.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> I've got a simple PCM capture test program below, which is basically
> a slightly tweak version of something from:
>
>     http://equalarea.com/paul/alsa-audio.html
>
>
> The program uses two different methods of setting up the capture
> handle; one that works (and is complex) and one that doesn't but
> seems like it should (and is simple). I'm trying to figure out
> why the simple one (using snd_pcm_set_params) doesn't work.
>
> The program can be compiled and run in two ways:
>
>     gcc -Wall -O2 -DUSE_SET_PARAMS=1 alsa_capture.c -lasound -o
alsa_capture
>     ./alsa_capture
>
> which fails with:
>
>     Read from audio interface failed (Input/output error)
>
> and:
>
>     gcc -Wall -O2 -DUSE_SET_PARAMS=0 alsa_capture.c -lasound -o
alsa_capture
>     ./alsa_capture
>
> which works as expected.
>
> Questions:
>
> * Is snd_pcm_set_params() supposed to work on capture handles (I've used
>   it successfully on playback handles)?
>
> * Is my use of snd_pcm_set_params() missing something and if so what?

Do your sound card driver support 0.5 second buffer?

>
> * If snd_pcm_set_params() is not supposed to work on capture handles
>   would it be possible to update the documentation to reflect that?
>
>
>         int buffer_frames = 128;
>         unsigned int rate = 44100;
>         snd_pcm_t *capture_handle;
>         snd_pcm_format_t format = SND_PCM_FORMAT_S32_LE;

>         if (USE_SET_PARAMS) {
>                 if ((err = snd_pcm_set_params (capture_handle, format,
SND_PCM_ACCESS_RW_INTERLEAVED, 2, rate, 0, 500000)) < 0) {   /* 0.5sec */
>                         printf ("Capture open error: %s\n", snd_strerror
(err)); exit (1) ;
>                 }
>         }
>         else {
>                 snd_pcm_hw_params_t *hw_params;
>
>                 if ((err = snd_pcm_hw_params_malloc (&hw_params)) < 0) {
>                         printf ("Cannot allocate hardware parameter
structure (%s)\n", snd_strerror (err)); exit (1) ;
>                 }
>
>                 if ((err = snd_pcm_hw_params_any (capture_handle,
hw_params)) < 0) {
>                         printf ("Cannot initialize hardware parameter
structure (%s)\n", snd_strerror (err)); exit (1) ;
>                 }
>
>                 if ((err = snd_pcm_hw_params_set_access (capture_handle,
hw_params, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
>                         printf ("cannot set access type (%s)\n",
snd_strerror (err)); exit (1) ;
>                 }
>
>                 if ((err = snd_pcm_hw_params_set_format (capture_handle,
hw_params, format)) < 0) {
>                         printf ("Cannot set sample format (%s)\n",
snd_strerror (err)); exit (1) ;
>                 }
>
>                 if ((err = snd_pcm_hw_params_set_rate_near
(capture_handle, hw_params, &rate, 0)) < 0) {
>                         printf ("Cannot set sample rate (%s)\n",
snd_strerror (err)); exit (1) ;
>                 }
>
>                 if ((err = snd_pcm_hw_params_set_channels
(capture_handle, hw_params, 2)) < 0) {
>                         printf ("cannot set channel count (%s)\n",
snd_strerror (err)); exit (1) ;
>                 }
>
>                 if ((err = snd_pcm_hw_params (capture_handle, hw_params))
< 0) {
>                         printf ("cannot set parameters (%s)\n",
snd_strerror (err)); exit (1) ;
>                 }

If you does not specify period, period_size or buffer size, period_time or
buffer_time before calling snd_pcm_hw_params , you have to use use those
hw_params_get_* functions after calling snd_pcm_hw_params to get back those
values

>
>         buffer = malloc (buffer_frames * snd_pcm_format_width(format) / 8
* 2);
>
>         if ((err = snd_pcm_prepare (capture_handle)) < 0) {
>                 printf ("cannot prepare audio interface for use (%s)\n",
snd_strerror (err)); exit (1) ;
>         }
>
>         for (i = 0; i < 10; ++i) {
>                 if ((err = snd_pcm_readi (capture_handle, buffer,
buffer_frames)) != buffer_frames) {
>                         printf ("Read from audio interface failed
(%s)\n", snd_strerror (err)); exit (1) ;
>                         break;
>                         }
>                 printf("read %d done\n", i);
>         }
>
