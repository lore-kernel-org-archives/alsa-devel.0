From: Christoph Lameter <christoph@lameter.com>
Subject: cmipci driver locking up linux hard
Date: Fri, 4 Aug 2006 16:22:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608041616590.9917@graphe.net>
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

I recently bought a cmpci pci card with support for 6 channel surround 
sound. Vendor was PPA Int'l.

I can play music for shorter or longer time period but then it invariably 
locks up. If one tries the surround sound then it locks up very fast. 
Guess some concurrency issue? Run on a P4M800PROC Motherbord with
a Pentium940 (verified that lockup also occurs with single processor).

Tried to enable the nmi_watchdog but it also could not revive linux.

How do I debug this thing?

christoph@pentium940:/proc/asound$ cat cards
 0 [CMI8738MC6     ]: CMI8738-MC6 - C-Media PCI CMI8738-MC6
                      C-Media PCI CMI8738-MC6 (model 55) at 0xe800, irq 201

christoph@pentium940:/proc/asound/card0$ cat cmipci
C-Media PCI CMI8738-MC6 (model 55) at 0xe800, irq 201

00: 02 00 00 00
04: 10 0c 00 00
08: 03 00 09 00
0c: 00 00 00 0a
10: c0 00 00 00
14: 00 00 00 00
18: 00 00 80 0c
1c: 00 00 fe ff
20: 10 40 08 00
24: 00 01 00 04
28: ff ff ff ff
2c: ff ff ff ff
30: 00 00 00 00
34: 00 00 00 00
38: 00 00 00 00
3c: 00 00 00 00

christoph@pentium940:/proc/asound/card0$ cat id
CMI8738MC6



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
