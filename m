From: Daniel Vukicevic <dv@zhor.de>
Subject: snd-hda-intel with Asus U5F
Date: Fri, 13 Oct 2006 11:05:26 +0200
Message-ID: <452F56D6.2070506@zhor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailgate.pce.de (mailgate.pce.de [213.185.64.16])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A1234199
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Oct 2006 11:05:30 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

just wanted to let you know, that the snd-hda-intel module on the new
Asus U5F Notebook works with model=laptop-eapd. That took me some hours
to find it out, so it would be very helpful for future U5F users to see
that model in the ALSA-Configuration Doc.

Regards
Daniel Vukicevic

dv@buran:~$lspci -nv

00:1b.0 0403: 8086:27d8 (rev 02)
        Subsystem: 1043:1263
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at feb3c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0

dv@buran:~$lspci -v

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
        Subsystem: ASUSTeK Computer Inc. Unknown device 1263
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at feb3c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
