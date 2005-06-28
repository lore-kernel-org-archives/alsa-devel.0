From: david-b@pacbell.net
Subject: Re: [linux-usb-devel] Fw: BUG: Kernel panic when
 disconnecting Edirol USB2 audio interface
Date: Mon, 27 Jun 2005 20:31:56 -0700
Message-ID: <20050628033156.9FB22BFF40@blackbox.site>
References: <Pine.HPX.4.33n.0506271650140.7308-100000@studcom.urz.uni-halle.de>
 <42C07072.1050105@axicon.com> <20050628020344.C5075C8944@blackbox.site>
 <1119925811.13519.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1119925811.13519.4.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: rlrevell@joe-job.com
Cc: linux-usb-devel@lists.sourceforge.net, colinf@axicon.com, clemens@ladisch.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> From: Lee Revell <rlrevell@joe-job.com>
> Date: Mon, 27 Jun 2005 22:30:11 -0400
>
> On Mon, 2005-06-27 at 19:03 -0700, david-b@pacbell.net wrote:
> > > With kernel 2.6.12 + "[PATCH] ehci-hcd - fix page pointer allocation in 
> > > itd_patch()"), using jackd in realtime mode at 44.1kHz with 64 
> > > frames/period and 4 periods/buffer, I get a stream of xruns of about 
> > > 0.020 ms, several per second.
> > 
> > In USB, one frame == 1 msec.  Most EHCI silicon using the 2.6.12 code
> > will get unhappy with 256 msec per ISO URB, so I hope you're using
> > "frame" without a necessary adjective ... ;)
> > 
>
> "frame" = audio frame (4 bytes with S16LE).
> "USB frame" = 1 msec

No.  "frame" == ambiguous.  This message is on a USB list, where the
no-adjective version means "USB frame".  It's also cross-posted to
a list where the no-adjective version means something very different.

The only solution that removes ambiguity for _everyone_ is to ensure
that such words never appear without an adjective.


> > > Using the same kernel and jackd settings, but with the sound/ and 
> > > include/sound directories from ALSA CVS of about 7:30 this evening, it 
> > > seems to work fine, at least for a couple of minutes of stereo playback.
> > >
> > > At 128 frames/period, both kernels have a crackling background noise: I 
> > > haven't experimented with any other settings yet.
> > 
> > I discourage drivers from using more than 64 msec per ISO URB.
> > 
>
> Please clarify.  64msec of what?

128 frames/period == 128 msec between transfers, probably not what he
meant to say ... but not clear what he _did_ mean to say either.

An ISO URB has one buffer that's split into N transfers, performed
one transfer per period.  If (N * P) < 64 msec it will hit the fewest
number of scheduling issues ... usually two or three can be scheduled
with no gaps (such gaps will cause noise).  At 128 msec, most hosts
can't double-buffer ... gaps are almost ensured.

- Dave



This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email in error please notify the system manager. This message contains confidential information and is intended only for the individual named. If you are not the named addressee you should not disseminate, distribute or copy this e-mail.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
