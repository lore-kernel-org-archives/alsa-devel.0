From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Opti92x-ad1848 won't take Opti924 card
Date: Tue, 23 Sep 2003 10:53:36 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0309231048590.8799-100000@studcom.urz.uni-halle.de>
References: <3F7001AF.C13AC3CC@srr.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <3F7001AF.C13AC3CC@srr.ro>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrei Boros <andrei@srr.ro>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Andrei Boros wrote:
> modprobe returns :
> /lib/modules/2.2.24/misc/snd-opti92x-ad1848.o: init_module: Device or
> resource busy

This means it found the card, but another driver is already loaded, or
the port/interrupts are already allocated.

Please check in /proc/interrupts and /proc/ioports that all needed
resources are free.

> All documentation I found so far says that my 924 card uses the ad1848
> chip, so I compiled only this module.

The documentation may be wrong, look at the chip. (The box of my
Mozart card shows a picture of a card with a CS4231, but the card
itself has an AD1848.)


HTH
Clemens




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
