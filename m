From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
	although poll returns POLLIN event
Date: Thu, 22 Apr 2010 10:41:50 +0800
Message-ID: <v2q4f3252891004211941xcdf33e7enbda0c2a8dcfe9609@mail.gmail.com>
References: <4BCEE140.5060704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id E62F72440E
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 04:41:51 +0200 (CEST)
Received: by pvh11 with SMTP id 11so254505pvh.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Apr 2010 19:41:50 -0700 (PDT)
In-Reply-To: <4BCEE140.5060704@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/21 Stefan Schoenleitner <dev.c0debabe@gmail.com>

> Hi,
>
> I wrote a small application that opens both streams (i.e. capture and
> playback)
> of a PCM in non blocking (i.e. SND_PCM_NONBLOCK) mode.
>
> During device configuration I also set up the minimum number of
> frames to consider a PCM ready:
>
>
> ---------------------------------------------------------------------------------
> // when to consider the device to be ready for the next data transfer
> operation
> if ((ret=snd_pcm_sw_params_set_avail_min(handle, swparams,
> pcm_period_size))<0)
> {
>        fprintf(stderr, "could not set avail_min: %s\n", snd_strerror(ret));
>        return NULL;
> }
>
> ---------------------------------------------------------------------------------
>
> As you can see it is set to the number of frames one period contains.
>
> In other words, each time there are at least that many frames available for
> reading
> on the capture device, we should get a POLLIN event when using poll().
> On the other side we should get a POLLOUT event if that many frames can be
> written
> to the playback device.
>
>
> Then, later in my application, I use poll() on the fds of the PCM devices.
> As, according to the ALSA reference, poll events can be "mangeled", I use
> snd_pcm_poll_descriptors_revents() to "demangle" the events:
>
>
> ---------------------------------------------------------------------------------
> if ((ret=snd_pcm_poll_descriptors_revents(device_handle, &poll_fds[i], 1,
> &revents))<0)
> {
>        fprintf(stderr, "could not snd_pcm_poll_descriptors_revents: %s\n",
> snd_strerror(ret));
>        exit(EXIT_FAILURE);
> }
>
> ---------------------------------------------------------------------------------
>
>
>
> After that, each time there was a POLLIN event, I am reading exactly one
> period from the
> capture PCM.
> On the other side, if there was a POLLOUT event, I am writing exactly one
> period to the
> playback PCM.
>
>
> While this works for a small number of periods (which is not always the
> same), I always end up
> with a "Resource temporarily unavailable" error when trying to read one
> period from the capture PCM:
>
>
> ---------------------------------------------------------------------------------
> demangled poll: POLLIN  on capture device
> could not read from capture device: Resource temporarily unavailable
>
> ---------------------------------------------------------------------------------
>
>
> Since a POLLIN event only occurs after at least a full period is available
> for
> reading (as set up by snd_pcm_sw_params_set_avail_min() above)
> and I only read after a POLLIN event occured on the capture device fd,
> I really do not understand why I get the above error.
>
> So why does the above happen ?
> What am I doing wrong ?
>
> If it helps, I pasted the source code here so that you can view it nicely:
> http://pastebin.com/fCicqctq
>
> cheers,
> stefan
>

which sound card are you using ?

The program did not run on my two sound card since you are using 160 frames
and mono

are you using "pulse" device for testing since only pulse device return the
error messages "could not read from capture device: Resource temporarily
unavailable" ?
