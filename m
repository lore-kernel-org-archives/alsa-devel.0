From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA support for firewire audio interfaces?
Date: Fri, 25 Jun 2004 14:32:46 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406251422420.17980-100000@studcom.urz.uni-halle.de>
References: <200406240755.i5O7tOt04413@sprite.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200406240755.i5O7tOt04413@sprite.physics.adelaide.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jonathan Woithe wrote:
> As you mentioned, the standard is mentioned in documents like
> those at
>   http://www.yamaha.co.jp/tech/1394mLAN/english/index.html
> and
>   http://www.yamaha.co.jp/tech/1394mLAN/Technical/mlan.html
>
> In particular, the protocol document there has a chapter on "Isochronous
> connection management" (chapter 7, page 33ff).  I'm not sure whether this is
> the "connection management" you're referring to or not.  Even if it is, I'm
> not sure whether there's enough detail in there to allow an ALSA driver to
> be written.

Looks promising.  It seems they (will) publish the entire
specification.

> Speaking of firewire devices, it seems that there's quite a few out there
> which don't do mLAN.  For example, the M-Audio fireware Audiophile box
> connects with firewire but there's no mention anywhere that it's mLAN.  I
> suspect it isn't.

It may be possible the the standard is identical to mLAN, or that mLAN
has extension on top of the standard protocol.

> > > My question is whether any work is actually being done on support for
> > > firewire audio device support in ALSA.
> > No.
>
> So, what would be needed in order to support these devices under ALSA in
> terms of drivers and information?

Somebody with enough knowledge to determine if the above
specifications are sufficient, and with enough time to write a driver.

> Interestingly enough, on
>   http://www.mlancentral.com/
> we have the statement "Linux support is planned for the future".

This may be an euphemism for "let's wait until the penguins have
written a driver by themselves".  ;-)


Regards,
Clemens




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
