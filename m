From: "Fernando Perfumo" <mfp.perfumo@ono.com>
Subject: TASCAM US122L
Date: Mon, 6 Oct 2008 13:11:48 +0200
Message-ID: <002b01c927a4$53e18c20$464da8c0@PC27C1536148166>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from resmaa06.ono.com (smtp3.ono.com [62.42.230.176])
	by alsa0.perex.cz (Postfix) with ESMTP id AD4531037EC
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Oct 2008 13:12:03 +0200 (CEST)
Received: from PC27C1536148166 (84.125.137.6) by resmaa06.ono.com (7.3.118.8)
	(authenticated as mfp.perfumo)
	id 48D747E500E2B237 for alsa-devel@alsa-project.org;
	Mon, 6 Oct 2008 13:11:50 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hello all,

    following is an extract of kern.log when connecting and disconecting a 
TASCAM US122L :
( the pcm part of the us122L does not appear in /proc/asound/... but only 
the midi part.
  kernel : 2.6.27-rc5-git11, alsa-driver-1.0.18rc3 compiled separately of 
the kernel sources, alsa-lib-1.0.18rc3 and  alsa-utils-1.0.18rc3 )

I'd appreciate some ideas about the segfault in alsactl and the ausence of 
the pcm functionality..
Thanks many,
    Fernando.

Oct  6 14:18:17 64studio kernel: usb 2-1: new high speed USB device using 
ehci_hcd and address 10
Oct  6 14:18:17 64studio kernel: usb 2-1: config 1 interface 1 altsetting 1 
bulk endpoint 0x83 has invalid maxpacket 9
Oct  6 14:18:17 64studio kernel: usb 2-1: configuration #1 chosen from 1 
choice
Oct  6 14:18:17 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/us122l.c:538: 
ffff880037942000:0
Oct  6 14:18:17 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/us122l.c:538: 
ffff88005e018000:1
Oct  6 14:18:17 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/us122l.c:103: 
0
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/us122l.c:103: 
0
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:61: 
idle=-18 ul=1518 ps=1536
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:61: 
idle=0 ul=1554 ps=1536
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:714: 
23 106
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:738: 
1
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:61: 
idle=-12 ul=1524 ps=1536
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:61: 
idle=-30 ul=1518 ps=1536
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
0 6 46 6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
0 11 46 0
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
0 88 46 -6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
0 176 46 -12
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
0 253 46 -18
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
1518 6 46 6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
1518 11 46 0
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
1518 242 46 -6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
3036 6 47 6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
4590 5 46 0
Oct  6 14:18:18 ....
..............................................................
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
44538 5 46 6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:738: 
3
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
46056 5 47 6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
50688 5 46 6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-ker..................................
.........................................................................................................................................................................
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
93696 5 46 6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
95220 5 47 6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:738: 
3
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
99846 5 46 6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb..............................................................
......................................................................................................................................................................

Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
153576 5 47 6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
158208 5 46 6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
165882 5 46 6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:552: 
173556 5 46 6
Oct  6 14:18:18 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:738: 
3
Oct  6 14:18:19 64studio last message repeated 2 times
Oct  6 14:18:19 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usbmidi.c:1368: created 1 output and 1 
input ports

Oct  6 14:18:19 64studio kernel: alsactl[25592]: segfault at 0 ip 
00007fb5c9e2f5a0 sp 00007fffd26840b8 error 4 in 
libc-2.3.6.so[7fb5c9dbd000+121000]
Oct  6 14:18:19 64studio kernel: alsactl[25594]: segfault at 0 ip 
00007fc0e9fc45a0 sp 00007ffff2819238 error 4 in 
libc-2.3.6.so[7fc0e9f52000+121000]
Oct  6 14:18:19 64studio kernel: alsactl[25670]: segfault at 0 ip 
00007fd7550975a0 sp 00007fff5d8ee318 error 4 in 
libc-2.3.6.so[7fd755025000+121000]
Oct  6 14:18:19 64studio kernel: alsactl[25671]: segfault at 0 ip 
00007f2ab8cc65a0 sp 00007fffc151cf38 error 4 in 
libc-2.3.6.so[7f2ab8c54000+121000]

Oct  6 14:18:47 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:456: 
underrun, status=4294967225
Oct  6 14:18:47 64studio kernel: ALSA 
/usr/src/alsa-driver-1.0.18rc3/usb/usx2y/../../alsa-kernel/usb/usx2y/usb_stream.c:456: 
underrun, status=4294967225
Oct  6 14:18:47 64studio kernel: usb 2-1: USB disconnect, address 10 
