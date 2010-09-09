From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: crash with assertion (?)
Date: Thu, 9 Sep 2010 09:30:02 +0800
Message-ID: <AANLkTi=5nxDDyfsUrvF3z+EpApiAjau6hbLK=a08WnKr@mail.gmail.com>
References: <4C8662AD.1040607@iem.at> <4C8670FD.5020906@ladisch.de>
	<4C874C1E.8040007@iem.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DE06B103884
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Sep 2010 03:30:03 +0200 (CEST)
Received: by ewy21 with SMTP id 21so554948ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Sep 2010 18:30:02 -0700 (PDT)
In-Reply-To: <4C874C1E.8040007@iem.at>
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

2010/9/8 IOhannes m zmoelnig <zmoelnig@iem.at>

> On 2010-09-07 19:06, Clemens Ladisch wrote:
> > IOhannes m zmoelnig wrote:
> >> i'm requesting my "plughw" device with 44100Hz
> >> the request is done with something like:
> >>  rate=44100;
> >>  err = snd_pcm_hw_params_set_rate_min(handle, params, &rate, 0);
> >
> > This requests a sample rate of at least 44100 Hz.
>
> yes. this is good enough for me.
> (it shouldn't crash though)
>
>
http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.htm

Restrict a configuration space with a minimum rate.

val approximate minimum rate ( on return filled with actul minimum )
dir sub unit direction (on return filled with actual direction)

Return 0 otherwise a negative error code if configuration space would become
empty



what is the minimum rate returned by snd_pcm_hw_params_get_rate_min() when
using hw:0,0 ?

>
> >> [...]
> >>  err = snd_pcm_hw_params(handle, params);
> >>
> >> what happens:
> >> in the snd_pcm_hw_params(), my program exits with:
> >> "interval_inline.h:52: snd_interval_single: Assertion
> >> `!snd_interval_empty(i)' failed."
> >
> > You called snd_pcm_hw_params with an invalid params structure.
> > I'd guess that snd_pcm_hw_params_set_rate_min (or some other
> > snd_pcm_hw_params_set_*) returned an error.
>
> i wish you were right.
> however, it seems like i am blindfolded.
>
> i noticed however, that i need to set both the rate (i use
> snd_pcm_hw_params_set_rate_min()) and the period size (i use
> snd_pcm_hw_params_set_period_size_near()), in order to make it crash.
>
> attached is an example code that triggers the crash.
> please someone shed some light...
>
> gmasdr
> IOhannes
>
>
> PS: that's how i use the sample program:
> $ gcc -o alsatest alsatest.c $(pkg-config --cflags --libs alsa)
> $ ./alsatest
> trying to open 'hw:0' as CAPTURE
> configuring device succeeded
> CAPTURE configured
> trying to open 'hw:0' as PLAYBACK
> configuring device succeeded
> PLAYBACK configured
> trying to open 'plughw:0' as CAPTURE
> configuring device succeeded
> CAPTURE configured
> trying to open 'plughw:0' as PLAYBACK
> alsatest: interval_inline.h:55: snd_interval_single: Assertion
> `!snd_interval_empty(i)' failed.
> Aborted
>
> so it seems to work fine with "hw:0" but not with "plughw:0".
>
> you can specify the device to be opened on the cmdline:
> $ ./alsatest hw:2
>
>

To debug , you will need to enable RULES_DEBUG In pcm_params.c

add snd_pcm_dump() after snd_pcm_hw_params in your program

export LIBASOUND_DEBUG=1

and post the output of your program
