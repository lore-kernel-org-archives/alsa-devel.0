From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [alsa-devel] Help requested: new HSS1394 MIDI back-end
Date: Fri, 1 Jun 2012 15:40:25 +0200
Message-ID: <20120601154025.40af3e8f@stein>
References: <94aa86f3-5257-402a-a094-f58fccdeb846@email.android.com>
	<38538c62-f01e-4743-be92-aea79d61085e@email.android.com>
	<4FC5AC47.4060606@mixxx.org> <4FC5C9C8.1000604@ladisch.de>
	<4FC7EB01.1070306@mixxx.org> <4FC87BD8.8070104@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <4FC87BD8.8070104@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "Sean M. Pappalardo - D.J. Pegasus" <spappalardo@mixxx.org>, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Jun 01 Clemens Ladisch wrote:
> Sean M. Pappalardo - D.J. Pegasus wrote:
> > On 05/30/2012 09:18 AM, Clemens Ladisch wrote:
> >> As it happens, the actual SysEx commands use the wrong manufacturer ID
> >> ("00 01 02" is Crystal Semiconductor); I could just use the real ID
> >> (Stanton is "00 01 60") to escape non-MIDI HSS1394 messages.  Let's add
> >> "HSS" to identify this, and to allow the full byte range, each HSS1394
> >> byte is split into two nibbles.

It wasn't quite clear (to me) from the start that HSS1394 is not actually
"MIDI encapsulated in a vendor-defined 1394 transport protocol" but more
like "a vendor-defined events-and-commands protocol which borrows much
from MIDI, encapsulated in a vendor-defined 1394 transport protocol".

> > That all sounds good, but that now means that applications that want
> > to use these device features must have different code for Linux than
> > they do for Windows or OSX.

On the other hand, there is the benefit that applications (multi-platform
or single-platform, HSS1394 aware or unaware) just have to cope with
generic ALSA-based MIDI programming when on Linux.

> IIRC it was decided to use a MIDI driver in order to allow other
> applications to access these devices with standard MIDI APIs.
> (Does this imply that on Windows and OS X, it is not possible to
> access them without using the HSS1394 library?)

I guess while a HSS1394-to-MIDI driver, sitting between the native 1394
stack and the native audio and music API, would be just as feasible on
these two other platforms, only the libhss1394 way was implemented.

Seeing how small Clemens' driver is, and speculating that a similar OS X
driver would be about the same amount of code while a Windows driver may
or may not be bigger, I suspect that the overall code size of such three
platform specific drivers would actually be less than
  - the platform independent part of libhss1394,
  - plus OS X, Windows, and Linux backends in libhss1394,
  - plus the Thesycon driver which is required by libhss1394 on Windows.
And then there is the need of applications (on whatever platform) to
interface with libhss1394 in addition to native MIDI interfaces if these
applications want to support other MIDI devices too.

Granted, if nobody is there to implement the small kernelspace solution
but somebody is there to implement the bigger userspace solution, then the
latter is what gets done, for better or worse.

> You could still port the HSS1394 library so that it sits on top of the
> MIDI driver.  (In other words, the Linux MIDI backend would be the
> equivalent of the Windows and OS X FireWire backends.)

The current interface between the platform-independent and
platform-specific parts of libhss1394 resides on a level of abstraction
similar to the raw1394 interface.  It deals with 1394 node IDs, 1394 bus
generation, 1394 block transactions and the likes.  (But also with
interfaces to the platforms' threading APIs etc.)  So, either the Linux
backend would have to be hooked into libhss1394 somewhere higher than
that, or it would have to be written as a raw-I/O backend and to ignore
Clemens' nice ALSA driver.
-- 
Stefan Richter
-=====-===-- -==- ----=
http://arcgraph.de/sr/

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
