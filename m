From: Greg KH <greg@kroah.com>
Subject: Re: [stable] Fix emu10k1 breakages in kernel 2.6.12
Date: Fri, 1 Jul 2005 22:52:42 -0700
Message-ID: <20050702055242.GA5823@kroah.com>
References: <1120273701.12256.30.camel@mindpipe> <20050702045614.GB5303@kroah.com> <1120283105.6975.21.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1120283105.6975.21.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: stable@kernel.org, Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>, Peter Zubaj <pzad@pobox.sk>, Mikael Magnusson <mikaelmagnusson@glocalnet.net>, alsa-devel <alsa-devel@lists.sourceforge.net>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 02, 2005 at 01:45:05AM -0400, Lee Revell wrote:
> On Fri, 2005-07-01 at 21:56 -0700, Greg KH wrote:
> > On Fri, Jul 01, 2005 at 11:08:21PM -0400, Lee Revell wrote:
> > > This set of critical fixes did not make it into the 2.6.12 kernel.
> > 
> > Is this patch in mainline already?
> > 
> 
> Yes, these fixes have been in ALSA CVS for 2-6 weeks.

Not my question.  Are they in Linus's tree yet?

> > A few minor complaints that make me worried about it for the -stable
> > kernel:
> > 	- it's bigger than expected for the -stable tree to take in just
> > 	  one patch.  Can you split it up into smaller pieces (one with
> > 	  the new table values, the other with the logic changes?)
> 
> The logic does have to change somewhat, because we were not handling
> unknown devices in a backward compatible way.

I'm not asking you to change the logic of the change, just break it up
into smaller pieces that are easier for you to look at and say, "of
course that is correct!" :)

thanks,

greg k-h


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
