From: m <m.ash@gmx.at>
Subject: hdsp9652 note
Date: Mon, 3 Mar 2003 20:42:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030303204249.3b3d0b0f.m.ash@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



hi.

I tried a hdsp9652 install this weekend and found out I had to add another case line to get it recognised at all (instead of downgrading firmware).

this seems to work for now ( although the driver claims that 
ALSA ../../alsa-kernel/pci/rme9652/hdsp.c:2935: I/O Box is a Digiface )

m.


[..]

lspci -v -s 00:0a.0   
00:0a.0 Multimedia audio controller: Xilinx, Inc.: Unknown device 3fc5 (rev 68)
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at ec000000 (32-bit, non-prefetchable) [size=64K]



[..]

--- alsa-kernel/pci/rme9652/hdsp.c.orig Sun Mar  2 21:33:58 2003
+++ alsa-kernel/pci/rme9652/hdsp.c      Sun Mar  2 21:35:08 2003
@@ -2985,6 +2985,7 @@
        case 0xa:
        case 0xb:       
        case 0x64:
+       case 0x68:
                /* hdsp_initialize_firmware() will reset this */
                hdsp->card_name = "RME Hammerfall DSP";
                break;



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
