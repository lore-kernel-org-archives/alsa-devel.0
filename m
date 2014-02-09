From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Echo Fireworks control protocol (was Re: Sample program for
	hwdep interface)
Date: Sun, 9 Feb 2014 15:51:45 +0100
Message-ID: <20140209155145.2175d147@stein>
References: <1387545269-3875-1-git-send-email-o-takashi@sakamocchi.jp>
	<52B45837.2080804@sakamocchi.jp>
	<20131221101123.GA17855@marvin.atrad.com.au>
	<52C93F8B.1010701@sakamocchi.jp> <20140112142230.4aacdc9e@stein>
	<52D2B41B.7090505@sakamocchi.jp> <20140202145850.1f8684b3@stein>
	<52F62FA0.6040809@sakamocchi.jp>
	<20140209114228.GB15049@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20140209114228.GB15049@marvin.atrad.com.au>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Jonathan Woithe <jwoithe@just42.net>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Feb 09 Jonathan Woithe wrote:
> On Sat, Feb 08, 2014 at 10:22:40PM +0900, Takashi Sakamoto wrote:
> > >I understood from Clemens' comments that ... the mixer applications are
> > >supposed to use firewire-cdev for all their other dealings with the audio
> > >devices.  (Clemens and Jonathan, correct me if I misunderstood or if I
> > >forgot other control and status I/O that is only possible with direct
> > >cooperation by the ALSA driver.)
> > 
> > I don't know his future plan. But according to his advices, my
> > current work is to focus on streaming driver. Currently the
> > functionality to control device's internal mixer should be
> > implemented in user-land application, not in ALSA drivers.
> 
> As per an earlier followup, the current intention is indeed to keep the
> mixer control in userspace.

Sure, definitely; my point was that the kernel ABI which userspace mixer
applications are going to use could be
  a) the ALSA hwdep interface, or
  b) the ALSA hwdep interface together with firewire-core's firewire-cdev
     interface,
but I understood that b) is the first choice.  Specifically, provide in
ALSA hwdep only the absolutely necessary interfaces and do as much as
possible via firewire-cdev.

In contrast, it can't be firewire-cdev alone because of streaming on/off
state influences what can be controlled, and because some devices embed
status into the isochronous stream (MotU? RME?), and because some devices
(which ones?) may have write-only registers, of which both streaming
driver and mixer application want to know what is being written there.
Furthermore, it can't be a kernel interface like sysfs or configfs because
of the complexity and variety of control protocols of FireWire audio
devices.
-- 
Stefan Richter
-=====-====- --=- -=--=
http://arcgraph.de/sr/

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
