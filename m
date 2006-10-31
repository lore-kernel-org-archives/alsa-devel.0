From: Stefan Wilke <free.willy@bossmail.de>
Subject: Bug #2308
Date: Tue, 31 Oct 2006 20:09:04 +0100
Message-ID: <200610312009.05135.free.willy@bossmail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

3 months ago, I filed the following bug in the bugtracker:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2308

but noone bothered to answer yet. So I hope by posting to the mailing lists, I 
might receive some attention at last.

In short: I have a SoundBlaster 5.1 live; but unfortunately, I don't receive 
anything via the front channels when using surround 5.1. ; using speaker-test 
or xine. The speakers are ok; they work with windows, and setting "Front 
Jack" to "Rear Output" gives me Rear Output (or anything else; only "Front 
Output" gives me nothing) via the front speakers. This situations has been 
present from 1.0.11 till now (1.0.13); it worked before (although I had other 
severe errors before...).

Similar errors have occured before, but it is not fixed for me:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1624
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1648

Concerning my card, I have the following information:

alsamixer:
Card: SB Live 5.1 [SB0220]
Chip: SigmaTel STAC9758,59

dopefish dopefish # lspci -vn | grep -A1 0401
01:0a.0 0401: 1102:0002 (rev 0a)
        Subsystem: 1102:100a

lshw:
description: Multimedia audio controller
                product: SB Live! EMU10k1
                vendor: Creative Labs
                physical id: a
                bus info: pci@01:0a.0
                version: 0a
                width: 32 bits
                clock: 33MHz
                capabilities: bus_master cap_list
                configuration: driver=EMU10K1_Audigy latency=32 maxlatency=20 
mingnt=2
                resources: ioport:9000-901f irq:20

I'm running gentoo on an Athlon XP 2400, with kernel 2.6.18-gentoo-r1, but 
alsa is compiled via ebuild, not into the kernel.

I'd be glad to receive more response here than I received in the bugtracker 
(i.e., I'm glad for anything...)

Thanks in advance

	Stefan



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
