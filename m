From: "Kristin Low" <kristin.low@gmail.com>
Subject: Re: ALSA Problem - Broken Pipe
Date: Thu, 10 Jul 2008 11:34:27 -0400
Message-ID: <3b2c72ff0807100834r2c921ca4pc7958d95a0bc87fb@mail.gmail.com>
References: <3b2c72ff0807091731m27ed3247nb91a8e55702bd3e3@mail.gmail.com>
	<s5hlk09k0s8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by alsa0.perex.cz (Postfix) with ESMTP id C7B6E2475A
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Jul 2008 17:34:29 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id a29so2170983pyi.36
	for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2008 08:34:28 -0700 (PDT)
In-Reply-To: <s5hlk09k0s8.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I don't get any kernel warning/error messages from what I can tell. I
checked /var/log/messages and dmesg (hopefully that's where I'm supposed to
look). The only messages I get are from selecting ALSA output: "[00000351]
alsa audio output error: write failed (Broken pipe)" or if I select
pulseaudio: "pulseaudio[5593]: module-alsa-sink.c: Got POLLERR from ALSA".
These usually happen near the beginning of a sound, but also may not come up
for several minutes.

When I say OSS works, I mean that when I set Sound Events and Music and
Movies in my Sound Preferences (setting the default setting for programs),
sound works fine (I just don't get simultaneous sounds, which I believe is
normal because of OSS). Also, if I set Amarok or VLC to use OSS and not ALSA
or pulseaudio, my sound works. However, if I run VLC with the aoss wrapper,
I get the same error messages as above. Totem and Rhythmbox don't work
either.

Thanks so much for looking at this for me.

On Thu, Jul 10, 2008 at 3:16 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 9 Jul 2008 20:31:19 -0400,
> Kristin Low wrote:
> >
> > Hi all,
> >
> >
> > I apologize if this isn't the right place to ask for help, but no one who
> > I've asked knows how to help and I'm somewhat new to Linux.
> >
> > I'm running Ubuntu Hardy Heron and haven't changed any config files
> > (practically a fresh install) however ALSA does not work properly and I
> > assume that because of this, Pulseaudio doesn't work either (it breaks
> when
> > ALSA does). Playing a song, I can hear the song for a random length of
> time
> > and then it cuts out. If I run VLC from a terminal, it claims "alsa
> output
> > error: write error (broken pipe)" as the cause and continues to write
> that
> > over the screen until I force VLC to quit. If I restart the song again,
> the
> > same thing occurs. Pulseaudio cuts out and says it gets a POLLERR from
> ALSA.
> > When I login, only part of the login sounds play and are cut just the
> same
> > as any songs or audio files I try. It seems like my sound card is
> detected
> > fine, and OSS works when I select to use it instead. It's on a laptop, a
> > Toshiba Satellite a70.
>
> Do you have any kernel error/warning messages?
> Also, do you mean "OSS works" that OSS emulation works?
>
>
> Takashi
>
