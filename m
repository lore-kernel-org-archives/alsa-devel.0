From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Re: [linux-audio-user] USB sound
Date: Mon, 01 Jul 2002 19:07:32 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D208C54.68578939@ladisch.de>
References: <B93F5FB3.BCB%Alexander_Carot@gmx.net>
 <s5h8z4zog7t.wl@alsa2.suse.de> <3D1CAA0D.5070608@boosthardware.com>
 <200206290818.04426.speaker-to-vegetables@pobox.com>
 <3D1DFA0C.30504@boosthardware.com> <s5hit3z21bq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Patrick Shirkey <pshirkey@boosthardware.com>, linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> Patrick Shirkey wrote:
> >
> > Speaker to Vegetables wrote:
> > > Stuff
> > > that goes in the kernel is harder to install and usually harder to use.

In this case, a kernel driver would be easier to use because it would be
integrated in the ALSA framework. The daemon currently must be downloaded
and compiled seperately. OTOH, the daemon could be added to the alsa-tools
package easily.

> > >The golden reason for putting anything
> > > in a kernel-level driver is when that's the only way to get it to
> > > perform well enough.
> >
> > Good point but then if then we shouldn't have included ALSA if that is
> > true. The ALSA code base is large and having the usb midi module as a
> > userland app seems to me to go against the precendant set by the rest of
> > the modules.

Yes. Most users expect all drivers to be kernel modules. Not being able
to do lsmod/modprobe/rmmod makes diagnosing problems harder.

> another reason pushing me against the implementation of kernel driver
> is that usb midi specification is not followed by all vendors.
> apparently, the spec is half-finished.  there is little devices which
> can be handeld properly by the existing usb-midi kernel driver without
> any workaround.

All devices understand the USB MIDI protocol AFAIK. The problem with most
devices is that the USB descriptors are broken or missing, so some
information must be supplied for them.

> unfortunately i myself don't have a midi usb device yet, so i cannot
> say 100% surely on how much latency this solution works.
> but i think that the scheduled thread should work with enough small
> latency comparable with a kernel module.

USB host controllers (at least UHCI) don't issue an interrupt before the
end of the 1ms frame. The additional latency of either driver or daemon
should be negligible.

On the other hand, there may be issues with task scheduling -- the
daemon uses SCHED_FIFO with priority 99, but so does Timidity.

On the gripping hand, I've now written a kernel driver (see my other
post to alsa-devel). With both available, I predict that nobody will
want to risk the (theoretically) higher latency of the daemon.
Requiescat in pacem. :-)


Clemens


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
