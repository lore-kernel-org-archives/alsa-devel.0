From: Pavel Roskin <proski@gnu.org>
Subject: Re: Problems with SBLive! and current CVS
Date: Mon, 23 Sep 2002 15:10:01 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209231501460.23365-100000@marabou.research.att.com>
References: <Pine.GSO.4.44.0209231915500.4522-100000@styx.csd.uch.gr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.GSO.4.44.0209231915500.4522-100000@styx.csd.uch.gr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Panagiotis Papadakos <papadako@csd.uoc.gr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

> For two weeks now, compiling the ALSA from CVS, I get distorted sound
> through XMMS with the ALSA plugin and also from mpg123 with OSS. Does
> anybody has the same problem?

I just checked the current version, and it seems to be Ok.  I didn't try 
xmms, but mpg123 plays through OSS just fine.  aplay with .wav and .au 
files are also fine.

Linux 2.4.20-pre7, Athlon 1GHz, KT-133 with VIA chipset.

# /sbin/lspci -v -n -s 00:08.0
00:08.0 Class 0401: 1102:0002 (rev 07)
        Subsystem: 1102:8064
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at ac00 [size=32]
        Capabilities: [dc] Power Management version 1

Try finding the exact time when the driver stopped working for you.

-- 
Regards,
Pavel Roskin



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
