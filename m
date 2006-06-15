From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002159]: ac3 passthrough not working
	on recent versions
Date: Thu, 15 Jun 2006 11:03:01 +0200
Message-ID: <fb3f23c85cd45a6102b37cc162234bac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0A438191
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jun 2006 11:03:01 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2159> 
======================================================================
Reported By:                nikke
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2159
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15
======================================================================
Date Submitted:             05-24-2006 23:44 CEST
Last Modified:              06-15-2006 11:03 CEST
======================================================================
Summary:                    ac3 passthrough not working on recent versions
Description: 
Using the following AC3 passthrough with mplayer works:
Linux 2.4.31
alsa-driver 1.0.8-7 (debian stable packaged)

Using Linux 2.6.15 (both with alsa-driver 1.10rc3 that ships with the
kernel and
alsa-driver 1.0.11) it doesn't work. The reciever just says "unlock" and
stays quiet.

The only change is booting with different kernels, no other config or
hardware is touched, so this must be a driver regression.

The card is YMF-754 based, connected with coax spdif to my HK reciever.

If you need more info, just tell me and I'll dig it up.
======================================================================

----------------------------------------------------------------------
 Raymond - 06-15-06 02:27 
----------------------------------------------------------------------
Please provide output of your YMF-754 

lspci -vn

cat /proc/asound/cards

cat /proc/asound/pcm

cat /proc/asound/card0/codec97#0/ac97#0-0+regs

The revisions links contain the list of patches.

http://hg-mirror.alsa-project.org/alsa-kernel?mf=f43cd9eba10a;path=/pci/ymfpci/;style=gitweb

The release date of 1.0.4 is 2004/04/03 and 1.0.10rc1 is 2005/08/20



----------------------------------------------------------------------
 Mimosius - 06-15-06 11:03 
----------------------------------------------------------------------
Hi,

I've exactly the same problem. Passthrough since 1.0.10* seems to be
broken, 1.0.9 instead works great.

output of "cat ac97#0-0+regs (playing AC3, using ac3dec -C)"

0:00 = 6940
0:02 = 9f1f
0:04 = 9f1f
0:06 = 801f
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 801f
0:10 = 0808
0:12 = 9f1f
0:14 = 9f1f
0:16 = 9f1f
0:18 = 9f1f
0:1a = 0505
0:1c = 0101
0:1e = 0000
0:20 = 0200
0:22 = 0000
0:24 = 0000
0:26 = 800f
0:28 = 0080
0:2a = 0080
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 0000
0:38 = 9f9f
0:3a = 0000
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0004
0:70 = 0000
0:72 = 8000
0:74 = 0380
0:76 = abba
0:78 = 9381
0:7a = 0000
0:7c = 8384
0:7e = 7608


output of "cat /proc/asound/card0/ymfpci (playing AC3, using ac3dec -C)"
YMFPCI

0000: 0002
0004: 0000
0008: 0000
000c: 0000
0010: 0000
0014: 0000
0018: 0003
001c: 8202
0020: 8202
0024: 8202
0028: 80008202
002c: 0000
0030: 0000
0034: 0004
0038: 0000
003c: 000c
0040: 0000
0044: 0000
0048: 0000
004c: 0000
0050: 0000
0054: ff00ff
0058: 555500ff
005c: 0000
0060: 807e800f
0064: 7e7608
0068: 7fffff
006c: 0000
0070: 0012
0074: 0000
0078: 0000
007c: 0000
0080: 0000
0084: 3fff3fff
0088: 0000
008c: 0000
0090: 3fff3fff
0094: 0000
0098: 0000
009c: 0000
00a0: 0000
00a4: 3fff3fff
00a8: 0000
00ac: 3fff3fff
00b0: 0000
00b4: 0000
00b8: 0000
00bc: 0000
00c0: 0000
00c4: 5fff
00c8: 0000
00cc: 0001
00d0: 0000
00d4: 0000
00d8: 0000
00dc: 0000
00e0: 0000
00e4: 0000
00e8: 0000
00ec: 0000
00f0: 0000
00f4: 0000
00f8: 0000
00fc: 0000
0100: 0003
0104: 0001
0108: 40000003
010c: 4200043
0110: 002a
0114: 0001
0118: 0000
011c: 0000
0120: 0000
0124: 0000
0128: 0000
012c: 0000
0130: 0000
0134: 0000
0138: 0000
013c: 0000
0140: 001e
0144: 0004
0148: 0004
014c: 0100
0150: 0000
0154: 0018
0158: 3c468000
015c: 3c46be00
0160: 3c46bf00
0164: 3c46c000

there is no ac97 register change playing MP3 then AC3
diff -u <(cat /proc/asound/card0/codec97#0/ac97#0-0+regs) <(sleep 5; cat
/proc/asound/card0/codec97#0/ac97#0-0+regs)
doesn't output anything


register change of /proc/asound/card0/ymfpci (playing MP3 then AC3)

diff -u <(cat /proc/asound/card0/ymfpci) <(sleep 5; cat
/proc/asound/card0/ymfpci)
--- /dev/fd/63  2006-06-15 10:49:46.356867225 +0200
+++ /dev/fd/62  2006-06-15 10:49:46.348866702 +0200
@@ -6,11 +6,11 @@
 000c: 0000
 0010: 0000
 0014: 0000
-0018: 0001
-001c: 8200
-0020: 0200
-0024: 0200
-0028: 80000200
+0018: 0003
+001c: 8202
+0020: 8202
+0024: 8202
+0028: 80008202
 002c: 0000
 0030: 0000
 0034: 0004
@@ -28,7 +28,7 @@
 0064: 7e7608
 0068: 7fffff
 006c: 0000
-0070: 0002
+0070: 0012
 0074: 0000
 0078: 0000
 007c: 0000
@@ -64,9 +64,9 @@
 00f4: 0000
 00f8: 0000
 00fc: 0000
-0100: 0000
-0104: 0000
-0108: 0000
+0100: 0003
+0104: 0001
+0108: 40000003
 010c: 4200043
 0110: 002a
 0114: 0001

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-06 23:44 nikke          New Issue                                    
05-24-06 23:44 nikke          Distribution              => Debian          
05-24-06 23:44 nikke          Kernel Version            => 2.6.15          
05-24-06 23:47 nikke          Issue Monitored: nikke                       
06-02-06 04:23 Raymond        Note Added: 0010045                          
06-02-06 04:25 Raymond        Note Edited: 0010045                         
06-12-06 13:14 Mimosius       Issue Monitored: Mimosius                    
06-14-06 22:32 nikke          Note Added: 0010216                          
06-15-06 02:18 Raymond        Note Added: 0010221                          
06-15-06 02:27 Raymond        Note Edited: 0010221                         
06-15-06 11:03 Mimosius       Note Added: 0010237                          
======================================================================
