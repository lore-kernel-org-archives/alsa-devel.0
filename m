From: Eric Sharkey <sharkey@netrics.com>
Subject: problem with ALSA on AMD64 w/VIA chipset
Date: Mon, 22 Nov 2004 10:30:21 -0500
Message-ID: <E1CWG8z-00011x-00@mastermind.netrics.internal>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi all,

I posted on alsa-user a while back, but I think I need developer
assistance with this.

There seems to be a problem with Alsa when running on the AMD64
architecture on motherboards with the Via K8T800 chipset.  The sound
is highly irregular, with lots of drop-outs, but also speed-ups,
slow-downs and weird volume changes.

I've got this problem on an Asus K8V SE motherboard.  Rod Smith
has the same problem on an MSI Neo-FSR.
(http://groups.google.com/groups?q=%22asus+k8v%22+alsa&hl=en&lr=&c2coff=1&selm=1et59c-90v.ln%40speaker.rodsbooks.com&rnum=4)

In that post, Rod thought the problem was the Alsa driver for the
on-board sound (VIA VT8237), but this is not the case, as I've installed
a PCI Trident 4DWave NX, and it shows exactly the same behavior.
The problem appears not to be in the low level driver code, but
something higher.

The degree of the problem is highly sensitive to the load on the
CPU at the time.  Games like bumprace, which use multiple threads
and never sleep (giving load values around 8), sound awful.  Most
games like tuxkart, which keep the load under 1, sound perfectly fine.

And yet, some things sound bad even when the CPU isn't loaded.
timidity++ is a good example.

This happens with both 64 and 32 bit kernels, and no amount of
twiddling with kernel parameters (ACPI/CPU frequency scaling, apic,
preemption, etc.) seems to make any difference.

Can anyone here offer a suggestion?

Eric


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
