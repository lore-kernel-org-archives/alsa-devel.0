From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Finding xruun sources in cs46xx
Date: Mon, 8 Nov 2004 18:17:05 +0100
Message-ID: <20041108181705.456b1aea@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (imap.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 5B1F8286
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2004 18:16:55 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi,

although i am using Ingo Molnar's VP/RP patches i still experience some
xruns with my cs46xx card. The amount of xruns has, of course, been
dramatically decreased by using the VP/RP patched kernels. But some few
remain. They appear regardless of the period size i use [the amount is
roughly the same afaik]. There's no kernel latencies reported by the latency
timing utilities provided by the RP/VP kernels corresponding to these xruns.
They seem to just come out of the blue [even in an idle jackd]. So i suspect
either the hardware to be faulty [soundcard or the PIC] or the alsa driver
for this card [as my sis onboard soundcard [snd-intel8x0] doesn't seem to
have this problem].

I wonder: how can i approach finding the source of these xruns? Would the
xrun debugging messages of ALSA provide a starting point?

And one more question: what happens to an IRQ raised by a pci device which
get's ignored [either due to a cli or because it's masked by another IRQ
with a higher prio]?

flo


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
