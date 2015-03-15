From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.0-rc3: sound broken in chromium but not in mpg123
Date: Sun, 15 Mar 2015 09:15:44 +0100
Message-ID: <20150315081544.GA17650@amd>
References: <20150314201109.GA21052@amd>
 <s5htwxmr85c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5htwxmr85c.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, alsa-devel@alsa-project.org, kernel list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun 2015-03-15 09:12:47, Takashi Iwai wrote:
> At Sat, 14 Mar 2015 21:11:09 +0100,
> Pavel Machek wrote:
> > 
> > Hi!
> > 
> > Intel desktop machine:
> > 
> > 00:1b.0 Audio device: Intel Corporation NM10/ICH7 Family High
> > Definition Audio Controller (rev 01)
> > 
> > Sound worked ok in both in previous kernel versions.
> > 
> > Any ideas?
> 
> How broken?  Did you get any error messages?

I get some funny, faint, rhytmic noises where audio should
be... Actually, I somehow suspect something is wrong with time during
video playback.

> If the behavior depends on the application (e.g. ALSA vs OSS), I'd
> suspect rather a device permission problem at first.  There are no
> significant changes between 3.19 and 4.0-rc3 regarding HD-audio.

My system contains pulseaudio, so it is more complex than ALSA vs OSS
:-(.

Audio seems to work ok on thinkpad x60 with very very similar config.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
