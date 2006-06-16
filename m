From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002159]: ac3 passthrough not working
	on recent versions
Date: Fri, 16 Jun 2006 13:01:21 +0200
Message-ID: <df282669f9a5d9c626ebdc4c52799e1c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 938D818B
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jun 2006 13:01:21 +0200 (MEST)
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
Last Modified:              06-16-2006 13:01 CEST
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
 nikke - 06-15-06 23:43 
----------------------------------------------------------------------
This is on a 2.6.15 kernel with ALSA 1.0.11.

lspci -vn:
0000:02:06.0 0401: 1073:0012
        Subsystem: 1073:0012
        Flags: bus master, medium devsel, latency 64, IRQ 177
        Memory at faff8000 (32-bit, non-prefetchable) [size=32K]
        I/O ports at ecc0 [size=64]
        I/O ports at ecb8 [size=4]
        Capabilities: [50] Power Management version 1

cat /proc/asound/cards:
 0 [YMF754         ]: YMF754 - Yamaha DS-1E (YMF754)
                      Yamaha DS-1E (YMF754) at 0xfaff8000, irq 177

cat /proc/asound/pcm:
00-03: YMFPCI - PCM2 : YMFPCI - Direct Recording : capture 1
00-02: YMFPCI - Rear : YMFPCI - Rear PCM : playback 1
00-01: YMFPCI - IEC958 : YMFPCI - IEC958 : playback 1
00-00: YMFPCI : YMFPCI : playback 32 : capture 1


cat /proc/asound/card0/codec97#0/ac97#0-0+regs (identical output
regardless of idle, playing pcm or playing ac3):
0:00 = 6940
0:02 = 0303
0:04 = 9f1f
0:06 = 801f
0:08 = 0000
0:0a = 801e
0:0c = 801f
0:0e = 801f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 9f1f
0:16 = 9f1f
0:18 = 0303
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
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
0:6e = 0000
0:70 = 0000
0:72 = 8000
0:74 = 0380
0:76 = abba
0:78 = 9381
0:7a = 0000
0:7c = 8384
0:7e = 7608

----------------------------------------------------------------------
 Mimosius - 06-16-06 13:01 
----------------------------------------------------------------------
I've started from 1.0.9b and applied patch by patch up to 1.0.11rc2. I
figured out, that this patch from Clemens Ladisch
http://hg-mirror.alsa-project.org/alsa-kernel?cmd=changeset;node=218164651eb8;style=gitweb
breaks the AC3-passthrough.

playing mp3 or ac3 the AC97 register are filled with the same values, but
there is a difference between version 1.0.11rc2, which comes with my SUSE
10.1 Kernel, and my patched 1.0.9b without Clemens patch:

--- ac97-1.0.11-ac3     2006-06-15 22:17:15.000000000 +0200
+++ ac97-1.0.9_patched-ac3      2006-06-16 12:49:49.000000000 +0200
@@ -6,18 +6,18 @@
 0:0a = 801e
 0:0c = 801f
 0:0e = 801f
-0:10 = 0808
+0:10 = 9f1f
 0:12 = 9f1f
 0:14 = 9f1f
 0:16 = 9f1f
 0:18 = 9f1f
-0:1a = 0505
-0:1c = 0101
+0:1a = 0000
+0:1c = 0000
 0:1e = 0000
-0:20 = 0200
+0:20 = 0000
 0:22 = 0000
 0:24 = 0000
-0:26 = 800f
+0:26 = 000f
 0:28 = 0080
 0:2a = 0080
 0:2c = 0000
@@ -53,9 +53,9 @@
 0:68 = 0000
 0:6a = 0000
 0:6c = 0000
-0:6e = 0004
+0:6e = 0008
 0:70 = 0000
-0:72 = 8000
+0:72 = ffef
 0:74 = 0380
 0:76 = abba
 0:78 = 9381

and here the diff of the ymfpci registers from 1.0.11rc2 and
1.0.9b(patched)
--- ymfpci-1.0.11-ac3   2006-06-15 22:17:20.000000000 +0200
+++ ymfpci-1.0.9_patched-ac3    2006-06-16 12:47:54.000000000 +0200
@@ -24,7 +24,7 @@
 0054: ff00ff
 0058: 555500ff
 005c: 0000
-0060: 807e0808
+0060: 807e0000
 0064: 7e7608
 0068: 7fffff
 006c: 0000
@@ -32,26 +32,26 @@
 0074: 0000
 0078: 0000
 007c: 0000
-0080: 0000
+0080: 3fff3fff
 0084: 3fff3fff
-0088: 0000
+0088: 3fff3fff
 008c: 0000
-0090: 3fff3fff
+0090: 0000
 0094: 0000
 0098: 0000
 009c: 0000
 00a0: 0000
 00a4: 3fff3fff
-00a8: 0000
+00a8: 3fff3fff
 00ac: 3fff3fff
 00b0: 0000
 00b4: 0000
 00b8: 0000
 00bc: 0000
 00c0: 0000
-00c4: 45a7
+00c4: 5fff
 00c8: 0000
-00cc: 0002
+00cc: 0001
 00d0: 0000
 00d4: 0000
 00d8: 0000
@@ -65,7 +65,7 @@
 00f8: 0000
 00fc: 0000
 0100: 0003
-0104: 0001
+0104: 0000
 0108: 40000003
 010c: 25a01
 0110: 0001
@@ -86,7 +86,7 @@
 014c: 0100
 0150: 0000
 0154: 0018
-0158: 3db70000
-015c: 3db73e00
-0160: 3db73f00
-0164: 3db74000
+0158: 13810000
+015c: 13813e00
+0160: 13813f00
+0164: 13814000

so AC3 works for me at the moment :) , but thats not the solution. I hope
Clemens will review his patch.

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
06-15-06 23:43 nikke          Note Added: 0010246                          
06-16-06 13:01 Mimosius       Note Added: 0010250                          
======================================================================
