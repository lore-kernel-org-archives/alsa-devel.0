From: Ross Vandegrift <ross@willow.seitz.com>
Subject: Re: Alsa-OSS - Pop at start of song update (rc2)
Date: Sun, 7 Dec 2003 16:33:13 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031207213313.GA23870@willow.seitz.com>
References: <1070820195.3841.42.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1070820195.3841.42.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@comcast.net>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 07, 2003 at 10:03:15AM -0800, Mark Knecht wrote:
>    This is a small update on the problem I've seen with loud pops and
> crackles at the start of audio when using Alsa's OSS emulation. As
> background, using xmms I am unable to play about 99% of the mp3, ogg and
> wave files I have without getting a very loud noise when first starting
> the playback. The noise also happens every time I pause and restart the
> playback. It also happens with pretty much every audio or video viewed
> and played by Mozilla. mplayer, xine, plugger-5.0 all have default
> setups that cuase this on my system. 

Hi Mark,

	Are you by chance using a sound server of some kind that keeps
the device open and mapped?  For example, esd keep the device open and
when it's not in use, it's writing zeroes to the sound device.

	If there was a bug in esd and it wasn't actually writing
zeroes, but some other constant value, things would be silent while
nothing is playing.  When actual sound starts, this could have an actual
zero at the beginning, causing a pop!

	Of course, you say you're using oss, so probably no esd is
involved.  Maybe dmix is being used and doing something like this?

>    However, an interesting aspect was that this does not ever happen
> when playing any of these files with an Alsa application instead. Using
> that as a clue, I tried using alsaplayer through the oss layer instead
> of directly into Alsa, using
> 
> alsaplayer -o oss

This difference is kind of telling - if it were a problem in the ALSA
OSS emulation layer, this should almost certainly exhibit the problem.
Of course, it could be a subtle API compatibility issue, but that seems
unlikely to me - people should see it on other hardware and it should be
common.

If you're using something like dmix, I'd try cutting it out of the
picture.

-- 
Ross Vandegrift
ross@willow.seitz.com

A Pope has a Water Cannon.                               It is a Water Cannon.
He fires Holy-Water from it.                        It is a Holy-Water Cannon.
He Blesses it.                                 It is a Holy Holy-Water Cannon.
He Blesses the Hell out of it.          It is a Wholly Holy Holy-Water Cannon.
He has it pierced.                It is a Holey Wholly Holy Holy-Water Cannon.
He makes it official.       It is a Canon Holey Wholly Holy Holy-Water Cannon.
Batman and Robin arrive.                                       He shoots them.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
