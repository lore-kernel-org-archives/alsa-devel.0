From: jaspal.kallar.xfree86@spray.se
Subject: Support for powermac G5?
Date: Sun, 20 Jun 2004 18:21:16 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56L0.0406201812430.22212@linux.local>
Reply-To: jaspal.kallar@.xfree86spray.se
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


Can anybody say if sound on the powermac G5 is supported ?
I have no idea which chipset it is either.

I've tried with kernels 2.6.5, 2.6.6 and 2.6.7

modprobe snd-powermac
FATAL: Error inserting snd_powermac 
(/lib/modules/2.6.7-r0/kernel/sound/ppc/snd-powermac.ko): No such device


and in /var/log/messages I get

"Jun 20 18:19:09 linux ALSA sound/ppc/pmac.c:1095: pmac: can't request resource 0!
 Jun 20 18:19:09 linux no PMac soundchip found"


Can anybody give me some pointers into what the problem could be. Btw I 
have snd-powermac as a module and not compliled into any of the above kernels.
But I have also tried it compliled into the kernel but with same results.


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
