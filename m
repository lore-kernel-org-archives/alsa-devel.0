From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: Patch series for Fast Track Ultra mixer quirks
Date: Thu, 26 May 2011 11:08:15 +1000
Message-ID: <BANLkTimPmOc46+Qthh9QJNt9n+BLu9+hYA@mail.gmail.com>
References: <1306307343-3247-1-git-send-email-zonque@gmail.com>
	<s5hoc2r2pnw.wl%tiwai@suse.de>
	<BANLkTi=4cTqUFkpHWw1RLGBbySFkpHCD1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 25E07103856
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 03:08:18 +0200 (CEST)
Received: by wyg36 with SMTP id 36so164888wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 25 May 2011 18:08:15 -0700 (PDT)
In-Reply-To: <BANLkTi=4cTqUFkpHWw1RLGBbySFkpHCD1A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, clemens@ladisch.de, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

>
> > I'd have exported a function creating FU mixer element instead of the
> > control element link, but your patches are simple enough, so I applied
> > as is.
>
> I can have a look at this later and send a fixup.
>

Thanks to everyone involved for efforts in developing and merging this
support.

So when Takashi says he's applied it what git branch/repo is that if it's
published?

So I thought it might be worthwhile sumarising the current status of the
Fast track ultra support in alsa from a user perspective:

Done working 100%:
Recording at all supported sample rates (44.1, 48, 88.2 and 96)kHz
Mixer support for channel routing within the device (thanks to Daniel and
Felix)
Midi in and out.

Still needing work for full functionality (device is usable as is these
things would make support as good as vendor (other os) drivers):

Playback works but has an odd artifact that's quite noticable when playing
back pure sine functions (seems to drop a sample once every some power of 2
it's not the end of the world and is not noticable in normal use. This was
discussed on this list in september however it remains unresolved.  I should
test my other usb soundcards and verify it's only the FTU that's affected
tho.

The remaining mixer controls and switches (dsp/reverb sends and setting and
internal/external clock controls)  now we have a framework for the mixer
support adding the remaining controls should be straightforward the big
challenge imho was how to integrate into the quirk code.

Grant.
