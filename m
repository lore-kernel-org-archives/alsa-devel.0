From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: Echo Fireworks control protocol (was Re: Sample program for
	hwdep interface)
Date: Mon, 10 Feb 2014 08:59:27 +1030
Message-ID: <20140209222927.GB23867@marvin.atrad.com.au>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
	<52B45837.2080804@sakamocchi.jp>
	<20131221101123.GA17855@marvin.atrad.com.au>
	<52C93F8B.1010701@sakamocchi.jp> <20140112142230.4aacdc9e@stein>
	<52D2B41B.7090505@sakamocchi.jp> <20140202145850.1f8684b3@stein>
	<52F62FA0.6040809@sakamocchi.jp>
	<20140209114228.GB15049@marvin.atrad.com.au>
	<20140209155145.2175d147@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20140209155145.2175d147@stein>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: alsa-devel@alsa-project.org, jwoithe@just42.net, ffado-devel@lists.sf.net, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Feb 09, 2014 at 03:51:45PM +0100, Stefan Richter wrote:
> Sure, definitely; my point was that the kernel ABI which userspace mixer
> applications are going to use could be
>   a) the ALSA hwdep interface, or
>   b) the ALSA hwdep interface together with firewire-core's firewire-cdev
>      interface,
> but I understood that b) is the first choice.  Specifically, provide in
> ALSA hwdep only the absolutely necessary interfaces and do as much as
> possible via firewire-cdev.

Agreed.

> In contrast, it can't be firewire-cdev alone because of streaming on/off
> state influences what can be controlled, and because some devices embed
> status into the isochronous stream (MotU? RME?) ...

MOTU to a certain extent (although we don't make direct use of that at this
point because the information is quite low level and isn't required to use
the device successfully).  Hardware meter values (which don't really
constitute status data) are sent by the RMEs as part of the iso stream but
again we're not making use of that yet either.

> ... and because some devices (which ones?) may have write-only registers,
> of which both streaming driver and mixer application want to know what is
> being written there.

RME is the primary example in this case.

> Furthermore, it can't be a kernel interface like sysfs or configfs because
> of the complexity and variety of control protocols of FireWire audio
> devices.

At this stage I don't believe a universal interface is possible because I
expect this will end up being a case of chasing one's tail (a list of basic
conventions will be fine though).  As you know, the physical features and
setup of each interface family can be very different and trying to come up
with a single interface which works across devices will be the stuff of
nightmares.  For example, some things needed by one interface may be of no
concern at all to others.  I imagine the device-specific userspace mixer
panels which need to will access their relevant kernel interface. 
Consequently, for the relatively small number of interface models which are
affected, an interface for each device through sysfs or configfs might work. 
Mixer and control for most devices will work fine with just the basic list
of information which can be made available via hwdep.  The most important
one of these is the streaming status, but it could be useful to include a
small number of other things which are common to all devices, such as sample
rate.

Regards
  jonathan

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
