From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Alsa plugin unable to be loaded by Pulseaudio
Date: Wed, 9 Sep 2009 16:10:20 +0800
Message-ID: <4f3252890909090110n68cbecefnab64f953d4788850@mail.gmail.com>
References: <1252365377.11542.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f177.google.com (mail-pz0-f177.google.com
	[209.85.222.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FEDC24567
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 10:10:21 +0200 (CEST)
Received: by pzk7 with SMTP id 7so897701pzk.2
	for <alsa-devel@alsa-project.org>; Wed, 09 Sep 2009 01:10:20 -0700 (PDT)
In-Reply-To: <1252365377.11542.5.camel@localhost.localdomain>
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

what is the "test" device ?

The slave "plug" plugin usually is "hw" device

Do the following work

aplay -v -Dtest any.wav

aplay -v -M -Dtest any.wav

Why do you need the "plug" plugin ?
do you mean that pulseaudio server cannot use the exact access , format ,
rate , channels and route which required by the "test" device

aplay -v -Dplug:test any.wav

aplay -v -M -Dplug:test any.wav


2009/9/8 Ng Oon-Ee <ngoonee@gmail.com>

> Hello, please find below an issue I had with loading plugins into
> pulseaudio. The pulse dev has sent this mail on his list concerning
> alsa's interaction with pulse, indicating that there is something buggy
> with how it works. Details below. I'd be willing to post something to
> the bugtracker, if I only knew what the below means...
>
> -------- Forwarded Message --------
> From: Lennart Poettering <lennart@poettering.net>
> Reply-to: General PulseAudio Discussion
> <pulseaudio-discuss@mail.0pointer.de>
> To: pulseaudio-discuss@mail.0pointer.de
> Subject: Re: [pulseaudio-discuss] Alsa output devices, able to use alsa
> plugin?
> Date: Fri, 4 Sep 2009 01:20:15 +0200
>
> On Wed, 26.08.09 12:27, Tanu Kaskinen (tanuk@iki.fi) wrote:
>
> > D: alsa-util.c: Trying test with SND_PCM_NO_AUTO_FORMAT ...
> > D: alsa-util.c: Managed to open test
> > D: alsa-util.c: Maximum hw buffer size is 371 ms
> > I: alsa-util.c: snd_pcm_hw_params_set_periods_near() failed: Tiedostoa
> tai hakemistoa ei ole
> > I: alsa-util.c: snd_pcm_hw_params_set_buffer_size_near() failed:
> Tiedostoa tai hakemistoa ei ole
> > D: alsa-util.c: Trying test without SND_PCM_NO_AUTO_FORMAT ...
> > D: alsa-util.c: Managed to open test
> > D: alsa-util.c: Maximum hw buffer size is 371 ms
> > I: alsa-util.c: snd_pcm_hw_params_set_periods_near() failed: Tiedostoa
> tai hakemistoa ei ole
> > I: alsa-util.c: snd_pcm_hw_params_set_buffer_size_near() failed:
> Tiedostoa tai hakemistoa ei ole
> > D: alsa-util.c: Trying plug:test with SND_PCM_NO_AUTO_FORMAT ...
> > D: alsa-util.c: Managed to open plug:test
> > D: alsa-util.c: Maximum hw buffer size is 371 ms
> > I: alsa-util.c: snd_pcm_hw_params_set_periods_near() failed: Tiedostoa
> tai hakemistoa ei ole
> > I: alsa-util.c: snd_pcm_hw_params_set_buffer_size_near() failed:
> Tiedostoa tai hakemistoa ei ole
> > D: alsa-util.c: Trying plug:test without SND_PCM_NO_AUTO_FORMAT ...
> > D: alsa-util.c: Managed to open plug:test
> > D: alsa-util.c: Maximum hw buffer size is 371 ms
> > I: alsa-util.c: snd_pcm_hw_params_set_periods_near() failed: Tiedostoa
> tai hakemistoa ei ole
> > I: alsa-util.c: snd_pcm_hw_params_set_buffer_size_near() failed:
> Tiedostoa tai hakemistoa ei ole
> > I: alsa-util.c: Failed to set hardware parameters on plug:test: Tiedostoa
> tai hakemistoa ei ole
> > E: module.c: Failed to load  module "module-alsa-sink" (argument:
> "device=test"): initialization failed.
> >
> > That "Tiedostoa tai hakemistoa ei ole" error means "No such file or
> > directory". I tried also with device=hw:0,0 and device=plughw:0,0 and
> > the first worked while the latter gave the same errors. Since the failed
> > function calls pertain to buffering, I also tried with tsched=0. It
> > worked. So, maybe this is a bug in the "plug" alsa plugin, ie. it
> > doesn't implement the *_near() functions properly.
> >
> > Lennart, any insights?
>
> I am pretty sure that ALSA is broken here. We nowadays first try to
> set the number of periods, and then set the buffer size in the
> hwparams struct. If this fails we print a warning message (the ones
> you see above with all the vowels regarding
> snd_pcm_hw_params_set_periods_near()
> resp. snd_pcm_hw_params_set_buffer_size_near()), but we do not
> consider this fatal.
>
> After doing this we call snd_pcm_hw_params() to activate our
> settings -- and if this fails then we consider this a fatal problem.
>
> Now the brokeness in ALSA is that after refusing our parameters it
> still fails to configure our settings, i.e. calling the two functions
> that fail breaks the hwparams setup: if we wouldn't call them, no breakage
> happens at all.
>
> The two functions in question should either succeed or fail, but if
> they fail they should not modify hwparams in a way that it
> subsequently becomes unusable for snd_pcm_hw_params().
>
> This issue needs to be fixed in ALSA.
>
> Lennart
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
