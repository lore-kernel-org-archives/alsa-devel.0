From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: AudioTrak Optoplay...
Date: Wed, 04 Jun 2003 16:00:46 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0306041550170.749-100000@studcom.urz.uni-halle.de>
References: <200306030848.43580.miller@penguinstation.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200306030848.43580.miller@penguinstation.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ross Miller <miller@penguinstation.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ross Miller wrote:
> On Tuesday 03 June 2003 01:03, Clemmens Ladisch wrote:
> > Are you sure that the Optoplay supports _one_-channel output?
> >
> That's a good question - I'll try a stereo WAV later this evening after I get
> off work.

It doesn't, but your aplay command used the "default" device which
automatically converts unsupported sample formats.
Anyway, the problem is with the sample rate.

> lsusb -v:
> [... many lines ...]
> BTW: Is there any documentation available that explains what all these
> fields mean?

The official documentation for this are the USB 2.0 Specification, the USB
Audio Specifications, and the USB Human Interface Device Specification
from www.usb.org, but those are not quite easy to parse.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
