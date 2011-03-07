From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_hw_params_set_buffer_time_near: invalid
	argument
Date: Mon, 7 Mar 2011 20:24:28 +0800
Message-ID: <AANLkTimfZwH+dqsPZaifekmmctrARdE0DoK5nHoW1Fu_@mail.gmail.com>
References: <AANLkTik5sX_DWLsN3y_7ANpoF5rgeCNZY7gm=+rFhCsy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F04251038B1
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 13:25:50 +0100 (CET)
Received: by fxm11 with SMTP id 11so4106049fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Mar 2011 04:25:50 -0800 (PST)
In-Reply-To: <AANLkTik5sX_DWLsN3y_7ANpoF5rgeCNZY7gm=+rFhCsy@mail.gmail.com>
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

2011/3/6 Jean-Yves Avenard <jyavenard@gmail.com>

> Hi there.
>
> I'm a bit puzzled as to what values are considered valids and which
> one aren't when it comes to setting the buffer time with
> snd_pcm_hw_params_set_buffer_time_near.
>
> For example setting a value of 295ms : all ok. From 300ms to 450ms ->
> "Invalid argument".
> but 500ms for example is okay.
>
> What's the logic behind it ?
> It's obviously related to the sampling rate, the audio format and the
> number of channels ; as the values giving me "Invalid argument" change
> then.
>
> Any comments would be greatly appreciated.
>
> Thanks!
> JY
>

This seem to be bug in alsa-lib as I can reproduce using alsa-lib/test/pcm.c
with buffer time 120000 and my hda codec support both 11025Hz and 22050Hz

using buffer time 160000 is OK


./pcm -Dhw:CARD=Intel,DEV=0 -b 120000  -r 22050 -c 2
Playback device is hw:CARD=Intel,DEV=0
Stream parameters are 22050Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Using transfer method: write
Unable to set buffer time 120000 for playback: Invalid argument
Setting of hwparams failed: Invalid argument


 ./pcm -Dhw:CARD=Intel,DEV=0 -b 120000  -r 11025 -c 2
Playback device is hw:CARD=Intel,DEV=0
Stream parameters are 11025Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Using transfer method: write
Unable to set buffer time 120000 for playback: Invalid argument
Setting of hwparams failed: Invalid argument



./pcm -Dhw:CARD=Intel,DEV=0 -b 160000  -r 11025 -c 2
Playback device is hw:CARD=Intel,DEV=0
Stream parameters are 11025Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Using transfer method: write
