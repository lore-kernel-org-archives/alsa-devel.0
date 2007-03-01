From: Lintula <bugreports2005@cs.tut.fi>
Subject: snd-hda-intel issues
Date: Thu, 01 Mar 2007 14:17:30 +0200
Message-ID: <45E6C45A.3090802@cs.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

Using ALSA modules shipped with Linux 2.6.20, I find that with a HP
dc7600 workstation I need to load snd-hda-intel with model=basic or
model=hp or there is no sound. Alsamixer indicates Chip: Realtek ALC260.

00:1b.0 0403: 8086:27d8 (rev 01)
        Subsystem: 103c:3010
        Flags: bus master, fast devsel, latency 0, IRQ 18
        Memory at e04c0000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0

Same with a Lenovo M55 8811, except I seem to need model=laptop.
alsamixer indicates Chip: Analog Devices AD1986A.

00:1b.0 0403: 8086:284b (rev 02)
        Subsystem: 17aa:1011
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at d0200000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
