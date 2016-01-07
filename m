From: Fabio Estevam <festevam@gmail.com>
Subject: Locking issue from snd_soc_suspend
Date: Thu, 7 Jan 2016 21:49:53 -0200
Message-ID: <CAOMZO5B2J+PSuAdTOA8VwuDSOAjcbeA4G5pMWPt3VAeJCpacEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f181.google.com (mail-ig0-f181.google.com
 [209.85.213.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 78538260483
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 00:49:56 +0100 (CET)
Received: by mail-ig0-f181.google.com with SMTP id t15so40792216igr.0
 for <alsa-devel@alsa-project.org>; Thu, 07 Jan 2016 15:49:56 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi,

I get the following issue when doing a suspend/resume sequence on a
mx6q-cubox-i running 4.4-rc8.

Haven't started debugging it yet, but if someone has some ideas,
please let me know.

Thanks

$ echo enabled > /sys/class/tty/ttymxc0/power/wakeup
$ echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.003 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
Unable to handle kernel NULL pointer dereference at virtual address 0000073c
pgd = ed888000
[0000073c] *pgd=8ecdf831
Internal error: Oops: 17 [#1] SMP ARM
Modules linked in:
CPU: 3 PID: 988 Comm: sh Not tainted 4.4.0-rc8 #272
Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
task: ee2ab980 ti: ed8f8000 task.ti: ed8f8000
PC is at __lock_acquire+0x15c/0x1ba4
LR is at lock_acquire+0x78/0x98
pc : [<c006f120>]    lr : [<c0070f20>]    psr: 20000093
sp : ed8f9bb0  ip : 00000000  fp : ed8f9c3c
r10: 00000000  r9 : c0af1ba8  r8 : 0000073c
r7 : ee2ab980  r6 : c1332014  r5 : c0ae42e4  r4 : ed8f8000
r3 : c112f600  r2 : 00000000  r1 : 00000000  r0 : 0000073c
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 3d88804a  DAC: 00000051
Process sh (pid: 988, stack limit = 0xed8f8210)
Stack: (0xed8f9bb0 to 0xed8fa000)
9ba0:                                     00000000 ee2abe28 00000005 c1332014
9bc0: ee2ab980 c1333944 c0af1ba8 00000016 00000000 ee2abe08 00000000 c1332014
9be0: ee2ab980 ee9b4210 c0af1ba8 0000009b 00000000 ee2abe08 00000004 c1332014
9c00: ee2ab980 ee9d1478 c0af1ba8 0000009c ed8f9cac 00000000 60000013 c05844e0
9c20: 00000001 ee9d1444 00000708 ee9d1410 ed8f9c74 ed8f9c40 c0070f20 c006efd0
9c40: 00000001 00000000 00000000 c05844e0 00000000 00000000 c05844e0 00000000
9c60: c1332014 ee2ab980 ed8f9ccc ed8f9c78 c07ab5b0 c0070eb4 00000001 00000000
9c80: c05844e0 00000000 ed8f9cb4 ed8f9c98 c0071754 c006e920 c07ab840 ee2ab980
9ca0: 00000001 00000000 ee248c10 c03c3194 00000002 ee9d1444 00000000 ee9d1410
9cc0: ed8f9cf4 ed8f9cd0 c05844e0 c07ab560 c05844a8 00000000 00000000 c03c3194
9ce0: 00000002 ee9d1444 ed8f9d04 ed8f9cf8 c03c31c8 c05844b4 ed8f9d3c ed8f9d08
9d00: c03cc850 c03c31a0 c07af6cc c0071974 00000000 00000000 ee9d1410 00000000
9d20: c134b238 00000002 ee9d1444 00000000 ed8f9d6c ed8f9d40 c03cd754 c03cc828
9d40: ee9d14c0 009d1410 c0b016c0 ee9d14c0 ee9d1410 c0b016c0 c134b238 c0b01724
9d60: ed8f9db4 ed8f9d70 c03ceaec c03cd62c a4b37d28 00000002 c03cee68 00000002
9d80: a4b37d28 00000002 60000013 00000002 c12ef69c 00000003 00000003 ed802200
9da0: 00000000 00000004 ed8f9dcc ed8f9db8 c03ceee4 c03ce9e4 00000000 c12ef69c
9dc0: ed8f9e14 ed8f9dd0 c00770a8 c03cee90 c007adf0 c007a834 c0978fac ed8f9e0c
9de0: ed8f9e04 ed8f9df0 c00c74e4 00000000 00000003 c12ef6a8 00000003 ed802200
9e00: 00000000 00000004 ed8f9e34 ed8f9e18 c0077718 c0077024 0000006d 00000003
9e20: c0974c8c c12ef6ac ed8f9e5c ed8f9e38 c00760c0 c00774a8 edffb580 00000004
9e40: ed802200 00000004 00000000 00000000 ed8f9e6c ed8f9e60 c02d4438 c007605c
9e60: ed8f9e8c ed8f9e70 c017bd30 c02d4428 c017bcdc edffb580 ed802200 edffb58c
9e80: ed8f9ed4 ed8f9e90 c017b028 c017bce8 00000000 00000000 60000013 c010e888
9ea0: ed8f9f78 00000051 ed8f8000 c07bf87c 01668408 edf24a00 ed8f9f78 00000004
9ec0: ed8f8000 01668408 ed8f9f44 ed8f9ed8 c010bfd8 c017af6c c006b5a8 c008423c
9ee0: 00000001 ee265234 ed8f9f24 ed8f9ef8 c006b824 c006b59c 00000001 00000000
9f00: c010e888 c0b3f6d5 ed8f9f34 00000001 ee265000 00000000 ed8f9f44 ed8f9f28
9f20: c010e888 edf24a00 01668408 00000004 ed8f9f78 00000004 ed8f9f74 ed8f9f48
9f40: c010d024 c010bfb0 c0129ce4 c0129c48 00000000 00000000 edf24a00 edf24a00
9f60: 00000004 01668408 ed8f9fa4 ed8f9f78 c010d2bc c010cf98 00000000 00000000
9f80: 00000004 b6f935c0 00000004 00000004 c000ff44 00000000 00000000 ed8f9fa8
9fa0: c000fda0 c010d284 00000004 b6f935c0 00000001 01668408 00000004 00000000
9fc0: 00000004 b6f935c0 00000004 00000004 01668408 016662e8 bea7fa48 00000000
9fe0: 00000000 bea7f9c8 b6ecf690 b6f220bc 60000010 00000001 00000000 00000000
Backtrace:
[<c006efc4>] (__lock_acquire) from [<c0070f20>] (lock_acquire+0x78/0x98)
 r10:ee9d1410 r9:00000708 r8:ee9d1444 r7:00000001 r6:c05844e0 r5:60000013
 r4:00000000
[<c0070ea8>] (lock_acquire) from [<c07ab5b0>] (mutex_lock_nested+0x5c/0x3ec)
 r7:ee2ab980 r6:c1332014 r5:00000000 r4:c05844e0
[<c07ab554>] (mutex_lock_nested) from [<c05844e0>] (snd_soc_suspend+0x38/0x404)
 r10:ee9d1410 r9:00000000 r8:ee9d1444 r7:00000002 r6:c03c3194 r5:ee248c10
 r4:00000000
[<c05844a8>] (snd_soc_suspend) from [<c03c31c8>] (platform_pm_suspend+0x34/0x5c)
 r8:ee9d1444 r7:00000002 r6:c03c3194 r5:00000000 r4:00000000 r3:c05844a8
[<c03c3194>] (platform_pm_suspend) from [<c03cc850>]
(dpm_run_callback+0x34/0xb4)
[<c03cc81c>] (dpm_run_callback) from [<c03cd754>] (__device_suspend+0x134/0x36c)
 r10:00000000 r8:ee9d1444 r7:00000002 r6:c134b238 r5:00000000 r4:ee9d1410
[<c03cd620>] (__device_suspend) from [<c03ceaec>] (dpm_suspend+0x114/0x224)
 r8:c0b01724 r7:c134b238 r6:c0b016c0 r5:ee9d1410 r4:ee9d14c0
[<c03ce9d8>] (dpm_suspend) from [<c03ceee4>] (dpm_suspend_start+0x60/0x68)
 r10:00000004 r9:00000000 r8:ed802200 r7:00000003 r6:00000003 r5:c12ef69c
 r4:00000002
[<c03cee84>] (dpm_suspend_start) from [<c00770a8>]
(suspend_devices_and_enter+0x90/0x484)
 r5:c12ef69c r4:00000000
[<c0077018>] (suspend_devices_and_enter) from [<c0077718>]
(pm_suspend+0x27c/0x2b4)
 r10:00000004 r9:00000000 r8:ed802200 r7:00000003 r6:c12ef6a8 r5:00000003
 r4:00000000
[<c007749c>] (pm_suspend) from [<c00760c0>] (state_store+0x70/0xc0)
 r6:c12ef6ac r5:c0974c8c r4:00000003 r3:0000006d
[<c0076050>] (state_store) from [<c02d4438>] (kobj_attr_store+0x1c/0x28)
 r10:00000000 r8:00000000 r7:00000004 r6:ed802200 r5:00000004 r4:edffb580
[<c02d441c>] (kobj_attr_store) from [<c017bd30>] (sysfs_kf_write+0x54/0x58)
[<c017bcdc>] (sysfs_kf_write) from [<c017b028>] (kernfs_fop_write+0xc8/0x1d0)
 r6:edffb58c r5:ed802200 r4:edffb580 r3:c017bcdc
[<c017af60>] (kernfs_fop_write) from [<c010bfd8>] (__vfs_write+0x34/0xe0)
 r10:01668408 r9:ed8f8000 r8:00000004 r7:ed8f9f78 r6:edf24a00 r5:01668408
 r4:c07bf87c
[<c010bfa4>] (__vfs_write) from [<c010d024>] (vfs_write+0x98/0x154)
 r8:00000004 r7:ed8f9f78 r6:00000004 r5:01668408 r4:edf24a00
[<c010cf8c>] (vfs_write) from [<c010d2bc>] (SyS_write+0x44/0x90)
 r10:01668408 r8:00000004 r7:edf24a00 r6:edf24a00 r5:00000000 r4:00000000
[<c010d278>] (SyS_write) from [<c000fda0>] (ret_fast_syscall+0x0/0x1c)
 r10:00000000 r8:c000ff44 r7:00000004 r6:00000004 r5:b6f935c0 r4:00000004
Code: e3a00000 e24bd028 e89daff0 e59f3dec (e5982000)
---[ end trace 0f2193ed95051e25 ]---

[   39.228498] 7ce0: 00000002 ee9d1444 edf17d04 edf17cf8 c03c31f0
c05844dc edf17d3c edf17d08
[   39.236704] 7d00: c03cc878 c03c31c8 c07af6f4 c0071974 00000000
00000000 ee9d1410 00000000
[   39.244910] 7d20: c134b238 00000002 ee9d1444 00000000 edf17d6c
edf17d40 c03cd77c c03cc850
[   39.253116] 7d40: ee9d14c0 009d1410 c0b016c0 ee9d14c0 ee9d1410
c0b016c0 c134b238 c0b01724
[   39.261321] 7d60: edf17db4 edf17d70 c03ceb14 c03cd654 1326b091
00000009 c03cee90 00000002
[   39.269526] 7d80: 1326b091 00000009 60000013 00000002 c12ef69c
00000003 00000003 ed832600
[   39.277731] 7da0: 00000000 00000004 edf17dcc edf17db8 c03cef0c
c03cea0c 00000000 c12ef69c
[   39.285938] 7dc0: edf17e14 edf17dd0 c00770a8 c03ceeb8 c007adf4
c007a838 c0978fb0 edf17e0c
[   39.294143] 7de0: edf17e04 edf17df0 c00c74e8 00000000 00000003
c12ef6a8 00000003 ed832600
[   39.302349] 7e00: 00000000 00000004 edf17e34 edf17e18 c0077718
c0077024 0000006d 00000003
[   39.310555] 7e20: c0974c8c c12ef6ac edf17e5c edf17e38 c00760c0
c00774a8 edfc1680 00000004
[   39.318760] 7e40: ed832600 00000004 00000000 00000000 edf17e6c
edf17e60 c02d4438 c007605c
[   39.326966] 7e60: edf17e8c edf17e70 c017bd34 c02d4428 c017bce0
edfc1680 ed832600 edfc168c
[   39.335172] 7e80: edf17ed4 edf17e90 c017b02c c017bcec 00000000
00000000 60000013 c010e88c
[   39.343377] 7ea0: edf17f78 00000051 edf16000 c07bf87c 01f9a408
edf0b540 edf17f78 00000004
[   39.351583] 7ec0: edf16000 01f9a408 edf17f44 edf17ed8 c010bfdc
c017af70 c006b5a8 c0084240
[   39.359789] 7ee0: 00000001 ee3c7a34 edf17f24 edf17ef8 c006b824
c006b59c 00000001 00000000
[   39.367994] 7f00: c010e88c c0b3f6d5 edf17f34 00000001 ee3c7800
00000000 edf17f44 edf17f28
[   39.376200] 7f20: c010e88c edf0b540 01f9a408 00000004 edf17f78
00000004 edf17f74 edf17f48
[   39.384406] 7f40: c010d028 c010bfb4 c0129ce8 c0129c4c 00000000
00000000 edf0b540 edf0b540
[   39.392611] 7f60: 00000004 01f9a408 edf17fa4 edf17f78 c010d2c0
c010cf9c 00000000 00000000
[   39.400818] 7f80: 00000004 b6ed65c0 00000004 00000004 c000ff44
00000000 00000000 edf17fa8
[   39.409024] 7fa0: c000fda0 c010d288 00000004 b6ed65c0 00000001
01f9a408 00000004 00000000
[   39.417230] 7fc0: 00000004 b6ed65c0 00000004 00000004 01f9a408
01f982e8 bef6eae8 00000000
[   39.425435] 7fe0: 00000000 bef6ea68 b6e12690 b6e650bc 60000010
00000001 00000000 00000000
[   39.433626] Backtrace:
[   39.436134] [<c006efc4>] (__lock_acquire) from [<c0070f20>]
(lock_acquire+0x78/0x98)
[   39.443896]  r10:ee9d1410 r9:00000708 r8:ee9d1444 r7:00000001
r6:c0584508 r5:60000013
[   39.451867]  r4:00000000
[   39.454468] [<c0070ea8>] (lock_acquire) from [<c07ab5d8>]
(mutex_lock_nested+0x5c/0x3ec)
[   39.462576]  r7:edf23980 r6:c1332014 r5:00000000 r4:c0584508
[   39.468382] [<c07ab57c>] (mutex_lock_nested) from [<c0584508>]
(snd_soc_suspend+0x38/0x404)
[   39.476750]  r10:ee9d1410 r9:00000000 r8:ee9d1444 r7:00000002
r6:c03c31bc r5:ee259410
[   39.484718]  r4:00000000
[   39.487313] [<c05844d0>] (snd_soc_suspend) from [<c03c31f0>]
(platform_pm_suspend+0x34/0x5c)
[   39.495766]  r8:ee9d1444 r7:00000002 r6:c03c31bc r5:00000000
r4:00000000 r3:c05844d0
[   39.503676] [<c03c31bc>] (platform_pm_suspend) from [<c03cc878>]
(dpm_run_callback+0x34/0xb4)
[   39.512236] [<c03cc844>] (dpm_run_callback) from [<c03cd77c>]
(__device_suspend+0x134/0x36c)
[   39.520689]  r10:00000000 r8:ee9d1444 r7:00000002 r6:c134b238
r5:00000000 r4:ee9d1410
[   39.528675] [<c03cd648>] (__device_suspend) from [<c03ceb14>]
(dpm_suspend+0x114/0x224)
[   39.536695]  r8:c0b01724 r7:c134b238 r6:c0b016c0 r5:ee9d1410 r4:ee9d14c0
[   39.543551] [<c03cea00>] (dpm_suspend) from [<c03cef0c>]
(dpm_suspend_start+0x60/0x68)
[   39.551483]  r10:00000004 r9:00000000 r8:ed832600 r7:00000003
r6:00000003 r5:c12ef69c
[   39.559452]  r4:00000002
[   39.562047] [<c03ceeac>] (dpm_suspend_start) from [<c00770a8>]
(suspend_devices_and_enter+0x90/0x484)
[   39.571281]  r5:c12ef69c r4:00000000
[   39.574935] [<c0077018>] (suspend_devices_and_enter) from
[<c0077718>] (pm_suspend+0x27c/0x2b4)
[   39.583648]  r10:00000004 r9:00000000 r8:ed832600 r7:00000003
r6:c12ef6a8 r5:00000003
[   39.591616]  r4:00000000
[   39.594200] [<c007749c>] (pm_suspend) from [<c00760c0>]
(state_store+0x70/0xc0)
[   39.601525]  r6:c12ef6ac r5:c0974c8c r4:00000003 r3:0000006d
[   39.607320] [<c0076050>] (state_store) from [<c02d4438>]
(kobj_attr_store+0x1c/0x28)
[   39.615079]  r10:00000000 r8:00000000 r7:00000004 r6:ed832600
r5:00000004 r4:edfc1680
[   39.623077] [<c02d441c>] (kobj_attr_store) from [<c017bd34>]
(sysfs_kf_write+0x54/0x58)
[   39.631117] [<c017bce0>] (sysfs_kf_write) from [<c017b02c>]
(kernfs_fop_write+0xc8/0x1d0)
[   39.639310]  r6:edfc168c r5:ed832600 r4:edfc1680 r3:c017bce0
[   39.645098] [<c017af64>] (kernfs_fop_write) from [<c010bfdc>]
(__vfs_write+0x34/0xe0)
[   39.652944]  r10:01f9a408 r9:edf16000 r8:00000004 r7:edf17f78
r6:edf0b540 r5:01f9a408
[   39.660913]  r4:c07bf87c
[   39.663498] [<c010bfa8>] (__vfs_write) from [<c010d028>]
(vfs_write+0x98/0x154)
[   39.670822]  r8:00000004 r7:edf17f78 r6:00000004 r5:01f9a408 r4:edf0b540
[   39.677673] [<c010cf90>] (vfs_write) from [<c010d2c0>] (SyS_write+0x44/0x90)
[   39.684737]  r10:01f9a408 r8:00000004 r7:edf0b540 r6:edf0b540
r5:00000000 r4:00000000
[   39.692730] [<c010d27c>] (SyS_write) from [<c000fda0>]
(ret_fast_syscall+0x0/0x1c)
[   39.700316]  r10:00000000 r8:c000ff44 r7:00000004 r6:00000004
r5:b6ed65c0 r4:00000004
[   39.708299] Code: e3a00000 e24bd028 e89daff0 e59f3dec (e5982000)
[   39.714422] ---[ end trace 0d94270494797cfb ]---
