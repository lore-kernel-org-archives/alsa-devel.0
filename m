From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [alsa-devel] Fw: BUG: Kernel panic when
	disconnecting Edirol USB2 audio interface
Date: Tue, 28 Jun 2005 00:10:06 -0400
Message-ID: <1119931807.13519.13.camel@mindpipe>
References: <Pine.HPX.4.33n.0506271650140.7308-100000@studcom.urz.uni-halle.de>
	 <42C07072.1050105@axicon.com> <20050628020344.C5075C8944@blackbox.site>
	 <1119925811.13519.4.camel@mindpipe>
	 <20050628033156.9FB22BFF40@blackbox.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050628033156.9FB22BFF40@blackbox.site>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: david-b@pacbell.net
Cc: linux-usb-devel@lists.sourceforge.net, colinf@axicon.com, clemens@ladisch.de, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-06-27 at 20:31 -0700, david-b@pacbell.net wrote:
> > From: Lee Revell <rlrevell@joe-job.com>
> > Date: Mon, 27 Jun 2005 22:30:11 -0400
> >
> > On Mon, 2005-06-27 at 19:03 -0700, david-b@pacbell.net wrote:
> > > > With kernel 2.6.12 + "[PATCH] ehci-hcd - fix page pointer allocation in 
> > > > itd_patch()"), using jackd in realtime mode at 44.1kHz with 64 
> > > > frames/period and 4 periods/buffer, I get a stream of xruns of about 
> > > > 0.020 ms, several per second.
> > > 
> > > In USB, one frame == 1 msec.  Most EHCI silicon using the 2.6.12 code
> > > will get unhappy with 256 msec per ISO URB, so I hope you're using
> > > "frame" without a necessary adjective ... ;)
> > > 
> >
> > "frame" = audio frame (4 bytes with S16LE).
> > "USB frame" = 1 msec
> 
> No.  "frame" == ambiguous.  This message is on a USB list, where the
> no-adjective version means "USB frame".  It's also cross-posted to
> a list where the no-adjective version means something very different.
> 
> The only solution that removes ambiguity for _everyone_ is to ensure
> that such words never appear without an adjective.
> 

OK, makes sense.

So what the poster was saying was that if he uses 64 audio frames per
period, which at 44.1KHz requires the audio interface to deliver a chink
of data every ~1.4ms, he gets periodic xruns, IOW the audio interface is
not able to do that.  If he uses 128, he gets no xruns, so he's getting
a chunk of data every 2.8ms, but it's corrupted, hence the crackling.

Lee



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
