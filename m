From: Petr Baudis <pasky@ucw.cz>
Subject: Re: hda-intel: azx_get_response timeout, switching to polling mode:
 last cmd=0x01db0000
Date: Sat, 21 Jan 2012 10:16:02 +0100
Message-ID: <20120121091602.GF30898@machine.or.cz>
References: <20111229025953.15211.24880.reportbug@machine.or.cz>
 <20111229062105.GB28780@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111229062105.GB28780@elie.Belkin>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

  Hi!

On Thu, Dec 29, 2011 at 12:21:05AM -0600, Jonathan Nieder wrote:
> Petr Baudis wrote[1]:
> 
> > Version: 3.1.5-1
> [...]
> > this bug is twofold - I'm not sure which of the two problems is the real
> > culprit of the issue I'm seeing, and if it's worth fixing both or just
> > either one. It boils down to sometimes choppy playback and mainly
> > applications getting stuck on some audio operations.
> [...]
> > This did not use to happen at least back around 2.6.32.
> [...]
> > I'd be willing to do some bisecting if people believe it would make
> > sense.
> 
> I don't see any relevant newer fixes, but could you test the for-next
> branch from [2] anyway?  Output from the alsa-info.sh script[3] would
> also be useful.

I'm really sorry for taking so long - this is still an issue for me, but
contrary to my expectations, I was not able to reboot this machine yet
and it might take some more time (weeks...) before that's convenient.
I will try the then-current kernel and for-next branch then.

The output from the alsa-info.sh script is at:

	http://www.alsa-project.org/db/?f=184928832b33b23c68d17460604b9a37af0fac4b

-- 
				Petr "Pasky" Baudis
	The goal of Computer Science is to build something that will
	last at least until we've finished building it.
