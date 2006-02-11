From: Nick <nick@linicks.net>
Subject: Re: [Alsa-devel] Re: ALSA - pnp OS bios option
Date: Sat, 11 Feb 2006 13:56:07 +0000
Message-ID: <7c3341450602110556u75c4bfffq@mail.gmail.com>
References: <200601092022.56244.nick@linicks.net>
	 <200601101759.20707.nick@linicks.net> <s5hek3geyup.wl%tiwai@suse.de>
	 <200602111054.50947.nick@linicks.net>
Reply-To: Nick <nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932289AbWBKN4K@vger.kernel.org>
In-Reply-To: <200602111054.50947.nick@linicks.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Ummm.  At the command line, same errors also.  So I deleted /etc/asound.state
> and reconfigured alsamixer from scratch.  Then following 'alsactl store',
> 'alsactl restore' completes without issue (i.e. works clean).
>
> If I then reboot, the same damn control #47 errors happen again.  It's as if
> something changes my asound.state file at boot time time?
>
> Ideas?  This is driving me potty.
>

OK, talking to myself (testing, testing, 1-2-3) - I have resolved this
issue after spending 2 hours trying to get my Mic to work again in
Teamspeak (why is there _so_ many frigging mixers
(alsamixer/amixer/aumix/kmix/arts) that all seem to do different
things...

I updated alsa-lib and alsa-utils to1.0.11rc3/rc2   This fixed my issues.

Now the question - there have been a lot of alsa changes (since my
alsa-tools was built Slack 10) - do we need to keep the alsa tools and
stuff current too?

Nick
