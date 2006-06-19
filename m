From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002159]: ac3 passthrough not working
	on recent versions
Date: Mon, 19 Jun 2006 13:11:22 +0200
Message-ID: <0344f3f181005a256b01e0a07f5549b2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AFE8C139
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jun 2006 13:11:23 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2159> 
======================================================================
Reported By:                nikke
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2159
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.15
======================================================================
Date Submitted:             05-24-2006 23:44 CEST
Last Modified:              06-19-2006 13:11 CEST
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
 Raymond - 06-02-06 04:25 
----------------------------------------------------------------------
You may need to revert some patch related to SPDIF to find out the cause


http://hg-mirror.alsa-project.org/alsa-kernel?fl=25ac64e78c4c;file=pci/ymfpci/ymfpci_main.c;style=gitweb



----------------------------------------------------------------------
 nikke - 06-14-06 22:32 
----------------------------------------------------------------------
I tried using a debian 2.6.8 kernel, and then AC3 passthrough works.
/proc/asound/version says ALSA 1.0.4 ...

Using a 2.6.14 kernel did not work (ALSA 1.0.10rc1).

So, any possibility of getting a list of what patches has been added to
ymfpci between v 1.0.4 (that works) and v 1.0.10rc1? It would help
narrowing down the candidates quite a bit...

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
 Mimosius - 06-16-06 13:16 
----------------------------------------------------------------------
I've started from 1.0.9b and applied patch by patch up to 1.0.11. I figured
out, that this patch from Clemens Ladisch
http://hg-mirror.alsa-project.org/alsa-kernel?cmd=changeset;node=218164651eb8;style=gitweb
breaks the AC3-passthrough.

playing mp3 or ac3 the AC97 register are filled with the same values, but
there is a difference between version 1.0.11, which comes with my SUSE
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

and here the diff of the ymfpci registers from 1.0.11 and 1.0.9b(patched)
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



----------------------------------------------------------------------
 Raymond - 06-17-06 02:43 
----------------------------------------------------------------------
Are you really sure that the patch "ymfpci: add per-voice volume controls"
break AC3 passthrough, the purpose of that patch is to implement pcm
volume control per substream using the hardware mixing of ymfpci

Please note that STAC9708 has no SPDIF control registers, there is no need
to compare ac97 registers


iecset



----------------------------------------------------------------------
 Mimosius - 06-16-06 13:37 
----------------------------------------------------------------------
Hi Raymond,

yes, I'm really sure this patch breaks AC3 passthrough. A comparison of
the /proc/asound/card0/ymfpci registers against 1.0.9b (patched up to
1.0.11 without Clemens patch) and 1.0.11 (native) is included in my
previous note.

----------------------------------------------------------------------
 Raymond - 06-16-06 16:25 
----------------------------------------------------------------------
I don't have this card.

The DAC resolution of STAC9708 is 18-bit , this may mean that there is
2-bit gain when 16-bit audio pass through the hardware mixer.

But AC3 stream (passthrough) don't need any gain/attenutation.

----------------------------------------------------------------------
 nikke - 06-17-06 01:17 
----------------------------------------------------------------------
I tried to do a quick revert of just that patch from 1.0.11, but there was
too many conflicts... However, I noticed that the
rear-channel-swapping-thingie shows up in the same function that this
patch modifies the most. And since AC3 passthrough works in 1.0.9 this
suggests that the patch really breaks things that the
rear-channel-swap-patch tries to fix...

Mimosius: Can you make a patch between stock 1.0.11 and your
1.0.11-with-working-ac3 so I can test too, and other people really can see
that it's the mentioned patch that breaks things?

----------------------------------------------------------------------
 Raymond - 06-17-06 10:24 
----------------------------------------------------------------------
Which application change those undocumented registers of STAC9708 ?

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

Are all channels correct when you run speaker-test -Dsurround40 -c 4 -t
wav ?



----------------------------------------------------------------------
 Raymond - 06-17-06 11:02 
----------------------------------------------------------------------
Mimosius

There is a patch which supposed to fix AC3 output

http://hg-mirror.alsa-project.org/alsa-kernel?cmd=changeset;node=fac92b1b0699;style=gitweb

Do this patch fix the problem ?

However there is another patch which add an module parameter

MODULE_PARM_DESC(rear_swap, "Swap rear channels (must be enabled for
correct IEC958 (S/PDIF)) output");

http://hg-mirror.alsa-project.org/alsa-kernel?cmd=changeset;node=2e21f4940a0f;style=gitweb

----------------------------------------------------------------------
 Raymond - 06-17-06 14:25 
----------------------------------------------------------------------
Are you sure that your patch in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1447 does not break AC3
pass through ?

It seem that there are 3 sources for SPDIF out
1) AC3
2) Digital Mixer
3) SPDIF in

----------------------------------------------------------------------
 nikke - 06-17-06 15:16 
----------------------------------------------------------------------
Being less tired than yesterday, I tried the following:

Using Linux 2.6.8: ALSA 1.0.9b AC3 works, 1.0.10 AC3 does NOT work. When
reverting the "ymfpci: add per-voice volume controls" patch from 1.0.10
AC3 passthrough started to work.

Since 1.0.10 compiles on Linux 2.6.15 I have been able to verify that
reverting said patch makes AC3 work on my normal setup too.

To conclude, I agree that "ymfpci: add per-voice volume controls" breaks
AC3 passthrough.

----------------------------------------------------------------------
 Raymond - 06-17-06 16:23 
----------------------------------------------------------------------
It seem that is a bug related to "ymfpci: add per-voice volume controls" 

It should assign kctl->private_value = substream in
snd_ymfpci_playback_open() instead of snd_ymfpci_mixer()

I had upload a small program (iface_pcm.c) to test this feature for au88x0
in https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1835

Without a suitable fuction in alsa-lib, this feature is unusable for those
hardware mixing sound cards



----------------------------------------------------------------------
 rlrevell - 06-17-06 18:22 
----------------------------------------------------------------------
Raymond,

Please post your patch to alsa-devel at lists.sourceforge.net so it can be
fixed in the next release.

----------------------------------------------------------------------
 Raymond - 06-18-06 13:30 
----------------------------------------------------------------------
I don't have this card, you better wait Clemens Ladisch's review.

BTW, Is there any reason why dsnoop is not eanbled ?

The volume per voice feature is hard to use, especially when different
drivers implement this feature in different ways
1) emu10k1 - use index
2) ymfpci  - use subdevice

Can any of you try speaker-test -Dsurround40 -c 4 -t wav  ?
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2026



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
06-16-06 13:16 Mimosius       Note Edited: 0010250                         
06-16-06 13:26 Raymond        Note Added: 0010251                          
06-16-06 13:31 Raymond        Note Edited: 0010251                         
06-16-06 13:37 Mimosius       Note Added: 0010252                          
06-16-06 16:25 Raymond        Note Added: 0010255                          
06-17-06 01:17 nikke          Note Added: 0010262                          
06-17-06 02:43 Raymond        Note Edited: 0010251                         
06-17-06 10:21 Raymond        Note Added: 0010266                          
06-17-06 10:24 Raymond        Note Edited: 0010266                         
06-17-06 11:02 Raymond        Note Added: 0010267                          
06-17-06 14:25 Raymond        Note Added: 0010268                          
06-17-06 15:16 nikke          Note Added: 0010269                          
06-17-06 16:10 Raymond        Note Added: 0010270                          
06-17-06 16:23 Raymond        Note Edited: 0010270                         
06-17-06 18:22 rlrevell       Note Added: 0010280                          
06-18-06 04:03 Raymond        Note Added: 0010295                          
06-18-06 04:08 Raymond        Note Edited: 0010295                         
06-18-06 04:14 Raymond        Note Edited: 0010295                         
06-18-06 13:30 Raymond        Note Edited: 0010295                         
06-19-06 13:11 Clemens LadischStatus                   new => assigned     
06-19-06 13:11 Clemens LadischAssigned To               => Clemens Ladisch 
======================================================================
