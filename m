From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: ALSA support for firewire audio interfaces?
Date: Thu, 24 Jun 2004 17:25:24 +0930 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406240755.i5O7tOt04413@sprite.physics.adelaide.edu.au>
References: <Pine.HPX.4.33n.0406231035070.4564-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0406231035070.4564-100000@studcom.urz.uni-halle.de> from "Clemens Ladisch" at Jun 23, 2004 10:36:49 AM
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens wrote:
> Jonathan Woithe wrote:
> > Back in April someone asked on this list about a driver for the firewire
> > Audiophile audio interface from M-Audio.  It was mentioned in that thread
> > that most new-model firewire audio devices were "class compliant" and
> > therefore a one-driver-fits-all situation should occur (like we now have for
> > usb-audio).
> 
> Yes, but the connection management isn't mentioned in that standard.
> IIRC most (all?) devices use Yamaha's mLan, but nothing is known about
> that.  I don't know what became of this:
> http://www.music.columbia.edu/pipermail/linux-audio-user/2004-March/010915.html

Nothing that I can see.  As you mentioned, the standard is mentioned in
documents like those at
  http://www.yamaha.co.jp/tech/1394mLAN/english/index.html
and
  http://www.yamaha.co.jp/tech/1394mLAN/Technical/mlan.html

In particular, the protocol document there has a chapter on "Isochronous
connection management" (chapter 7, page 33ff).  I'm not sure whether this is
the "connection management" you're referring to or not.  Even if it is, I'm
not sure whether there's enough detail in there to allow an ALSA driver to
be written.

Speaking of firewire devices, it seems that there's quite a few out there
which don't do mLAN.  For example, the M-Audio fireware Audiophile box
connects with firewire but there's no mention anywhere that it's mLAN.  I
suspect it isn't.

> > My question is whether any work is actually being done on support for
> > firewire audio device support in ALSA.
> No.

So, what would be needed in order to support these devices under ALSA in
terms of drivers and information?

>From my very incomplete knowledge of these things I'm guessing we'd need an
ALSA module which talked to these things utilising services provided by the
low-level ieee1394 layer.  Whether we're talking two modules (one in the
ieee1394 subsystem and one in ALSA) or just one I couldn't guess.  In the
long run we'd probably need to have something like a unifying firewire-audio
module which then interfaced to separate lower-level modules to deal with
the fact that we have mLAN as well as other protocols.  We'd also need
someone with hardware to test with.  Interestingly enough, on
  http://www.mlancentral.com/
we have the statement "Linux support is planned for the future".

I have been toying with the idea of getting a firewire audio interface but I
don't know which one yet.  Whether this is a feasible solution for me is
another thing - I probably need to do some more reading on ieee1394 and the
ALSA architecture before deciding whether such support is possible and if
so, how far off it might be.

One thing that should be noted is that mLAN support is probably going to be
essential in future, especially if Yamaha gets its way and displaces MIDI.
Whether the other protocols out there are as necessary, only time will tell.

Regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
