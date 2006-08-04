From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002330]: Problems with compiling
	alsa-driver-1.0.12rc1
Date: Fri, 4 Aug 2006 07:28:20 +0200
Message-ID: <f72c11dd2cd3fba1fcb611f58f3c4f6f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6E042179
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Aug 2006 07:28:20 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2330> 
======================================================================
Reported By:                Mikey84
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2330
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5 x86_64
Kernel Version:             2.6.17
======================================================================
Date Submitted:             08-04-2006 07:28 CEST
Last Modified:              08-04-2006 07:28 CEST
======================================================================
Summary:                    Problems with compiling alsa-driver-1.0.12rc1
Description: 
I have a problem with compiling alsa-driver-1.0.12rc1. "Make" command gives
me this:

-------------------------------------------------------------------------------

make dep
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1'
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore'
copying file alsa-kernel/core/info.c
patching file info.c
Hunk #2 succeeded at 21
 with fuzz 2
.
Hunk #3 succeeded at 153
 with fuzz 1
 (offset 31 lines)
.
Hunk #5 succeeded at 175
 (offset 31 lines)
.
Hunk #7 succeeded at 491
 (offset 18 lines)
.
Hunk #9 succeeded at 964
 with fuzz 1
 (offset 28 lines)
.
Hunk #10 succeeded at 989
 (offset 4 lines)
.
copying file alsa-kernel/core/pcm_native.c
patching file pcm_native.c
Hunk #3 succeeded at 2844
 (offset -3 lines)
.
Hunk #5 succeeded at 2917
 (offset -3 lines)
.
Hunk #7 succeeded at 3035
 (offset -3 lines)
.
Hunk #9 succeeded at 3073
 (offset -3 lines)
.
Hunk #11 succeeded at 3139
 (offset -3 lines)
.
Hunk #13 succeeded at 3201
 (offset -3 lines)
.
Hunk #15 succeeded at 3240
 (offset -3 lines)
.
Hunk #17 succeeded at 3272
 (offset -3 lines)
.
Hunk #19 succeeded at 3370
 (offset -3 lines)
.
Hunk #21 succeeded at 3440
 (offset -3 lines)
.
copying file alsa-kernel/core/control.c
patching file control.c
Hunk #2 succeeded at 1327
 (offset 110 lines)
.
copying file alsa-kernel/core/hwdep.c
patching file hwdep.c
Hunk #1 succeeded at 308
 (offset 5 lines)
.
copying file alsa-kernel/core/init.c
patching file init.c
Hunk #2 succeeded at 207
 (offset 15 lines)
.
Hunk #3 succeeded at 265
 (offset 1 line)
.
copying file alsa-kernel/core/rawmidi.c
patching file rawmidi.c
Hunk #1 succeeded at 1297
 (offset 30 lines)
.
Hunk #2 succeeded at 1350
 with fuzz 1
.
copying file alsa-kernel/core/sound.c
patching file sound.c
Hunk #2 succeeded at 187
 (offset -5 lines)
.
Hunk #4 succeeded at 331
 (offset -5 lines)
.
Hunk #5 succeeded at 432
 (offset -1 lines)
.
Hunk #6 succeeded at 456
 (offset -5 lines)
.
Hunk #7 succeeded at 484
 (offset -1 lines)
.
copying file alsa-kernel/core/timer.c
patching file timer.c
Hunk #1 succeeded at 1018
 with fuzz 1
 (offset 23 lines)
.
Hunk #2 succeeded at 1908
 (offset 117 lines)
.
Hunk #3 succeeded at 1859
 with fuzz 2
 (offset 14 lines)
.
copying file alsa-kernel/core/memalloc.c
patching file memalloc.c
copying file alsa-kernel/core/misc.c
patching file misc.c
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/ioctl32'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/ioctl32'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/oss'
copying file alsa-kernel/core/oss/mixer_oss.c
patching file mixer_oss.c
Hunk #1 succeeded at 379
 with fuzz 1
 (offset 2 lines)
.
copying file alsa-kernel/core/oss/pcm_oss.c
patching file pcm_oss.c
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/oss'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq'
copying file alsa-kernel/core/seq/seq.c
patching file seq.c
Hunk #1 succeeded at 57
 (offset 6 lines)
.
copying file alsa-kernel/core/seq/seq_clientmgr.c
patching file seq_clientmgr.c
Hunk #2 succeeded at 2209
 (offset 68 lines)
.
Hunk #3 succeeded at 2490
 with fuzz 1
 (offset 21 lines)
.
copying file alsa-kernel/core/seq/seq_memory.c
patching file seq_memory.c
Hunk #3 succeeded at 248
 (offset 3 lines)
.
make[4]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/instr'
make[4]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/instr'
make[4]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/oss'
copying file alsa-kernel/core/seq/oss/seq_oss.c
patching file seq_oss.c
Hunk #1 succeeded at 189
 (offset 3 lines)
.
Hunk #2 succeeded at 220
 with fuzz 1
.
Hunk #3 succeeded at 327
 (offset -7 lines)
.
make[4]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/oss'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq'
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore'
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c/other'
copying file alsa-kernel/i2c/other/tea575x-tuner.c
patching file tea575x-tuner.c
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c/other'
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c'
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/mpu401'
copying file alsa-kernel/drivers/mpu401/mpu401.c
patching file mpu401.c
Hunk #1 succeeded at 30
 (offset 2 lines)
.
Hunk #3 succeeded at 64
 with fuzz 2
 (offset 2 lines)
.
Hunk #4 succeeded at 90
 with fuzz 2
 (offset -57 lines)
.
Hunk #5 succeeded at 352
 (offset 105 lines)
.
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/mpu401'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/opl3'
copying file alsa-kernel/drivers/opl3/opl3_lib.c
patching file opl3_lib.c
Hunk #1 succeeded at 435
 (offset 2 lines)
.
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/opl3'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/opl4'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/opl4'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/pcsp'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/pcsp'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/vx'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/vx'
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers'
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/ad1816a'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/ad1816a'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/ad1848'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/ad1848'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/cs423x'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/cs423x'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/es1688'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/es1688'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/gus'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/gus'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/msnd'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/msnd'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/opti9xx'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/opti9xx'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/sb'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/sb'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/wavefront'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/wavefront'
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa'
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/synth'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/synth/emux'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/synth/emux'
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/synth'
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci'
copying file alsa-kernel/pci/ad1889.c
patching file ad1889.c
Hunk #1 succeeded at 53
 with fuzz 2
 (offset 1 line)
.
copying file alsa-kernel/pci/bt87x.c
patching file bt87x.c
Hunk #1 succeeded at 815
 (offset 5 lines)
.
copying file alsa-kernel/pci/intel8x0.c
patching file intel8x0.c
Hunk #1 succeeded at 41
 (offset -2 lines)
.
Hunk #2 succeeded at 730
 (offset -19 lines)
.
Hunk #3 succeeded at 758
 (offset -2 lines)
.
Hunk #4 succeeded at 3036
 (offset 223 lines)
.
copying file alsa-kernel/pci/maestro3.c
patching file maestro3.c
Hunk #5 succeeded at 2911
 (offset 1 line)
.
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ac97'
copying file alsa-kernel/pci/ac97/ac97_codec.c
patching file ac97_codec.c
Hunk #1 succeeded at 34
 (offset 1 line)
.
Hunk #2 succeeded at 1791
 with fuzz 2
 (offset -22 lines)
.
Hunk #3 succeeded at 1848
 (offset 2 lines)
.
copying file alsa-kernel/pci/ac97/ac97_bus.c
patching file ac97_bus.c
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ac97'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ali5451'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ali5451'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/au88x0'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/au88x0'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ca0106'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ca0106'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/cs46xx'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/cs46xx'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/cs5535audio'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/cs5535audio'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/echoaudio'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/echoaudio'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/emu10k1'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/emu10k1'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/hda'
copying file alsa-kernel/pci/hda/hda_codec.c
patching file hda_codec.c
Hunk #1 succeeded at 232
 (offset 7 lines)
.
Hunk #2 succeeded at 311
 (offset 5 lines)
.
Hunk #3 succeeded at 339
 (offset 7 lines)
.
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/hda'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ice1712'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ice1712'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/korg1212'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/korg1212'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/mixart'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/mixart'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/nm256'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/nm256'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/pcxhr'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/pcxhr'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/pdplus'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/pdplus'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/riptide'
copying file alsa-kernel/pci/riptide/riptide.c
patching file riptide.c
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/riptide'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/rme9652'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/rme9652'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/trident'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/trident'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/vx222'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/vx222'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ymfpci'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ymfpci'
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci'
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/usb'
copying file alsa-kernel/usb/usbaudio.c
patching file usbaudio.c
Hunk #12 succeeded at 2684
 (offset 1 line)
.
Hunk #14 succeeded at 3041
 (offset 1 line)
.
Hunk #16 succeeded at 3128
 (offset 1 line)
.
Hunk #18 succeeded at 3155
 (offset 1 line)
.
Hunk #20 succeeded at 3416
 (offset 1 line)
.
Hunk #22 succeeded at 3573
 (offset 1 line)
.
copying file alsa-kernel/usb/usbmidi.c
patching file usbmidi.c
Hunk #2 succeeded at 225
 with fuzz 2
 (offset -3 lines)
.
Hunk #3 succeeded at 252
 with fuzz 2
.
Hunk #4 succeeded at 343
 (offset -3 lines)
.
Hunk #5 succeeded at 1366
 (offset 56 lines)
.
Hunk #6 succeeded at 1651
 (offset 2 lines)
.
copying file alsa-kernel/usb/usbmixer.c
patching file usbmixer.c
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/usb/usx2y'
copying file alsa-kernel/usb/usx2y/usX2Yhwdep.c
patching file usX2Yhwdep.c
copying file alsa-kernel/usb/usx2y/usbusx2y.c
patching file usbusx2y.c
copying file alsa-kernel/usb/usx2y/usbusx2yaudio.c
patching file usbusx2yaudio.c
copying file alsa-kernel/usb/usx2y/usx2yhwdeppcm.c
patching file usx2yhwdeppcm.c
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/usb/usx2y'
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/usb'
make[2]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pcmcia'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pcmcia/pdaudiocf'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pcmcia/pdaudiocf'
make[3]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pcmcia/vx'
make[3]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pcmcia/vx'
make[2]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pcmcia'
make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1'
make -C /lib/modules/2.6.17/source
SUBDIRS=/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1
O=/lib/modules/2.6.17/build CPP="gcc -E" CC="gcc" modules
make[1]: Entering directory
`/home/Mikey_A/Asennus_LINUX/Linux/Kernel/linux-2.6.17'
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/hwdep.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/memalloc.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/sgbuf.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/memory_wrapper.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/pcm.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/pcm_native.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/pcm_lib.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/pcm_timer.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/pcm_misc.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/pcm_memory.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/rawmidi.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/rtctimer.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/timer.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/sound.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/init.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/memory.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/info.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/control.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/misc.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/device.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/isadma.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/sound_oss.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/info_oss.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/wrappers.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/misc_driver.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/snd.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/snd-hwdep.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/snd-timer.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/snd-rtctimer.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/snd-pcm.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/snd-page-alloc.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/snd-rawmidi.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/oss/mixer_oss.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/oss/pcm_oss.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/oss/pcm_plugin.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/oss/io.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/oss/copy.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/oss/linear.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/oss/mulaw.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/oss/route.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/oss/rate.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/oss/snd-mixer-oss.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/oss/snd-pcm-oss.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_device.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_dummy.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_instr.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_midi_emul.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_midi_event.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_midi.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_virmidi.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_lock.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_clientmgr.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_memory.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_queue.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_fifo.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_prioq.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_timer.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_system.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_ports.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/seq_info.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/snd-seq.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/snd-seq-device.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/snd-seq-midi-event.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/snd-seq-dummy.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/snd-seq-virmidi.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/snd-seq-midi.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/snd-seq-midi-emul.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/snd-seq-instr.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/instr/ainstr_fm.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/instr/ainstr_simple.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/instr/snd-ainstr-fm.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/instr/snd-ainstr-simple.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/oss/seq_oss.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/oss/seq_oss_init.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/oss/seq_oss_timer.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/oss/seq_oss_ioctl.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/oss/seq_oss_event.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/oss/seq_oss_rw.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/oss/seq_oss_synth.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/oss/seq_oss_midi.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/oss/seq_oss_readq.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/oss/seq_oss_writeq.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/acore/seq/oss/snd-seq-oss.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/aloop.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/dummy.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/mtpav.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/mts64.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/portman2x4.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/serial-u16550.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/virmidi.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/snd-aloop.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/snd-portman2x4.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/snd-mts64.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/snd-dummy.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/snd-virmidi.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/snd-serial-u16550.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/snd-mtpav.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/mpu401/mpu401_uart.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/mpu401/mpu401.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/mpu401/snd-mpu401-uart.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/mpu401/snd-mpu401.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/opl3/opl3_lib.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/opl3/opl3_synth.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/opl3/opl3_seq.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/opl3/opl3_midi.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/opl3/opl3_drums.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/opl3/opl3_oss.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/opl3/snd-opl3-lib.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/opl3/snd-opl3-synth.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/vx/vx_core.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/vx/vx_hwdep.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/vx/vx_pcm.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/vx/vx_mixer.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/vx/vx_cmd.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/vx/vx_uer.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/drivers/vx/snd-vx-lib.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c/cs8427.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c/i2c.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c/snd-cs8427.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c/snd-i2c.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c/other/ak4114.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c/other/ak4117.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c/other/ak4xxx-adda.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c/other/tea575x-tuner.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c/other/snd-tea575x-tuner.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c/other/snd-ak4117.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c/other/snd-ak4xxx-adda.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/i2c/other/snd-ak4114.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/adlib.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/snd-adlib.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/sb/sb_common.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/sb/sb_mixer.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/isa/sb/snd-sb-common.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ad1889.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/als300.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/als4000.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/atiixp_modem.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/atiixp.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/azt3328.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/bt87x.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/cmipci.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/cs4281.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ens1370.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ens1371.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/es1938.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/es1968.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/fm801.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/intel8x0.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/intel8x0m.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/maestro3.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/rme32.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/rme96.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/sonicvibes.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/via82xx_modem.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/via82xx.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-ad1889.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-als300.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-als4000.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-atiixp.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-atiixp-modem.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-azt3328.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-bt87x.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-cmipci.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-cs4281.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-ens1370.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-ens1371.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-es1938.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-es1968.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-fm801.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-intel8x0.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-intel8x0m.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-maestro3.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-rme32.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-rme96.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-sonicvibes.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-via82xx.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/snd-via82xx-modem.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ac97/ac97_bus.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ac97/ac97_codec.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ac97/ac97_pcm.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ac97/ac97_patch.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ac97/ac97_proc.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ac97/ak4531_codec.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ac97/snd-ac97-bus.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ac97/snd-ac97-codec.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ac97/snd-ak4531-codec.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ali5451/ali5451.o
  LD [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/ali5451/snd-ali5451.o
  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.o
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c:
In function 'snd_card_asihpi_playback_hw_params':

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c:352:
warning: cast from pointer to integer of different size

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c:
In function 'snd_card_asihpi_playback_copy':

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c:563:
warning: cast from pointer to integer of different size

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c:
In function 'snd_card_asihpi_capture_hw_params':

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c:683:
warning: cast from pointer to integer of different size

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c:
In function 'snd_card_asihpi_capture_copy':

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/asihpi.c:876:
warning: cast from pointer to integer of different size

  CC [M] 
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.o
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.c:
In function 'hpi_ioctl':

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.c:255:
warning: cast to pointer from integer of different size

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.c:260:
warning: cast from pointer to integer of different size

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.c:
In function 'adapter_probe':

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.c:461:
warning: cast from pointer to integer of different size

In file included from
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.c:572:
/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:
At top level:

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:30:
error: initializer element is not constant

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:30:
error: (near initialization for 'asihpi_pci_tbl[0].driver_data')

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:36:
error: initializer element is not constant

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:36:
error: (near initialization for 'asihpi_pci_tbl[1].driver_data')

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:42:
error: initializer element is not constant

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:42:
error: (near initialization for 'asihpi_pci_tbl[2].driver_data')

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:47:
error: initializer element is not constant

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:47:
error: (near initialization for 'asihpi_pci_tbl[3].driver_data')

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:52:
error: initializer element is not constant

/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpipcida.h:52:
error: (near initialization for 'asihpi_pci_tbl[4].driver_data')

make[5]: 
***
[/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi/hpimod.o]
Error 1

make[4]: ***
[/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci/asihpi]
Error 2
make[3]: ***
[/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1/pci]
Error 2
make[2]: ***
[_module_/home/Mikey_A/Asennus_LINUX/Music/Freebob/needed/alsa/alsa-driver-1.0.12rc1]
Error 2
make[1]: *** [modules] Error 2
make[1]: Leaving directory
`/home/Mikey_A/Asennus_LINUX/Linux/Kernel/linux-2.6.17'
make: *** [compile] Error 2

-------------------------------------------------------------------------------

So what should I do? For me it seems that this hpipcida thing has
problems, but I can be wrong ...

As you see, my kernel version is 2.6.17 and is not packed with
distribution (directly from www.kernel.org) ...
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-04-06 07:28 Mikey84        New Issue                                    
08-04-06 07:28 Mikey84        Distribution              => Fedora Core 5 x86_64
08-04-06 07:28 Mikey84        Kernel Version            => 2.6.17          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
