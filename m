From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: bugs in usb midi alsa code?
Date: Thu, 07 Nov 2002 16:15:50 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211071557380.23415-100000@studcom.urz.uni-halle.de>
References: <20021107142039.GA535@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA20915
	for <alsa-devel@alsa-project.org>; Thu, 7 Nov 2002 16:17:19 +0100
In-reply-to: <20021107142039.GA535@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Martin Langer wrote:
> On Thu, Nov 07, 2002 at 01:50:29PM +0100, Clemens Ladisch wrote:
> > Apparently, the bug only occurs if a rawmidi port is used through the
> > alsa-lib functions. (The subdevice checking code in rawmidi_hw.c did
> > change, but that was a bugfix. Hmmm...)
>
> commenting out that new line doesn't help!

It fixed a bug. Without that line, opening a specific input-only rawmidi
subdevice with a subdevice number would fail.

> In former days I have had these lines in /proc/asound/seq/clients. There
> were two endpoints for each direction.
> Client  64 : "Evolution Electronics Ltd. MK-249C USB MIDI keyboard" [Kernel]
>   Port   0 : "MK-249C USB MIDI keyboard Port 0" (R-e-)
>   Port   1 : "MK-249C USB MIDI keyboard Port 1" (-We-)

Having seperate ports for each endpoint was a side effect of the endpoint
handling code. Using rawmidi had the side effect of fixing this. :-)

> Now I have two endpoints in the messages, but a mixed entry in the clients
> list. Is this correct or do we have a multi endpoint problem?

It's correct, and I consider it more correct than one port for each
direction, from a usability point of view.

> ... the description doesn't has the port number included like above.
>
> Client  80 : "External MIDI 2" [Kernel]
>   Port   0 : "MK-249C USB MIDI keyboard Port " (RWeX)

The sequencer allocates 64 bytes for port names, but rawmidi ports have
only 32 bytes (including the terminating zero). You should've bought an
MK-249 instead. ;-)


Regards,
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
