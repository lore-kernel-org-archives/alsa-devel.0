From: Lex Wassenberg <lex.wassenberg@gmail.com>
Subject: Re: Sound streaming application: which device to use?
Date: Tue, 9 Jun 2009 16:01:59 +0200
Message-ID: <45c981ab0906090701t209abbc6jda420e4e666c5198@mail.gmail.com>
References: <45c981ab0906040428v3910cbcfq7e3024b23f6653e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AABB1037F7
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Jun 2009 16:02:00 +0200 (CEST)
Received: by bwz11 with SMTP id 11so3903239bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 09 Jun 2009 07:01:59 -0700 (PDT)
In-Reply-To: <45c981ab0906040428v3910cbcfq7e3024b23f6653e1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 4, 2009 at 1:28 PM, Lex Wassenberg<lex.wassenberg@gmail.com> wr=
ote:
> Hi all,
>
> I'm completely new to ALSA, so forgive me if these are newby questions.
>
> I'm working on an application which receives sound chunks via an IP
> connection, and it should use the local sound card to make this sound
> audible. Up to now it used OSS, but there were some problems with
> that, so I'm busy with rewriting the application to ALSA. The sound is
> 16-bit stereo, sampled at 8000 Hz, and it comes in chunks of 1024
> frames. I managed to get things more or less working, but there are
> still some things unclear to me.
>
> 1. If I open the soundcard with device "default" or device "plughw" I
> get good sound, but the device "default" only accepts 1020 frames of
> every 1024 that I offer it (as can be seen from the return value of
> snd_pcm_writei() ). The device "plughw" nicely accepts all 1024
> frames. Why is this? In both cases I have set the sample rate to 8000
> via a call to snd_pcm_hw_params_set_rate_near() and the buffer size to
> 2048 frames via snd_pcm_hw_params_set_buffer_size_near().
>
> 2. If I use device "default", there seems to be no obligation to set
> the buffer size nor the period size, I still get good sound at the
> output. If I use "plughw", I have to set either the buffer size (2048
> frames) or the period size (1024 frames), otherwise I get distorted
> sound. If I set both (the buffer size being 2048 and the period size
> being 1024) I also get distorted sound. Why?
>
> 3. If I set the buffer size twice the period size (as above), and ask
> the sizes back, ALSA nicely reports the buffer size as being twice the
> period size. But if I ask the buffer and period TIMES, they are
> reported as being the same: 128000 us! =A0Huh????
>
> 4. The return value of snd_pcm_hw_params_set_rate_near() is sometimes
> 8000, sometimes 7999, from the very same program. I would expect ALSA
> to always return the same value, be it what I request or not, but at
> least being deterministic. How can this be?
>
> 5. There is another application running on the same target system,
> which will sometimes produce audible alarms. However, if my
> application is running that other application cannot generate the
> alarms, it produces a "resource busy" error. It is clear to me that my
> application is using the sound card exclusively, but how can I get it
> to allow other applications access to it too? I tried using the device
> "dmix", but then my sound is again very distorted.
>
> Hope that somebody can help me out.
> Thanks in advance.
>
> Lex
>

Is there nobody that can help me out on the questions above? I figured
the answer to question 4 (passing a pointer to an uninitialized
integer; I thought the integer was only used for reporting back, which
is not true), but all other questions still stand. Nobody??

Lex
