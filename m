From: Alf <alf@mypals.org>
Subject: Bt87x audio driver card ID
Date: Mon, 19 Feb 2007 09:42:54 -0700
Message-ID: <200702190942.54242.alf@mypals.org>
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
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

The ALSA Bt87x audio driver does not detect the ID on my ATI TV-Wonder card.  
Below is the information obtained from the kernel log and lspci.  The card 
seems to work, although there was no capture volume control on the mixer 
(it used to be there on kernel <2.6.8; it is currently not on my 2.6.10 
kernel, however).

I hope this information helps.

Feb 19 09:23:41 slim unknown card 0x878-0x1002:0x01, using default rate 
32000
Feb 19 09:23:41 slim please mail id, board name, and, if it works, the 
correct digital_rate option to <alsa-devel@lists.sf.net>
Feb 19 09:23:41 slim ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
Feb 19 09:23:41 slim ACPI: PCI Interrupt 0000:01:0a.1[A] -> Link [APC1] -> 
GSI 16 (level, high) -> IRQ 19

01:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
	Subsystem: ATI Technologies Inc Unknown device 0001
	Flags: bus master, medium devsel, latency 32, IRQ 5
	Memory at e0000000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2

01:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
	Subsystem: ATI Technologies Inc TV-Wonder
	Flags: bus master, medium devsel, latency 32, IRQ 19
	Memory at e0001000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2

-- 
Alf
@

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
