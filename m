From: Alan Taylor <cathect@gmail.com>
Subject: External Sound Card Prevents Boot, errors
Date: Fri, 1 Apr 2016 14:57:26 -0400
Message-ID: <56FEC496.7020501@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080700050906060100010905"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f176.google.com (mail-qk0-f176.google.com
 [209.85.220.176])
 by alsa0.perex.cz (Postfix) with ESMTP id CC6CC265162
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 20:57:29 +0200 (CEST)
Received: by mail-qk0-f176.google.com with SMTP id s5so42054660qkd.0
 for <alsa-devel@alsa-project.org>; Fri, 01 Apr 2016 11:57:29 -0700 (PDT)
Received: from [192.168.2.9] (h96-61-83-16.cntcnh.dsl.dynamic.tds.net.
 [96.61.83.16])
 by smtp.gmail.com with ESMTPSA id d65sm6703262qgf.30.2016.04.01.11.57.26
 for <alsa-devel@alsa-project.org> (version=TLSv1/SSLv3 cipher=OTHER);
 Fri, 01 Apr 2016 11:57:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080700050906060100010905
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



I have an external sound card--a Topping VX2. When plugged in to USB,
the device prevents Ubuntu from booting properly. It hangs until I
remove the USB cord from the device, then Ubuntu boots normally.

Once booted, the device can be recognized by Ubuntu, but then seems to
nuke PulseAudio, leaving no devices in the Sound Settings.

The VX2 uses Via Technologies VT 1620A USB audio controller. I suspect
that this may be the issue.

I've tried this with two separate VX2 devices, with the same results.

I see:

-110 connection time out
-71 protocol error
-19 no device

Attaching a Pulse Audio log here.

I'm running Ubuntu 15.10.

also posted: https://bugzilla.kernel.org/show_bug.cgi?id=115661

--------------080700050906060100010905
Content-Type: text/x-log;
 name="pulseverbose.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pulseverbose.log"

(   0.000|   0.000) I: [pulseaudio] main.c: setrlimit(RLIMIT_NICE, (31, 31)) failed: Operation not permitted
(   0.000|   0.000) I: [pulseaudio] main.c: setrlimit(RLIMIT_RTPRIO, (9, 9)) failed: Operation not permitted
(   0.000|   0.000) D: [pulseaudio] core-rtclock.c: Timer slack is set to 50 us.
(   0.004|   0.004) D: [pulseaudio] core-util.c: RealtimeKit worked.
(   0.004|   0.000) I: [pulseaudio] core-util.c: Successfully gained nice level -11.
(   0.004|   0.000) I: [pulseaudio] main.c: This is PulseAudio 6.0
(   0.004|   0.000) D: [pulseaudio] main.c: Compilation host: x86_64-pc-linux-gnu
(   0.004|   0.000) D: [pulseaudio] main.c: Compilation CFLAGS: -g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wall -W -Wextra -pipe -Wno-long-long -Wno-overlength-strings -Wunsafe-loop-optimizations -Wundef -Wformat=2 -Wlogical-op -Wsign-compare -Wformat-security -Wmissing-include-dirs -Wformat-nonliteral -Wpointer-arith -Winit-self -Wdeclaration-after-statement -Wfloat-equal -Wmissing-prototypes -Wredundant-decls -Wmissing-declarations -Wmissing-noreturn -Wshadow -Wendif-labels -Wcast-align -Wstrict-aliasing -Wwrite-strings -Wno-unused-parameter -ffast-math -fno-common -fdiagnostics-show-option -fdiagnostics-color=auto
(   0.004|   0.000) D: [pulseaudio] main.c: Running on host: Linux x86_64 4.2.0-34-generic #39-Ubuntu SMP Thu Mar 10 22:13:01 UTC 2016
(   0.004|   0.000) D: [pulseaudio] main.c: Found 12 CPUs.
(   0.004|   0.000) I: [pulseaudio] main.c: Page size is 4096 bytes
(   0.005|   0.000) D: [pulseaudio] main.c: Compiled with Valgrind support: no
(   0.005|   0.000) D: [pulseaudio] main.c: Running in valgrind mode: no
(   0.005|   0.000) D: [pulseaudio] main.c: Running in VM: no
(   0.005|   0.000) D: [pulseaudio] main.c: Optimized build: yes
(   0.005|   0.000) D: [pulseaudio] main.c: FASTPATH defined, only fast path asserts disabled.
(   0.005|   0.000) I: [pulseaudio] main.c: Machine ID is c4a0c801fe1340cf81538919e73928d0.
(   0.005|   0.000) I: [pulseaudio] main.c: Session ID is c2.
(   0.005|   0.000) I: [pulseaudio] main.c: Using runtime directory /run/user/1000/pulse.
(   0.005|   0.000) I: [pulseaudio] main.c: Using state directory /home/alan/.config/pulse.
(   0.005|   0.000) I: [pulseaudio] main.c: Using modules directory /usr/lib/pulse-6.0/modules.
(   0.005|   0.000) I: [pulseaudio] main.c: Running in system mode: no
(   0.005|   0.000) I: [pulseaudio] main.c: Fresh high-resolution timers available! Bon appetit!
(   0.005|   0.000) D: [pulseaudio] memblock.c: Using shared memory pool with 1024 slots of size 64.0 KiB each, total size is 64.0 MiB, maximum usable slot size is 65472
(   0.005|   0.000) D: [pulseaudio] memblock.c: Using shared memory pool with 1024 slots of size 64.0 KiB each, total size is 64.0 MiB, maximum usable slot size is 65472
(   0.006|   0.000) I: [pulseaudio] cpu-x86.c: CPU flags: CMOV MMX SSE SSE2 SSE3 SSSE3 SSE4_1 SSE4_2 
(   0.006|   0.000) I: [pulseaudio] svolume_mmx.c: Initialising MMX optimized volume functions.
(   0.006|   0.000) I: [pulseaudio] remap_mmx.c: Initialising MMX optimized remappers.
(   0.006|   0.000) I: [pulseaudio] svolume_sse.c: Initialising SSE2 optimized volume functions.
(   0.006|   0.000) I: [pulseaudio] remap_sse.c: Initialising SSE2 optimized remappers.
(   0.006|   0.000) I: [pulseaudio] sconv_sse.c: Initialising SSE2 optimized conversions.
(   0.006|   0.000) I: [pulseaudio] svolume_orc.c: Initialising ORC optimized volume functions.
(   0.007|   0.000) D: [pulseaudio] database-tdb.c: Opened TDB database '/home/alan/.config/pulse/c4a0c801fe1340cf81538919e73928d0-device-volumes.tdb'
(   0.007|   0.000) I: [pulseaudio] module-device-restore.c: Successfully opened database file '/home/alan/.config/pulse/c4a0c801fe1340cf81538919e73928d0-device-volumes'.
(   0.007|   0.000) I: [pulseaudio] module.c: Loaded "module-device-restore" (index: #0; argument: "").
(   0.007|   0.000) D: [pulseaudio] database-tdb.c: Opened TDB database '/home/alan/.config/pulse/c4a0c801fe1340cf81538919e73928d0-stream-volumes.tdb'
(   0.007|   0.000) I: [pulseaudio] module-stream-restore.c: Successfully opened database file '/home/alan/.config/pulse/c4a0c801fe1340cf81538919e73928d0-stream-volumes'.
(   0.007|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1 added for object /org/pulseaudio/stream_restore1
(   0.007|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object /org/pulseaudio/stream_restore1/entry0
(   0.007|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object /org/pulseaudio/stream_restore1/entry1
(   0.007|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object /org/pulseaudio/stream_restore1/entry2
(   0.007|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object /org/pulseaudio/stream_restore1/entry3
(   0.008|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object /org/pulseaudio/stream_restore1/entry4
(   0.008|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object /org/pulseaudio/stream_restore1/entry5
(   0.008|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object /org/pulseaudio/stream_restore1/entry6
(   0.008|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object /org/pulseaudio/stream_restore1/entry7
(   0.008|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object /org/pulseaudio/stream_restore1/entry8
(   0.008|   0.000) I: [pulseaudio] module.c: Loaded "module-stream-restore" (index: #1; argument: "").
(   0.008|   0.000) D: [pulseaudio] database-tdb.c: Opened TDB database '/home/alan/.config/pulse/c4a0c801fe1340cf81538919e73928d0-card-database.tdb'
(   0.008|   0.000) I: [pulseaudio] module-card-restore.c: Successfully opened database file '/home/alan/.config/pulse/c4a0c801fe1340cf81538919e73928d0-card-database'.
(   0.008|   0.000) I: [pulseaudio] module.c: Loaded "module-card-restore" (index: #2; argument: "").
(   0.009|   0.000) I: [pulseaudio] module.c: Loaded "module-augment-properties" (index: #3; argument: "").
(   0.009|   0.000) I: [pulseaudio] module.c: Loaded "module-switch-on-port-available" (index: #4; argument: "").
(   0.009|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/lib/pulse-6.0/modules/module-udev-detect.so': success
(   0.013|   0.004) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC1 is accessible: yes
(   0.013|   0.000) D: [pulseaudio] module-udev-detect.c: /devices/pci0000:00/0000:00:03.0/0000:06:00.1/sound/card1 is busy: no
(   0.014|   0.000) D: [pulseaudio] module-udev-detect.c: Loading module-alsa-card with arguments 'device_id="1" name="pci-0000_06_00.1" card_name="alsa_card.pci-0000_06_00.1" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1"'
(   0.016|   0.002) D: [pulseaudio] dbus-util.c: Successfully connected to D-Bus session bus e5a00f309b04d560e69d0ff056fcede2 as :1.131
(   0.017|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully acquired reservation lock on device 'Audio1'
(   0.017|   0.000) I: [pulseaudio] (alsa-lib)utils.c: could not open configuration file /usr/share/alsa/ucm/HDA NVidia/HDA NVidia.conf
(   0.017|   0.000) I: [pulseaudio] (alsa-lib)parser.c: error: could not parse configuration for card HDA NVidia
(   0.017|   0.000) I: [pulseaudio] (alsa-lib)main.c: error: failed to import HDA NVidia use case configuration -2
(   0.017|   0.000) I: [pulseaudio] alsa-ucm.c: UCM not available for card HDA NVidia
(   0.017|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/profile-sets/default.conf'
(   0.019|   0.001) D: [pulseaudio] alsa-mixer.c: Looking at profile input:analog-mono
(   0.019|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Mono (analog-mono)
(   0.019|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.021|   0.001) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0c' failed (-2)
(   0.021|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hw:1: No such file or directory
(   0.021|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:analog-mono
(   0.021|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:analog-stereo
(   0.021|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Stereo (analog-stereo)
(   0.021|   0.000) D: [pulseaudio] alsa-util.c: Trying front:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.024|   0.003) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0c' failed (-2)
(   0.024|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device front:1: No such file or directory
(   0.024|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.025|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0c' failed (-2)
(   0.025|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hw:1: No such file or directory
(   0.025|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:analog-stereo
(   0.025|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:iec958-stereo
(   0.025|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Digital Stereo (IEC958) (iec958-stereo)
(   0.025|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.025|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D1c' failed (-2)
(   0.025|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device iec958:1: No such file or directory
(   0.025|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:iec958-stereo
(   0.025|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-mono
(   0.025|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Mono (analog-mono)
(   0.025|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.025|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0p' failed (-2)
(   0.025|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hw:1: No such file or directory
(   0.025|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-mono
(   0.025|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:analog-mono - will not be able to open output:analog-mono
(   0.025|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:analog-stereo - will not be able to open output:analog-mono
(   0.025|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:iec958-stereo - will not be able to open output:analog-mono
(   0.025|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-stereo
(   0.025|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Stereo (analog-stereo)
(   0.025|   0.000) D: [pulseaudio] alsa-util.c: Trying front:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.026|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0p' failed (-2)
(   0.026|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device front:1: No such file or directory
(   0.026|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.026|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0p' failed (-2)
(   0.026|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hw:1: No such file or directory
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-stereo
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:analog-mono - will not be able to open output:analog-stereo
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:analog-stereo - will not be able to open output:analog-stereo
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:iec958-stereo - will not be able to open output:analog-stereo
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-21
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 2.1 (analog-surround-21)
(   0.026|   0.000) D: [pulseaudio] alsa-util.c: Trying surround21:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.026|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0p' failed (-2)
(   0.026|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device surround21:1: No such file or directory
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-21
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:analog-mono - will not be able to open output:analog-surround-21
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:analog-stereo - will not be able to open output:analog-surround-21
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:iec958-stereo - will not be able to open output:analog-surround-21
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-40
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 4.0 (analog-surround-40)
(   0.026|   0.000) D: [pulseaudio] alsa-util.c: Trying surround40:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.026|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0p' failed (-2)
(   0.026|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device surround40:1: No such file or directory
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-40
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:analog-mono - will not be able to open output:analog-surround-40
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:analog-stereo - will not be able to open output:analog-surround-40
(   0.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:iec958-stereo - will not be able to open output:analog-surround-40
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-41
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 4.1 (analog-surround-41)
(   0.027|   0.000) D: [pulseaudio] alsa-util.c: Trying surround41:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.027|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0p' failed (-2)
(   0.027|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device surround41:1: No such file or directory
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-41
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:analog-mono - will not be able to open output:analog-surround-41
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:analog-stereo - will not be able to open output:analog-surround-41
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:iec958-stereo - will not be able to open output:analog-surround-41
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-50
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 5.0 (analog-surround-50)
(   0.027|   0.000) D: [pulseaudio] alsa-util.c: Trying surround50:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.027|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0p' failed (-2)
(   0.027|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device surround50:1: No such file or directory
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-50
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:analog-mono - will not be able to open output:analog-surround-50
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:analog-stereo - will not be able to open output:analog-surround-50
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:iec958-stereo - will not be able to open output:analog-surround-50
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-51
(   0.027|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 5.1 (analog-surround-51)
(   0.027|   0.000) D: [pulseaudio] alsa-util.c: Trying surround51:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.028|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0p' failed (-2)
(   0.028|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device surround51:1: No such file or directory
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-51
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:analog-mono - will not be able to open output:analog-surround-51
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:analog-stereo - will not be able to open output:analog-surround-51
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:iec958-stereo - will not be able to open output:analog-surround-51
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-71
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 7.1 (analog-surround-71)
(   0.028|   0.000) D: [pulseaudio] alsa-util.c: Trying surround71:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.028|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0p' failed (-2)
(   0.028|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device surround71:1: No such file or directory
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-71
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:analog-mono - will not be able to open output:analog-surround-71
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:analog-stereo - will not be able to open output:analog-surround-71
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:iec958-stereo - will not be able to open output:analog-surround-71
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-stereo
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (IEC958) (iec958-stereo)
(   0.028|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.028|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D1p' failed (-2)
(   0.028|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device iec958:1: No such file or directory
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-stereo
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:analog-mono - will not be able to open output:iec958-stereo
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:analog-stereo - will not be able to open output:iec958-stereo
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:iec958-stereo - will not be able to open output:iec958-stereo
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-ac3-surround-40
(   0.028|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 4.0 (IEC958/AC3) (iec958-ac3-surround-40)
(   0.028|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.028|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:1
(   0.028|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device a52:1: No such file or directory
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-ac3-surround-40
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:analog-mono - will not be able to open output:iec958-ac3-surround-40
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:analog-stereo - will not be able to open output:iec958-ac3-surround-40
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:iec958-stereo - will not be able to open output:iec958-ac3-surround-40
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-ac3-surround-51
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (IEC958/AC3) (iec958-ac3-surround-51)
(   0.029|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.029|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:1
(   0.029|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device a52:1: No such file or directory
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-ac3-surround-51
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:analog-mono - will not be able to open output:iec958-ac3-surround-51
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:analog-stereo - will not be able to open output:iec958-ac3-surround-51
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:iec958-stereo - will not be able to open output:iec958-ac3-surround-51
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-dts-surround-51
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (IEC958/DTS) (iec958-dts-surround-51)
(   0.029|   0.000) D: [pulseaudio] alsa-util.c: Trying dca:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.029|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dca:1
(   0.029|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dca:1: No such file or directory
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-dts-surround-51
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:analog-mono - will not be able to open output:iec958-dts-surround-51
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:analog-stereo - will not be able to open output:iec958-dts-surround-51
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:iec958-stereo - will not be able to open output:iec958-dts-surround-51
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo
(   0.029|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI) (hdmi-stereo)
(   0.029|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.029|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1
(   0.029|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   0.133|   0.103) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   0.237|   0.104) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-stereo supported.
(   0.237|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/hdmi-output-0.conf'
(   0.237|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1
(   0.237|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer hdmi:1: No such file or directory
(   0.237|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:1'
(   0.237|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'hdmi-output-0'
(   0.237|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'HDMI/DP,pcm=3 Jack' succeeded (found!)
(   0.237|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   0.237|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xf24480, direction=1
(   0.237|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-0 (HDMI / DisplayPort), direction=1, priority=59, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   0.237|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=3, alsa_name='HDMI/DP,pcm=3 Jack', detection possible
(   0.237|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:analog-mono - will not be able to open input:analog-mono
(   0.237|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:analog-stereo - will not be able to open input:analog-stereo
(   0.237|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:iec958-stereo - will not be able to open input:iec958-stereo
(   0.245|   0.007) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround
(   0.245|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI) (hdmi-surround)
(   0.245|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.245|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1
(   0.245|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(6) failed: Invalid argument
(   0.253|   0.007) D: [pulseaudio] alsa-util.c: Trying hdmi:1 without SND_PCM_NO_AUTO_FORMAT ...
(   0.253|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1
(   0.253|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(6) failed: Invalid argument
(   0.261|   0.007) D: [pulseaudio] alsa-util.c: Trying plug:hdmi:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.261|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hdmi:1
(   0.261|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(6) failed: Invalid argument
(   0.269|   0.007) D: [pulseaudio] alsa-util.c: Trying plug:hdmi:1 without SND_PCM_NO_AUTO_FORMAT ...
(   0.269|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hdmi:1
(   0.269|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(6) failed: Invalid argument
(   0.269|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:hdmi:1: Invalid argument
(   0.277|   0.007) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround
(   0.277|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:analog-mono - will not be able to open output:hdmi-surround
(   0.277|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:analog-stereo - will not be able to open output:hdmi-surround
(   0.277|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:iec958-stereo - will not be able to open output:hdmi-surround
(   0.277|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71
(   0.277|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI) (hdmi-surround71)
(   0.277|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.277|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1
(   0.277|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(8) failed: Invalid argument
(   0.285|   0.007) D: [pulseaudio] alsa-util.c: Trying hdmi:1 without SND_PCM_NO_AUTO_FORMAT ...
(   0.285|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1
(   0.285|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(8) failed: Invalid argument
(   0.293|   0.007) D: [pulseaudio] alsa-util.c: Trying plug:hdmi:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.293|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hdmi:1
(   0.293|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(8) failed: Invalid argument
(   0.301|   0.007) D: [pulseaudio] alsa-util.c: Trying plug:hdmi:1 without SND_PCM_NO_AUTO_FORMAT ...
(   0.301|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hdmi:1
(   0.301|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(8) failed: Invalid argument
(   0.301|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:hdmi:1: Invalid argument
(   0.309|   0.007) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71
(   0.309|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:analog-mono - will not be able to open output:hdmi-surround71
(   0.309|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:analog-stereo - will not be able to open output:hdmi-surround71
(   0.309|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:iec958-stereo - will not be able to open output:hdmi-surround71
(   0.309|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround
(   0.309|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI/DTS) (hdmi-dts-surround)
(   0.309|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.309|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1
(   0.309|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1: No such file or directory
(   0.309|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround
(   0.309|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:analog-mono - will not be able to open output:hdmi-dts-surround
(   0.309|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:analog-stereo - will not be able to open output:hdmi-dts-surround
(   0.309|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:iec958-stereo - will not be able to open output:hdmi-dts-surround
(   0.309|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra1
(   0.309|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 2) (hdmi-stereo-extra1)
(   0.309|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.309|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,1
(   0.309|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   0.413|   0.103) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   0.517|   0.104) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-stereo-extra1 supported.
(   0.517|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/hdmi-output-1.conf'
(   0.517|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1,1
(   0.517|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer hdmi:1,1: No such file or directory
(   0.517|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:1'
(   0.517|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'hdmi-output-1'
(   0.517|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'HDMI/DP,pcm=7 Jack' succeeded (found!)
(   0.517|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   0.517|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xf1edb0, direction=1
(   0.517|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-1 (HDMI / DisplayPort 2), direction=1, priority=58, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   0.517|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=7, alsa_name='HDMI/DP,pcm=7 Jack', detection possible
(   0.517|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:analog-mono - will not be able to open input:analog-mono
(   0.517|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:analog-stereo - will not be able to open input:analog-stereo
(   0.517|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:iec958-stereo - will not be able to open input:iec958-stereo
(   0.525|   0.007) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra1
(   0.525|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 2) (hdmi-surround-extra1)
(   0.525|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.525|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,1
(   0.525|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(6) failed: Invalid argument
(   0.533|   0.007) D: [pulseaudio] alsa-util.c: Trying hdmi:1,1 without SND_PCM_NO_AUTO_FORMAT ...
(   0.533|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,1
(   0.533|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(6) failed: Invalid argument
(   0.541|   0.007) D: [pulseaudio] alsa-util.c: Trying plug:hdmi:1,1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.541|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Unknown parameter 1
(   0.541|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Parse arguments error: No such file or directory
(   0.541|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM plug:hdmi:1,1
(   0.541|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device plug:hdmi:1,1: No such file or directory
(   0.541|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra1
(   0.541|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:analog-mono - will not be able to open output:hdmi-surround-extra1
(   0.541|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:analog-stereo - will not be able to open output:hdmi-surround-extra1
(   0.541|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:iec958-stereo - will not be able to open output:hdmi-surround-extra1
(   0.541|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra1
(   0.541|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 2) (hdmi-surround71-extra1)
(   0.541|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.541|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,1
(   0.541|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(8) failed: Invalid argument
(   0.549|   0.007) D: [pulseaudio] alsa-util.c: Trying hdmi:1,1 without SND_PCM_NO_AUTO_FORMAT ...
(   0.549|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,1
(   0.549|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(8) failed: Invalid argument
(   0.557|   0.007) D: [pulseaudio] alsa-util.c: Trying plug:hdmi:1,1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.557|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Unknown parameter 1
(   0.557|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Parse arguments error: No such file or directory
(   0.557|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM plug:hdmi:1,1
(   0.557|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device plug:hdmi:1,1: No such file or directory
(   0.557|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra1
(   0.557|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:analog-mono - will not be able to open output:hdmi-surround71-extra1
(   0.557|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:analog-stereo - will not be able to open output:hdmi-surround71-extra1
(   0.557|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra1
(   0.557|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra1
(   0.557|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 2/DTS) (hdmi-dts-surround-extra1)
(   0.557|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:1,1 with SND_PCM_NO_AUTO_FORMAT ...
(   0.557|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1,1
(   0.557|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1,1: No such file or directory
(   0.557|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra1
(   0.557|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra1
(   0.557|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra1
(   0.557|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra1
(   0.557|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra2
(   0.557|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 3) (hdmi-stereo-extra2)
(   0.557|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,2 with SND_PCM_NO_AUTO_FORMAT ...
(   0.557|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,2
(   0.557|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   0.621|   0.063) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   0.725|   0.104) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-stereo-extra2 supported.
(   0.725|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/hdmi-output-2.conf'
(   0.725|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1,2
(   0.725|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer hdmi:1,2: No such file or directory
(   0.725|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:1'
(   0.725|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'hdmi-output-2'
(   0.725|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'HDMI/DP,pcm=8 Jack' succeeded (found!)
(   0.725|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   0.725|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xf713d0, direction=1
(   0.725|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-2 (HDMI / DisplayPort 3), direction=1, priority=57, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   0.725|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=8, alsa_name='HDMI/DP,pcm=8 Jack', detection possible
(   0.725|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:analog-mono - will not be able to open input:analog-mono
(   0.725|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:analog-stereo - will not be able to open input:analog-stereo
(   0.725|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:iec958-stereo - will not be able to open input:iec958-stereo
(   0.733|   0.007) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra2
(   0.733|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 3) (hdmi-surround-extra2)
(   0.733|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,2 with SND_PCM_NO_AUTO_FORMAT ...
(   0.733|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,2
(   0.733|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 123 ms
(   0.813|   0.079) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   0.917|   0.104) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-surround-extra2 supported.
(   0.917|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1,2
(   0.917|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer hdmi:1,2: No such file or directory
(   0.917|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:1'
(   0.917|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   0.917|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xf721b0, direction=1
(   0.917|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-2 (HDMI / DisplayPort 3), direction=1, priority=57, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   0.917|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=8, alsa_name='HDMI/DP,pcm=8 Jack', detection possible
(   0.917|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:analog-mono - will not be able to open input:analog-mono
(   0.917|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:analog-stereo - will not be able to open input:analog-stereo
(   0.917|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:iec958-stereo - will not be able to open input:iec958-stereo
(   0.925|   0.007) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra2
(   0.925|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 3) (hdmi-surround71-extra2)
(   0.925|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,2 with SND_PCM_NO_AUTO_FORMAT ...
(   0.925|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,2
(   0.925|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 92 ms
(   1.005|   0.079) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   1.109|   0.104) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-surround71-extra2 supported.
(   1.109|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1,2
(   1.109|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer hdmi:1,2: No such file or directory
(   1.109|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:1'
(   1.109|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   1.109|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xf71a40, direction=1
(   1.109|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-2 (HDMI / DisplayPort 3), direction=1, priority=57, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   1.109|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=8, alsa_name='HDMI/DP,pcm=8 Jack', detection possible
(   1.109|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:analog-mono - will not be able to open input:analog-mono
(   1.109|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:analog-stereo - will not be able to open input:analog-stereo
(   1.109|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:iec958-stereo - will not be able to open input:iec958-stereo
(   1.117|   0.007) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra2
(   1.117|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 3/DTS) (hdmi-dts-surround-extra2)
(   1.117|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:1,2 with SND_PCM_NO_AUTO_FORMAT ...
(   1.117|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1,2
(   1.117|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1,2: No such file or directory
(   1.117|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra2
(   1.117|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra2
(   1.117|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra2
(   1.117|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra2
(   1.117|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra3
(   1.117|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 4) (hdmi-stereo-extra3)
(   1.117|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.117|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,3
(   1.117|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   1.197|   0.079) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   1.301|   0.104) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-stereo-extra3 supported.
(   1.301|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/hdmi-output-3.conf'
(   1.301|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1,3
(   1.301|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer hdmi:1,3: No such file or directory
(   1.301|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:1'
(   1.301|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'hdmi-output-3'
(   1.301|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'HDMI/DP,pcm=9 Jack' succeeded (found!)
(   1.301|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   1.301|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xf70d20, direction=1
(   1.301|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-3 (HDMI / DisplayPort 4), direction=1, priority=56, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   1.301|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=9, alsa_name='HDMI/DP,pcm=9 Jack', detection possible
(   1.301|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:analog-mono - will not be able to open input:analog-mono
(   1.301|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:analog-stereo - will not be able to open input:analog-stereo
(   1.301|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:iec958-stereo - will not be able to open input:iec958-stereo
(   1.309|   0.007) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra3
(   1.309|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 4) (hdmi-surround-extra3)
(   1.309|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.309|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,3
(   1.309|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 123 ms
(   1.389|   0.079) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   1.493|   0.103) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-surround-extra3 supported.
(   1.493|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1,3
(   1.493|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer hdmi:1,3: No such file or directory
(   1.493|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:1'
(   1.493|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   1.493|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xf76610, direction=1
(   1.493|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-3 (HDMI / DisplayPort 4), direction=1, priority=56, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   1.493|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=9, alsa_name='HDMI/DP,pcm=9 Jack', detection possible
(   1.493|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:analog-mono - will not be able to open input:analog-mono
(   1.493|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:analog-stereo - will not be able to open input:analog-stereo
(   1.493|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:iec958-stereo - will not be able to open input:iec958-stereo
(   1.501|   0.007) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra3
(   1.501|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 4) (hdmi-surround71-extra3)
(   1.501|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.501|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,3
(   1.501|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 92 ms
(   1.581|   0.079) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   1.685|   0.104) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-surround71-extra3 supported.
(   1.685|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1,3
(   1.685|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer hdmi:1,3: No such file or directory
(   1.685|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:1'
(   1.685|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   1.685|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xf765f0, direction=1
(   1.685|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-3 (HDMI / DisplayPort 4), direction=1, priority=56, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   1.685|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=9, alsa_name='HDMI/DP,pcm=9 Jack', detection possible
(   1.685|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:analog-mono - will not be able to open input:analog-mono
(   1.685|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:analog-stereo - will not be able to open input:analog-stereo
(   1.685|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:iec958-stereo - will not be able to open input:iec958-stereo
(   1.693|   0.007) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra3
(   1.693|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 4/DTS) (hdmi-dts-surround-extra3)
(   1.693|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:1,3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.693|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1,3
(   1.693|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1,3: No such file or directory
(   1.693|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra3
(   1.693|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra3
(   1.693|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra3
(   1.693|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra3
(   1.693|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra4
(   1.693|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 5) (hdmi-stereo-extra4)
(   1.693|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,4 with SND_PCM_NO_AUTO_FORMAT ...
(   1.693|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D10p' failed (-2)
(   1.693|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,4: No such file or directory
(   1.693|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra4
(   1.693|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:analog-mono - will not be able to open output:hdmi-stereo-extra4
(   1.693|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:analog-stereo - will not be able to open output:hdmi-stereo-extra4
(   1.693|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra4
(   1.693|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra4
(   1.693|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 5) (hdmi-surround-extra4)
(   1.693|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,4 with SND_PCM_NO_AUTO_FORMAT ...
(   1.694|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D10p' failed (-2)
(   1.694|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,4: No such file or directory
(   1.694|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra4
(   1.694|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:analog-mono - will not be able to open output:hdmi-surround-extra4
(   1.694|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:analog-stereo - will not be able to open output:hdmi-surround-extra4
(   1.694|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:iec958-stereo - will not be able to open output:hdmi-surround-extra4
(   1.694|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra4
(   1.694|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 5) (hdmi-surround71-extra4)
(   1.694|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,4 with SND_PCM_NO_AUTO_FORMAT ...
(   1.694|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D10p' failed (-2)
(   1.694|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,4: No such file or directory
(   1.694|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra4
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:analog-mono - will not be able to open output:hdmi-surround71-extra4
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:analog-stereo - will not be able to open output:hdmi-surround71-extra4
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra4
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra4
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 5/DTS) (hdmi-dts-surround-extra4)
(   1.695|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:1,4 with SND_PCM_NO_AUTO_FORMAT ...
(   1.695|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1,4
(   1.695|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1,4: No such file or directory
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra4
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra4
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra4
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra4
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra5
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 6) (hdmi-stereo-extra5)
(   1.695|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,5 with SND_PCM_NO_AUTO_FORMAT ...
(   1.695|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D11p' failed (-2)
(   1.695|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,5: No such file or directory
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra5
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:analog-mono - will not be able to open output:hdmi-stereo-extra5
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:analog-stereo - will not be able to open output:hdmi-stereo-extra5
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra5
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra5
(   1.695|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 6) (hdmi-surround-extra5)
(   1.695|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,5 with SND_PCM_NO_AUTO_FORMAT ...
(   1.696|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D11p' failed (-2)
(   1.696|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,5: No such file or directory
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra5
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:analog-mono - will not be able to open output:hdmi-surround-extra5
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:analog-stereo - will not be able to open output:hdmi-surround-extra5
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:iec958-stereo - will not be able to open output:hdmi-surround-extra5
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra5
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 6) (hdmi-surround71-extra5)
(   1.696|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,5 with SND_PCM_NO_AUTO_FORMAT ...
(   1.696|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D11p' failed (-2)
(   1.696|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,5: No such file or directory
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra5
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:analog-mono - will not be able to open output:hdmi-surround71-extra5
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:analog-stereo - will not be able to open output:hdmi-surround71-extra5
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra5
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra5
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 6/DTS) (hdmi-dts-surround-extra5)
(   1.696|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:1,5 with SND_PCM_NO_AUTO_FORMAT ...
(   1.696|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1,5
(   1.696|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1,5: No such file or directory
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra5
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra5
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra5
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra5
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra6
(   1.696|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 7) (hdmi-stereo-extra6)
(   1.696|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,6 with SND_PCM_NO_AUTO_FORMAT ...
(   1.697|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D12p' failed (-2)
(   1.697|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,6: No such file or directory
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra6
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:analog-mono - will not be able to open output:hdmi-stereo-extra6
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:analog-stereo - will not be able to open output:hdmi-stereo-extra6
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra6
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra6
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 7) (hdmi-surround-extra6)
(   1.697|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,6 with SND_PCM_NO_AUTO_FORMAT ...
(   1.697|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D12p' failed (-2)
(   1.697|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,6: No such file or directory
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra6
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:analog-mono - will not be able to open output:hdmi-surround-extra6
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:analog-stereo - will not be able to open output:hdmi-surround-extra6
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:iec958-stereo - will not be able to open output:hdmi-surround-extra6
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra6
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 7) (hdmi-surround71-extra6)
(   1.697|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,6 with SND_PCM_NO_AUTO_FORMAT ...
(   1.697|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D12p' failed (-2)
(   1.697|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,6: No such file or directory
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra6
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:analog-mono - will not be able to open output:hdmi-surround71-extra6
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:analog-stereo - will not be able to open output:hdmi-surround71-extra6
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra6
(   1.697|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra6
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 7/DTS) (hdmi-dts-surround-extra6)
(   1.698|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:1,6 with SND_PCM_NO_AUTO_FORMAT ...
(   1.698|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1,6
(   1.698|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1,6: No such file or directory
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra6
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra6
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra6
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra6
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra7
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 8) (hdmi-stereo-extra7)
(   1.698|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,7 with SND_PCM_NO_AUTO_FORMAT ...
(   1.698|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D13p' failed (-2)
(   1.698|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,7: No such file or directory
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra7
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:analog-mono - will not be able to open output:hdmi-stereo-extra7
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:analog-stereo - will not be able to open output:hdmi-stereo-extra7
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra7
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra7
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 8) (hdmi-surround-extra7)
(   1.698|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,7 with SND_PCM_NO_AUTO_FORMAT ...
(   1.698|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D13p' failed (-2)
(   1.698|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,7: No such file or directory
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra7
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:analog-mono - will not be able to open output:hdmi-surround-extra7
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:analog-stereo - will not be able to open output:hdmi-surround-extra7
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:iec958-stereo - will not be able to open output:hdmi-surround-extra7
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra7
(   1.698|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 8) (hdmi-surround71-extra7)
(   1.698|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,7 with SND_PCM_NO_AUTO_FORMAT ...
(   1.699|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D13p' failed (-2)
(   1.699|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,7: No such file or directory
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra7
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:analog-mono - will not be able to open output:hdmi-surround71-extra7
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:analog-stereo - will not be able to open output:hdmi-surround71-extra7
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra7
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra7
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 8/DTS) (hdmi-dts-surround-extra7)
(   1.699|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:1,7 with SND_PCM_NO_AUTO_FORMAT ...
(   1.699|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1,7
(   1.699|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1,7: No such file or directory
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra7
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra7
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra7
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra7
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:multichannel
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Multichannel (multichannel)
(   1.699|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:1 with SND_PCM_NO_AUTO_FORMAT ...
(   1.699|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0c' failed (-2)
(   1.699|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hw:1: No such file or directory
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:multichannel
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:multichannel - will not be able to open output:analog-mono
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:multichannel - will not be able to open output:analog-stereo
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:multichannel - will not be able to open output:analog-surround-21
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:multichannel - will not be able to open output:analog-surround-40
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:multichannel - will not be able to open output:analog-surround-41
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:multichannel - will not be able to open output:analog-surround-50
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:multichannel - will not be able to open output:analog-surround-51
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:multichannel - will not be able to open output:analog-surround-71
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:multichannel - will not be able to open output:iec958-stereo
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:multichannel - will not be able to open output:iec958-ac3-surround-40
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:multichannel - will not be able to open output:iec958-ac3-surround-51
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:multichannel - will not be able to open output:iec958-dts-surround-51
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:multichannel - will not be able to open input:multichannel
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:multichannel - will not be able to open output:hdmi-surround
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:multichannel - will not be able to open output:hdmi-surround71
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:multichannel - will not be able to open output:hdmi-dts-surround
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:multichannel - will not be able to open input:multichannel
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:multichannel - will not be able to open output:hdmi-surround-extra1
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:multichannel - will not be able to open output:hdmi-surround71-extra1
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:multichannel - will not be able to open output:hdmi-dts-surround-extra1
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:multichannel - will not be able to open input:multichannel
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:multichannel - will not be able to open input:multichannel
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:multichannel - will not be able to open input:multichannel
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:multichannel - will not be able to open output:hdmi-dts-surround-extra2
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:multichannel - will not be able to open input:multichannel
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:multichannel - will not be able to open input:multichannel
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:multichannel - will not be able to open input:multichannel
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:multichannel - will not be able to open output:hdmi-dts-surround-extra3
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:multichannel - will not be able to open output:hdmi-stereo-extra4
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:multichannel - will not be able to open output:hdmi-surround-extra4
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:multichannel - will not be able to open output:hdmi-surround71-extra4
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:multichannel - will not be able to open output:hdmi-dts-surround-extra4
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:multichannel - will not be able to open output:hdmi-stereo-extra5
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:multichannel - will not be able to open output:hdmi-surround-extra5
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:multichannel - will not be able to open output:hdmi-surround71-extra5
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:multichannel - will not be able to open output:hdmi-dts-surround-extra5
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:multichannel - will not be able to open output:hdmi-stereo-extra6
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:multichannel - will not be able to open output:hdmi-surround-extra6
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:multichannel - will not be able to open output:hdmi-surround71-extra6
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:multichannel - will not be able to open output:hdmi-dts-surround-extra6
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:multichannel - will not be able to open output:hdmi-stereo-extra7
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:multichannel - will not be able to open output:hdmi-surround-extra7
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:multichannel - will not be able to open output:hdmi-surround71-extra7
(   1.699|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:multichannel - will not be able to open output:hdmi-dts-surround-extra7
(   1.700|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(   1.700|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(   1.700|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(   1.700|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(   1.700|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(   1.700|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(   1.700|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(   1.700|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(   1.700|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(   1.700|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(   1.700|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Profile set 0xe36e40, auto_profiles=yes, probed=yes, n_mappings=8, n_profiles=8, n_decibel_fixes=0
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping hdmi-stereo (Digital Stereo (HDMI)), priority=54, channel_map=front-left,front-right, supported=yes, direction=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping hdmi-stereo-extra1 (Digital Stereo (HDMI 2)), priority=52, channel_map=front-left,front-right, supported=yes, direction=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping hdmi-stereo-extra2 (Digital Stereo (HDMI 3)), priority=52, channel_map=front-left,front-right, supported=yes, direction=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping hdmi-surround-extra2 (Digital Surround 5.1 (HDMI 3)), priority=1, channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe, supported=yes, direction=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping hdmi-surround71-extra2 (Digital Surround 7.1 (HDMI 3)), priority=1, channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe,side-left,side-right, supported=yes, direction=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping hdmi-stereo-extra3 (Digital Stereo (HDMI 4)), priority=52, channel_map=front-left,front-right, supported=yes, direction=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping hdmi-surround-extra3 (Digital Surround 5.1 (HDMI 4)), priority=1, channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe, supported=yes, direction=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping hdmi-surround71-extra3 (Digital Surround 7.1 (HDMI 4)), priority=1, channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe,side-left,side-right, supported=yes, direction=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-stereo (Digital Stereo (HDMI) Output), priority=5400, supported=yes n_input_mappings=0, n_output_mappings=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-stereo
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-stereo-extra1 (Digital Stereo (HDMI 2) Output), priority=5200, supported=yes n_input_mappings=0, n_output_mappings=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-stereo-extra1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-stereo-extra2 (Digital Stereo (HDMI 3) Output), priority=5200, supported=yes n_input_mappings=0, n_output_mappings=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-stereo-extra2
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-surround-extra2 (Digital Surround 5.1 (HDMI 3) Output), priority=100, supported=yes n_input_mappings=0, n_output_mappings=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-surround-extra2
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-surround71-extra2 (Digital Surround 7.1 (HDMI 3) Output), priority=100, supported=yes n_input_mappings=0, n_output_mappings=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-surround71-extra2
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-stereo-extra3 (Digital Stereo (HDMI 4) Output), priority=5200, supported=yes n_input_mappings=0, n_output_mappings=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-stereo-extra3
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-surround-extra3 (Digital Surround 5.1 (HDMI 4) Output), priority=100, supported=yes n_input_mappings=0, n_output_mappings=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-surround-extra3
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:hdmi-surround71-extra3 (Digital Surround 7.1 (HDMI 4) Output), priority=100, supported=yes n_input_mappings=0, n_output_mappings=1
(   1.700|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-surround71-extra3
(   1.701|   0.000) I: [pulseaudio] module-card-restore.c: Restoring port latency offsets for card alsa_card.pci-0000_06_00.1.
(   1.701|   0.000) I: [pulseaudio] card.c: Created 0 "alsa_card.pci-0000_06_00.1"
(   1.701|   0.000) D: [pulseaudio] module-alsa-card.c: Found 4 jacks.
(   1.701|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:1'
(   1.701|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'HDMI/DP,pcm=3 Jack' is now plugged in
(   1.701|   0.000) D: [pulseaudio] device-port.c: Setting port hdmi-output-0 to status yes
(   1.701|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   1.701|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'HDMI/DP,pcm=7 Jack' is now plugged in
(   1.701|   0.000) D: [pulseaudio] device-port.c: Setting port hdmi-output-1 to status yes
(   1.701|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   1.701|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'HDMI/DP,pcm=8 Jack' is now unplugged
(   1.701|   0.000) D: [pulseaudio] device-port.c: Setting port hdmi-output-2 to status no
(   1.701|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   1.701|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'HDMI/DP,pcm=9 Jack' is now unplugged
(   1.701|   0.000) D: [pulseaudio] device-port.c: Setting port hdmi-output-3 to status no
(   1.701|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   1.702|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully create reservation lock monitor for device 'Audio1'
(   1.702|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1 with SND_PCM_NO_AUTO_FORMAT ...
(   1.702|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1
(   1.702|   0.000) I: [pulseaudio] alsa-util.c: Trying to disable ALSA period wakeups, using timers only
(   1.702|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   1.821|   0.118) D: [pulseaudio] alsa-util.c: Set buffer size first (to 88200 samples), period size second (to 88200 samples).
(   1.925|   0.103) I: [pulseaudio] alsa-util.c: ALSA period wakeups disabled
(   1.925|   0.000) I: [pulseaudio] alsa-sink.c: Successfully opened device hdmi:1.
(   1.925|   0.000) I: [pulseaudio] alsa-sink.c: Selected mapping 'Digital Stereo (HDMI)' (hdmi-stereo).
(   1.925|   0.000) I: [pulseaudio] alsa-sink.c: Successfully enabled mmap() mode.
(   1.925|   0.000) I: [pulseaudio] alsa-sink.c: Successfully enabled timer-based scheduling mode.
(   1.925|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1
(   1.925|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer hdmi:1: No such file or directory
(   1.925|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:1'
(   1.925|   0.000) D: [pulseaudio] alsa-mixer.c: Added 1 ports
(   1.925|   0.000) I: [pulseaudio] sink.c: Created sink 0 "alsa_output.pci-0000_06_00.1.hdmi-stereo" with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
(   1.925|   0.000) I: [pulseaudio] sink.c:     alsa.resolution_bits = "16"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.api = "alsa"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.class = "sound"
(   1.925|   0.000) I: [pulseaudio] sink.c:     alsa.class = "generic"
(   1.925|   0.000) I: [pulseaudio] sink.c:     alsa.subclass = "generic-mix"
(   1.925|   0.000) I: [pulseaudio] sink.c:     alsa.name = "HDMI 0"
(   1.925|   0.000) I: [pulseaudio] sink.c:     alsa.id = "HDMI 0"
(   1.925|   0.000) I: [pulseaudio] sink.c:     alsa.subdevice = "0"
(   1.925|   0.000) I: [pulseaudio] sink.c:     alsa.subdevice_name = "subdevice #0"
(   1.925|   0.000) I: [pulseaudio] sink.c:     alsa.device = "3"
(   1.925|   0.000) I: [pulseaudio] sink.c:     alsa.card = "1"
(   1.925|   0.000) I: [pulseaudio] sink.c:     alsa.card_name = "HDA NVidia"
(   1.925|   0.000) I: [pulseaudio] sink.c:     alsa.long_card_name = "HDA NVidia at 0xfb080000 irq 17"
(   1.925|   0.000) I: [pulseaudio] sink.c:     alsa.driver_name = "snd_hda_intel"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.bus_path = "pci-0000:06:00.1"
(   1.925|   0.000) I: [pulseaudio] sink.c:     sysfs.path = "/devices/pci0000:00/0000:00:03.0/0000:06:00.1/sound/card1"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.bus = "pci"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.vendor.id = "10de"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.vendor.name = "NVIDIA Corporation"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.product.id = "0fba"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.string = "hdmi:1"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.buffering.buffer_size = "65536"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.buffering.fragment_size = "32768"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.access_mode = "mmap+timer"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.profile.name = "hdmi-stereo"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.profile.description = "Digital Stereo (HDMI)"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.description = "HDA NVidia Digital Stereo (HDMI)"
(   1.925|   0.000) I: [pulseaudio] sink.c:     alsa.mixer_name = "Nvidia GPU 72 HDMI/DP"
(   1.925|   0.000) I: [pulseaudio] sink.c:     alsa.components = "HDA:10de0072,38422951,00100100"
(   1.925|   0.000) I: [pulseaudio] sink.c:     module-udev-detect.discovered = "1"
(   1.925|   0.000) I: [pulseaudio] sink.c:     device.icon_name = "audio-card-pci"
(   1.925|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   1.925|   0.000) I: [pulseaudio] source.c: Created source 0 "alsa_output.pci-0000_06_00.1.hdmi-stereo.monitor" with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
(   1.925|   0.000) I: [pulseaudio] source.c:     device.description = "Monitor of HDA NVidia Digital Stereo (HDMI)"
(   1.925|   0.000) I: [pulseaudio] source.c:     device.class = "monitor"
(   1.925|   0.000) I: [pulseaudio] source.c:     alsa.card = "1"
(   1.925|   0.000) I: [pulseaudio] source.c:     alsa.card_name = "HDA NVidia"
(   1.925|   0.000) I: [pulseaudio] source.c:     alsa.long_card_name = "HDA NVidia at 0xfb080000 irq 17"
(   1.925|   0.000) I: [pulseaudio] source.c:     alsa.driver_name = "snd_hda_intel"
(   1.925|   0.000) I: [pulseaudio] source.c:     device.bus_path = "pci-0000:06:00.1"
(   1.925|   0.000) I: [pulseaudio] source.c:     sysfs.path = "/devices/pci0000:00/0000:00:03.0/0000:06:00.1/sound/card1"
(   1.925|   0.000) I: [pulseaudio] source.c:     device.bus = "pci"
(   1.925|   0.000) I: [pulseaudio] source.c:     device.vendor.id = "10de"
(   1.925|   0.000) I: [pulseaudio] source.c:     device.vendor.name = "NVIDIA Corporation"
(   1.925|   0.000) I: [pulseaudio] source.c:     device.product.id = "0fba"
(   1.925|   0.000) I: [pulseaudio] source.c:     device.string = "1"
(   1.925|   0.000) I: [pulseaudio] source.c:     module-udev-detect.discovered = "1"
(   1.925|   0.000) I: [pulseaudio] source.c:     device.icon_name = "audio-card-pci"
(   1.926|   0.000) I: [pulseaudio] alsa-sink.c: Using 2.0 fragments of size 32768 bytes (185.76ms), buffer size is 65536 bytes (371.52ms)
(   1.926|   0.000) I: [pulseaudio] alsa-sink.c: Time scheduling watermark is 20.00ms
(   1.926|   0.000) D: [pulseaudio] alsa-sink.c: hwbuf_unused=0
(   1.926|   0.000) D: [pulseaudio] alsa-sink.c: setting avail_min=15502
(   1.926|   0.000) D: [pulseaudio] alsa-mixer.c: Activating path hdmi-output-0
(   1.926|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-0 (HDMI / DisplayPort), direction=1, priority=59, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   1.926|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=3, alsa_name='HDMI/DP,pcm=3 Jack', detection possible
(   1.926|   0.000) I: [pulseaudio] alsa-sink.c: Driver does not support hardware volume control, falling back to software volume control.
(   1.926|   0.000) I: [pulseaudio] alsa-sink.c: Driver does not support hardware mute control, falling back to software mute control.
(   1.926|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_dump():
(   1.926|   0.000) D: [pulseaudio] alsa-util.c: Hooks PCM
(   1.926|   0.000) D: [pulseaudio] alsa-util.c: Its setup is:
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   stream       : PLAYBACK
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   access       : MMAP_INTERLEAVED
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   format       : S16_LE
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   subformat    : STD
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   channels     : 2
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   rate         : 44100
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   exact rate   : 44100 (44100/1)
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   msbits       : 16
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   buffer_size  : 16384
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   period_size  : 8192
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   period_time  : 185759
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_type  : MONOTONIC
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   period_step  : 1
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   avail_min    : 15502
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   period_event : 0
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   start_threshold  : -1
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   stop_threshold   : 4611686018427387904
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   silence_threshold: 0
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   silence_size : 0
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   boundary     : 4611686018427387904
(   1.926|   0.000) D: [pulseaudio] alsa-util.c: Slave: Hardware PCM card 1 'HDA NVidia' device 3 subdevice 0
(   1.926|   0.000) D: [pulseaudio] alsa-util.c: Its setup is:
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   stream       : PLAYBACK
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   access       : MMAP_INTERLEAVED
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   format       : S16_LE
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   subformat    : STD
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   channels     : 2
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   rate         : 44100
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   exact rate   : 44100 (44100/1)
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   msbits       : 16
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   buffer_size  : 16384
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   period_size  : 8192
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   period_time  : 185759
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_type  : MONOTONIC
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   period_step  : 1
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   avail_min    : 15502
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   period_event : 0
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   start_threshold  : -1
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   stop_threshold   : 4611686018427387904
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   silence_threshold: 0
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   silence_size : 0
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   boundary     : 4611686018427387904
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   appl_ptr     : 0
(   1.926|   0.000) D: [pulseaudio] alsa-util.c:   hw_ptr       : 0
(   1.926|   0.000) D: [alsa-sink-HDMI 0] alsa-sink.c: Thread starting up
(   1.931|   0.005) D: [alsa-sink-HDMI 0] core-util.c: RealtimeKit worked.
(   1.931|   0.000) I: [alsa-sink-HDMI 0] core-util.c: Successfully enabled SCHED_RR scheduling for thread, with priority 5.
(   1.932|   0.000) I: [alsa-sink-HDMI 0] alsa-sink.c: Starting playback.
(   1.932|   0.000) D: [pulseaudio] alsa-util.c: Monitor name in ELD info is 'DELL U2417H
(   1.932|   0.000) D: [pulseaudio] alsa-util.c:  ' (for device=3)
(   1.932|   0.000) D: [pulseaudio] alsa-util.c: Monitor name in ELD info is 'DELL U2417H
(   1.932|   0.000) D: [pulseaudio] alsa-util.c:  ' (for device=7)
(   1.932|   0.000) D: [pulseaudio] alsa-util.c: ELD info empty (for device=8)
(   1.932|   0.000) D: [pulseaudio] alsa-util.c: ELD info empty (for device=9)
(   1.932|   0.000) I: [pulseaudio] module.c: Loaded "module-alsa-card" (index: #6; argument: "device_id="1" name="pci-0000_06_00.1" card_name="alsa_card.pci-0000_06_00.1" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1"").
(   1.932|   0.000) I: [pulseaudio] module-udev-detect.c: Card /devices/pci0000:00/0000:00:03.0/0000:06:00.1/sound/card1 (alsa_card.pci-0000_06_00.1) module loaded.
(   1.932|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC3 is accessible: yes
(   1.932|   0.000) D: [pulseaudio] module-udev-detect.c: /devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11:1.1/sound/card3 is busy: no
(   1.932|   0.000) D: [pulseaudio] module-udev-detect.c: Loading module-alsa-card with arguments 'device_id="3" name="usb-Yoyodyne_Consulting_ODAC-revB-01" card_name="alsa_card.usb-Yoyodyne_Consulting_ODAC-revB-01" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1"'
(   1.933|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully acquired reservation lock on device 'Audio3'
(   1.933|   0.000) I: [pulseaudio] (alsa-lib)utils.c: could not open configuration file /usr/share/alsa/ucm/ODAC-revB/ODAC-revB.conf
(   1.933|   0.000) I: [pulseaudio] (alsa-lib)parser.c: error: could not parse configuration for card ODAC-revB
(   1.933|   0.000) I: [pulseaudio] (alsa-lib)main.c: error: failed to import ODAC-revB use case configuration -2
(   1.933|   0.000) I: [pulseaudio] alsa-ucm.c: UCM not available for card ODAC-revB
(   1.933|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/profile-sets/default.conf'
(   1.934|   0.001) D: [pulseaudio] alsa-mixer.c: Looking at profile input:analog-mono
(   1.935|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Mono (analog-mono)
(   1.935|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.935|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC3D0c' failed (-2)
(   1.935|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hw:3: No such file or directory
(   1.935|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:analog-mono
(   1.935|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:analog-stereo
(   1.935|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Stereo (analog-stereo)
(   1.935|   0.000) D: [pulseaudio] alsa-util.c: Trying front:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.935|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC3D0c' failed (-2)
(   1.935|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device front:3: No such file or directory
(   1.935|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.935|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC3D0c' failed (-2)
(   1.935|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hw:3: No such file or directory
(   1.935|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:analog-stereo
(   1.935|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:iec958-stereo
(   1.935|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Digital Stereo (IEC958) (iec958-stereo)
(   1.935|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.935|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC3D0c' failed (-2)
(   1.935|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device iec958:3: No such file or directory
(   1.935|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:iec958-stereo
(   1.935|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-mono
(   1.936|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Mono (analog-mono)
(   1.936|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.936|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:3
(   1.936|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.936|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   1.936|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:3 without SND_PCM_NO_AUTO_FORMAT ...
(   1.936|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:3
(   1.936|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.936|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   1.936|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.936|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:3
(   1.936|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.936|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   1.936|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:3 without SND_PCM_NO_AUTO_FORMAT ...
(   1.936|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:3
(   1.936|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.936|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   1.936|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:hw:3: Invalid argument
(   1.936|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-mono
(   1.936|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:analog-mono - will not be able to open output:analog-mono
(   1.937|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:analog-stereo - will not be able to open output:analog-mono
(   1.937|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:iec958-stereo - will not be able to open output:analog-mono
(   1.937|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-stereo
(   1.937|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Stereo (analog-stereo)
(   1.937|   0.000) D: [pulseaudio] alsa-util.c: Trying front:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.937|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:3
(   1.937|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.937|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
(   1.938|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   1.938|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-stereo supported.
(   1.938|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf'
(   1.938|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   1.938|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-lineout.conf'
(   1.938|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   1.938|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-speaker.conf'
(   1.939|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   1.939|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-headphones.conf'
(   1.939|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   1.939|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-headphones-2.conf'
(   1.939|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   1.939|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL front:3
(   1.939|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer front:3: No such file or directory
(   1.939|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:3'
(   1.939|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output'
(   1.939|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=1, switch=1, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-lineout'
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Phantom Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Front Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Front Phantom Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out CLFE Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out CLFE Phantom Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Surround Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Surround Phantom Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Side Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Side Phantom Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line HP Swap' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Front' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Surround' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Side' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=1, switch=1, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-output-lineout', none of required-any elements preset.
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-speaker'
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Headphone Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Headphone Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Front Jack' succeeded (not found)
(   1.940|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Speaker Phantom Jack' succeeded (not found)
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Speaker Front Phantom Jack' succeeded (not found)
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Front' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Surround' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Side' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=1, switch=1, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-output-speaker', none of required-any elements preset.
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-headphones'
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Headphone Jack' succeeded (not found)
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Headphone Phantom Jack' succeeded (not found)
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Headphone Jack' succeeded (not found)
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Headphone Phantom Jack' succeeded (not found)
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Phantom Jack' succeeded (not found)
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Mic Jack' succeeded (not found)
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headset' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line HP Swap' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=0, switch=0, enumeration=0).
(   1.941|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Front' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Surround' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Side' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=1, switch=1, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-output-headphones', none of required-any elements preset.
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-headphones-2'
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' failed.
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xe51c30, direction=1
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output (Analog Output), direction=1, priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=110, min_dB=-55, max_dB=0
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:analog-mono - will not be able to open input:analog-mono
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:analog-stereo - will not be able to open input:analog-stereo
(   1.942|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:iec958-stereo - will not be able to open input:iec958-stereo
(   1.945|   0.003) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-21
(   1.945|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 2.1 (analog-surround-21)
(   1.945|   0.000) D: [pulseaudio] alsa-util.c: Trying surround21:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.946|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state for chmap_get: OPEN
(   1.946|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround21:3
(   1.946|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.946|   0.000) D: [pulseaudio] alsa-util.c: Trying surround21:3 without SND_PCM_NO_AUTO_FORMAT ...
(   1.946|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state for chmap_get: OPEN
(   1.946|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround21:3
(   1.946|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.946|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround21:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.947|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state for chmap_get: OPEN
(   1.947|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround21:3
(   1.947|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   1.947|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.947|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround21:3 without SND_PCM_NO_AUTO_FORMAT ...
(   1.947|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state for chmap_get: OPEN
(   1.947|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround21:3
(   1.947|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   1.947|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.947|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround21:3: Invalid argument
(   1.947|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-21
(   1.947|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:analog-mono - will not be able to open output:analog-surround-21
(   1.947|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:analog-stereo - will not be able to open output:analog-surround-21
(   1.947|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:iec958-stereo - will not be able to open output:analog-surround-21
(   1.947|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-40
(   1.947|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 4.0 (analog-surround-40)
(   1.947|   0.000) D: [pulseaudio] alsa-util.c: Trying surround40:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.948|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround40:3
(   1.948|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.948|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(4) failed: Invalid argument
(   1.948|   0.000) D: [pulseaudio] alsa-util.c: Trying surround40:3 without SND_PCM_NO_AUTO_FORMAT ...
(   1.948|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround40:3
(   1.948|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.948|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(4) failed: Invalid argument
(   1.948|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround40:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.949|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround40:3
(   1.949|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.949|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(4) failed: Invalid argument
(   1.949|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround40:3 without SND_PCM_NO_AUTO_FORMAT ...
(   1.950|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround40:3
(   1.950|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.950|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(4) failed: Invalid argument
(   1.950|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround40:3: Invalid argument
(   1.950|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-40
(   1.950|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:analog-mono - will not be able to open output:analog-surround-40
(   1.950|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:analog-stereo - will not be able to open output:analog-surround-40
(   1.950|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:iec958-stereo - will not be able to open output:analog-surround-40
(   1.950|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-41
(   1.950|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 4.1 (analog-surround-41)
(   1.950|   0.000) D: [pulseaudio] alsa-util.c: Trying surround41:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.950|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround41:3
(   1.950|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.950|   0.000) D: [pulseaudio] alsa-util.c: Trying surround41:3 without SND_PCM_NO_AUTO_FORMAT ...
(   1.951|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround41:3
(   1.951|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.951|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround41:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.951|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround41:3
(   1.951|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   1.951|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.951|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround41:3 without SND_PCM_NO_AUTO_FORMAT ...
(   1.952|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround41:3
(   1.952|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   1.952|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.952|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround41:3: Invalid argument
(   1.952|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-41
(   1.952|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:analog-mono - will not be able to open output:analog-surround-41
(   1.952|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:analog-stereo - will not be able to open output:analog-surround-41
(   1.952|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:iec958-stereo - will not be able to open output:analog-surround-41
(   1.952|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-50
(   1.952|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 5.0 (analog-surround-50)
(   1.952|   0.000) D: [pulseaudio] alsa-util.c: Trying surround50:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.952|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround50:3
(   1.952|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.952|   0.000) D: [pulseaudio] alsa-util.c: Trying surround50:3 without SND_PCM_NO_AUTO_FORMAT ...
(   1.953|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround50:3
(   1.953|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.953|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround50:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.953|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround50:3
(   1.953|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   1.953|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.953|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround50:3 without SND_PCM_NO_AUTO_FORMAT ...
(   1.954|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround50:3
(   1.954|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   1.954|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.954|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround50:3: Invalid argument
(   1.954|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-50
(   1.954|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:analog-mono - will not be able to open output:analog-surround-50
(   1.954|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:analog-stereo - will not be able to open output:analog-surround-50
(   1.954|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:iec958-stereo - will not be able to open output:analog-surround-50
(   1.954|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-51
(   1.954|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 5.1 (analog-surround-51)
(   1.954|   0.000) D: [pulseaudio] alsa-util.c: Trying surround51:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.954|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround51:3
(   1.954|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.954|   0.000) D: [pulseaudio] alsa-util.c: Trying surround51:3 without SND_PCM_NO_AUTO_FORMAT ...
(   1.955|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround51:3
(   1.955|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.955|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround51:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.955|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround51:3
(   1.955|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   1.955|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.955|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround51:3 without SND_PCM_NO_AUTO_FORMAT ...
(   1.955|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround51:3
(   1.955|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   1.956|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.956|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround51:3: Invalid argument
(   1.956|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-51
(   1.956|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:analog-mono - will not be able to open output:analog-surround-51
(   1.956|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:analog-stereo - will not be able to open output:analog-surround-51
(   1.956|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:iec958-stereo - will not be able to open output:analog-surround-51
(   1.956|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-71
(   1.956|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 7.1 (analog-surround-71)
(   1.956|   0.000) D: [pulseaudio] alsa-util.c: Trying surround71:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.956|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround71:3
(   1.956|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.956|   0.000) D: [pulseaudio] alsa-util.c: Trying surround71:3 without SND_PCM_NO_AUTO_FORMAT ...
(   1.956|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround71:3
(   1.956|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.957|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround71:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.957|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround71:3
(   1.957|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   1.957|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.957|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround71:3 without SND_PCM_NO_AUTO_FORMAT ...
(   1.957|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround71:3
(   1.957|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   1.957|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   1.957|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround71:3: Invalid argument
(   1.957|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-71
(   1.957|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:analog-mono - will not be able to open output:analog-surround-71
(   1.957|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:analog-stereo - will not be able to open output:analog-surround-71
(   1.957|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:iec958-stereo - will not be able to open output:analog-surround-71
(   1.957|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-stereo
(   1.957|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (IEC958) (iec958-stereo)
(   1.958|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.958|   0.000) D: [pulseaudio] alsa-util.c: Managed to open iec958:3
(   1.958|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.958|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
(   1.959|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   1.959|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:iec958-stereo supported.
(   1.959|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/iec958-stereo-output.conf'
(   1.959|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL iec958:3
(   1.959|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer iec958:3: No such file or directory
(   1.959|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:3'
(   1.959|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'iec958-stereo-output'
(   1.959|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   1.959|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   1.959|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xf1fba0, direction=1
(   1.959|   0.000) D: [pulseaudio] alsa-mixer.c: Path iec958-stereo-output (Digital Output (S/PDIF)), direction=1, priority=0, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   1.959|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:analog-mono - will not be able to open input:analog-mono
(   1.959|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:analog-stereo - will not be able to open input:analog-stereo
(   1.959|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:iec958-stereo - will not be able to open input:iec958-stereo
(   1.961|   0.001) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-ac3-surround-40
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 4.0 (IEC958/AC3) (iec958-ac3-surround-40)
(   1.961|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.961|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:3
(   1.961|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device a52:3: No such file or directory
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-ac3-surround-40
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:analog-mono - will not be able to open output:iec958-ac3-surround-40
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:analog-stereo - will not be able to open output:iec958-ac3-surround-40
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:iec958-stereo - will not be able to open output:iec958-ac3-surround-40
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-ac3-surround-51
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (IEC958/AC3) (iec958-ac3-surround-51)
(   1.961|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.961|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:3
(   1.961|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device a52:3: No such file or directory
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-ac3-surround-51
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:analog-mono - will not be able to open output:iec958-ac3-surround-51
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:analog-stereo - will not be able to open output:iec958-ac3-surround-51
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:iec958-stereo - will not be able to open output:iec958-ac3-surround-51
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-dts-surround-51
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (IEC958/DTS) (iec958-dts-surround-51)
(   1.961|   0.000) D: [pulseaudio] alsa-util.c: Trying dca:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.961|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dca:3
(   1.961|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dca:3: No such file or directory
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-dts-surround-51
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:analog-mono - will not be able to open output:iec958-dts-surround-51
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:analog-stereo - will not be able to open output:iec958-dts-surround-51
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:iec958-stereo - will not be able to open output:iec958-dts-surround-51
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo
(   1.961|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI) (hdmi-stereo)
(   1.962|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.962|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.0:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.962|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.962|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.962|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3
(   1.962|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3: No such file or directory
(   1.962|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo
(   1.962|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:analog-mono - will not be able to open output:hdmi-stereo
(   1.962|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:analog-stereo - will not be able to open output:hdmi-stereo
(   1.962|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:iec958-stereo - will not be able to open output:hdmi-stereo
(   1.962|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround
(   1.962|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI) (hdmi-surround)
(   1.962|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.962|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.0:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.962|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.962|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.962|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3
(   1.962|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3: No such file or directory
(   1.962|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround
(   1.962|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:analog-mono - will not be able to open output:hdmi-surround
(   1.962|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:analog-stereo - will not be able to open output:hdmi-surround
(   1.962|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:iec958-stereo - will not be able to open output:hdmi-surround
(   1.962|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71
(   1.962|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI) (hdmi-surround71)
(   1.962|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.962|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.0:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.962|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.962|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.963|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3
(   1.963|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3: No such file or directory
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:analog-mono - will not be able to open output:hdmi-surround71
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:analog-stereo - will not be able to open output:hdmi-surround71
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:iec958-stereo - will not be able to open output:hdmi-surround71
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI/DTS) (hdmi-dts-surround)
(   1.963|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.963|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:3
(   1.963|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:3: No such file or directory
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:analog-mono - will not be able to open output:hdmi-dts-surround
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:analog-stereo - will not be able to open output:hdmi-dts-surround
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:iec958-stereo - will not be able to open output:hdmi-dts-surround
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra1
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 2) (hdmi-stereo-extra1)
(   1.963|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,1 with SND_PCM_NO_AUTO_FORMAT ...
(   1.963|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.1:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.963|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.963|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.963|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,1
(   1.963|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,1: No such file or directory
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra1
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:analog-mono - will not be able to open output:hdmi-stereo-extra1
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:analog-stereo - will not be able to open output:hdmi-stereo-extra1
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra1
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra1
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 2) (hdmi-surround-extra1)
(   1.963|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,1 with SND_PCM_NO_AUTO_FORMAT ...
(   1.963|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.1:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.963|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.963|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.963|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,1
(   1.963|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,1: No such file or directory
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra1
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:analog-mono - will not be able to open output:hdmi-surround-extra1
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:analog-stereo - will not be able to open output:hdmi-surround-extra1
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:iec958-stereo - will not be able to open output:hdmi-surround-extra1
(   1.963|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra1
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 2) (hdmi-surround71-extra1)
(   1.964|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,1 with SND_PCM_NO_AUTO_FORMAT ...
(   1.964|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.1:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.964|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.964|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.964|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,1
(   1.964|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,1: No such file or directory
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra1
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:analog-mono - will not be able to open output:hdmi-surround71-extra1
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:analog-stereo - will not be able to open output:hdmi-surround71-extra1
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra1
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra1
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 2/DTS) (hdmi-dts-surround-extra1)
(   1.964|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:3,1 with SND_PCM_NO_AUTO_FORMAT ...
(   1.964|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:3,1
(   1.964|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:3,1: No such file or directory
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra1
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra1
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra1
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra1
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra2
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 3) (hdmi-stereo-extra2)
(   1.964|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,2 with SND_PCM_NO_AUTO_FORMAT ...
(   1.964|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.2:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.964|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.964|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.964|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,2
(   1.964|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,2: No such file or directory
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra2
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:analog-mono - will not be able to open output:hdmi-stereo-extra2
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:analog-stereo - will not be able to open output:hdmi-stereo-extra2
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra2
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra2
(   1.964|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 3) (hdmi-surround-extra2)
(   1.964|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,2 with SND_PCM_NO_AUTO_FORMAT ...
(   1.965|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.2:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.965|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.965|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.965|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,2
(   1.965|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,2: No such file or directory
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra2
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:analog-mono - will not be able to open output:hdmi-surround-extra2
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:analog-stereo - will not be able to open output:hdmi-surround-extra2
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:iec958-stereo - will not be able to open output:hdmi-surround-extra2
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra2
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 3) (hdmi-surround71-extra2)
(   1.965|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,2 with SND_PCM_NO_AUTO_FORMAT ...
(   1.965|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.2:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.965|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.965|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.965|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,2
(   1.965|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,2: No such file or directory
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra2
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:analog-mono - will not be able to open output:hdmi-surround71-extra2
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:analog-stereo - will not be able to open output:hdmi-surround71-extra2
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra2
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra2
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 3/DTS) (hdmi-dts-surround-extra2)
(   1.965|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:3,2 with SND_PCM_NO_AUTO_FORMAT ...
(   1.965|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:3,2
(   1.965|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:3,2: No such file or directory
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra2
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra2
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra2
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra2
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra3
(   1.965|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 4) (hdmi-stereo-extra3)
(   1.965|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.965|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.3:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.965|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.965|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.965|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,3
(   1.966|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,3: No such file or directory
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:analog-mono - will not be able to open output:hdmi-stereo-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:analog-stereo - will not be able to open output:hdmi-stereo-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 4) (hdmi-surround-extra3)
(   1.966|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.966|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.3:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.966|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.966|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.966|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,3
(   1.966|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,3: No such file or directory
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:analog-mono - will not be able to open output:hdmi-surround-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:analog-stereo - will not be able to open output:hdmi-surround-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:iec958-stereo - will not be able to open output:hdmi-surround-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 4) (hdmi-surround71-extra3)
(   1.966|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.966|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.3:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.966|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.966|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.966|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,3
(   1.966|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,3: No such file or directory
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:analog-mono - will not be able to open output:hdmi-surround71-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:analog-stereo - will not be able to open output:hdmi-surround71-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 4/DTS) (hdmi-dts-surround-extra3)
(   1.966|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:3,3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.966|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:3,3
(   1.966|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:3,3: No such file or directory
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra3
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra4
(   1.966|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 5) (hdmi-stereo-extra4)
(   1.966|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,4 with SND_PCM_NO_AUTO_FORMAT ...
(   1.967|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.4:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.967|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.967|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.967|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,4
(   1.967|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,4: No such file or directory
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:analog-mono - will not be able to open output:hdmi-stereo-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:analog-stereo - will not be able to open output:hdmi-stereo-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 5) (hdmi-surround-extra4)
(   1.967|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,4 with SND_PCM_NO_AUTO_FORMAT ...
(   1.967|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.4:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.967|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.967|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.967|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,4
(   1.967|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,4: No such file or directory
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:analog-mono - will not be able to open output:hdmi-surround-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:analog-stereo - will not be able to open output:hdmi-surround-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:iec958-stereo - will not be able to open output:hdmi-surround-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 5) (hdmi-surround71-extra4)
(   1.967|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,4 with SND_PCM_NO_AUTO_FORMAT ...
(   1.967|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.4:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.967|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.967|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.967|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,4
(   1.967|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,4: No such file or directory
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:analog-mono - will not be able to open output:hdmi-surround71-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:analog-stereo - will not be able to open output:hdmi-surround71-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 5/DTS) (hdmi-dts-surround-extra4)
(   1.967|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:3,4 with SND_PCM_NO_AUTO_FORMAT ...
(   1.967|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:3,4
(   1.967|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:3,4: No such file or directory
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra4
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra5
(   1.967|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 6) (hdmi-stereo-extra5)
(   1.967|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,5 with SND_PCM_NO_AUTO_FORMAT ...
(   1.968|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.5:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.968|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.968|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.968|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,5
(   1.968|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,5: No such file or directory
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:analog-mono - will not be able to open output:hdmi-stereo-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:analog-stereo - will not be able to open output:hdmi-stereo-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 6) (hdmi-surround-extra5)
(   1.968|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,5 with SND_PCM_NO_AUTO_FORMAT ...
(   1.968|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.5:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.968|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.968|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.968|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,5
(   1.968|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,5: No such file or directory
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:analog-mono - will not be able to open output:hdmi-surround-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:analog-stereo - will not be able to open output:hdmi-surround-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:iec958-stereo - will not be able to open output:hdmi-surround-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 6) (hdmi-surround71-extra5)
(   1.968|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,5 with SND_PCM_NO_AUTO_FORMAT ...
(   1.968|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.5:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.968|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.968|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.968|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,5
(   1.968|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,5: No such file or directory
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:analog-mono - will not be able to open output:hdmi-surround71-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:analog-stereo - will not be able to open output:hdmi-surround71-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 6/DTS) (hdmi-dts-surround-extra5)
(   1.968|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:3,5 with SND_PCM_NO_AUTO_FORMAT ...
(   1.968|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:3,5
(   1.968|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:3,5: No such file or directory
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra5
(   1.968|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra5
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra5
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 7) (hdmi-stereo-extra6)
(   1.969|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,6 with SND_PCM_NO_AUTO_FORMAT ...
(   1.969|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.6:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.969|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.969|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.969|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,6
(   1.969|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,6: No such file or directory
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:analog-mono - will not be able to open output:hdmi-stereo-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:analog-stereo - will not be able to open output:hdmi-stereo-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 7) (hdmi-surround-extra6)
(   1.969|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,6 with SND_PCM_NO_AUTO_FORMAT ...
(   1.969|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.6:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.969|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.969|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.969|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,6
(   1.969|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,6: No such file or directory
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:analog-mono - will not be able to open output:hdmi-surround-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:analog-stereo - will not be able to open output:hdmi-surround-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:iec958-stereo - will not be able to open output:hdmi-surround-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 7) (hdmi-surround71-extra6)
(   1.969|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,6 with SND_PCM_NO_AUTO_FORMAT ...
(   1.969|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.6:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.969|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.969|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.969|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,6
(   1.969|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,6: No such file or directory
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:analog-mono - will not be able to open output:hdmi-surround71-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:analog-stereo - will not be able to open output:hdmi-surround71-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra6
(   1.969|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 7/DTS) (hdmi-dts-surround-extra6)
(   1.970|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:3,6 with SND_PCM_NO_AUTO_FORMAT ...
(   1.970|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:3,6
(   1.970|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:3,6: No such file or directory
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra6
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra6
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra6
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra6
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra7
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 8) (hdmi-stereo-extra7)
(   1.970|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,7 with SND_PCM_NO_AUTO_FORMAT ...
(   1.970|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.7:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.970|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.970|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.970|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,7
(   1.970|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,7: No such file or directory
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra7
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:analog-mono - will not be able to open output:hdmi-stereo-extra7
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:analog-stereo - will not be able to open output:hdmi-stereo-extra7
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra7
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra7
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 8) (hdmi-surround-extra7)
(   1.970|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,7 with SND_PCM_NO_AUTO_FORMAT ...
(   1.970|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.7:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.970|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.970|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.970|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,7
(   1.970|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,7: No such file or directory
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra7
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:analog-mono - will not be able to open output:hdmi-surround-extra7
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:analog-stereo - will not be able to open output:hdmi-surround-extra7
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:iec958-stereo - will not be able to open output:hdmi-surround-extra7
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra7
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 8) (hdmi-surround71-extra7)
(   1.970|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:3,7 with SND_PCM_NO_AUTO_FORMAT ...
(   1.970|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.7:CARD=3,AES0=4,AES1=130,AES2=0,AES3=2'
(   1.970|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   1.970|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   1.970|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:3,7
(   1.970|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:3,7: No such file or directory
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra7
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:analog-mono - will not be able to open output:hdmi-surround71-extra7
(   1.970|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:analog-stereo - will not be able to open output:hdmi-surround71-extra7
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra7
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra7
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 8/DTS) (hdmi-dts-surround-extra7)
(   1.971|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:3,7 with SND_PCM_NO_AUTO_FORMAT ...
(   1.971|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:3,7
(   1.971|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:3,7: No such file or directory
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra7
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra7
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra7
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra7
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:multichannel
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Multichannel (multichannel)
(   1.971|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.971|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC3D0c' failed (-2)
(   1.971|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hw:3: No such file or directory
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:multichannel
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:multichannel - will not be able to open output:analog-mono
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:multichannel - will not be able to open input:multichannel
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:multichannel - will not be able to open output:analog-surround-21
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:multichannel - will not be able to open output:analog-surround-40
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:multichannel - will not be able to open output:analog-surround-41
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:multichannel - will not be able to open output:analog-surround-50
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:multichannel - will not be able to open output:analog-surround-51
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:multichannel - will not be able to open output:analog-surround-71
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:multichannel - will not be able to open input:multichannel
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:multichannel - will not be able to open output:iec958-ac3-surround-40
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:multichannel - will not be able to open output:iec958-ac3-surround-51
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:multichannel - will not be able to open output:iec958-dts-surround-51
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:multichannel - will not be able to open output:hdmi-stereo
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:multichannel - will not be able to open output:hdmi-surround
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:multichannel - will not be able to open output:hdmi-surround71
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:multichannel - will not be able to open output:hdmi-dts-surround
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:multichannel - will not be able to open output:hdmi-stereo-extra1
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:multichannel - will not be able to open output:hdmi-surround-extra1
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:multichannel - will not be able to open output:hdmi-surround71-extra1
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:multichannel - will not be able to open output:hdmi-dts-surround-extra1
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:multichannel - will not be able to open output:hdmi-stereo-extra2
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:multichannel - will not be able to open output:hdmi-surround-extra2
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:multichannel - will not be able to open output:hdmi-surround71-extra2
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:multichannel - will not be able to open output:hdmi-dts-surround-extra2
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:multichannel - will not be able to open output:hdmi-stereo-extra3
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:multichannel - will not be able to open output:hdmi-surround-extra3
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:multichannel - will not be able to open output:hdmi-surround71-extra3
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:multichannel - will not be able to open output:hdmi-dts-surround-extra3
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:multichannel - will not be able to open output:hdmi-stereo-extra4
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:multichannel - will not be able to open output:hdmi-surround-extra4
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:multichannel - will not be able to open output:hdmi-surround71-extra4
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:multichannel - will not be able to open output:hdmi-dts-surround-extra4
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:multichannel - will not be able to open output:hdmi-stereo-extra5
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:multichannel - will not be able to open output:hdmi-surround-extra5
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:multichannel - will not be able to open output:hdmi-surround71-extra5
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:multichannel - will not be able to open output:hdmi-dts-surround-extra5
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:multichannel - will not be able to open output:hdmi-stereo-extra6
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:multichannel - will not be able to open output:hdmi-surround-extra6
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:multichannel - will not be able to open output:hdmi-surround71-extra6
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:multichannel - will not be able to open output:hdmi-dts-surround-extra6
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:multichannel - will not be able to open output:hdmi-stereo-extra7
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:multichannel - will not be able to open output:hdmi-surround-extra7
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:multichannel - will not be able to open output:hdmi-surround71-extra7
(   1.971|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:multichannel - will not be able to open output:hdmi-dts-surround-extra7
(   1.972|   0.000) D: [pulseaudio] alsa-mixer.c: Profile set 0xe5ea40, auto_profiles=yes, probed=yes, n_mappings=2, n_profiles=2, n_decibel_fixes=0
(   1.972|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping analog-stereo (Analog Stereo), priority=60, channel_map=front-left,front-right, supported=yes, direction=0
(   1.972|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping iec958-stereo (Digital Stereo (IEC958)), priority=55, channel_map=front-left,front-right, supported=yes, direction=0
(   1.972|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-stereo (Analog Stereo Output), priority=6000, supported=yes n_input_mappings=0, n_output_mappings=1
(   1.972|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-stereo
(   1.972|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:iec958-stereo (Digital Stereo (IEC958) Output), priority=5500, supported=yes n_input_mappings=0, n_output_mappings=1
(   1.972|   0.000) D: [pulseaudio] alsa-mixer.c: Output iec958-stereo
(   1.973|   0.000) I: [pulseaudio] module-card-restore.c: Restored profile 'output:iec958-stereo' for card alsa_card.usb-Yoyodyne_Consulting_ODAC-revB-01.
(   1.973|   0.000) I: [pulseaudio] module-card-restore.c: Restoring port latency offsets for card alsa_card.usb-Yoyodyne_Consulting_ODAC-revB-01.
(   1.973|   0.000) I: [pulseaudio] card.c: Created 1 "alsa_card.usb-Yoyodyne_Consulting_ODAC-revB-01"
(   1.973|   0.000) D: [pulseaudio] module-alsa-card.c: Found 0 jacks.
(   1.973|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully create reservation lock monitor for device 'Audio3'
(   1.973|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:3 with SND_PCM_NO_AUTO_FORMAT ...
(   1.974|   0.000) D: [pulseaudio] alsa-util.c: Managed to open iec958:3
(   1.974|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.974|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
(   1.974|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   1.975|   0.000) I: [pulseaudio] alsa-sink.c: Successfully opened device iec958:3.
(   1.975|   0.000) I: [pulseaudio] alsa-sink.c: Selected mapping 'Digital Stereo (IEC958)' (iec958-stereo).
(   1.975|   0.000) I: [pulseaudio] alsa-sink.c: Cannot enable timer-based scheduling, falling back to sound IRQ scheduling.
(   1.975|   0.000) I: [pulseaudio] alsa-sink.c: Successfully enabled mmap() mode.
(   1.975|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL iec958:3
(   1.975|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer iec958:3: No such file or directory
(   1.975|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:3'
(   1.975|   0.000) D: [pulseaudio] alsa-mixer.c: Added 1 ports
(   1.975|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   1.975|   0.000) I: [pulseaudio] module-device-restore.c: Restoring volume for sink alsa_output.usb-Yoyodyne_Consulting_ODAC-revB-01.iec958-stereo: front-left: 65536 / 100%,   front-right: 65536 / 100%
(   1.975|   0.000) I: [pulseaudio] sink.c: Created sink 1 "alsa_output.usb-Yoyodyne_Consulting_ODAC-revB-01.iec958-stereo" with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
(   1.975|   0.000) I: [pulseaudio] sink.c:     alsa.resolution_bits = "16"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.api = "alsa"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.class = "sound"
(   1.975|   0.000) I: [pulseaudio] sink.c:     alsa.class = "generic"
(   1.975|   0.000) I: [pulseaudio] sink.c:     alsa.subclass = "generic-mix"
(   1.975|   0.000) I: [pulseaudio] sink.c:     alsa.name = "USB Audio"
(   1.975|   0.000) I: [pulseaudio] sink.c:     alsa.id = "USB Audio"
(   1.975|   0.000) I: [pulseaudio] sink.c:     alsa.subdevice = "0"
(   1.975|   0.000) I: [pulseaudio] sink.c:     alsa.subdevice_name = "subdevice #0"
(   1.975|   0.000) I: [pulseaudio] sink.c:     alsa.device = "0"
(   1.975|   0.000) I: [pulseaudio] sink.c:     alsa.card = "3"
(   1.975|   0.000) I: [pulseaudio] sink.c:     alsa.card_name = "ODAC-revB"
(   1.975|   0.000) I: [pulseaudio] sink.c:     alsa.long_card_name = "Yoyodyne Consulting ODAC-revB at usb-0000:00:14.0-11, full speed"
(   1.975|   0.000) I: [pulseaudio] sink.c:     alsa.driver_name = "snd_usb_audio"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.bus_path = "pci-0000:00:14.0-usb-0:11:1.1"
(   1.975|   0.000) I: [pulseaudio] sink.c:     sysfs.path = "/devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11:1.1/sound/card3"
(   1.975|   0.000) I: [pulseaudio] sink.c:     udev.id = "usb-Yoyodyne_Consulting_ODAC-revB-01"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.bus = "usb"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.vendor.id = "262a"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.vendor.name = "Yoyodyne Consulting"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.product.id = "1048"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.product.name = "ODAC-revB"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.serial = "Yoyodyne_Consulting_ODAC-revB"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.string = "iec958:3"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.buffering.buffer_size = "17632"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.buffering.fragment_size = "4408"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.access_mode = "mmap"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.profile.name = "iec958-stereo"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.profile.description = "Digital Stereo (IEC958)"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.description = "ODAC-revB Digital Stereo (IEC958)"
(   1.975|   0.000) I: [pulseaudio] sink.c:     alsa.mixer_name = "USB Mixer"
(   1.975|   0.000) I: [pulseaudio] sink.c:     alsa.components = "USB262a:1048"
(   1.975|   0.000) I: [pulseaudio] sink.c:     module-udev-detect.discovered = "1"
(   1.975|   0.000) I: [pulseaudio] sink.c:     device.icon_name = "audio-card-usb"
(   1.976|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   1.976|   0.000) I: [pulseaudio] source.c: Created source 1 "alsa_output.usb-Yoyodyne_Consulting_ODAC-revB-01.iec958-stereo.monitor" with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
(   1.976|   0.000) I: [pulseaudio] source.c:     device.description = "Monitor of ODAC-revB Digital Stereo (IEC958)"
(   1.976|   0.000) I: [pulseaudio] source.c:     device.class = "monitor"
(   1.976|   0.000) I: [pulseaudio] source.c:     alsa.card = "3"
(   1.976|   0.000) I: [pulseaudio] source.c:     alsa.card_name = "ODAC-revB"
(   1.976|   0.000) I: [pulseaudio] source.c:     alsa.long_card_name = "Yoyodyne Consulting ODAC-revB at usb-0000:00:14.0-11, full speed"
(   1.976|   0.000) I: [pulseaudio] source.c:     alsa.driver_name = "snd_usb_audio"
(   1.976|   0.000) I: [pulseaudio] source.c:     device.bus_path = "pci-0000:00:14.0-usb-0:11:1.1"
(   1.976|   0.000) I: [pulseaudio] source.c:     sysfs.path = "/devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11:1.1/sound/card3"
(   1.976|   0.000) I: [pulseaudio] source.c:     udev.id = "usb-Yoyodyne_Consulting_ODAC-revB-01"
(   1.976|   0.000) I: [pulseaudio] source.c:     device.bus = "usb"
(   1.976|   0.000) I: [pulseaudio] source.c:     device.vendor.id = "262a"
(   1.976|   0.000) I: [pulseaudio] source.c:     device.vendor.name = "Yoyodyne Consulting"
(   1.976|   0.000) I: [pulseaudio] source.c:     device.product.id = "1048"
(   1.976|   0.000) I: [pulseaudio] source.c:     device.product.name = "ODAC-revB"
(   1.976|   0.000) I: [pulseaudio] source.c:     device.serial = "Yoyodyne_Consulting_ODAC-revB"
(   1.976|   0.000) I: [pulseaudio] source.c:     device.string = "3"
(   1.976|   0.000) I: [pulseaudio] source.c:     module-udev-detect.discovered = "1"
(   1.976|   0.000) I: [pulseaudio] source.c:     device.icon_name = "audio-card-usb"
(   1.976|   0.000) I: [pulseaudio] alsa-sink.c: Using 4.0 fragments of size 4408 bytes (24.99ms), buffer size is 17632 bytes (99.95ms)
(   1.976|   0.000) D: [pulseaudio] alsa-sink.c: hwbuf_unused=0
(   1.976|   0.000) D: [pulseaudio] alsa-sink.c: setting avail_min=1
(   1.976|   0.000) D: [pulseaudio] alsa-mixer.c: Activating path iec958-stereo-output
(   1.976|   0.000) D: [pulseaudio] alsa-mixer.c: Path iec958-stereo-output (Digital Output (S/PDIF)), direction=1, priority=0, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   1.976|   0.000) I: [pulseaudio] alsa-sink.c: Driver does not support hardware volume control, falling back to software volume control.
(   1.976|   0.000) I: [pulseaudio] alsa-sink.c: Driver does not support hardware mute control, falling back to software mute control.
(   1.976|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_dump():
(   1.976|   0.000) D: [pulseaudio] alsa-util.c: Hardware PCM card 3 'ODAC-revB' device 0 subdevice 0
(   1.976|   0.000) D: [pulseaudio] alsa-util.c: Its setup is:
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   stream       : PLAYBACK
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   access       : MMAP_INTERLEAVED
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   format       : S16_LE
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   subformat    : STD
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   channels     : 2
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   rate         : 44100
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   exact rate   : 44100 (44100/1)
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   msbits       : 16
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   buffer_size  : 4408
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   period_size  : 1102
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   period_time  : 24988
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_type  : MONOTONIC
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   period_step  : 1
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   avail_min    : 1102
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   period_event : 1
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   start_threshold  : -1
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   stop_threshold   : 4962966789362286592
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   silence_threshold: 0
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   silence_size : 0
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   boundary     : 4962966789362286592
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   appl_ptr     : 0
(   1.976|   0.000) D: [pulseaudio] alsa-util.c:   hw_ptr       : 0
(   1.976|   0.000) D: [alsa-sink-USB Audio] alsa-sink.c: Thread starting up
(   1.981|   0.004) D: [alsa-sink-USB Audio] core-util.c: RealtimeKit worked.
(   1.981|   0.000) I: [alsa-sink-USB Audio] core-util.c: Successfully enabled SCHED_RR scheduling for thread, with priority 5.
(   1.981|   0.000) I: [alsa-sink-USB Audio] alsa-sink.c: Starting playback.
(   1.981|   0.000) I: [pulseaudio] module.c: Loaded "module-alsa-card" (index: #7; argument: "device_id="3" name="usb-Yoyodyne_Consulting_ODAC-revB-01" card_name="alsa_card.usb-Yoyodyne_Consulting_ODAC-revB-01" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1"").
(   1.982|   0.000) I: [pulseaudio] module-udev-detect.c: Card /devices/pci0000:00/0000:00:14.0/usb1/1-11/1-11:1.1/sound/card3 (alsa_card.usb-Yoyodyne_Consulting_ODAC-revB-01) module loaded.
(   1.982|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC2 is accessible: yes
(   1.982|   0.000) D: [pulseaudio] module-udev-detect.c: /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.2/sound/card2 is busy: no
(   1.982|   0.000) D: [pulseaudio] module-udev-detect.c: Loading module-alsa-card with arguments 'device_id="2" name="usb-046d_HD_Pro_Webcam_C920_9DADF56F-02" card_name="alsa_card.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1"'
(   1.983|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully acquired reservation lock on device 'Audio2'
(   1.983|   0.000) I: [pulseaudio] (alsa-lib)utils.c: could not open configuration file /usr/share/alsa/ucm/HD Pro Webcam C920/HD Pro Webcam C920.conf
(   1.983|   0.000) I: [pulseaudio] (alsa-lib)parser.c: error: could not parse configuration for card HD Pro Webcam C920
(   1.983|   0.000) I: [pulseaudio] (alsa-lib)main.c: error: failed to import HD Pro Webcam C920 use case configuration -2
(   1.983|   0.000) I: [pulseaudio] alsa-ucm.c: UCM not available for card HD Pro Webcam C920
(   1.983|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/profile-sets/default.conf'
(   1.985|   0.001) D: [pulseaudio] alsa-mixer.c: Looking at profile input:analog-mono
(   1.985|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Mono (analog-mono)
(   1.985|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:2 with SND_PCM_NO_AUTO_FORMAT ...
(   1.985|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:2
(   1.985|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.985|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   1.985|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:2 without SND_PCM_NO_AUTO_FORMAT ...
(   1.986|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:2
(   1.986|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.986|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   1.986|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:2 with SND_PCM_NO_AUTO_FORMAT ...
(   1.986|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:2
(   1.986|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.986|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   1.986|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:2 without SND_PCM_NO_AUTO_FORMAT ...
(   1.986|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:2
(   1.986|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.986|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   1.986|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:hw:2: Invalid argument
(   1.986|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:analog-mono
(   1.986|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:analog-stereo
(   1.986|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Stereo (analog-stereo)
(   1.986|   0.000) D: [pulseaudio] alsa-util.c: Trying front:2 with SND_PCM_NO_AUTO_FORMAT ...
(   1.987|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:2
(   1.987|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   1.987|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 8192 ms
(   2.043|   0.056) D: [pulseaudio] alsa-util.c: Set buffer size first (to 3198 samples), period size second (to 799 samples).
(   2.043|   0.000) I: [pulseaudio] alsa-util.c: Device front:2 doesn't support 44100 Hz, changed to 32000 Hz.
(   2.043|   0.000) D: [pulseaudio] alsa-mixer.c: Profile input:analog-stereo supported.
(   2.043|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-front-mic.conf'
(   2.043|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.043|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-rear-mic.conf'
(   2.044|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.044|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-internal-mic.conf'
(   2.044|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.044|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-dock-mic.conf'
(   2.044|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.044|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf'
(   2.044|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.044|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf'
(   2.045|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.045|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-linein.conf'
(   2.045|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-aux.conf'
(   2.045|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.045|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-video.conf'
(   2.045|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.045|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-tvtuner.conf'
(   2.046|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.046|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-fm.conf'
(   2.046|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.046|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic-line.conf'
(   2.046|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.046|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.047|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-headphone-mic.conf'
(   2.047|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.047|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-headset-mic.conf'
(   2.047|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.047|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL front:2
(   2.047|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer front:2: No such file or directory
(   2.047|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:2'
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-front-mic'
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Mic Jack' succeeded (not found)
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Mic Phantom Jack' succeeded (not found)
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.047|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-front-mic', none of required-any elements preset.
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-rear-mic'
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Rear Mic Jack' succeeded (not found)
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Rear Mic Phantom Jack' succeeded (not found)
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-rear-mic', none of required-any elements preset.
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-internal-mic'
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Mic Jack' succeeded (not found)
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Mic Jack' succeeded (not found)
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Mic Jack' succeeded (not found)
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Rear Mic Jack' succeeded (not found)
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Internal Mic Phantom Jack' succeeded (not found)
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Int Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Int Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.048|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-internal-mic', none of required-any elements preset.
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-dock-mic'
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Mic Jack' succeeded (not found)
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Mic Phantom Jack' succeeded (not found)
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-dock-mic', none of required-any elements preset.
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input'
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' failed.
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-mic'
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Mic Jack' succeeded (not found)
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Mic Phantom Jack' succeeded (not found)
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=1, switch=1, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Select' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost (+20dB)' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.049|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-linein'
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Jack' succeeded (not found)
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Phantom Jack' succeeded (not found)
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-linein', none of required-any elements preset.
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-aux'
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' failed.
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-video'
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' failed.
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-tvtuner'
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' failed.
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-fm'
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.050|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' failed.
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-mic-line'
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' failed.
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-headphone-mic'
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Mic Jack' succeeded (not found)
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Auto-Mute Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-headphone-mic', none of required-any elements preset.
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-headset-mic'
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headset Mic Jack' succeeded (not found)
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headset Mic Phantom Jack' succeeded (not found)
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Mic Jack' succeeded (not found)
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headset Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headset Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headset' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.051|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-headset-mic', none of required-any elements preset.
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xea4680, direction=2
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-input-mic (Microphone), direction=2, priority=87, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=15, min_dB=20, max_dB=50
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Element Mic, direction=2, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=4, required_absent=0, mask=0x7ffffffffffff, n_channels=1, override_map=yes
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Mic, alsa_name='Mic Jack', detection unavailable
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Mic Phantom, alsa_name='Mic Phantom Jack', detection unavailable
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:iec958-stereo
(   2.052|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Digital Stereo (IEC958) (iec958-stereo)
(   2.052|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.053|   0.000) D: [pulseaudio] alsa-util.c: Managed to open iec958:2
(   2.053|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.053|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 8192 ms
(   2.109|   0.056) D: [pulseaudio] alsa-util.c: Set buffer size first (to 3198 samples), period size second (to 799 samples).
(   2.109|   0.000) I: [pulseaudio] alsa-util.c: Device iec958:2 doesn't support 44100 Hz, changed to 32000 Hz.
(   2.109|   0.000) D: [pulseaudio] alsa-mixer.c: Profile input:iec958-stereo supported.
(   2.110|   0.000) D: [pulseaudio] conf-parser.c: Failed to open configuration file '/usr/share/pulseaudio/alsa-mixer/paths/iec958-stereo-input.conf': No such file or directory
(   2.110|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL iec958:2
(   2.110|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer iec958:2: No such file or directory
(   2.110|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:2'
(   2.110|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'iec958-stereo-input'
(   2.110|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   2.110|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xe686c0, direction=2
(   2.110|   0.000) D: [pulseaudio] alsa-mixer.c: Path iec958-stereo-input (Digital Input (S/PDIF)), direction=2, priority=0, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   2.110|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-mono
(   2.110|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Mono (analog-mono)
(   2.110|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.111|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC2D0p' failed (-2)
(   2.111|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hw:2: No such file or directory
(   2.111|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-mono
(   2.111|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:analog-mono - will not be able to open output:analog-mono
(   2.111|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:analog-stereo - will not be able to open output:analog-mono
(   2.111|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:iec958-stereo - will not be able to open output:analog-mono
(   2.111|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-stereo
(   2.111|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Stereo (analog-stereo)
(   2.111|   0.000) D: [pulseaudio] alsa-util.c: Trying front:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.111|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC2D0p' failed (-2)
(   2.111|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device front:2: No such file or directory
(   2.111|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.111|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC2D0p' failed (-2)
(   2.111|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hw:2: No such file or directory
(   2.111|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-stereo
(   2.111|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:analog-mono - will not be able to open output:analog-stereo
(   2.111|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:analog-stereo - will not be able to open output:analog-stereo
(   2.111|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:iec958-stereo - will not be able to open output:analog-stereo
(   2.111|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-21
(   2.111|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 2.1 (analog-surround-21)
(   2.111|   0.000) D: [pulseaudio] alsa-util.c: Trying surround21:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.112|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC2D0p' failed (-2)
(   2.112|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device surround21:2: No such file or directory
(   2.112|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-21
(   2.112|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:analog-mono - will not be able to open output:analog-surround-21
(   2.112|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:analog-stereo - will not be able to open output:analog-surround-21
(   2.112|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:iec958-stereo - will not be able to open output:analog-surround-21
(   2.112|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-40
(   2.112|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 4.0 (analog-surround-40)
(   2.112|   0.000) D: [pulseaudio] alsa-util.c: Trying surround40:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.112|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC2D0p' failed (-2)
(   2.112|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device surround40:2: No such file or directory
(   2.112|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-40
(   2.112|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:analog-mono - will not be able to open output:analog-surround-40
(   2.112|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:analog-stereo - will not be able to open output:analog-surround-40
(   2.112|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:iec958-stereo - will not be able to open output:analog-surround-40
(   2.112|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-41
(   2.113|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 4.1 (analog-surround-41)
(   2.113|   0.000) D: [pulseaudio] alsa-util.c: Trying surround41:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.113|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC2D0p' failed (-2)
(   2.113|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device surround41:2: No such file or directory
(   2.113|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-41
(   2.113|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:analog-mono - will not be able to open output:analog-surround-41
(   2.113|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:analog-stereo - will not be able to open output:analog-surround-41
(   2.113|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:iec958-stereo - will not be able to open output:analog-surround-41
(   2.113|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-50
(   2.113|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 5.0 (analog-surround-50)
(   2.113|   0.000) D: [pulseaudio] alsa-util.c: Trying surround50:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.113|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC2D0p' failed (-2)
(   2.113|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device surround50:2: No such file or directory
(   2.113|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-50
(   2.113|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:analog-mono - will not be able to open output:analog-surround-50
(   2.113|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:analog-stereo - will not be able to open output:analog-surround-50
(   2.113|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:iec958-stereo - will not be able to open output:analog-surround-50
(   2.114|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-51
(   2.114|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 5.1 (analog-surround-51)
(   2.114|   0.000) D: [pulseaudio] alsa-util.c: Trying surround51:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.114|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC2D0p' failed (-2)
(   2.114|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device surround51:2: No such file or directory
(   2.114|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-51
(   2.114|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:analog-mono - will not be able to open output:analog-surround-51
(   2.114|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:analog-stereo - will not be able to open output:analog-surround-51
(   2.114|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:iec958-stereo - will not be able to open output:analog-surround-51
(   2.114|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-71
(   2.114|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 7.1 (analog-surround-71)
(   2.114|   0.000) D: [pulseaudio] alsa-util.c: Trying surround71:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.114|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC2D0p' failed (-2)
(   2.114|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device surround71:2: No such file or directory
(   2.114|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-71
(   2.114|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:analog-mono - will not be able to open output:analog-surround-71
(   2.114|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:analog-stereo - will not be able to open output:analog-surround-71
(   2.114|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:iec958-stereo - will not be able to open output:analog-surround-71
(   2.114|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-stereo
(   2.114|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (IEC958) (iec958-stereo)
(   2.115|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.115|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC2D0p' failed (-2)
(   2.115|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device iec958:2: No such file or directory
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-stereo
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:analog-mono - will not be able to open output:iec958-stereo
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:analog-stereo - will not be able to open output:iec958-stereo
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:iec958-stereo - will not be able to open output:iec958-stereo
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-ac3-surround-40
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 4.0 (IEC958/AC3) (iec958-ac3-surround-40)
(   2.115|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.115|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:2
(   2.115|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device a52:2: No such file or directory
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-ac3-surround-40
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:analog-mono - will not be able to open output:iec958-ac3-surround-40
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:analog-stereo - will not be able to open output:iec958-ac3-surround-40
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:iec958-stereo - will not be able to open output:iec958-ac3-surround-40
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-ac3-surround-51
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (IEC958/AC3) (iec958-ac3-surround-51)
(   2.115|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.115|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:2
(   2.115|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device a52:2: No such file or directory
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-ac3-surround-51
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:analog-mono - will not be able to open output:iec958-ac3-surround-51
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:analog-stereo - will not be able to open output:iec958-ac3-surround-51
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:iec958-stereo - will not be able to open output:iec958-ac3-surround-51
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-dts-surround-51
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (IEC958/DTS) (iec958-dts-surround-51)
(   2.115|   0.000) D: [pulseaudio] alsa-util.c: Trying dca:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.115|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dca:2
(   2.115|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dca:2: No such file or directory
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-dts-surround-51
(   2.115|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:analog-mono - will not be able to open output:iec958-dts-surround-51
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:analog-stereo - will not be able to open output:iec958-dts-surround-51
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:iec958-stereo - will not be able to open output:iec958-dts-surround-51
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI) (hdmi-stereo)
(   2.116|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.116|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.0:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.116|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.116|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.116|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2
(   2.116|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2: No such file or directory
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:analog-mono - will not be able to open output:hdmi-stereo
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:analog-stereo - will not be able to open output:hdmi-stereo
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:iec958-stereo - will not be able to open output:hdmi-stereo
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI) (hdmi-surround)
(   2.116|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.116|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.0:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.116|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.116|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.116|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2
(   2.116|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2: No such file or directory
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:analog-mono - will not be able to open output:hdmi-surround
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:analog-stereo - will not be able to open output:hdmi-surround
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:iec958-stereo - will not be able to open output:hdmi-surround
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71
(   2.116|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI) (hdmi-surround71)
(   2.116|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.117|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.0:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.117|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.117|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.117|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2
(   2.117|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2: No such file or directory
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:analog-mono - will not be able to open output:hdmi-surround71
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:analog-stereo - will not be able to open output:hdmi-surround71
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:iec958-stereo - will not be able to open output:hdmi-surround71
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI/DTS) (hdmi-dts-surround)
(   2.117|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.117|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:2
(   2.117|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:2: No such file or directory
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:analog-mono - will not be able to open output:hdmi-dts-surround
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:analog-stereo - will not be able to open output:hdmi-dts-surround
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:iec958-stereo - will not be able to open output:hdmi-dts-surround
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra1
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 2) (hdmi-stereo-extra1)
(   2.117|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,1 with SND_PCM_NO_AUTO_FORMAT ...
(   2.117|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.1:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.117|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.117|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.117|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,1
(   2.117|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,1: No such file or directory
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra1
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:analog-mono - will not be able to open output:hdmi-stereo-extra1
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:analog-stereo - will not be able to open output:hdmi-stereo-extra1
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra1
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra1
(   2.117|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 2) (hdmi-surround-extra1)
(   2.117|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,1 with SND_PCM_NO_AUTO_FORMAT ...
(   2.118|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.1:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.118|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.118|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.118|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,1
(   2.118|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,1: No such file or directory
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra1
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:analog-mono - will not be able to open output:hdmi-surround-extra1
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:analog-stereo - will not be able to open output:hdmi-surround-extra1
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:iec958-stereo - will not be able to open output:hdmi-surround-extra1
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra1
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 2) (hdmi-surround71-extra1)
(   2.118|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,1 with SND_PCM_NO_AUTO_FORMAT ...
(   2.118|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.1:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.118|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.118|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.118|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,1
(   2.118|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,1: No such file or directory
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra1
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:analog-mono - will not be able to open output:hdmi-surround71-extra1
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:analog-stereo - will not be able to open output:hdmi-surround71-extra1
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra1
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra1
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 2/DTS) (hdmi-dts-surround-extra1)
(   2.118|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:2,1 with SND_PCM_NO_AUTO_FORMAT ...
(   2.118|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:2,1
(   2.118|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:2,1: No such file or directory
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra1
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra1
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra1
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra1
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra2
(   2.118|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 3) (hdmi-stereo-extra2)
(   2.118|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.118|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.2:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.118|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.118|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.119|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,2
(   2.119|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,2: No such file or directory
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:analog-mono - will not be able to open output:hdmi-stereo-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:analog-stereo - will not be able to open output:hdmi-stereo-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 3) (hdmi-surround-extra2)
(   2.119|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.119|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.2:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.119|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.119|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.119|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,2
(   2.119|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,2: No such file or directory
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:analog-mono - will not be able to open output:hdmi-surround-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:analog-stereo - will not be able to open output:hdmi-surround-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:iec958-stereo - will not be able to open output:hdmi-surround-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 3) (hdmi-surround71-extra2)
(   2.119|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.119|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.2:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.119|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.119|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.119|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,2
(   2.119|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,2: No such file or directory
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:analog-mono - will not be able to open output:hdmi-surround71-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:analog-stereo - will not be able to open output:hdmi-surround71-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 3/DTS) (hdmi-dts-surround-extra2)
(   2.119|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:2,2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.119|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:2,2
(   2.119|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:2,2: No such file or directory
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra2
(   2.119|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra2
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra2
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra3
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 4) (hdmi-stereo-extra3)
(   2.120|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,3 with SND_PCM_NO_AUTO_FORMAT ...
(   2.120|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.3:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.120|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.120|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.120|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,3
(   2.120|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,3: No such file or directory
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra3
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:analog-mono - will not be able to open output:hdmi-stereo-extra3
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:analog-stereo - will not be able to open output:hdmi-stereo-extra3
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra3
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra3
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 4) (hdmi-surround-extra3)
(   2.120|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,3 with SND_PCM_NO_AUTO_FORMAT ...
(   2.120|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.3:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.120|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.120|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.120|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,3
(   2.120|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,3: No such file or directory
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra3
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:analog-mono - will not be able to open output:hdmi-surround-extra3
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:analog-stereo - will not be able to open output:hdmi-surround-extra3
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:iec958-stereo - will not be able to open output:hdmi-surround-extra3
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra3
(   2.120|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 4) (hdmi-surround71-extra3)
(   2.120|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,3 with SND_PCM_NO_AUTO_FORMAT ...
(   2.120|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.3:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.121|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.121|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.121|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,3
(   2.121|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,3: No such file or directory
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra3
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:analog-mono - will not be able to open output:hdmi-surround71-extra3
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:analog-stereo - will not be able to open output:hdmi-surround71-extra3
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra3
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra3
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 4/DTS) (hdmi-dts-surround-extra3)
(   2.121|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:2,3 with SND_PCM_NO_AUTO_FORMAT ...
(   2.121|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:2,3
(   2.121|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:2,3: No such file or directory
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra3
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra3
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra3
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra3
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra4
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 5) (hdmi-stereo-extra4)
(   2.121|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.121|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.4:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.121|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.121|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.121|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,4
(   2.121|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,4: No such file or directory
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra4
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:analog-mono - will not be able to open output:hdmi-stereo-extra4
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:analog-stereo - will not be able to open output:hdmi-stereo-extra4
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra4
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra4
(   2.121|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 5) (hdmi-surround-extra4)
(   2.121|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.121|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.4:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.121|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.121|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.121|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,4
(   2.121|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,4: No such file or directory
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra4
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:analog-mono - will not be able to open output:hdmi-surround-extra4
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:analog-stereo - will not be able to open output:hdmi-surround-extra4
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:iec958-stereo - will not be able to open output:hdmi-surround-extra4
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra4
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 5) (hdmi-surround71-extra4)
(   2.122|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.122|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.4:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.122|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.122|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.122|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,4
(   2.122|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,4: No such file or directory
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra4
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:analog-mono - will not be able to open output:hdmi-surround71-extra4
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:analog-stereo - will not be able to open output:hdmi-surround71-extra4
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra4
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra4
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 5/DTS) (hdmi-dts-surround-extra4)
(   2.122|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:2,4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.122|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:2,4
(   2.122|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:2,4: No such file or directory
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra4
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra4
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra4
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra4
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra5
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 6) (hdmi-stereo-extra5)
(   2.122|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,5 with SND_PCM_NO_AUTO_FORMAT ...
(   2.122|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.5:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.122|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.122|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.122|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,5
(   2.122|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,5: No such file or directory
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra5
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:analog-mono - will not be able to open output:hdmi-stereo-extra5
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:analog-stereo - will not be able to open output:hdmi-stereo-extra5
(   2.122|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 6) (hdmi-surround-extra5)
(   2.123|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,5 with SND_PCM_NO_AUTO_FORMAT ...
(   2.123|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.5:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.123|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.123|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.123|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,5
(   2.123|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,5: No such file or directory
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:analog-mono - will not be able to open output:hdmi-surround-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:analog-stereo - will not be able to open output:hdmi-surround-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:iec958-stereo - will not be able to open output:hdmi-surround-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 6) (hdmi-surround71-extra5)
(   2.123|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,5 with SND_PCM_NO_AUTO_FORMAT ...
(   2.123|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.5:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.123|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.123|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.123|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,5
(   2.123|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,5: No such file or directory
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:analog-mono - will not be able to open output:hdmi-surround71-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:analog-stereo - will not be able to open output:hdmi-surround71-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 6/DTS) (hdmi-dts-surround-extra5)
(   2.123|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:2,5 with SND_PCM_NO_AUTO_FORMAT ...
(   2.123|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:2,5
(   2.123|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:2,5: No such file or directory
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra5
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra6
(   2.123|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 7) (hdmi-stereo-extra6)
(   2.123|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,6 with SND_PCM_NO_AUTO_FORMAT ...
(   2.124|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.6:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.124|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.124|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.124|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,6
(   2.124|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,6: No such file or directory
(   2.124|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra6
(   2.124|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:analog-mono - will not be able to open output:hdmi-stereo-extra6
(   2.124|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:analog-stereo - will not be able to open output:hdmi-stereo-extra6
(   2.124|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra6
(   2.124|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra6
(   2.124|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 7) (hdmi-surround-extra6)
(   2.124|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,6 with SND_PCM_NO_AUTO_FORMAT ...
(   2.124|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.6:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.124|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.124|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.124|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,6
(   2.124|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,6: No such file or directory
(   2.124|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra6
(   2.124|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:analog-mono - will not be able to open output:hdmi-surround-extra6
(   2.124|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:analog-stereo - will not be able to open output:hdmi-surround-extra6
(   2.124|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:iec958-stereo - will not be able to open output:hdmi-surround-extra6
(   2.124|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra6
(   2.124|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 7) (hdmi-surround71-extra6)
(   2.124|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,6 with SND_PCM_NO_AUTO_FORMAT ...
(   2.124|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.6:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.124|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.124|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.124|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,6
(   2.124|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,6: No such file or directory
(   2.124|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra6
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:analog-mono - will not be able to open output:hdmi-surround71-extra6
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:analog-stereo - will not be able to open output:hdmi-surround71-extra6
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra6
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra6
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 7/DTS) (hdmi-dts-surround-extra6)
(   2.125|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:2,6 with SND_PCM_NO_AUTO_FORMAT ...
(   2.125|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:2,6
(   2.125|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:2,6: No such file or directory
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra6
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra6
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra6
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra6
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra7
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 8) (hdmi-stereo-extra7)
(   2.125|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,7 with SND_PCM_NO_AUTO_FORMAT ...
(   2.125|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.7:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.125|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.125|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.125|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,7
(   2.125|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,7: No such file or directory
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra7
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:analog-mono - will not be able to open output:hdmi-stereo-extra7
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:analog-stereo - will not be able to open output:hdmi-stereo-extra7
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra7
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra7
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 8) (hdmi-surround-extra7)
(   2.125|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,7 with SND_PCM_NO_AUTO_FORMAT ...
(   2.125|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.7:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.125|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.125|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.125|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,7
(   2.125|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,7: No such file or directory
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra7
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:analog-mono - will not be able to open output:hdmi-surround-extra7
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:analog-stereo - will not be able to open output:hdmi-surround-extra7
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:iec958-stereo - will not be able to open output:hdmi-surround-extra7
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra7
(   2.125|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 8) (hdmi-surround71-extra7)
(   2.125|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:2,7 with SND_PCM_NO_AUTO_FORMAT ...
(   2.126|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.7:CARD=2,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.126|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.126|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.126|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:2,7
(   2.126|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:2,7: No such file or directory
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra7
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:analog-mono - will not be able to open output:hdmi-surround71-extra7
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:analog-stereo - will not be able to open output:hdmi-surround71-extra7
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra7
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra7
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 8/DTS) (hdmi-dts-surround-extra7)
(   2.126|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:2,7 with SND_PCM_NO_AUTO_FORMAT ...
(   2.126|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:2,7
(   2.126|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:2,7: No such file or directory
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra7
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra7
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra7
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra7
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:multichannel
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Multichannel (multichannel)
(   2.126|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.126|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC2D0p' failed (-2)
(   2.126|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hw:2: No such file or directory
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:multichannel
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:multichannel+input:analog-mono - will not be able to open output:multichannel
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:multichannel+input:analog-stereo - will not be able to open output:multichannel
(   2.126|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:multichannel+input:iec958-stereo - will not be able to open output:multichannel
(   2.127|   0.001) D: [pulseaudio] alsa-mixer.c: Profile set 0xe8aec0, auto_profiles=yes, probed=yes, n_mappings=2, n_profiles=2, n_decibel_fixes=0
(   2.127|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping analog-stereo (Analog Stereo), priority=60, channel_map=front-left,front-right, supported=yes, direction=0
(   2.127|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping iec958-stereo (Digital Stereo (IEC958)), priority=55, channel_map=front-left,front-right, supported=yes, direction=0
(   2.127|   0.000) D: [pulseaudio] alsa-mixer.c: Profile input:analog-stereo (Analog Stereo Input), priority=60, supported=yes n_input_mappings=1, n_output_mappings=0
(   2.127|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   2.127|   0.000) D: [pulseaudio] alsa-mixer.c: Profile input:iec958-stereo (Digital Stereo (IEC958) Input), priority=55, supported=yes n_input_mappings=1, n_output_mappings=0
(   2.127|   0.000) D: [pulseaudio] alsa-mixer.c: Input iec958-stereo
(   2.128|   0.000) I: [pulseaudio] module-card-restore.c: Restored profile 'input:iec958-stereo' for card alsa_card.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02.
(   2.128|   0.000) I: [pulseaudio] module-card-restore.c: Restoring port latency offsets for card alsa_card.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02.
(   2.128|   0.000) I: [pulseaudio] card.c: Created 2 "alsa_card.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02"
(   2.128|   0.000) D: [pulseaudio] module-alsa-card.c: Found 0 jacks.
(   2.128|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully create reservation lock monitor for device 'Audio2'
(   2.129|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.129|   0.000) D: [pulseaudio] alsa-util.c: Managed to open iec958:2
(   2.129|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.129|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 8192 ms
(   2.185|   0.056) D: [pulseaudio] alsa-util.c: Set buffer size first (to 3198 samples), period size second (to 799 samples).
(   2.185|   0.000) I: [pulseaudio] alsa-util.c: Device iec958:2 doesn't support 44100 Hz, changed to 32000 Hz.
(   2.186|   0.000) I: [pulseaudio] alsa-source.c: Successfully opened device iec958:2.
(   2.186|   0.000) I: [pulseaudio] alsa-source.c: Selected mapping 'Digital Stereo (IEC958)' (iec958-stereo).
(   2.186|   0.000) I: [pulseaudio] alsa-source.c: Cannot enable timer-based scheduling, falling back to sound IRQ scheduling.
(   2.186|   0.000) I: [pulseaudio] alsa-source.c: Successfully enabled mmap() mode.
(   2.186|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL iec958:2
(   2.186|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer iec958:2: No such file or directory
(   2.186|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:2'
(   2.186|   0.000) D: [pulseaudio] alsa-mixer.c: Added 1 ports
(   2.186|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   2.186|   0.000) I: [pulseaudio] module-device-restore.c: Restoring mute state for source alsa_input.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02.iec958-stereo: muted
(   2.187|   0.000) I: [pulseaudio] source.c: Created source 2 "alsa_input.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02.iec958-stereo" with sample spec s16le 2ch 32000Hz and channel map front-left,front-right
(   2.187|   0.000) I: [pulseaudio] source.c:     alsa.resolution_bits = "16"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.api = "alsa"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.class = "sound"
(   2.187|   0.000) I: [pulseaudio] source.c:     alsa.class = "generic"
(   2.187|   0.000) I: [pulseaudio] source.c:     alsa.subclass = "generic-mix"
(   2.187|   0.000) I: [pulseaudio] source.c:     alsa.name = "USB Audio"
(   2.187|   0.000) I: [pulseaudio] source.c:     alsa.id = "USB Audio"
(   2.187|   0.000) I: [pulseaudio] source.c:     alsa.subdevice = "0"
(   2.187|   0.000) I: [pulseaudio] source.c:     alsa.subdevice_name = "subdevice #0"
(   2.187|   0.000) I: [pulseaudio] source.c:     alsa.device = "0"
(   2.187|   0.000) I: [pulseaudio] source.c:     alsa.card = "2"
(   2.187|   0.000) I: [pulseaudio] source.c:     alsa.card_name = "HD Pro Webcam C920"
(   2.187|   0.000) I: [pulseaudio] source.c:     alsa.long_card_name = "HD Pro Webcam C920 at usb-0000:00:14.0-7, high speed"
(   2.187|   0.000) I: [pulseaudio] source.c:     alsa.driver_name = "snd_usb_audio"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.bus_path = "pci-0000:00:14.0-usb-0:7:1.2"
(   2.187|   0.000) I: [pulseaudio] source.c:     sysfs.path = "/devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.2/sound/card2"
(   2.187|   0.000) I: [pulseaudio] source.c:     udev.id = "usb-046d_HD_Pro_Webcam_C920_9DADF56F-02"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.bus = "usb"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.vendor.id = "046d"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.vendor.name = "Logitech, Inc."
(   2.187|   0.000) I: [pulseaudio] source.c:     device.product.id = "082d"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.product.name = "HD Pro Webcam C920"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.serial = "046d_HD_Pro_Webcam_C920_9DADF56F"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.form_factor = "webcam"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.string = "iec958:2"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.buffering.buffer_size = "12792"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.buffering.fragment_size = "3196"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.access_mode = "mmap"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.profile.name = "iec958-stereo"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.profile.description = "Digital Stereo (IEC958)"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.description = "HD Pro Webcam C920 Digital Stereo (IEC958)"
(   2.187|   0.000) I: [pulseaudio] source.c:     alsa.mixer_name = "USB Mixer"
(   2.187|   0.000) I: [pulseaudio] source.c:     alsa.components = "USB046d:082d"
(   2.187|   0.000) I: [pulseaudio] source.c:     module-udev-detect.discovered = "1"
(   2.187|   0.000) I: [pulseaudio] source.c:     device.icon_name = "camera-web-usb"
(   2.187|   0.000) I: [pulseaudio] alsa-source.c: Using 4.0 fragments of size 3196 bytes (24.97ms), buffer size is 12792 bytes (99.94ms)
(   2.187|   0.000) D: [pulseaudio] alsa-source.c: hwbuf_unused=0
(   2.187|   0.000) D: [pulseaudio] alsa-source.c: setting avail_min=1
(   2.187|   0.000) D: [pulseaudio] alsa-mixer.c: Activating path iec958-stereo-input
(   2.187|   0.000) D: [pulseaudio] alsa-mixer.c: Path iec958-stereo-input (Digital Input (S/PDIF)), direction=2, priority=0, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   2.187|   0.000) I: [pulseaudio] alsa-source.c: Driver does not support hardware volume control, falling back to software volume control.
(   2.187|   0.000) I: [pulseaudio] alsa-source.c: Driver does not support hardware mute control, falling back to software mute control.
(   2.187|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_dump():
(   2.187|   0.000) D: [pulseaudio] alsa-util.c: Hardware PCM card 2 'HD Pro Webcam C920' device 0 subdevice 0
(   2.187|   0.000) D: [pulseaudio] alsa-util.c: Its setup is:
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   stream       : CAPTURE
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   access       : MMAP_INTERLEAVED
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   format       : S16_LE
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   subformat    : STD
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   channels     : 2
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   rate         : 32000
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   exact rate   : 32000 (32000/1)
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   msbits       : 16
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   buffer_size  : 3198
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   period_size  : 799
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   period_time  : 24968
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_type  : MONOTONIC
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   period_step  : 1
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   avail_min    : 799
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   period_event : 1
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   start_threshold  : -1
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   stop_threshold   : 7201255804165423104
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   silence_threshold: 0
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   silence_size : 0
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   boundary     : 7201255804165423104
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   appl_ptr     : 0
(   2.187|   0.000) D: [pulseaudio] alsa-util.c:   hw_ptr       : 0
(   2.187|   0.000) D: [alsa-source-USB Audio] alsa-source.c: Thread starting up
(   2.192|   0.004) D: [alsa-source-USB Audio] core-util.c: RealtimeKit worked.
(   2.192|   0.000) I: [alsa-source-USB Audio] core-util.c: Successfully enabled SCHED_RR scheduling for thread, with priority 5.
(   2.192|   0.000) I: [alsa-source-USB Audio] alsa-source.c: Starting capture.
(   2.192|   0.000) I: [pulseaudio] module.c: Loaded "module-alsa-card" (index: #8; argument: "device_id="2" name="usb-046d_HD_Pro_Webcam_C920_9DADF56F-02" card_name="alsa_card.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1"").
(   2.192|   0.000) I: [pulseaudio] module-udev-detect.c: Card /devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.2/sound/card2 (alsa_card.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02) module loaded.
(   2.193|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC4 is accessible: yes
(   2.193|   0.000) D: [pulseaudio] module-udev-detect.c: /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9.2/1-9.2:1.0/sound/card4 is busy: no
(   2.193|   0.000) D: [pulseaudio] module-udev-detect.c: Loading module-alsa-card with arguments 'device_id="4" name="usb-0d8c_C-Media_USB_Audio_Device-00" card_name="alsa_card.usb-0d8c_C-Media_USB_Audio_Device-00" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1"'
(   2.194|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully acquired reservation lock on device 'Audio4'
(   2.194|   0.000) I: [pulseaudio] (alsa-lib)utils.c: could not open configuration file /usr/share/alsa/ucm/C-Media USB Audio Device/C-Media USB Audio Device.conf
(   2.194|   0.000) I: [pulseaudio] (alsa-lib)parser.c: error: could not parse configuration for card C-Media USB Audio Device
(   2.194|   0.000) I: [pulseaudio] (alsa-lib)main.c: error: failed to import C-Media USB Audio Device use case configuration -2
(   2.194|   0.000) I: [pulseaudio] alsa-ucm.c: UCM not available for card C-Media USB Audio Device
(   2.194|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/profile-sets/default.conf'
(   2.196|   0.001) D: [pulseaudio] alsa-mixer.c: Looking at profile input:analog-mono
(   2.196|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Mono (analog-mono)
(   2.196|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.196|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:4
(   2.197|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.197|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 11888 ms
(   2.197|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   2.198|   0.000) D: [pulseaudio] alsa-mixer.c: Profile input:analog-mono supported.
(   2.198|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-front-mic.conf'
(   2.198|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.198|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-rear-mic.conf'
(   2.198|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.198|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-internal-mic.conf'
(   2.198|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.198|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-dock-mic.conf'
(   2.198|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.199|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf'
(   2.199|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.199|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf'
(   2.199|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.199|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-linein.conf'
(   2.199|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-aux.conf'
(   2.199|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.200|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-video.conf'
(   2.200|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.200|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-tvtuner.conf'
(   2.200|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.200|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-fm.conf'
(   2.200|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.201|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic-line.conf'
(   2.201|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.201|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.201|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-headset-mic.conf'
(   2.201|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.201|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:4'
(   2.201|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-front-mic'
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Mic Jack' succeeded (not found)
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Mic Phantom Jack' succeeded (not found)
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-front-mic', none of required-any elements preset.
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-rear-mic'
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Rear Mic Jack' succeeded (not found)
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Rear Mic Phantom Jack' succeeded (not found)
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-rear-mic', none of required-any elements preset.
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-internal-mic'
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Mic Jack' succeeded (not found)
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Mic Jack' succeeded (not found)
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Mic Jack' succeeded (not found)
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Rear Mic Jack' succeeded (not found)
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Internal Mic Phantom Jack' succeeded (not found)
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.202|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Int Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Int Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-internal-mic', none of required-any elements preset.
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-dock-mic'
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Mic Jack' succeeded (not found)
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Mic Phantom Jack' succeeded (not found)
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-dock-mic', none of required-any elements preset.
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input'
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' failed.
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-mic'
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Mic Jack' succeeded (not found)
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Mic Phantom Jack' succeeded (not found)
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=1, switch=1, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Select' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost (+20dB)' succeeded (volume=0, switch=0, enumeration=0).
(   2.203|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-linein'
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Jack' succeeded (not found)
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Phantom Jack' succeeded (not found)
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-linein', none of required-any elements preset.
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-aux'
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' failed.
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-video'
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' failed.
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-tvtuner'
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' failed.
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-fm'
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.204|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' failed.
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-mic-line'
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=2, switch=2, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' failed.
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-headset-mic'
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headset Mic Jack' succeeded (not found)
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headset Mic Phantom Jack' succeeded (not found)
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Mic Jack' succeeded (not found)
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headset Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headset Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headset' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-headset-mic', none of required-any elements preset.
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xefdd10, direction=2
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-input-mic (Microphone), direction=2, priority=87, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=16, min_dB=0, max_dB=23.81
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Element Mic, direction=2, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=4, required_absent=0, mask=0x7ffffffffffff, n_channels=1, override_map=yes
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Mic, alsa_name='Mic Jack', detection unavailable
(   2.205|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Mic Phantom, alsa_name='Mic Phantom Jack', detection unavailable
(   2.206|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:analog-stereo
(   2.206|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Stereo (analog-stereo)
(   2.206|   0.000) D: [pulseaudio] alsa-util.c: Trying front:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.206|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:4
(   2.206|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.206|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(2) failed: Invalid argument
(   2.206|   0.000) D: [pulseaudio] alsa-util.c: Trying front:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.207|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:4
(   2.207|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.207|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(2) failed: Invalid argument
(   2.207|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:front:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.207|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:front:4
(   2.207|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.207|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(2) failed: Invalid argument
(   2.207|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:front:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.207|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:front:4
(   2.208|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.208|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(2) failed: Invalid argument
(   2.208|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:front:4: Invalid argument
(   2.208|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.208|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:4
(   2.208|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.208|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(2) failed: Invalid argument
(   2.208|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.208|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:4
(   2.208|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.208|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(2) failed: Invalid argument
(   2.208|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.208|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:4
(   2.209|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.209|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(2) failed: Invalid argument
(   2.209|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.209|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:4
(   2.209|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.209|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(2) failed: Invalid argument
(   2.209|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:hw:4: Invalid argument
(   2.209|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:analog-stereo
(   2.209|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:iec958-stereo
(   2.209|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Digital Stereo (IEC958) (iec958-stereo)
(   2.209|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.210|   0.000) D: [pulseaudio] alsa-util.c: Managed to open iec958:4
(   2.210|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.210|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(2) failed: Invalid argument
(   2.210|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.210|   0.000) D: [pulseaudio] alsa-util.c: Managed to open iec958:4
(   2.210|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.210|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(2) failed: Invalid argument
(   2.210|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:iec958:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.211|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:iec958:4
(   2.211|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.211|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(2) failed: Invalid argument
(   2.211|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:iec958:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.211|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:iec958:4
(   2.212|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.212|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(2) failed: Invalid argument
(   2.212|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:iec958:4: Invalid argument
(   2.212|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:iec958-stereo
(   2.212|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-mono
(   2.212|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Mono (analog-mono)
(   2.212|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.212|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:4
(   2.212|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.212|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   2.212|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.212|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:4
(   2.212|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.212|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   2.212|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.212|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:4
(   2.212|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.212|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   2.212|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.213|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:4
(   2.213|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.213|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   2.213|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:hw:4: Invalid argument
(   2.213|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-mono
(   2.213|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:analog-mono - will not be able to open output:analog-mono
(   2.213|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:analog-stereo - will not be able to open output:analog-mono
(   2.213|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:iec958-stereo - will not be able to open output:analog-mono
(   2.213|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-stereo
(   2.213|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Stereo (analog-stereo)
(   2.213|   0.000) D: [pulseaudio] alsa-util.c: Trying front:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.213|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:4
(   2.213|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.213|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
(   2.214|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   2.215|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-stereo supported.
(   2.215|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf'
(   2.215|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   2.215|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-lineout.conf'
(   2.215|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   2.215|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-speaker.conf'
(   2.215|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   2.215|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-headphones.conf'
(   2.216|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   2.216|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-headphones-2.conf'
(   2.216|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   2.216|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL front:4
(   2.216|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer front:4: No such file or directory
(   2.216|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:4'
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output'
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=1, switch=1, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-lineout'
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Jack' succeeded (not found)
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Phantom Jack' succeeded (not found)
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   2.216|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Front Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Front Phantom Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out CLFE Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out CLFE Phantom Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Surround Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Surround Phantom Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Side Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Side Phantom Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line HP Swap' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Front' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Surround' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Side' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=1, switch=1, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-output-lineout', none of required-any elements preset.
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-speaker'
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Headphone Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Headphone Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Front Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Speaker Phantom Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Speaker Front Phantom Jack' succeeded (not found)
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Front' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Surround' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Side' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=0, switch=0, enumeration=0).
(   2.217|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=1, switch=1, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-output-speaker', none of required-any elements preset.
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-headphones'
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Headphone Jack' succeeded (not found)
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Headphone Phantom Jack' succeeded (not found)
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Headphone Jack' succeeded (not found)
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Headphone Phantom Jack' succeeded (not found)
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Phantom Jack' succeeded (not found)
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Mic Jack' succeeded (not found)
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headset' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line HP Swap' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Front' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Surround' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Side' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=1, switch=1, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-output-headphones', none of required-any elements preset.
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-headphones-2'
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' failed.
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xe7e710, direction=1
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output (Analog Output), direction=1, priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=151, min_dB=-28.37, max_dB=-0.06
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-stereo+input:analog-mono
(   2.218|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Mono (analog-mono)
(   2.218|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.219|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:4
(   2.219|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.219|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 11888 ms
(   2.220|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   2.220|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-stereo+input:analog-mono supported.
(   2.221|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:analog-stereo - will not be able to open input:analog-stereo
(   2.221|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:iec958-stereo - will not be able to open input:iec958-stereo
(   2.225|   0.004) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-21
(   2.225|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 2.1 (analog-surround-21)
(   2.225|   0.000) D: [pulseaudio] alsa-util.c: Trying surround21:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.226|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state for chmap_get: OPEN
(   2.226|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround21:4
(   2.226|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.226|   0.000) D: [pulseaudio] alsa-util.c: Trying surround21:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.226|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state for chmap_get: OPEN
(   2.226|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround21:4
(   2.226|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.226|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround21:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.226|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state for chmap_get: OPEN
(   2.226|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround21:4
(   2.226|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   2.227|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.227|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround21:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.227|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state for chmap_get: OPEN
(   2.227|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround21:4
(   2.227|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   2.227|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.227|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround21:4: Invalid argument
(   2.227|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-21
(   2.227|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:analog-mono - will not be able to open output:analog-surround-21
(   2.227|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:analog-stereo - will not be able to open output:analog-surround-21
(   2.227|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:iec958-stereo - will not be able to open output:analog-surround-21
(   2.227|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-40
(   2.227|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 4.0 (analog-surround-40)
(   2.227|   0.000) D: [pulseaudio] alsa-util.c: Trying surround40:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.227|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround40:4
(   2.228|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.228|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(4) failed: Invalid argument
(   2.228|   0.000) D: [pulseaudio] alsa-util.c: Trying surround40:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.228|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround40:4
(   2.228|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.228|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(4) failed: Invalid argument
(   2.228|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround40:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.228|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround40:4
(   2.229|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.229|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(4) failed: Invalid argument
(   2.229|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround40:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.229|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround40:4
(   2.229|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.229|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(4) failed: Invalid argument
(   2.229|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround40:4: Invalid argument
(   2.229|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-40
(   2.229|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:analog-mono - will not be able to open output:analog-surround-40
(   2.229|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:analog-stereo - will not be able to open output:analog-surround-40
(   2.229|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:iec958-stereo - will not be able to open output:analog-surround-40
(   2.229|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-41
(   2.229|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 4.1 (analog-surround-41)
(   2.229|   0.000) D: [pulseaudio] alsa-util.c: Trying surround41:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.230|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround41:4
(   2.230|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.230|   0.000) D: [pulseaudio] alsa-util.c: Trying surround41:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.230|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround41:4
(   2.230|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.230|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround41:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.231|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround41:4
(   2.231|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   2.231|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.231|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround41:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.231|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround41:4
(   2.231|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   2.231|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.231|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround41:4: Invalid argument
(   2.231|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-41
(   2.231|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:analog-mono - will not be able to open output:analog-surround-41
(   2.231|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:analog-stereo - will not be able to open output:analog-surround-41
(   2.231|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:iec958-stereo - will not be able to open output:analog-surround-41
(   2.231|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-50
(   2.231|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 5.0 (analog-surround-50)
(   2.231|   0.000) D: [pulseaudio] alsa-util.c: Trying surround50:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.232|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround50:4
(   2.232|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.232|   0.000) D: [pulseaudio] alsa-util.c: Trying surround50:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.232|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround50:4
(   2.232|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.232|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround50:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.232|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround50:4
(   2.232|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   2.232|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.233|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround50:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.233|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround50:4
(   2.233|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   2.233|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.233|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround50:4: Invalid argument
(   2.233|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-50
(   2.233|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:analog-mono - will not be able to open output:analog-surround-50
(   2.233|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:analog-stereo - will not be able to open output:analog-surround-50
(   2.233|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:iec958-stereo - will not be able to open output:analog-surround-50
(   2.233|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-51
(   2.233|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 5.1 (analog-surround-51)
(   2.233|   0.000) D: [pulseaudio] alsa-util.c: Trying surround51:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.233|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround51:4
(   2.233|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.233|   0.000) D: [pulseaudio] alsa-util.c: Trying surround51:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.234|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround51:4
(   2.234|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.234|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround51:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.234|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround51:4
(   2.234|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   2.234|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.234|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround51:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.235|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround51:4
(   2.235|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   2.235|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.235|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround51:4: Invalid argument
(   2.235|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-51
(   2.235|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:analog-mono - will not be able to open output:analog-surround-51
(   2.235|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:analog-stereo - will not be able to open output:analog-surround-51
(   2.235|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:iec958-stereo - will not be able to open output:analog-surround-51
(   2.235|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-71
(   2.235|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 7.1 (analog-surround-71)
(   2.235|   0.000) D: [pulseaudio] alsa-util.c: Trying surround71:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.235|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround71:4
(   2.235|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.235|   0.000) D: [pulseaudio] alsa-util.c: Trying surround71:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.236|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround71:4
(   2.236|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.236|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround71:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.236|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround71:4
(   2.236|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   2.236|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.236|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround71:4 without SND_PCM_NO_AUTO_FORMAT ...
(   2.236|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround71:4
(   2.236|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   2.236|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   2.236|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround71:4: Invalid argument
(   2.236|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-71
(   2.237|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:analog-mono - will not be able to open output:analog-surround-71
(   2.237|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:analog-stereo - will not be able to open output:analog-surround-71
(   2.237|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:iec958-stereo - will not be able to open output:analog-surround-71
(   2.237|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-stereo
(   2.237|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (IEC958) (iec958-stereo)
(   2.237|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.237|   0.000) D: [pulseaudio] alsa-util.c: Managed to open iec958:4
(   2.237|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.237|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
(   2.238|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   2.238|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:iec958-stereo supported.
(   2.238|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/iec958-stereo-output.conf'
(   2.238|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL iec958:4
(   2.238|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer iec958:4: No such file or directory
(   2.238|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:4'
(   2.238|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'iec958-stereo-output'
(   2.238|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   2.238|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   2.238|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0x1005630, direction=1
(   2.238|   0.000) D: [pulseaudio] alsa-mixer.c: Path iec958-stereo-output (Digital Output (S/PDIF)), direction=1, priority=0, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   2.239|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-stereo+input:analog-mono
(   2.239|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Mono (analog-mono)
(   2.239|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.239|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:4
(   2.239|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.239|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 11888 ms
(   2.240|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   2.240|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:iec958-stereo+input:analog-mono supported.
(   2.241|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:analog-stereo - will not be able to open input:analog-stereo
(   2.241|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:iec958-stereo - will not be able to open input:iec958-stereo
(   2.245|   0.004) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-ac3-surround-40
(   2.245|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 4.0 (IEC958/AC3) (iec958-ac3-surround-40)
(   2.245|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.245|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:4
(   2.245|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device a52:4: No such file or directory
(   2.245|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-ac3-surround-40
(   2.245|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:analog-mono - will not be able to open output:iec958-ac3-surround-40
(   2.245|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:analog-stereo - will not be able to open output:iec958-ac3-surround-40
(   2.245|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:iec958-stereo - will not be able to open output:iec958-ac3-surround-40
(   2.245|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-ac3-surround-51
(   2.245|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (IEC958/AC3) (iec958-ac3-surround-51)
(   2.245|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.245|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:4
(   2.245|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device a52:4: No such file or directory
(   2.245|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-ac3-surround-51
(   2.245|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:analog-mono - will not be able to open output:iec958-ac3-surround-51
(   2.245|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:analog-stereo - will not be able to open output:iec958-ac3-surround-51
(   2.245|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:iec958-stereo - will not be able to open output:iec958-ac3-surround-51
(   2.245|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-dts-surround-51
(   2.245|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (IEC958/DTS) (iec958-dts-surround-51)
(   2.245|   0.000) D: [pulseaudio] alsa-util.c: Trying dca:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.245|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dca:4
(   2.245|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dca:4: No such file or directory
(   2.245|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-dts-surround-51
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:analog-mono - will not be able to open output:iec958-dts-surround-51
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:analog-stereo - will not be able to open output:iec958-dts-surround-51
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:iec958-stereo - will not be able to open output:iec958-dts-surround-51
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI) (hdmi-stereo)
(   2.246|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.246|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.0:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.246|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.246|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.246|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4
(   2.246|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4: No such file or directory
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:analog-mono - will not be able to open output:hdmi-stereo
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:analog-stereo - will not be able to open output:hdmi-stereo
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:iec958-stereo - will not be able to open output:hdmi-stereo
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI) (hdmi-surround)
(   2.246|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.246|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.0:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.246|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.246|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.246|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4
(   2.246|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4: No such file or directory
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:analog-mono - will not be able to open output:hdmi-surround
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:analog-stereo - will not be able to open output:hdmi-surround
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:iec958-stereo - will not be able to open output:hdmi-surround
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71
(   2.246|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI) (hdmi-surround71)
(   2.246|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.246|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.0:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.247|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.247|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.247|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4
(   2.247|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4: No such file or directory
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:analog-mono - will not be able to open output:hdmi-surround71
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:analog-stereo - will not be able to open output:hdmi-surround71
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:iec958-stereo - will not be able to open output:hdmi-surround71
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI/DTS) (hdmi-dts-surround)
(   2.247|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.247|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:4
(   2.247|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:4: No such file or directory
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:analog-mono - will not be able to open output:hdmi-dts-surround
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:analog-stereo - will not be able to open output:hdmi-dts-surround
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:iec958-stereo - will not be able to open output:hdmi-dts-surround
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra1
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 2) (hdmi-stereo-extra1)
(   2.247|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,1 with SND_PCM_NO_AUTO_FORMAT ...
(   2.247|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.1:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.247|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.247|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.247|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,1
(   2.247|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,1: No such file or directory
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra1
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:analog-mono - will not be able to open output:hdmi-stereo-extra1
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:analog-stereo - will not be able to open output:hdmi-stereo-extra1
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra1
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra1
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 2) (hdmi-surround-extra1)
(   2.247|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,1 with SND_PCM_NO_AUTO_FORMAT ...
(   2.247|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.1:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.247|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.247|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.247|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,1
(   2.247|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,1: No such file or directory
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra1
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:analog-mono - will not be able to open output:hdmi-surround-extra1
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:analog-stereo - will not be able to open output:hdmi-surround-extra1
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:iec958-stereo - will not be able to open output:hdmi-surround-extra1
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra1
(   2.247|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 2) (hdmi-surround71-extra1)
(   2.247|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,1 with SND_PCM_NO_AUTO_FORMAT ...
(   2.248|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.1:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.248|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.248|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.248|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,1
(   2.248|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,1: No such file or directory
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra1
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:analog-mono - will not be able to open output:hdmi-surround71-extra1
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:analog-stereo - will not be able to open output:hdmi-surround71-extra1
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra1
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra1
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 2/DTS) (hdmi-dts-surround-extra1)
(   2.248|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:4,1 with SND_PCM_NO_AUTO_FORMAT ...
(   2.248|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:4,1
(   2.248|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:4,1: No such file or directory
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra1
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra1
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra1
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra1
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra2
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 3) (hdmi-stereo-extra2)
(   2.248|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.248|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.2:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.248|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.248|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.248|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,2
(   2.248|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,2: No such file or directory
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra2
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:analog-mono - will not be able to open output:hdmi-stereo-extra2
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:analog-stereo - will not be able to open output:hdmi-stereo-extra2
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra2
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra2
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 3) (hdmi-surround-extra2)
(   2.248|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.248|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.2:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.248|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.248|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.248|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,2
(   2.248|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,2: No such file or directory
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra2
(   2.248|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:analog-mono - will not be able to open output:hdmi-surround-extra2
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:analog-stereo - will not be able to open output:hdmi-surround-extra2
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:iec958-stereo - will not be able to open output:hdmi-surround-extra2
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra2
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 3) (hdmi-surround71-extra2)
(   2.249|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.249|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.2:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.249|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.249|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.249|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,2
(   2.249|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,2: No such file or directory
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra2
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:analog-mono - will not be able to open output:hdmi-surround71-extra2
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:analog-stereo - will not be able to open output:hdmi-surround71-extra2
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra2
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra2
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 3/DTS) (hdmi-dts-surround-extra2)
(   2.249|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:4,2 with SND_PCM_NO_AUTO_FORMAT ...
(   2.249|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:4,2
(   2.249|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:4,2: No such file or directory
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra2
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra2
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra2
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra2
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra3
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 4) (hdmi-stereo-extra3)
(   2.249|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,3 with SND_PCM_NO_AUTO_FORMAT ...
(   2.249|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.3:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.249|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.249|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.249|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,3
(   2.249|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,3: No such file or directory
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra3
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:analog-mono - will not be able to open output:hdmi-stereo-extra3
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:analog-stereo - will not be able to open output:hdmi-stereo-extra3
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra3
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra3
(   2.249|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 4) (hdmi-surround-extra3)
(   2.249|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,3 with SND_PCM_NO_AUTO_FORMAT ...
(   2.250|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.3:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.250|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.250|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.250|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,3
(   2.250|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,3: No such file or directory
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra3
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:analog-mono - will not be able to open output:hdmi-surround-extra3
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:analog-stereo - will not be able to open output:hdmi-surround-extra3
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:iec958-stereo - will not be able to open output:hdmi-surround-extra3
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra3
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 4) (hdmi-surround71-extra3)
(   2.250|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,3 with SND_PCM_NO_AUTO_FORMAT ...
(   2.250|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.3:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.250|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.250|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.250|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,3
(   2.250|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,3: No such file or directory
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra3
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:analog-mono - will not be able to open output:hdmi-surround71-extra3
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:analog-stereo - will not be able to open output:hdmi-surround71-extra3
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra3
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra3
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 4/DTS) (hdmi-dts-surround-extra3)
(   2.250|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:4,3 with SND_PCM_NO_AUTO_FORMAT ...
(   2.250|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:4,3
(   2.250|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:4,3: No such file or directory
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra3
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra3
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra3
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra3
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra4
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 5) (hdmi-stereo-extra4)
(   2.250|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.250|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.4:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.250|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.250|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.250|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,4
(   2.250|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,4: No such file or directory
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra4
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:analog-mono - will not be able to open output:hdmi-stereo-extra4
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:analog-stereo - will not be able to open output:hdmi-stereo-extra4
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra4
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra4
(   2.250|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 5) (hdmi-surround-extra4)
(   2.251|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.251|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.4:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.251|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.251|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.251|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,4
(   2.251|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,4: No such file or directory
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra4
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:analog-mono - will not be able to open output:hdmi-surround-extra4
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:analog-stereo - will not be able to open output:hdmi-surround-extra4
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:iec958-stereo - will not be able to open output:hdmi-surround-extra4
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra4
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 5) (hdmi-surround71-extra4)
(   2.251|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.251|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.4:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.251|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.251|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.251|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,4
(   2.251|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,4: No such file or directory
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra4
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:analog-mono - will not be able to open output:hdmi-surround71-extra4
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:analog-stereo - will not be able to open output:hdmi-surround71-extra4
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra4
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra4
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 5/DTS) (hdmi-dts-surround-extra4)
(   2.251|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:4,4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.251|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:4,4
(   2.251|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:4,4: No such file or directory
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra4
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra4
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra4
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra4
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra5
(   2.251|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 6) (hdmi-stereo-extra5)
(   2.251|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,5 with SND_PCM_NO_AUTO_FORMAT ...
(   2.251|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.5:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.251|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.251|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.251|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,5
(   2.252|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,5: No such file or directory
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:analog-mono - will not be able to open output:hdmi-stereo-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:analog-stereo - will not be able to open output:hdmi-stereo-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 6) (hdmi-surround-extra5)
(   2.252|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,5 with SND_PCM_NO_AUTO_FORMAT ...
(   2.252|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.5:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.252|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.252|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.252|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,5
(   2.252|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,5: No such file or directory
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:analog-mono - will not be able to open output:hdmi-surround-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:analog-stereo - will not be able to open output:hdmi-surround-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:iec958-stereo - will not be able to open output:hdmi-surround-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 6) (hdmi-surround71-extra5)
(   2.252|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,5 with SND_PCM_NO_AUTO_FORMAT ...
(   2.252|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.5:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.252|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.252|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.252|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,5
(   2.252|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,5: No such file or directory
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:analog-mono - will not be able to open output:hdmi-surround71-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:analog-stereo - will not be able to open output:hdmi-surround71-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 6/DTS) (hdmi-dts-surround-extra5)
(   2.252|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:4,5 with SND_PCM_NO_AUTO_FORMAT ...
(   2.252|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:4,5
(   2.252|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:4,5: No such file or directory
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra5
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra6
(   2.252|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 7) (hdmi-stereo-extra6)
(   2.252|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,6 with SND_PCM_NO_AUTO_FORMAT ...
(   2.253|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.6:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.253|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.253|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.253|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,6
(   2.253|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,6: No such file or directory
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:analog-mono - will not be able to open output:hdmi-stereo-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:analog-stereo - will not be able to open output:hdmi-stereo-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 7) (hdmi-surround-extra6)
(   2.253|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,6 with SND_PCM_NO_AUTO_FORMAT ...
(   2.253|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.6:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.253|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.253|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.253|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,6
(   2.253|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,6: No such file or directory
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:analog-mono - will not be able to open output:hdmi-surround-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:analog-stereo - will not be able to open output:hdmi-surround-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:iec958-stereo - will not be able to open output:hdmi-surround-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 7) (hdmi-surround71-extra6)
(   2.253|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,6 with SND_PCM_NO_AUTO_FORMAT ...
(   2.253|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.6:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.253|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.253|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.253|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,6
(   2.253|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,6: No such file or directory
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:analog-mono - will not be able to open output:hdmi-surround71-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:analog-stereo - will not be able to open output:hdmi-surround71-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 7/DTS) (hdmi-dts-surround-extra6)
(   2.253|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:4,6 with SND_PCM_NO_AUTO_FORMAT ...
(   2.253|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:4,6
(   2.253|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:4,6: No such file or directory
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra6
(   2.253|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra6
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra6
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra6
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra7
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 8) (hdmi-stereo-extra7)
(   2.254|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,7 with SND_PCM_NO_AUTO_FORMAT ...
(   2.254|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.7:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.254|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.254|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.254|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,7
(   2.254|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,7: No such file or directory
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra7
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:analog-mono - will not be able to open output:hdmi-stereo-extra7
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:analog-stereo - will not be able to open output:hdmi-stereo-extra7
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra7
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra7
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 8) (hdmi-surround-extra7)
(   2.254|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,7 with SND_PCM_NO_AUTO_FORMAT ...
(   2.254|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.7:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.254|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.254|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.254|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,7
(   2.254|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,7: No such file or directory
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra7
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:analog-mono - will not be able to open output:hdmi-surround-extra7
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:analog-stereo - will not be able to open output:hdmi-surround-extra7
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:iec958-stereo - will not be able to open output:hdmi-surround-extra7
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra7
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 8) (hdmi-surround71-extra7)
(   2.254|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:4,7 with SND_PCM_NO_AUTO_FORMAT ...
(   2.254|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.7:CARD=4,AES0=4,AES1=130,AES2=0,AES3=2'
(   2.254|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(   2.254|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(   2.254|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:4,7
(   2.254|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:4,7: No such file or directory
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra7
(   2.254|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:analog-mono - will not be able to open output:hdmi-surround71-extra7
(   2.255|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:analog-stereo - will not be able to open output:hdmi-surround71-extra7
(   2.255|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra7
(   2.255|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra7
(   2.255|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 8/DTS) (hdmi-dts-surround-extra7)
(   2.255|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:4,7 with SND_PCM_NO_AUTO_FORMAT ...
(   2.255|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:4,7
(   2.255|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:4,7: No such file or directory
(   2.255|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra7
(   2.255|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra7
(   2.255|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra7
(   2.255|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra7
(   2.255|   0.000) D: [pulseaudio] alsa-mixer.c: Profile set 0xe9f2f0, auto_profiles=yes, probed=yes, n_mappings=3, n_profiles=5, n_decibel_fixes=0
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping analog-mono (Analog Mono), priority=2, channel_map=mono, supported=yes, direction=0
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping analog-stereo (Analog Stereo), priority=60, channel_map=front-left,front-right, supported=yes, direction=0
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping iec958-stereo (Digital Stereo (IEC958)), priority=55, channel_map=front-left,front-right, supported=yes, direction=0
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Profile input:analog-mono (Analog Mono Input), priority=2, supported=yes n_input_mappings=1, n_output_mappings=0
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-mono
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-stereo (Analog Stereo Output), priority=6000, supported=yes n_input_mappings=0, n_output_mappings=1
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-stereo
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-stereo+input:analog-mono (Analog Stereo Output + Analog Mono Input), priority=6002, supported=yes n_input_mappings=1, n_output_mappings=1
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-mono
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-stereo
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:iec958-stereo (Digital Stereo (IEC958) Output), priority=5500, supported=yes n_input_mappings=0, n_output_mappings=1
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Output iec958-stereo
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:iec958-stereo+input:analog-mono (Digital Stereo (IEC958) Output + Analog Mono Input), priority=5502, supported=yes n_input_mappings=1, n_output_mappings=1
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-mono
(   2.256|   0.000) D: [pulseaudio] alsa-mixer.c: Output iec958-stereo
(   2.256|   0.000) I: [pulseaudio] module-card-restore.c: Restoring port latency offsets for card alsa_card.usb-0d8c_C-Media_USB_Audio_Device-00.
(   2.256|   0.000) I: [pulseaudio] card.c: Created 3 "alsa_card.usb-0d8c_C-Media_USB_Audio_Device-00"
(   2.256|   0.000) D: [pulseaudio] module-alsa-card.c: Found 0 jacks.
(   2.257|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully create reservation lock monitor for device 'Audio4'
(   2.257|   0.000) D: [pulseaudio] alsa-util.c: Trying front:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.257|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:4
(   2.257|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.257|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
(   2.258|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   2.258|   0.000) I: [pulseaudio] alsa-sink.c: Successfully opened device front:4.
(   2.258|   0.000) I: [pulseaudio] alsa-sink.c: Selected mapping 'Analog Stereo' (analog-stereo).
(   2.258|   0.000) I: [pulseaudio] alsa-sink.c: Cannot enable timer-based scheduling, falling back to sound IRQ scheduling.
(   2.258|   0.000) I: [pulseaudio] alsa-sink.c: Successfully enabled mmap() mode.
(   2.258|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL front:4
(   2.258|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer front:4: No such file or directory
(   2.259|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:4'
(   2.259|   0.000) D: [pulseaudio] alsa-mixer.c: Added 1 ports
(   2.259|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   2.259|   0.000) I: [pulseaudio] sink.c: Created sink 2 "alsa_output.usb-0d8c_C-Media_USB_Audio_Device-00.analog-stereo" with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
(   2.259|   0.000) I: [pulseaudio] sink.c:     alsa.resolution_bits = "16"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.api = "alsa"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.class = "sound"
(   2.259|   0.000) I: [pulseaudio] sink.c:     alsa.class = "generic"
(   2.259|   0.000) I: [pulseaudio] sink.c:     alsa.subclass = "generic-mix"
(   2.259|   0.000) I: [pulseaudio] sink.c:     alsa.name = "USB Audio"
(   2.259|   0.000) I: [pulseaudio] sink.c:     alsa.id = "USB Audio"
(   2.259|   0.000) I: [pulseaudio] sink.c:     alsa.subdevice = "0"
(   2.259|   0.000) I: [pulseaudio] sink.c:     alsa.subdevice_name = "subdevice #0"
(   2.259|   0.000) I: [pulseaudio] sink.c:     alsa.device = "0"
(   2.259|   0.000) I: [pulseaudio] sink.c:     alsa.card = "4"
(   2.259|   0.000) I: [pulseaudio] sink.c:     alsa.card_name = "C-Media USB Audio Device"
(   2.259|   0.000) I: [pulseaudio] sink.c:     alsa.long_card_name = "C-Media USB Audio Device at usb-0000:00:14.0-9.2, full speed"
(   2.259|   0.000) I: [pulseaudio] sink.c:     alsa.driver_name = "snd_usb_audio"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.bus_path = "pci-0000:00:14.0-usb-0:9.2:1.0"
(   2.259|   0.000) I: [pulseaudio] sink.c:     sysfs.path = "/devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9.2/1-9.2:1.0/sound/card4"
(   2.259|   0.000) I: [pulseaudio] sink.c:     udev.id = "usb-0d8c_C-Media_USB_Audio_Device-00"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.bus = "usb"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.vendor.id = "0d8c"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.vendor.name = "C-Media Electronics, Inc."
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.product.id = "0008"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.product.name = "C-Media USB Audio Device   "
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.serial = "0d8c_C-Media_USB_Audio_Device"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.string = "front:4"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.buffering.buffer_size = "17632"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.buffering.fragment_size = "4408"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.access_mode = "mmap"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.profile.name = "analog-stereo"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.profile.description = "Analog Stereo"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.description = "C-Media USB Audio Device    Analog Stereo"
(   2.259|   0.000) I: [pulseaudio] sink.c:     alsa.mixer_name = "USB Mixer"
(   2.259|   0.000) I: [pulseaudio] sink.c:     alsa.components = "USB0d8c:0008"
(   2.259|   0.000) I: [pulseaudio] sink.c:     module-udev-detect.discovered = "1"
(   2.259|   0.000) I: [pulseaudio] sink.c:     device.icon_name = "audio-card-usb"
(   2.259|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   2.259|   0.000) I: [pulseaudio] source.c: Created source 3 "alsa_output.usb-0d8c_C-Media_USB_Audio_Device-00.analog-stereo.monitor" with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
(   2.259|   0.000) I: [pulseaudio] source.c:     device.description = "Monitor of C-Media USB Audio Device    Analog Stereo"
(   2.259|   0.000) I: [pulseaudio] source.c:     device.class = "monitor"
(   2.259|   0.000) I: [pulseaudio] source.c:     alsa.card = "4"
(   2.259|   0.000) I: [pulseaudio] source.c:     alsa.card_name = "C-Media USB Audio Device"
(   2.259|   0.000) I: [pulseaudio] source.c:     alsa.long_card_name = "C-Media USB Audio Device at usb-0000:00:14.0-9.2, full speed"
(   2.259|   0.000) I: [pulseaudio] source.c:     alsa.driver_name = "snd_usb_audio"
(   2.259|   0.000) I: [pulseaudio] source.c:     device.bus_path = "pci-0000:00:14.0-usb-0:9.2:1.0"
(   2.259|   0.000) I: [pulseaudio] source.c:     sysfs.path = "/devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9.2/1-9.2:1.0/sound/card4"
(   2.259|   0.000) I: [pulseaudio] source.c:     udev.id = "usb-0d8c_C-Media_USB_Audio_Device-00"
(   2.259|   0.000) I: [pulseaudio] source.c:     device.bus = "usb"
(   2.259|   0.000) I: [pulseaudio] source.c:     device.vendor.id = "0d8c"
(   2.259|   0.000) I: [pulseaudio] source.c:     device.vendor.name = "C-Media Electronics, Inc."
(   2.259|   0.000) I: [pulseaudio] source.c:     device.product.id = "0008"
(   2.259|   0.000) I: [pulseaudio] source.c:     device.product.name = "C-Media USB Audio Device   "
(   2.259|   0.000) I: [pulseaudio] source.c:     device.serial = "0d8c_C-Media_USB_Audio_Device"
(   2.259|   0.000) I: [pulseaudio] source.c:     device.string = "4"
(   2.259|   0.000) I: [pulseaudio] source.c:     module-udev-detect.discovered = "1"
(   2.259|   0.000) I: [pulseaudio] source.c:     device.icon_name = "audio-card-usb"
(   2.260|   0.000) I: [pulseaudio] alsa-sink.c: Using 4.0 fragments of size 4408 bytes (24.99ms), buffer size is 17632 bytes (99.95ms)
(   2.260|   0.000) D: [pulseaudio] alsa-sink.c: hwbuf_unused=0
(   2.260|   0.000) D: [pulseaudio] alsa-sink.c: setting avail_min=1
(   2.260|   0.000) D: [pulseaudio] alsa-mixer.c: Activating path analog-output
(   2.260|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output (Analog Output), direction=1, priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=151, min_dB=-28.37, max_dB=-0.06
(   2.260|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   2.260|   0.000) I: [pulseaudio] alsa-sink.c: Successfully enabled deferred volume.
(   2.260|   0.000) I: [pulseaudio] alsa-sink.c: Hardware volume ranges from -28.37 dB to -0.06 dB.
(   2.260|   0.000) I: [pulseaudio] alsa-sink.c: Fixing base volume to 0.06 dB
(   2.260|   0.000) I: [pulseaudio] alsa-sink.c: Using hardware volume control. Hardware dB scale supported.
(   2.260|   0.000) I: [pulseaudio] alsa-sink.c: Using hardware mute control.
(   2.260|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_dump():
(   2.260|   0.000) D: [pulseaudio] alsa-util.c: Hardware PCM card 4 'C-Media USB Audio Device' device 0 subdevice 0
(   2.260|   0.000) D: [pulseaudio] alsa-util.c: Its setup is:
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   stream       : PLAYBACK
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   access       : MMAP_INTERLEAVED
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   format       : S16_LE
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   subformat    : STD
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   channels     : 2
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   rate         : 44100
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   exact rate   : 44100 (44100/1)
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   msbits       : 16
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   buffer_size  : 4408
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   period_size  : 1102
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   period_time  : 24988
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_type  : MONOTONIC
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   period_step  : 1
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   avail_min    : 1102
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   period_event : 1
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   start_threshold  : -1
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   stop_threshold   : 4962966789362286592
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   silence_threshold: 0
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   silence_size : 0
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   boundary     : 4962966789362286592
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   appl_ptr     : 0
(   2.260|   0.000) D: [pulseaudio] alsa-util.c:   hw_ptr       : 0
(   2.260|   0.000) D: [pulseaudio] alsa-sink.c: Read hardware volume: front-left: 30338 /  46% / -20.07 dB,   front-right: 30338 /  46% / -20.07 dB
(   2.260|   0.000) D: [alsa-sink-USB Audio] alsa-sink.c: Thread starting up
(   2.265|   0.004) D: [alsa-sink-USB Audio] core-util.c: RealtimeKit worked.
(   2.265|   0.000) I: [alsa-sink-USB Audio] core-util.c: Successfully enabled SCHED_RR scheduling for thread, with priority 5.
(   2.265|   0.000) I: [alsa-sink-USB Audio] alsa-sink.c: Starting playback.
(   2.265|   0.000) D: [pulseaudio] module-device-restore.c: Could not set format on sink alsa_output.usb-0d8c_C-Media_USB_Audio_Device-00.analog-stereo
(   2.265|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:4 with SND_PCM_NO_AUTO_FORMAT ...
(   2.265|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:4
(   2.265|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   2.265|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 11888 ms
(   2.266|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   2.266|   0.000) I: [pulseaudio] alsa-source.c: Successfully opened device hw:4.
(   2.266|   0.000) I: [pulseaudio] alsa-source.c: Selected mapping 'Analog Mono' (analog-mono).
(   2.266|   0.000) I: [pulseaudio] alsa-source.c: Cannot enable timer-based scheduling, falling back to sound IRQ scheduling.
(   2.266|   0.000) I: [pulseaudio] alsa-source.c: Successfully enabled mmap() mode.
(   2.267|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:4'
(   2.267|   0.000) D: [pulseaudio] alsa-mixer.c: Added 1 ports
(   2.267|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   2.267|   0.000) I: [pulseaudio] module-device-restore.c: Restoring volume for source alsa_input.usb-0d8c_C-Media_USB_Audio_Device-00.analog-mono: mono: 65536 / 100%
(   2.267|   0.000) I: [pulseaudio] module-device-restore.c: Restoring mute state for source alsa_input.usb-0d8c_C-Media_USB_Audio_Device-00.analog-mono: unmuted
(   2.267|   0.000) I: [pulseaudio] source.c: Created source 4 "alsa_input.usb-0d8c_C-Media_USB_Audio_Device-00.analog-mono" with sample spec s16le 1ch 44100Hz and channel map mono
(   2.267|   0.000) I: [pulseaudio] source.c:     alsa.resolution_bits = "16"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.api = "alsa"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.class = "sound"
(   2.267|   0.000) I: [pulseaudio] source.c:     alsa.class = "generic"
(   2.267|   0.000) I: [pulseaudio] source.c:     alsa.subclass = "generic-mix"
(   2.267|   0.000) I: [pulseaudio] source.c:     alsa.name = "USB Audio"
(   2.267|   0.000) I: [pulseaudio] source.c:     alsa.id = "USB Audio"
(   2.267|   0.000) I: [pulseaudio] source.c:     alsa.subdevice = "0"
(   2.267|   0.000) I: [pulseaudio] source.c:     alsa.subdevice_name = "subdevice #0"
(   2.267|   0.000) I: [pulseaudio] source.c:     alsa.device = "0"
(   2.267|   0.000) I: [pulseaudio] source.c:     alsa.card = "4"
(   2.267|   0.000) I: [pulseaudio] source.c:     alsa.card_name = "C-Media USB Audio Device"
(   2.267|   0.000) I: [pulseaudio] source.c:     alsa.long_card_name = "C-Media USB Audio Device at usb-0000:00:14.0-9.2, full speed"
(   2.267|   0.000) I: [pulseaudio] source.c:     alsa.driver_name = "snd_usb_audio"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.bus_path = "pci-0000:00:14.0-usb-0:9.2:1.0"
(   2.267|   0.000) I: [pulseaudio] source.c:     sysfs.path = "/devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9.2/1-9.2:1.0/sound/card4"
(   2.267|   0.000) I: [pulseaudio] source.c:     udev.id = "usb-0d8c_C-Media_USB_Audio_Device-00"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.bus = "usb"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.vendor.id = "0d8c"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.vendor.name = "C-Media Electronics, Inc."
(   2.267|   0.000) I: [pulseaudio] source.c:     device.product.id = "0008"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.product.name = "C-Media USB Audio Device   "
(   2.267|   0.000) I: [pulseaudio] source.c:     device.serial = "0d8c_C-Media_USB_Audio_Device"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.string = "hw:4"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.buffering.buffer_size = "8816"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.buffering.fragment_size = "2204"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.access_mode = "mmap"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.profile.name = "analog-mono"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.profile.description = "Analog Mono"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.description = "C-Media USB Audio Device    Analog Mono"
(   2.267|   0.000) I: [pulseaudio] source.c:     alsa.mixer_name = "USB Mixer"
(   2.267|   0.000) I: [pulseaudio] source.c:     alsa.components = "USB0d8c:0008"
(   2.267|   0.000) I: [pulseaudio] source.c:     module-udev-detect.discovered = "1"
(   2.267|   0.000) I: [pulseaudio] source.c:     device.icon_name = "audio-card-usb"
(   2.267|   0.000) I: [pulseaudio] alsa-source.c: Using 4.0 fragments of size 2204 bytes (24.99ms), buffer size is 8816 bytes (99.95ms)
(   2.267|   0.000) D: [pulseaudio] alsa-source.c: hwbuf_unused=0
(   2.267|   0.000) D: [pulseaudio] alsa-source.c: setting avail_min=1
(   2.267|   0.000) D: [pulseaudio] alsa-mixer.c: Activating path analog-input-mic
(   2.267|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-input-mic (Microphone), direction=2, priority=87, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=16, min_dB=0, max_dB=23.81
(   2.267|   0.000) D: [pulseaudio] alsa-mixer.c: Element Mic, direction=2, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=4, required_absent=0, mask=0x7ffffffffffff, n_channels=1, override_map=yes
(   2.267|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Mic, alsa_name='Mic Jack', detection unavailable
(   2.267|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Mic Phantom, alsa_name='Mic Phantom Jack', detection unavailable
(   2.267|   0.000) I: [pulseaudio] alsa-source.c: Successfully enabled deferred volume.
(   2.267|   0.000) I: [pulseaudio] alsa-source.c: Hardware volume ranges from 0.00 dB to 23.81 dB.
(   2.267|   0.000) I: [pulseaudio] alsa-source.c: Fixing base volume to -23.81 dB
(   2.268|   0.000) I: [pulseaudio] alsa-source.c: Using hardware volume control. Hardware dB scale supported.
(   2.268|   0.000) I: [pulseaudio] alsa-source.c: Using hardware mute control.
(   2.268|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_dump():
(   2.268|   0.000) D: [pulseaudio] alsa-util.c: Hardware PCM card 4 'C-Media USB Audio Device' device 0 subdevice 0
(   2.268|   0.000) D: [pulseaudio] alsa-util.c: Its setup is:
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   stream       : CAPTURE
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   access       : MMAP_INTERLEAVED
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   format       : S16_LE
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   subformat    : STD
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   channels     : 1
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   rate         : 44100
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   exact rate   : 44100 (44100/1)
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   msbits       : 16
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   buffer_size  : 4408
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   period_size  : 1102
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   period_time  : 24988
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_type  : MONOTONIC
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   period_step  : 1
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   avail_min    : 1102
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   period_event : 1
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   start_threshold  : -1
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   stop_threshold   : 4962966789362286592
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   silence_threshold: 0
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   silence_size : 0
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   boundary     : 4962966789362286592
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   appl_ptr     : 0
(   2.268|   0.000) D: [pulseaudio] alsa-util.c:   hw_ptr       : 0
(   2.268|   0.000) D: [pulseaudio] alsa-source.c: Requested volume: mono: 65536 / 100% / 0.00 dB
(   2.268|   0.000) D: [pulseaudio] alsa-source.c: Got hardware volume: mono: 65535 / 100% / -0.00 dB
(   2.268|   0.000) D: [pulseaudio] alsa-source.c: Calculated software volume: mono: 65537 / 100% / 0.00 dB (accurate-enough=yes)
(   2.268|   0.000) D: [alsa-source-USB Audio] alsa-source.c: Thread starting up
(   2.273|   0.005) D: [alsa-source-USB Audio] core-util.c: RealtimeKit worked.
(   2.273|   0.000) I: [alsa-source-USB Audio] core-util.c: Successfully enabled SCHED_RR scheduling for thread, with priority 5.
(   2.273|   0.000) I: [alsa-source-USB Audio] alsa-source.c: Starting capture.
(   2.273|   0.000) I: [pulseaudio] module.c: Loaded "module-alsa-card" (index: #9; argument: "device_id="4" name="usb-0d8c_C-Media_USB_Audio_Device-00" card_name="alsa_card.usb-0d8c_C-Media_USB_Audio_Device-00" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1"").
(   2.273|   0.000) I: [pulseaudio] module-udev-detect.c: Card /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9.2/1-9.2:1.0/sound/card4 (alsa_card.usb-0d8c_C-Media_USB_Audio_Device-00) module loaded.
(   2.273|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC0 is accessible: yes
(   2.274|   0.000) D: [pulseaudio] module-udev-detect.c: /devices/pci0000:00/0000:00:1b.0/sound/card0 is busy: no
(   2.274|   0.000) D: [pulseaudio] module-udev-detect.c: Loading module-alsa-card with arguments 'device_id="0" name="pci-0000_00_1b.0" card_name="alsa_card.pci-0000_00_1b.0" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1"'
(   2.275|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully acquired reservation lock on device 'Audio0'
(   2.275|   0.000) I: [pulseaudio] (alsa-lib)utils.c: could not open configuration file /usr/share/alsa/ucm/HDA Intel PCH/HDA Intel PCH.conf
(   2.275|   0.000) I: [pulseaudio] (alsa-lib)parser.c: error: could not parse configuration for card HDA Intel PCH
(   2.275|   0.000) I: [pulseaudio] (alsa-lib)main.c: error: failed to import HDA Intel PCH use case configuration -2
(   2.275|   0.000) I: [pulseaudio] alsa-ucm.c: UCM not available for card HDA Intel PCH
(   2.275|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/profile-sets/default.conf'
(   2.278|   0.002) D: [pulseaudio] alsa-mixer.c: Looking at profile input:analog-mono
(   2.278|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Mono (analog-mono)
(   2.278|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:0 with SND_PCM_NO_AUTO_FORMAT ...
(   2.278|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:0
(   2.278|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   2.278|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:0 without SND_PCM_NO_AUTO_FORMAT ...
(   2.278|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:0
(   2.278|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   2.278|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:0 with SND_PCM_NO_AUTO_FORMAT ...
(   2.279|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:0
(   2.279|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   2.279|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:0 without SND_PCM_NO_AUTO_FORMAT ...
(   2.279|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:0
(   2.279|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   2.279|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:hw:0: Invalid argument
(   2.279|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:analog-mono
(   2.279|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:analog-stereo
(   2.279|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Stereo (analog-stereo)
(   2.279|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
(   2.280|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   2.280|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   2.280|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   2.280|   0.000) D: [pulseaudio] alsa-mixer.c: Profile input:analog-stereo supported.
(   2.280|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-front-mic.conf'
(   2.280|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.280|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-rear-mic.conf'
(   2.280|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.281|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-internal-mic.conf'
(   2.281|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.281|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-dock-mic.conf'
(   2.281|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.281|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf'
(   2.281|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.281|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf'
(   2.282|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.282|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-linein.conf'
(   2.282|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-aux.conf'
(   2.282|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.282|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-video.conf'
(   2.282|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.282|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-tvtuner.conf'
(   2.283|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.283|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-fm.conf'
(   2.283|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.283|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic-line.conf'
(   2.283|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input.conf.common'
(   2.283|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.283|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-headphone-mic.conf'
(   2.284|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.284|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-headset-mic.conf'
(   2.284|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-input-mic.conf.common'
(   2.284|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL front:0
(   2.284|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer front:0: No such file or directory
(   2.284|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:0'
(   2.284|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-front-mic'
(   2.284|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Mic Jack' succeeded (found!)
(   2.284|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Mic Phantom Jack' succeeded (not found)
(   2.284|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   2.284|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=1, switch=0, enumeration=0).
(   2.284|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.284|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   2.284|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.284|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.284|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-rear-mic'
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Rear Mic Jack' succeeded (found!)
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Rear Mic Phantom Jack' succeeded (not found)
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=1, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-internal-mic'
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Mic Jack' succeeded (not found)
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Mic Jack' succeeded (not found)
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Mic Jack' succeeded (found!)
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Rear Mic Jack' succeeded (found!)
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Internal Mic Phantom Jack' succeeded (not found)
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Int Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Int Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.285|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-internal-mic', none of required-any elements preset.
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-dock-mic'
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Mic Jack' succeeded (not found)
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Mic Phantom Jack' succeeded (not found)
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-dock-mic', none of required-any elements preset.
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input'
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' failed.
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-mic'
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Mic Jack' succeeded (not found)
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Mic Phantom Jack' succeeded (not found)
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Select' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost (+20dB)' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.286|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-mic', none of required-any elements preset.
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-linein'
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Jack' succeeded (found!)
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Phantom Jack' succeeded (not found)
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=1, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-aux'
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' failed.
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-video'
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' failed.
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-tvtuner'
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' failed.
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-fm'
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' failed.
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-mic-line'
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.287|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' failed.
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-headphone-mic'
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Mic Jack' succeeded (not found)
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Auto-Mute Mode' succeeded (volume=0, switch=0, enumeration=1).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-headphone-mic', none of required-any elements preset.
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input-headset-mic'
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headset Mic Jack' succeeded (not found)
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headset Mic Phantom Jack' succeeded (not found)
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Mic Jack' succeeded (not found)
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headset Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headset Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headset' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Video' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-input-headset-mic', none of required-any elements preset.
(   2.288|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xf9f0e0, direction=2
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-input-front-mic (Front Microphone), direction=2, priority=85, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=63, min_dB=-17.25, max_dB=60
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Capture, direction=2, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front Mic Boost, direction=2, switch=0, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=4, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Input Source, direction=2, switch=0, volume=0, volume_limit=-1, enumeration=1, required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0, override_map=no
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Option Front Mic (analog-input-microphone-front/analog-input-microphone-front) index=0, priority=0
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Rear Mic Boost, direction=2, switch=0, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Line Boost, direction=2, switch=0, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Front Mic, alsa_name='Front Mic Jack', detection possible
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Front Mic Phantom, alsa_name='Front Mic Phantom Jack', detection unavailable
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Setting analog-input-microphone-front (analog-input-microphone-front) priority=0
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-input-rear-mic (Rear Microphone), direction=2, priority=82, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=63, min_dB=-17.25, max_dB=60
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Capture, direction=2, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Rear Mic Boost, direction=2, switch=0, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=4, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Input Source, direction=2, switch=0, volume=0, volume_limit=-1, enumeration=1, required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0, override_map=no
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Option Rear Mic (analog-input-microphone-rear/analog-input-microphone-rear) index=1, priority=0
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front Mic Boost, direction=2, switch=0, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Line Boost, direction=2, switch=0, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Rear Mic, alsa_name='Rear Mic Jack', detection possible
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Rear Mic Phantom, alsa_name='Rear Mic Phantom Jack', detection unavailable
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Setting analog-input-microphone-rear (analog-input-microphone-rear) priority=0
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-input-linein (Line In), direction=2, priority=81, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=63, min_dB=-17.25, max_dB=60
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Capture, direction=2, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Line Boost, direction=2, switch=0, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=4, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Input Source, direction=2, switch=0, volume=0, volume_limit=-1, enumeration=1, required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0, override_map=no
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Option Line (analog-input-linein/analog-input-linein) index=2, priority=0
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front Mic Boost, direction=2, switch=0, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Element Rear Mic Boost, direction=2, switch=0, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line, alsa_name='Line Jack', detection possible
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Phantom, alsa_name='Line Phantom Jack', detection unavailable
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Setting analog-input-linein (analog-input-linein) priority=0
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:iec958-stereo
(   2.289|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Digital Stereo (IEC958) (iec958-stereo)
(   2.289|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:0 with SND_PCM_NO_AUTO_FORMAT ...
(   2.289|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D1c' failed (-2)
(   2.290|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device iec958:0: No such file or directory
(   2.290|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:iec958-stereo
(   2.290|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-mono
(   2.290|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Mono (analog-mono)
(   2.290|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:0 with SND_PCM_NO_AUTO_FORMAT ...
(   2.290|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:0
(   2.290|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   2.290|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:0 without SND_PCM_NO_AUTO_FORMAT ...
(   2.290|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:0
(   2.290|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   2.290|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:0 with SND_PCM_NO_AUTO_FORMAT ...
(   2.290|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:0
(   2.290|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   2.290|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:0 without SND_PCM_NO_AUTO_FORMAT ...
(   2.291|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:0
(   2.291|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   2.291|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:hw:0: Invalid argument
(   2.291|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-mono
(   2.291|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:analog-mono - will not be able to open output:analog-mono
(   2.291|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:analog-stereo - will not be able to open output:analog-mono
(   2.291|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:iec958-stereo - will not be able to open output:analog-mono
(   2.291|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-stereo
(   2.291|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Stereo (analog-stereo)
(   2.291|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
(   2.291|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   2.291|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   3.329|   1.037) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   3.329|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-stereo supported.
(   3.329|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf'
(   3.329|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   3.329|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-lineout.conf'
(   3.329|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   3.329|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-speaker.conf'
(   3.330|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   3.330|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-headphones.conf'
(   3.330|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   3.330|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-headphones-2.conf'
(   3.330|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   3.330|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL front:0
(   3.330|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer front:0: No such file or directory
(   3.331|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:0'
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output'
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=1, switch=1, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=1, switch=1, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=1, switch=1, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=1, switch=1, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=1, switch=1, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=1, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=2, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-lineout'
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Jack' succeeded (not found)
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Phantom Jack' succeeded (not found)
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Front Jack' succeeded (found!)
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Front Phantom Jack' succeeded (not found)
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out CLFE Jack' succeeded (found!)
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out CLFE Phantom Jack' succeeded (not found)
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Surround Jack' succeeded (found!)
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Surround Phantom Jack' succeeded (not found)
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Side Jack' succeeded (not found)
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Side Phantom Jack' succeeded (not found)
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=1, switch=1, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line HP Swap' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=2, switch=2, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   3.331|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=1, switch=1, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=1, switch=1, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=1, switch=1, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=1, switch=1, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Front' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Surround' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Side' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=1, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=2, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-speaker'
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Headphone Jack' succeeded (not found)
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Headphone Jack' succeeded (found!)
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Jack' succeeded (not found)
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Front Jack' succeeded (found!)
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Speaker Phantom Jack' succeeded (not found)
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Speaker Front Phantom Jack' succeeded (not found)
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=1, switch=1, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=2, switch=2, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=1, switch=1, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Front' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=1, switch=1, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Surround' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Side' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=1, switch=1, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=1, switch=1, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=1, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=2, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-output-speaker', none of required-any elements preset.
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-headphones'
(   3.332|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Headphone Jack' succeeded (not found)
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Headphone Phantom Jack' succeeded (not found)
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Headphone Jack' succeeded (found!)
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Headphone Phantom Jack' succeeded (not found)
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Phantom Jack' succeeded (not found)
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Mic Jack' succeeded (not found)
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=1, switch=1, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=1, switch=1, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headset' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line HP Swap' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=3, switch=1, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=2, switch=2, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=2, switch=2, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=2, switch=2, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Front' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Surround' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Side' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=1, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=2, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-headphones-2'
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=1, switch=1, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=3, switch=1, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' failed.
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Removing path 'analog-output' as it is a subset of 'analog-output-lineout'.
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xfa9040, direction=1
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output-lineout (Line Out), direction=1, priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=87, min_dB=-181.5, max_dB=0
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff, n_channels=1, override_map=yes
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone, direction=1, switch=2, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=yes
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x60, n_channels=2, override_map=yes
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x4900000000018, n_channels=1, override_map=yes
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x80, n_channels=1, override_map=yes
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM, direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958, direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0, override_map=no
(   3.333|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out, alsa_name='Line Out Jack', detection unavailable
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Phantom, alsa_name='Line Out Phantom Jack', detection unavailable
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Headphone, alsa_name='Headphone Jack', detection unavailable
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Front, alsa_name='Line Out Front Jack', detection possible
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Front Phantom, alsa_name='Line Out Front Phantom Jack', detection unavailable
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out CLFE, alsa_name='Line Out CLFE Jack', detection possible
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out CLFE Phantom, alsa_name='Line Out CLFE Phantom Jack', detection unavailable
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Surround, alsa_name='Line Out Surround Jack', detection possible
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Surround Phantom, alsa_name='Line Out Surround Phantom Jack', detection unavailable
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Side, alsa_name='Line Out Side Jack', detection unavailable
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Side Phantom, alsa_name='Line Out Side Phantom Jack', detection unavailable
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output-headphones (Headphones), direction=1, priority=90, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=87, min_dB=-181.5, max_dB=0
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff, n_channels=1, override_map=yes
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=4, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front, direction=1, switch=1, volume=3, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround, direction=1, switch=2, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center, direction=1, switch=2, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff, n_channels=1, override_map=no
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE, direction=1, switch=2, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff, n_channels=1, override_map=no
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM, direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958, direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0, override_map=no
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Dock Headphone, alsa_name='Dock Headphone Jack', detection unavailable
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Dock Headphone Phantom, alsa_name='Dock Headphone Phantom Jack', detection unavailable
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Front Headphone, alsa_name='Front Headphone Jack', detection possible
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Front Headphone Phantom, alsa_name='Front Headphone Phantom Jack', detection unavailable
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Headphone, alsa_name='Headphone Jack', detection unavailable
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Headphone Phantom, alsa_name='Headphone Phantom Jack', detection unavailable
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Headphone Mic, alsa_name='Headphone Mic Jack', detection unavailable
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:analog-mono - will not be able to open input:analog-mono
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-stereo+input:analog-stereo
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Stereo (analog-stereo)
(   3.334|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.334|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   3.334|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   3.334|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   3.334|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-stereo+input:analog-stereo supported.
(   3.335|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:iec958-stereo - will not be able to open input:iec958-stereo
(   3.335|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-21
(   3.335|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 2.1 (analog-surround-21)
(   3.335|   0.000) D: [pulseaudio] alsa-util.c: Trying surround21:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.335|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround21:0
(   3.335|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 123 ms
(   3.365|   0.029) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-21 supported.
(   3.365|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL surround21:0
(   3.365|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer surround21:0: No such file or directory
(   3.365|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:0'
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Removing path 'analog-output' as it is a subset of 'analog-output-lineout'.
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0x101ec10, direction=1
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output-lineout (Line Out), direction=1, priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=87, min_dB=-181.5, max_dB=0
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff, n_channels=1, override_map=yes
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone, direction=1, switch=2, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=yes
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x60, n_channels=2, override_map=yes
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x4900000000018, n_channels=1, override_map=yes
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x80, n_channels=1, override_map=yes
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM, direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958, direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0, override_map=no
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out, alsa_name='Line Out Jack', detection unavailable
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Phantom, alsa_name='Line Out Phantom Jack', detection unavailable
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Headphone, alsa_name='Headphone Jack', detection unavailable
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Front, alsa_name='Line Out Front Jack', detection possible
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Front Phantom, alsa_name='Line Out Front Phantom Jack', detection unavailable
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out CLFE, alsa_name='Line Out CLFE Jack', detection possible
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out CLFE Phantom, alsa_name='Line Out CLFE Phantom Jack', detection unavailable
(   3.365|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Surround, alsa_name='Line Out Surround Jack', detection possible
(   3.366|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Surround Phantom, alsa_name='Line Out Surround Phantom Jack', detection unavailable
(   3.366|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Side, alsa_name='Line Out Side Jack', detection unavailable
(   3.366|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Side Phantom, alsa_name='Line Out Side Phantom Jack', detection unavailable
(   3.366|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:analog-mono - will not be able to open input:analog-mono
(   3.366|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-21+input:analog-stereo
(   3.366|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Stereo (analog-stereo)
(   3.366|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.366|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   3.366|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   3.366|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   3.366|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-21+input:analog-stereo supported.
(   3.366|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:iec958-stereo - will not be able to open input:iec958-stereo
(   3.366|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-40
(   3.366|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 4.0 (analog-surround-40)
(   3.366|   0.000) D: [pulseaudio] alsa-util.c: Trying surround40:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.367|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround40:0
(   3.367|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 185 ms
(   3.397|   0.029) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-40 supported.
(   3.397|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL surround40:0
(   3.397|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer surround40:0: No such file or directory
(   3.397|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:0'
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Removing path 'analog-output' as it is a subset of 'analog-output-lineout'.
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0x103a5c0, direction=1
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output-lineout (Line Out), direction=1, priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=87, min_dB=-181.5, max_dB=0
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff, n_channels=1, override_map=yes
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone, direction=1, switch=2, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=yes
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x60, n_channels=2, override_map=yes
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x4900000000018, n_channels=1, override_map=yes
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x80, n_channels=1, override_map=yes
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM, direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958, direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0, override_map=no
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out, alsa_name='Line Out Jack', detection unavailable
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Phantom, alsa_name='Line Out Phantom Jack', detection unavailable
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Headphone, alsa_name='Headphone Jack', detection unavailable
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Front, alsa_name='Line Out Front Jack', detection possible
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Front Phantom, alsa_name='Line Out Front Phantom Jack', detection unavailable
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out CLFE, alsa_name='Line Out CLFE Jack', detection possible
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out CLFE Phantom, alsa_name='Line Out CLFE Phantom Jack', detection unavailable
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Surround, alsa_name='Line Out Surround Jack', detection possible
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Surround Phantom, alsa_name='Line Out Surround Phantom Jack', detection unavailable
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Side, alsa_name='Line Out Side Jack', detection unavailable
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Side Phantom, alsa_name='Line Out Side Phantom Jack', detection unavailable
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:analog-mono - will not be able to open input:analog-mono
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-40+input:analog-stereo
(   3.397|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Stereo (analog-stereo)
(   3.398|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.398|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   3.398|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   3.398|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   3.398|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-40+input:analog-stereo supported.
(   3.398|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:iec958-stereo - will not be able to open input:iec958-stereo
(   3.398|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-41
(   3.398|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 4.1 (analog-surround-41)
(   3.398|   0.000) D: [pulseaudio] alsa-util.c: Trying surround41:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.398|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround41:0
(   3.399|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 123 ms
(   3.429|   0.029) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-41 supported.
(   3.429|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL surround41:0
(   3.429|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer surround41:0: No such file or directory
(   3.429|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:0'
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Removing path 'analog-output' as it is a subset of 'analog-output-lineout'.
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0x10386f0, direction=1
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output-lineout (Line Out), direction=1, priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=87, min_dB=-181.5, max_dB=0
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff, n_channels=1, override_map=yes
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone, direction=1, switch=2, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=yes
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x60, n_channels=2, override_map=yes
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x4900000000018, n_channels=1, override_map=yes
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x80, n_channels=1, override_map=yes
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM, direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958, direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0, override_map=no
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out, alsa_name='Line Out Jack', detection unavailable
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Phantom, alsa_name='Line Out Phantom Jack', detection unavailable
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Headphone, alsa_name='Headphone Jack', detection unavailable
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Front, alsa_name='Line Out Front Jack', detection possible
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Front Phantom, alsa_name='Line Out Front Phantom Jack', detection unavailable
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out CLFE, alsa_name='Line Out CLFE Jack', detection possible
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out CLFE Phantom, alsa_name='Line Out CLFE Phantom Jack', detection unavailable
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Surround, alsa_name='Line Out Surround Jack', detection possible
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Surround Phantom, alsa_name='Line Out Surround Phantom Jack', detection unavailable
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Side, alsa_name='Line Out Side Jack', detection unavailable
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Side Phantom, alsa_name='Line Out Side Phantom Jack', detection unavailable
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:analog-mono - will not be able to open input:analog-mono
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-41+input:analog-stereo
(   3.429|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Stereo (analog-stereo)
(   3.429|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.430|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   3.430|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   3.430|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   3.430|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-41+input:analog-stereo supported.
(   3.430|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:iec958-stereo - will not be able to open input:iec958-stereo
(   3.430|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-50
(   3.430|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 5.0 (analog-surround-50)
(   3.430|   0.000) D: [pulseaudio] alsa-util.c: Trying surround50:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.430|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround50:0
(   3.431|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 123 ms
(   3.431|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-50 supported.
(   3.431|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL surround50:0
(   3.431|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer surround50:0: No such file or directory
(   3.431|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:0'
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Removing path 'analog-output' as it is a subset of 'analog-output-lineout'.
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xfb0ae0, direction=1
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output-lineout (Line Out), direction=1, priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=87, min_dB=-181.5, max_dB=0
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff, n_channels=1, override_map=yes
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone, direction=1, switch=2, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=yes
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x60, n_channels=2, override_map=yes
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x4900000000018, n_channels=1, override_map=yes
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x80, n_channels=1, override_map=yes
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM, direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958, direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0, override_map=no
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out, alsa_name='Line Out Jack', detection unavailable
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Phantom, alsa_name='Line Out Phantom Jack', detection unavailable
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Headphone, alsa_name='Headphone Jack', detection unavailable
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Front, alsa_name='Line Out Front Jack', detection possible
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Front Phantom, alsa_name='Line Out Front Phantom Jack', detection unavailable
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out CLFE, alsa_name='Line Out CLFE Jack', detection possible
(   3.431|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out CLFE Phantom, alsa_name='Line Out CLFE Phantom Jack', detection unavailable
(   3.432|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Surround, alsa_name='Line Out Surround Jack', detection possible
(   3.432|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Surround Phantom, alsa_name='Line Out Surround Phantom Jack', detection unavailable
(   3.432|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Side, alsa_name='Line Out Side Jack', detection unavailable
(   3.432|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Side Phantom, alsa_name='Line Out Side Phantom Jack', detection unavailable
(   3.432|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:analog-mono - will not be able to open input:analog-mono
(   3.432|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-50+input:analog-stereo
(   3.432|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Stereo (analog-stereo)
(   3.432|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.432|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   3.432|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   3.432|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   3.432|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-50+input:analog-stereo supported.
(   3.432|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:iec958-stereo - will not be able to open input:iec958-stereo
(   3.432|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-51
(   3.432|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 5.1 (analog-surround-51)
(   3.432|   0.000) D: [pulseaudio] alsa-util.c: Trying surround51:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.432|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround51:0
(   3.433|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 123 ms
(   3.433|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-51 supported.
(   3.433|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL surround51:0
(   3.433|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer surround51:0: No such file or directory
(   3.433|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:0'
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Removing path 'analog-output' as it is a subset of 'analog-output-lineout'.
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xfa52a0, direction=1
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output-lineout (Line Out), direction=1, priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=87, min_dB=-181.5, max_dB=0
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff, n_channels=1, override_map=yes
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone, direction=1, switch=2, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=yes
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x60, n_channels=2, override_map=yes
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x4900000000018, n_channels=1, override_map=yes
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE, direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x80, n_channels=1, override_map=yes
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM, direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958, direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0, override_map=no
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out, alsa_name='Line Out Jack', detection unavailable
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Phantom, alsa_name='Line Out Phantom Jack', detection unavailable
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Headphone, alsa_name='Headphone Jack', detection unavailable
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Front, alsa_name='Line Out Front Jack', detection possible
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Front Phantom, alsa_name='Line Out Front Phantom Jack', detection unavailable
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out CLFE, alsa_name='Line Out CLFE Jack', detection possible
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out CLFE Phantom, alsa_name='Line Out CLFE Phantom Jack', detection unavailable
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Surround, alsa_name='Line Out Surround Jack', detection possible
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Surround Phantom, alsa_name='Line Out Surround Phantom Jack', detection unavailable
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Side, alsa_name='Line Out Side Jack', detection unavailable
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line Out Side Phantom, alsa_name='Line Out Side Phantom Jack', detection unavailable
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:analog-mono - will not be able to open input:analog-mono
(   3.433|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-51+input:analog-stereo
(   3.434|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Stereo (analog-stereo)
(   3.434|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.434|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   3.434|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   3.434|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   3.434|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-51+input:analog-stereo supported.
(   3.434|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:iec958-stereo - will not be able to open input:iec958-stereo
(   3.434|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-71
(   3.434|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 7.1 (analog-surround-71)
(   3.434|   0.000) D: [pulseaudio] alsa-util.c: Trying surround71:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.434|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround71:0
(   3.435|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(8) failed: Invalid argument
(   3.435|   0.000) D: [pulseaudio] alsa-util.c: Trying surround71:0 without SND_PCM_NO_AUTO_FORMAT ...
(   3.435|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround71:0
(   3.435|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(8) failed: Invalid argument
(   3.435|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround71:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.436|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround71:0
(   3.436|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(8) failed: Invalid argument
(   3.436|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround71:0 without SND_PCM_NO_AUTO_FORMAT ...
(   3.436|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround71:0
(   3.436|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(8) failed: Invalid argument
(   3.436|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround71:0: Invalid argument
(   3.436|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-71
(   3.436|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:analog-mono - will not be able to open output:analog-surround-71
(   3.436|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:analog-stereo - will not be able to open output:analog-surround-71
(   3.436|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:iec958-stereo - will not be able to open output:analog-surround-71
(   3.436|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-stereo
(   3.436|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (IEC958) (iec958-stereo)
(   3.436|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.437|   0.000) D: [pulseaudio] alsa-util.c: Managed to open iec958:0
(   3.437|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   3.453|   0.015) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   3.453|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:iec958-stereo supported.
(   3.453|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/iec958-stereo-output.conf'
(   3.453|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL iec958:0
(   3.453|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer iec958:0: No such file or directory
(   3.453|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:0'
(   3.453|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'iec958-stereo-output'
(   3.453|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=1, enumeration=0).
(   3.453|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   3.453|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0x103b2f0, direction=1
(   3.453|   0.000) D: [pulseaudio] alsa-mixer.c: Path iec958-stereo-output (Digital Output (S/PDIF)), direction=1, priority=0, probed=yes, supported=yes, has_mute=yes, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   3.453|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958, direction=1, switch=1, volume=0, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0, override_map=no
(   3.454|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:analog-mono - will not be able to open input:analog-mono
(   3.454|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-stereo+input:analog-stereo
(   3.454|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Stereo (analog-stereo)
(   3.454|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.454|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   3.454|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   3.454|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   3.454|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:iec958-stereo+input:analog-stereo supported.
(   3.454|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:iec958-stereo - will not be able to open input:iec958-stereo
(   3.454|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-ac3-surround-40
(   3.454|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 4.0 (IEC958/AC3) (iec958-ac3-surround-40)
(   3.454|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.454|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:0
(   3.454|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device a52:0: No such file or directory
(   3.454|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-ac3-surround-40
(   3.454|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:analog-mono - will not be able to open output:iec958-ac3-surround-40
(   3.454|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:analog-stereo - will not be able to open output:iec958-ac3-surround-40
(   3.454|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:iec958-stereo - will not be able to open output:iec958-ac3-surround-40
(   3.454|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-ac3-surround-51
(   3.454|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (IEC958/AC3) (iec958-ac3-surround-51)
(   3.454|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.454|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:0
(   3.454|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device a52:0: No such file or directory
(   3.454|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-ac3-surround-51
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:analog-mono - will not be able to open output:iec958-ac3-surround-51
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:analog-stereo - will not be able to open output:iec958-ac3-surround-51
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:iec958-stereo - will not be able to open output:iec958-ac3-surround-51
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-dts-surround-51
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (IEC958/DTS) (iec958-dts-surround-51)
(   3.455|   0.000) D: [pulseaudio] alsa-util.c: Trying dca:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.455|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dca:0
(   3.455|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dca:0: No such file or directory
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-dts-surround-51
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:analog-mono - will not be able to open output:iec958-dts-surround-51
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:analog-stereo - will not be able to open output:iec958-dts-surround-51
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:iec958-stereo - will not be able to open output:iec958-dts-surround-51
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI) (hdmi-stereo)
(   3.455|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.455|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D3p' failed (-2)
(   3.455|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0: No such file or directory
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:analog-mono - will not be able to open output:hdmi-stereo
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:analog-stereo - will not be able to open output:hdmi-stereo
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:iec958-stereo - will not be able to open output:hdmi-stereo
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround
(   3.455|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI) (hdmi-surround)
(   3.455|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.456|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D3p' failed (-2)
(   3.456|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0: No such file or directory
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:analog-mono - will not be able to open output:hdmi-surround
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:analog-stereo - will not be able to open output:hdmi-surround
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:iec958-stereo - will not be able to open output:hdmi-surround
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI) (hdmi-surround71)
(   3.456|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.456|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D3p' failed (-2)
(   3.456|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0: No such file or directory
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:analog-mono - will not be able to open output:hdmi-surround71
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:analog-stereo - will not be able to open output:hdmi-surround71
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:iec958-stereo - will not be able to open output:hdmi-surround71
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI/DTS) (hdmi-dts-surround)
(   3.456|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.456|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:0
(   3.456|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:0: No such file or directory
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:analog-mono - will not be able to open output:hdmi-dts-surround
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:analog-stereo - will not be able to open output:hdmi-dts-surround
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:iec958-stereo - will not be able to open output:hdmi-dts-surround
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra1
(   3.456|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 2) (hdmi-stereo-extra1)
(   3.456|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,1 with SND_PCM_NO_AUTO_FORMAT ...
(   3.457|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D7p' failed (-2)
(   3.457|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,1: No such file or directory
(   3.457|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra1
(   3.457|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:analog-mono - will not be able to open output:hdmi-stereo-extra1
(   3.457|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:analog-stereo - will not be able to open output:hdmi-stereo-extra1
(   3.457|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra1
(   3.457|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra1
(   3.457|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 2) (hdmi-surround-extra1)
(   3.457|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,1 with SND_PCM_NO_AUTO_FORMAT ...
(   3.457|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D7p' failed (-2)
(   3.457|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,1: No such file or directory
(   3.457|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra1
(   3.457|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:analog-mono - will not be able to open output:hdmi-surround-extra1
(   3.457|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:analog-stereo - will not be able to open output:hdmi-surround-extra1
(   3.457|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:iec958-stereo - will not be able to open output:hdmi-surround-extra1
(   3.457|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra1
(   3.457|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 2) (hdmi-surround71-extra1)
(   3.457|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,1 with SND_PCM_NO_AUTO_FORMAT ...
(   3.458|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D7p' failed (-2)
(   3.458|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,1: No such file or directory
(   3.458|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra1
(   3.458|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:analog-mono - will not be able to open output:hdmi-surround71-extra1
(   3.458|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:analog-stereo - will not be able to open output:hdmi-surround71-extra1
(   3.458|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra1
(   3.458|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra1
(   3.458|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 2/DTS) (hdmi-dts-surround-extra1)
(   3.458|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:0,1 with SND_PCM_NO_AUTO_FORMAT ...
(   3.458|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:0,1
(   3.458|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:0,1: No such file or directory
(   3.458|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra1
(   3.458|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra1
(   3.458|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra1
(   3.458|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra1
(   3.458|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra2
(   3.458|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 3) (hdmi-stereo-extra2)
(   3.458|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,2 with SND_PCM_NO_AUTO_FORMAT ...
(   3.458|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D8p' failed (-2)
(   3.458|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,2: No such file or directory
(   3.458|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra2
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:analog-mono - will not be able to open output:hdmi-stereo-extra2
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:analog-stereo - will not be able to open output:hdmi-stereo-extra2
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra2
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra2
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 3) (hdmi-surround-extra2)
(   3.459|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,2 with SND_PCM_NO_AUTO_FORMAT ...
(   3.459|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D8p' failed (-2)
(   3.459|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,2: No such file or directory
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra2
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:analog-mono - will not be able to open output:hdmi-surround-extra2
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:analog-stereo - will not be able to open output:hdmi-surround-extra2
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:iec958-stereo - will not be able to open output:hdmi-surround-extra2
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra2
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 3) (hdmi-surround71-extra2)
(   3.459|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,2 with SND_PCM_NO_AUTO_FORMAT ...
(   3.459|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D8p' failed (-2)
(   3.459|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,2: No such file or directory
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra2
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:analog-mono - will not be able to open output:hdmi-surround71-extra2
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:analog-stereo - will not be able to open output:hdmi-surround71-extra2
(   3.459|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra2
(   3.460|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra2
(   3.460|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 3/DTS) (hdmi-dts-surround-extra2)
(   3.460|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:0,2 with SND_PCM_NO_AUTO_FORMAT ...
(   3.460|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:0,2
(   3.460|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:0,2: No such file or directory
(   3.460|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra2
(   3.460|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra2
(   3.460|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra2
(   3.460|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra2
(   3.460|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra3
(   3.460|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 4) (hdmi-stereo-extra3)
(   3.460|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,3 with SND_PCM_NO_AUTO_FORMAT ...
(   3.460|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D9p' failed (-2)
(   3.460|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,3: No such file or directory
(   3.460|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra3
(   3.460|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:analog-mono - will not be able to open output:hdmi-stereo-extra3
(   3.460|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:analog-stereo - will not be able to open output:hdmi-stereo-extra3
(   3.460|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra3
(   3.460|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra3
(   3.460|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 4) (hdmi-surround-extra3)
(   3.460|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,3 with SND_PCM_NO_AUTO_FORMAT ...
(   3.461|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D9p' failed (-2)
(   3.461|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,3: No such file or directory
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra3
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:analog-mono - will not be able to open output:hdmi-surround-extra3
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:analog-stereo - will not be able to open output:hdmi-surround-extra3
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:iec958-stereo - will not be able to open output:hdmi-surround-extra3
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra3
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 4) (hdmi-surround71-extra3)
(   3.461|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,3 with SND_PCM_NO_AUTO_FORMAT ...
(   3.461|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D9p' failed (-2)
(   3.461|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,3: No such file or directory
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra3
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:analog-mono - will not be able to open output:hdmi-surround71-extra3
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:analog-stereo - will not be able to open output:hdmi-surround71-extra3
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra3
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra3
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 4/DTS) (hdmi-dts-surround-extra3)
(   3.461|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:0,3 with SND_PCM_NO_AUTO_FORMAT ...
(   3.461|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:0,3
(   3.461|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:0,3: No such file or directory
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra3
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra3
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra3
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra3
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra4
(   3.461|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 5) (hdmi-stereo-extra4)
(   3.461|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,4 with SND_PCM_NO_AUTO_FORMAT ...
(   3.462|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D10p' failed (-2)
(   3.462|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,4: No such file or directory
(   3.462|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra4
(   3.462|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:analog-mono - will not be able to open output:hdmi-stereo-extra4
(   3.462|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:analog-stereo - will not be able to open output:hdmi-stereo-extra4
(   3.462|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra4
(   3.462|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra4
(   3.462|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 5) (hdmi-surround-extra4)
(   3.462|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,4 with SND_PCM_NO_AUTO_FORMAT ...
(   3.462|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D10p' failed (-2)
(   3.462|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,4: No such file or directory
(   3.462|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra4
(   3.462|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:analog-mono - will not be able to open output:hdmi-surround-extra4
(   3.462|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:analog-stereo - will not be able to open output:hdmi-surround-extra4
(   3.462|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:iec958-stereo - will not be able to open output:hdmi-surround-extra4
(   3.462|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra4
(   3.462|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 5) (hdmi-surround71-extra4)
(   3.462|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,4 with SND_PCM_NO_AUTO_FORMAT ...
(   3.463|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D10p' failed (-2)
(   3.463|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,4: No such file or directory
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra4
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:analog-mono - will not be able to open output:hdmi-surround71-extra4
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:analog-stereo - will not be able to open output:hdmi-surround71-extra4
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra4
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra4
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 5/DTS) (hdmi-dts-surround-extra4)
(   3.463|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:0,4 with SND_PCM_NO_AUTO_FORMAT ...
(   3.463|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:0,4
(   3.463|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:0,4: No such file or directory
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra4
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra4
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra4
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra4
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra5
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 6) (hdmi-stereo-extra5)
(   3.463|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,5 with SND_PCM_NO_AUTO_FORMAT ...
(   3.463|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D11p' failed (-2)
(   3.463|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,5: No such file or directory
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra5
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:analog-mono - will not be able to open output:hdmi-stereo-extra5
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:analog-stereo - will not be able to open output:hdmi-stereo-extra5
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra5
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra5
(   3.463|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 6) (hdmi-surround-extra5)
(   3.463|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,5 with SND_PCM_NO_AUTO_FORMAT ...
(   3.464|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D11p' failed (-2)
(   3.464|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,5: No such file or directory
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra5
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:analog-mono - will not be able to open output:hdmi-surround-extra5
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:analog-stereo - will not be able to open output:hdmi-surround-extra5
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:iec958-stereo - will not be able to open output:hdmi-surround-extra5
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra5
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 6) (hdmi-surround71-extra5)
(   3.464|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,5 with SND_PCM_NO_AUTO_FORMAT ...
(   3.464|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D11p' failed (-2)
(   3.464|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,5: No such file or directory
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra5
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:analog-mono - will not be able to open output:hdmi-surround71-extra5
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:analog-stereo - will not be able to open output:hdmi-surround71-extra5
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra5
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra5
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 6/DTS) (hdmi-dts-surround-extra5)
(   3.464|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:0,5 with SND_PCM_NO_AUTO_FORMAT ...
(   3.464|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:0,5
(   3.464|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:0,5: No such file or directory
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra5
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra5
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra5
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra5
(   3.464|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra6
(   3.465|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 7) (hdmi-stereo-extra6)
(   3.465|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,6 with SND_PCM_NO_AUTO_FORMAT ...
(   3.465|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D12p' failed (-2)
(   3.465|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,6: No such file or directory
(   3.465|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra6
(   3.465|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:analog-mono - will not be able to open output:hdmi-stereo-extra6
(   3.465|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:analog-stereo - will not be able to open output:hdmi-stereo-extra6
(   3.465|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra6
(   3.465|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra6
(   3.465|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 7) (hdmi-surround-extra6)
(   3.465|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,6 with SND_PCM_NO_AUTO_FORMAT ...
(   3.465|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D12p' failed (-2)
(   3.465|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,6: No such file or directory
(   3.465|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra6
(   3.465|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:analog-mono - will not be able to open output:hdmi-surround-extra6
(   3.465|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:analog-stereo - will not be able to open output:hdmi-surround-extra6
(   3.465|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:iec958-stereo - will not be able to open output:hdmi-surround-extra6
(   3.465|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra6
(   3.465|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 7) (hdmi-surround71-extra6)
(   3.465|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,6 with SND_PCM_NO_AUTO_FORMAT ...
(   3.466|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D12p' failed (-2)
(   3.466|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,6: No such file or directory
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra6
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:analog-mono - will not be able to open output:hdmi-surround71-extra6
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:analog-stereo - will not be able to open output:hdmi-surround71-extra6
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra6
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra6
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 7/DTS) (hdmi-dts-surround-extra6)
(   3.466|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:0,6 with SND_PCM_NO_AUTO_FORMAT ...
(   3.466|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:0,6
(   3.466|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:0,6: No such file or directory
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra6
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra6
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra6
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra6
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra7
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 8) (hdmi-stereo-extra7)
(   3.466|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,7 with SND_PCM_NO_AUTO_FORMAT ...
(   3.466|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D13p' failed (-2)
(   3.466|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,7: No such file or directory
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra7
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:analog-mono - will not be able to open output:hdmi-stereo-extra7
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:analog-stereo - will not be able to open output:hdmi-stereo-extra7
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra7
(   3.466|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra7
(   3.467|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 8) (hdmi-surround-extra7)
(   3.467|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,7 with SND_PCM_NO_AUTO_FORMAT ...
(   3.467|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D13p' failed (-2)
(   3.467|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,7: No such file or directory
(   3.467|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra7
(   3.467|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:analog-mono - will not be able to open output:hdmi-surround-extra7
(   3.467|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:analog-stereo - will not be able to open output:hdmi-surround-extra7
(   3.467|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:iec958-stereo - will not be able to open output:hdmi-surround-extra7
(   3.467|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra7
(   3.467|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 8) (hdmi-surround71-extra7)
(   3.467|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,7 with SND_PCM_NO_AUTO_FORMAT ...
(   3.467|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC0D13p' failed (-2)
(   3.467|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:0,7: No such file or directory
(   3.467|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra7
(   3.467|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:analog-mono - will not be able to open output:hdmi-surround71-extra7
(   3.467|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:analog-stereo - will not be able to open output:hdmi-surround71-extra7
(   3.467|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra7
(   3.467|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra7
(   3.467|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 8/DTS) (hdmi-dts-surround-extra7)
(   3.467|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:0,7 with SND_PCM_NO_AUTO_FORMAT ...
(   3.467|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:0,7
(   3.467|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:0,7: No such file or directory
(   3.467|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra7
(   3.468|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra7
(   3.468|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra7
(   3.468|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra7
(   3.468|   0.000) D: [pulseaudio] alsa-mixer.c: Profile set 0xe74490, auto_profiles=yes, probed=yes, n_mappings=7, n_profiles=15, n_decibel_fixes=0
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping analog-stereo (Analog Stereo), priority=60, channel_map=front-left,front-right, supported=yes, direction=0
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping analog-surround-21 (Analog Surround 2.1), priority=8, channel_map=front-left,front-right,lfe, supported=yes, direction=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping analog-surround-40 (Analog Surround 4.0), priority=7, channel_map=front-left,front-right,rear-left,rear-right, supported=yes, direction=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping analog-surround-41 (Analog Surround 4.1), priority=8, channel_map=front-left,front-right,rear-left,rear-right,lfe, supported=yes, direction=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping analog-surround-50 (Analog Surround 5.0), priority=7, channel_map=front-left,front-right,rear-left,rear-right,front-center, supported=yes, direction=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping analog-surround-51 (Analog Surround 5.1), priority=8, channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe, supported=yes, direction=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping iec958-stereo (Digital Stereo (IEC958)), priority=55, channel_map=front-left,front-right, supported=yes, direction=0
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile input:analog-stereo (Analog Stereo Input), priority=60, supported=yes n_input_mappings=1, n_output_mappings=0
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-stereo (Analog Stereo Output), priority=6000, supported=yes n_input_mappings=0, n_output_mappings=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-stereo
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-stereo+input:analog-stereo (Analog Stereo Duplex), priority=6060, supported=yes n_input_mappings=1, n_output_mappings=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-stereo
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-21 (Analog Surround 2.1 Output), priority=800, supported=yes n_input_mappings=0, n_output_mappings=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-21
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-21+input:analog-stereo (Analog Surround 2.1 Output + Analog Stereo Input), priority=860, supported=yes n_input_mappings=1, n_output_mappings=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-21
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-40 (Analog Surround 4.0 Output), priority=700, supported=yes n_input_mappings=0, n_output_mappings=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-40
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-40+input:analog-stereo (Analog Surround 4.0 Output + Analog Stereo Input), priority=760, supported=yes n_input_mappings=1, n_output_mappings=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-40
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-41 (Analog Surround 4.1 Output), priority=800, supported=yes n_input_mappings=0, n_output_mappings=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-41
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-41+input:analog-stereo (Analog Surround 4.1 Output + Analog Stereo Input), priority=860, supported=yes n_input_mappings=1, n_output_mappings=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-41
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-50 (Analog Surround 5.0 Output), priority=700, supported=yes n_input_mappings=0, n_output_mappings=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-50
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-50+input:analog-stereo (Analog Surround 5.0 Output + Analog Stereo Input), priority=760, supported=yes n_input_mappings=1, n_output_mappings=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-50
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-51 (Analog Surround 5.1 Output), priority=800, supported=yes n_input_mappings=0, n_output_mappings=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-51
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-surround-51+input:analog-stereo (Analog Surround 5.1 Output + Analog Stereo Input), priority=860, supported=yes n_input_mappings=1, n_output_mappings=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-51
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:iec958-stereo (Digital Stereo (IEC958) Output), priority=5500, supported=yes n_input_mappings=0, n_output_mappings=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Output iec958-stereo
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:iec958-stereo+input:analog-stereo (Digital Stereo (IEC958) Output + Analog Stereo Input), priority=5560, supported=yes n_input_mappings=1, n_output_mappings=1
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   3.469|   0.000) D: [pulseaudio] alsa-mixer.c: Output iec958-stereo
(   3.470|   0.000) I: [pulseaudio] module-card-restore.c: Restored profile 'output:iec958-stereo+input:analog-stereo' for card alsa_card.pci-0000_00_1b.0.
(   3.470|   0.000) I: [pulseaudio] module-card-restore.c: Restoring port latency offsets for card alsa_card.pci-0000_00_1b.0.
(   3.470|   0.000) I: [pulseaudio] card.c: Created 4 "alsa_card.pci-0000_00_1b.0"
(   3.470|   0.000) D: [pulseaudio] module-alsa-card.c: Found 7 jacks.
(   3.470|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:0'
(   3.470|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'Line Out Front Jack' is now unplugged
(   3.470|   0.000) D: [pulseaudio] device-port.c: Setting port analog-output-lineout to status no
(   3.470|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   3.470|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'Line Out CLFE Jack' is now unplugged
(   3.470|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'Line Out Surround Jack' is now unplugged
(   3.470|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'Front Headphone Jack' is now unplugged
(   3.470|   0.000) D: [pulseaudio] device-port.c: Setting port analog-output-headphones to status no
(   3.470|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   3.470|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'Front Mic Jack' is now unplugged
(   3.470|   0.000) D: [pulseaudio] device-port.c: Setting port analog-input-front-mic to status no
(   3.470|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   3.470|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'Rear Mic Jack' is now unplugged
(   3.470|   0.000) D: [pulseaudio] device-port.c: Setting port analog-input-rear-mic to status no
(   3.470|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   3.470|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'Line Jack' is now unplugged
(   3.470|   0.000) D: [pulseaudio] device-port.c: Setting port analog-input-linein to status no
(   3.470|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   3.471|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully create reservation lock monitor for device 'Audio0'
(   3.471|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.472|   0.000) D: [pulseaudio] alsa-util.c: Managed to open iec958:0
(   3.472|   0.000) I: [pulseaudio] alsa-util.c: Trying to disable ALSA period wakeups, using timers only
(   3.472|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   3.472|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 88200 samples), period size second (to 88200 samples).
(   3.472|   0.000) I: [pulseaudio] alsa-util.c: ALSA period wakeups disabled
(   3.472|   0.000) I: [pulseaudio] alsa-sink.c: Successfully opened device iec958:0.
(   3.472|   0.000) I: [pulseaudio] alsa-sink.c: Selected mapping 'Digital Stereo (IEC958)' (iec958-stereo).
(   3.472|   0.000) I: [pulseaudio] alsa-sink.c: Successfully enabled mmap() mode.
(   3.472|   0.000) I: [pulseaudio] alsa-sink.c: Successfully enabled timer-based scheduling mode.
(   3.472|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL iec958:0
(   3.472|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer iec958:0: No such file or directory
(   3.472|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:0'
(   3.473|   0.000) D: [pulseaudio] alsa-mixer.c: Added 1 ports
(   3.473|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   3.473|   0.000) I: [pulseaudio] module-device-restore.c: Restoring volume for sink alsa_output.pci-0000_00_1b.0.iec958-stereo: front-left: 65536 / 100%,   front-right: 65536 / 100%
(   3.473|   0.000) I: [pulseaudio] sink.c: Created sink 3 "alsa_output.pci-0000_00_1b.0.iec958-stereo" with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
(   3.473|   0.000) I: [pulseaudio] sink.c:     alsa.resolution_bits = "16"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.api = "alsa"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.class = "sound"
(   3.473|   0.000) I: [pulseaudio] sink.c:     alsa.class = "generic"
(   3.473|   0.000) I: [pulseaudio] sink.c:     alsa.subclass = "generic-mix"
(   3.473|   0.000) I: [pulseaudio] sink.c:     alsa.name = "ALC1150 Digital"
(   3.473|   0.000) I: [pulseaudio] sink.c:     alsa.id = "ALC1150 Digital"
(   3.473|   0.000) I: [pulseaudio] sink.c:     alsa.subdevice = "0"
(   3.473|   0.000) I: [pulseaudio] sink.c:     alsa.subdevice_name = "subdevice #0"
(   3.473|   0.000) I: [pulseaudio] sink.c:     alsa.device = "1"
(   3.473|   0.000) I: [pulseaudio] sink.c:     alsa.card = "0"
(   3.473|   0.000) I: [pulseaudio] sink.c:     alsa.card_name = "HDA Intel PCH"
(   3.473|   0.000) I: [pulseaudio] sink.c:     alsa.long_card_name = "HDA Intel PCH at 0xfb130000 irq 34"
(   3.473|   0.000) I: [pulseaudio] sink.c:     alsa.driver_name = "snd_hda_intel"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.bus_path = "pci-0000:00:1b.0"
(   3.473|   0.000) I: [pulseaudio] sink.c:     sysfs.path = "/devices/pci0000:00/0000:00:1b.0/sound/card0"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.bus = "pci"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.vendor.id = "8086"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.vendor.name = "Intel Corporation"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.product.id = "8d20"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.product.name = "C610/X99 series chipset HD Audio Controller"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.form_factor = "internal"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.string = "iec958:0"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.buffering.buffer_size = "65536"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.buffering.fragment_size = "32768"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.access_mode = "mmap+timer"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.profile.name = "iec958-stereo"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.profile.description = "Digital Stereo (IEC958)"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.description = "Built-in Audio Digital Stereo (IEC958)"
(   3.473|   0.000) I: [pulseaudio] sink.c:     alsa.mixer_name = "Realtek ALC1150"
(   3.473|   0.000) I: [pulseaudio] sink.c:     alsa.components = "HDA:10ec0900,1458a182,00100001"
(   3.473|   0.000) I: [pulseaudio] sink.c:     module-udev-detect.discovered = "1"
(   3.473|   0.000) I: [pulseaudio] sink.c:     device.icon_name = "audio-card-pci"
(   3.473|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   3.473|   0.000) I: [pulseaudio] source.c: Created source 5 "alsa_output.pci-0000_00_1b.0.iec958-stereo.monitor" with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
(   3.473|   0.000) I: [pulseaudio] source.c:     device.description = "Monitor of Built-in Audio Digital Stereo (IEC958)"
(   3.473|   0.000) I: [pulseaudio] source.c:     device.class = "monitor"
(   3.473|   0.000) I: [pulseaudio] source.c:     alsa.card = "0"
(   3.473|   0.000) I: [pulseaudio] source.c:     alsa.card_name = "HDA Intel PCH"
(   3.473|   0.000) I: [pulseaudio] source.c:     alsa.long_card_name = "HDA Intel PCH at 0xfb130000 irq 34"
(   3.473|   0.000) I: [pulseaudio] source.c:     alsa.driver_name = "snd_hda_intel"
(   3.473|   0.000) I: [pulseaudio] source.c:     device.bus_path = "pci-0000:00:1b.0"
(   3.473|   0.000) I: [pulseaudio] source.c:     sysfs.path = "/devices/pci0000:00/0000:00:1b.0/sound/card0"
(   3.473|   0.000) I: [pulseaudio] source.c:     device.bus = "pci"
(   3.473|   0.000) I: [pulseaudio] source.c:     device.vendor.id = "8086"
(   3.473|   0.000) I: [pulseaudio] source.c:     device.vendor.name = "Intel Corporation"
(   3.473|   0.000) I: [pulseaudio] source.c:     device.product.id = "8d20"
(   3.473|   0.000) I: [pulseaudio] source.c:     device.product.name = "C610/X99 series chipset HD Audio Controller"
(   3.473|   0.000) I: [pulseaudio] source.c:     device.form_factor = "internal"
(   3.473|   0.000) I: [pulseaudio] source.c:     device.string = "0"
(   3.473|   0.000) I: [pulseaudio] source.c:     module-udev-detect.discovered = "1"
(   3.473|   0.000) I: [pulseaudio] source.c:     device.icon_name = "audio-card-pci"
(   3.473|   0.000) I: [pulseaudio] alsa-sink.c: Using 2.0 fragments of size 32768 bytes (185.76ms), buffer size is 65536 bytes (371.52ms)
(   3.474|   0.000) I: [pulseaudio] alsa-sink.c: Time scheduling watermark is 20.00ms
(   3.474|   0.000) D: [pulseaudio] alsa-sink.c: hwbuf_unused=0
(   3.474|   0.000) D: [pulseaudio] alsa-sink.c: setting avail_min=15502
(   3.474|   0.000) D: [pulseaudio] alsa-mixer.c: Activating path iec958-stereo-output
(   3.474|   0.000) D: [pulseaudio] alsa-mixer.c: Path iec958-stereo-output (Digital Output (S/PDIF)), direction=1, priority=0, probed=yes, supported=yes, has_mute=yes, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   3.474|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958, direction=1, switch=1, volume=0, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0, override_map=no
(   3.474|   0.000) I: [pulseaudio] alsa-sink.c: Driver does not support hardware volume control, falling back to software volume control.
(   3.474|   0.000) I: [pulseaudio] alsa-sink.c: Using hardware mute control.
(   3.474|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_dump():
(   3.474|   0.000) D: [pulseaudio] alsa-util.c: Hooks PCM
(   3.474|   0.000) D: [pulseaudio] alsa-util.c: Its setup is:
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   stream       : PLAYBACK
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   access       : MMAP_INTERLEAVED
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   format       : S16_LE
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   subformat    : STD
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   channels     : 2
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   rate         : 44100
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   exact rate   : 44100 (44100/1)
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   msbits       : 16
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   buffer_size  : 16384
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   period_size  : 8192
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   period_time  : 185759
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_type  : MONOTONIC
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   period_step  : 1
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   avail_min    : 15502
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   period_event : 0
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   start_threshold  : -1
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   stop_threshold   : 4611686018427387904
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   silence_threshold: 0
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   silence_size : 0
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   boundary     : 4611686018427387904
(   3.474|   0.000) D: [pulseaudio] alsa-util.c: Slave: Hardware PCM card 0 'HDA Intel PCH' device 1 subdevice 0
(   3.474|   0.000) D: [pulseaudio] alsa-util.c: Its setup is:
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   stream       : PLAYBACK
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   access       : MMAP_INTERLEAVED
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   format       : S16_LE
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   subformat    : STD
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   channels     : 2
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   rate         : 44100
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   exact rate   : 44100 (44100/1)
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   msbits       : 16
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   buffer_size  : 16384
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   period_size  : 8192
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   period_time  : 185759
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_type  : MONOTONIC
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   period_step  : 1
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   avail_min    : 15502
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   period_event : 0
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   start_threshold  : -1
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   stop_threshold   : 4611686018427387904
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   silence_threshold: 0
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   silence_size : 0
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   boundary     : 4611686018427387904
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   appl_ptr     : 0
(   3.474|   0.000) D: [pulseaudio] alsa-util.c:   hw_ptr       : 0
(   3.474|   0.000) D: [alsa-sink-ALC1150 Digital] alsa-sink.c: Thread starting up
(   3.479|   0.005) D: [alsa-sink-ALC1150 Digital] core-util.c: RealtimeKit worked.
(   3.479|   0.000) I: [alsa-sink-ALC1150 Digital] core-util.c: Successfully enabled SCHED_RR scheduling for thread, with priority 5.
(   3.480|   0.000) I: [alsa-sink-ALC1150 Digital] alsa-sink.c: Starting playback.
(   3.480|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
(   3.480|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   3.480|   0.000) I: [pulseaudio] alsa-util.c: Trying to disable ALSA period wakeups, using timers only
(   3.480|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 371 ms
(   3.480|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first (to 88200 samples), period size second (to 88200 samples).
(   3.480|   0.000) I: [pulseaudio] alsa-util.c: ALSA period wakeups disabled
(   3.480|   0.000) I: [pulseaudio] alsa-source.c: Successfully opened device front:0.
(   3.480|   0.000) I: [pulseaudio] alsa-source.c: Selected mapping 'Analog Stereo' (analog-stereo).
(   3.480|   0.000) I: [pulseaudio] alsa-source.c: Successfully enabled mmap() mode.
(   3.480|   0.000) I: [pulseaudio] alsa-source.c: Successfully enabled timer-based scheduling mode.
(   3.481|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL front:0
(   3.481|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer front:0: No such file or directory
(   3.481|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:0'
(   3.481|   0.000) D: [pulseaudio] alsa-mixer.c: Added 3 ports
(   3.481|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   3.481|   0.000) D: [pulseaudio] module-switch-on-port-available.c: Switching initial port for source 'alsa_input.pci-0000_00_1b.0.analog-stereo' to 'analog-input-front-mic'
(   3.481|   0.000) I: [pulseaudio] module-device-restore.c: Restoring volume for source alsa_input.pci-0000_00_1b.0.analog-stereo: front-left: 65540 / 100%,   front-right: 65540 / 100%
(   3.481|   0.000) I: [pulseaudio] module-device-restore.c: Restoring mute state for source alsa_input.pci-0000_00_1b.0.analog-stereo: unmuted
(   3.481|   0.000) I: [pulseaudio] source.c: Created source 6 "alsa_input.pci-0000_00_1b.0.analog-stereo" with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
(   3.481|   0.000) I: [pulseaudio] source.c:     alsa.resolution_bits = "16"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.api = "alsa"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.class = "sound"
(   3.481|   0.000) I: [pulseaudio] source.c:     alsa.class = "generic"
(   3.481|   0.000) I: [pulseaudio] source.c:     alsa.subclass = "generic-mix"
(   3.481|   0.000) I: [pulseaudio] source.c:     alsa.name = "ALC1150 Analog"
(   3.481|   0.000) I: [pulseaudio] source.c:     alsa.id = "ALC1150 Analog"
(   3.481|   0.000) I: [pulseaudio] source.c:     alsa.subdevice = "0"
(   3.481|   0.000) I: [pulseaudio] source.c:     alsa.subdevice_name = "subdevice #0"
(   3.481|   0.000) I: [pulseaudio] source.c:     alsa.device = "0"
(   3.481|   0.000) I: [pulseaudio] source.c:     alsa.card = "0"
(   3.481|   0.000) I: [pulseaudio] source.c:     alsa.card_name = "HDA Intel PCH"
(   3.481|   0.000) I: [pulseaudio] source.c:     alsa.long_card_name = "HDA Intel PCH at 0xfb130000 irq 34"
(   3.481|   0.000) I: [pulseaudio] source.c:     alsa.driver_name = "snd_hda_intel"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.bus_path = "pci-0000:00:1b.0"
(   3.481|   0.000) I: [pulseaudio] source.c:     sysfs.path = "/devices/pci0000:00/0000:00:1b.0/sound/card0"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.bus = "pci"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.vendor.id = "8086"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.vendor.name = "Intel Corporation"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.product.id = "8d20"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.product.name = "C610/X99 series chipset HD Audio Controller"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.form_factor = "internal"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.string = "front:0"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.buffering.buffer_size = "65536"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.buffering.fragment_size = "32768"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.access_mode = "mmap+timer"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.profile.name = "analog-stereo"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.profile.description = "Analog Stereo"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.description = "Built-in Audio Analog Stereo"
(   3.481|   0.000) I: [pulseaudio] source.c:     alsa.mixer_name = "Realtek ALC1150"
(   3.481|   0.000) I: [pulseaudio] source.c:     alsa.components = "HDA:10ec0900,1458a182,00100001"
(   3.481|   0.000) I: [pulseaudio] source.c:     module-udev-detect.discovered = "1"
(   3.481|   0.000) I: [pulseaudio] source.c:     device.icon_name = "audio-card-pci"
(   3.482|   0.000) I: [pulseaudio] alsa-source.c: Using 2.0 fragments of size 32768 bytes (185.76ms), buffer size is 65536 bytes (371.52ms)
(   3.482|   0.000) I: [pulseaudio] alsa-source.c: Time scheduling watermark is 20.00ms
(   3.482|   0.000) D: [pulseaudio] alsa-source.c: hwbuf_unused=0
(   3.482|   0.000) D: [pulseaudio] alsa-source.c: setting avail_min=15502
(   3.482|   0.000) D: [pulseaudio] alsa-mixer.c: Activating path analog-input-front-mic
(   3.482|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-input-front-mic (Front Microphone), direction=2, priority=85, probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=63, min_dB=-17.25, max_dB=60
(   3.482|   0.000) D: [pulseaudio] alsa-mixer.c: Element Capture, direction=2, switch=1, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   3.482|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front Mic Boost, direction=2, switch=0, volume=1, volume_limit=-1, enumeration=0, required=0, required_any=4, required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
(   3.482|   0.000) D: [pulseaudio] alsa-mixer.c: Element Input Source, direction=2, switch=0, volume=0, volume_limit=-1, enumeration=1, required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0, override_map=no
(   3.482|   0.000) D: [pulseaudio] alsa-mixer.c: Option Front Mic (analog-input-microphone-front/analog-input-microphone-front) index=0, priority=0
(   3.482|   0.000) D: [pulseaudio] alsa-mixer.c: Element Rear Mic Boost, direction=2, switch=0, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   3.482|   0.000) D: [pulseaudio] alsa-mixer.c: Element Line Boost, direction=2, switch=0, volume=2, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2, override_map=no
(   3.482|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Front Mic, alsa_name='Front Mic Jack', detection possible
(   3.482|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Front Mic Phantom, alsa_name='Front Mic Phantom Jack', detection unavailable
(   3.482|   0.000) D: [pulseaudio] alsa-mixer.c: Setting analog-input-microphone-front (analog-input-microphone-front) priority=0
(   3.482|   0.000) I: [pulseaudio] alsa-source.c: Successfully enabled deferred volume.
(   3.482|   0.000) I: [pulseaudio] alsa-source.c: Hardware volume ranges from -17.25 dB to 60.00 dB.
(   3.482|   0.000) I: [pulseaudio] alsa-source.c: Fixing base volume to -60.00 dB
(   3.482|   0.000) I: [pulseaudio] alsa-source.c: Using hardware volume control. Hardware dB scale supported.
(   3.482|   0.000) I: [pulseaudio] alsa-source.c: Using hardware mute control.
(   3.482|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_dump():
(   3.482|   0.000) D: [pulseaudio] alsa-util.c: Hardware PCM card 0 'HDA Intel PCH' device 0 subdevice 0
(   3.482|   0.000) D: [pulseaudio] alsa-util.c: Its setup is:
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   stream       : CAPTURE
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   access       : MMAP_INTERLEAVED
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   format       : S16_LE
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   subformat    : STD
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   channels     : 2
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   rate         : 44100
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   exact rate   : 44100 (44100/1)
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   msbits       : 16
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   buffer_size  : 16384
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   period_size  : 8192
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   period_time  : 185759
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_type  : MONOTONIC
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   period_step  : 1
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   avail_min    : 15502
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   period_event : 0
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   start_threshold  : -1
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   stop_threshold   : 4611686018427387904
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   silence_threshold: 0
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   silence_size : 0
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   boundary     : 4611686018427387904
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   appl_ptr     : 0
(   3.482|   0.000) D: [pulseaudio] alsa-util.c:   hw_ptr       : 0
(   3.483|   0.000) D: [alsa-source-ALC1150 Analog] alsa-source.c: Thread starting up
(   3.483|   0.000) D: [pulseaudio] alsa-source.c: Requested volume: front-left: 65540 / 100% / 0.00 dB,   front-right: 65540 / 100% / 0.00 dB
(   3.483|   0.000) D: [pulseaudio] alsa-source.c: Got hardware volume: front-left: 44652 /  68% / -10.00 dB,   front-right: 44652 /  68% / -10.00 dB
(   3.483|   0.000) D: [pulseaudio] alsa-source.c: Calculated software volume: front-left: 96193 / 147% / 10.00 dB,   front-right: 96193 / 147% / 10.00 dB (accurate-enough=no)
(   3.487|   0.004) D: [alsa-source-ALC1150 Analog] core-util.c: RealtimeKit worked.
(   3.487|   0.000) I: [alsa-source-ALC1150 Analog] core-util.c: Successfully enabled SCHED_RR scheduling for thread, with priority 5.
(   3.487|   0.000) I: [alsa-source-ALC1150 Analog] alsa-source.c: Starting capture.
(   3.488|   0.000) I: [pulseaudio] module.c: Loaded "module-alsa-card" (index: #10; argument: "device_id="0" name="pci-0000_00_1b.0" card_name="alsa_card.pci-0000_00_1b.0" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1"").
(   3.488|   0.000) I: [pulseaudio] module-udev-detect.c: Card /devices/pci0000:00/0000:00:1b.0/sound/card0 (alsa_card.pci-0000_00_1b.0) module loaded.
(   3.488|   0.000) I: [pulseaudio] module-udev-detect.c: Found 5 cards.
(   3.488|   0.000) I: [pulseaudio] module.c: Loaded "module-udev-detect" (index: #5; argument: "").
(   3.488|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/lib/pulse-6.0/modules/module-jackdbus-detect.so': failure
(   3.488|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/lib/pulse-6.0/modules/module-bluetooth-policy.so': success
(   3.488|   0.000) I: [pulseaudio] module.c: Loaded "module-bluetooth-policy" (index: #11; argument: "").
(   3.488|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/lib/pulse-6.0/modules/module-bluetooth-discover.so': success
(   3.488|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/lib/pulse-6.0/modules/module-bluez5-discover.so': success
(   3.490|   0.001) D: [pulseaudio] dbus-util.c: Successfully connected to D-Bus system bus 2a14bc887aa72ebe55f5a1cc56fcedd0 as :1.134
(   3.491|   0.001) I: [pulseaudio] module.c: Loaded "module-bluez5-discover" (index: #13; argument: "").
(   3.491|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/lib/pulse-6.0/modules/module-bluez4-discover.so': failure
(   3.491|   0.000) I: [pulseaudio] module.c: Loaded "module-bluetooth-discover" (index: #12; argument: "").
(   3.491|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/lib/pulse-6.0/modules/module-esound-protocol-unix.so': failure
(   3.492|   0.000) I: [pulseaudio] module.c: Loaded "module-native-protocol-unix" (index: #14; argument: "").
(   3.492|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/lib/pulse-6.0/modules/module-gconf.so': failure
(   3.492|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   3.492|   0.000) I: [pulseaudio] module-default-device-restore.c: Restored default sink 'alsa_output.pci-0000_00_1b.0.iec958-stereo'.
(   3.492|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
(   3.492|   0.000) I: [pulseaudio] module-default-device-restore.c: Restored default source 'alsa_input.usb-0d8c_C-Media_USB_Audio_Device-00.analog-mono'.
(   3.492|   0.000) I: [pulseaudio] module.c: Loaded "module-default-device-restore" (index: #15; argument: "").
(   3.493|   0.000) I: [pulseaudio] module.c: Loaded "module-rescue-streams" (index: #16; argument: "").
(   3.493|   0.000) I: [pulseaudio] module.c: Loaded "module-always-sink" (index: #17; argument: "").
(   3.493|   0.000) I: [pulseaudio] module.c: Loaded "module-intended-roles" (index: #18; argument: "").
(   3.494|   0.000) D: [pulseaudio] module-suspend-on-idle.c: Sink alsa_output.pci-0000_06_00.1.hdmi-stereo becomes idle, timeout in 5 seconds.
(   3.494|   0.000) D: [pulseaudio] module-suspend-on-idle.c: Sink alsa_output.usb-Yoyodyne_Consulting_ODAC-revB-01.iec958-stereo becomes idle, timeout in 5 seconds.
(   3.494|   0.000) D: [pulseaudio] module-suspend-on-idle.c: Sink alsa_output.usb-0d8c_C-Media_USB_Audio_Device-00.analog-stereo becomes idle, timeout in 5 seconds.
(   3.494|   0.000) D: [pulseaudio] module-suspend-on-idle.c: Sink alsa_output.pci-0000_00_1b.0.iec958-stereo becomes idle, timeout in 5 seconds.
(   3.494|   0.000) D: [pulseaudio] module-suspend-on-idle.c: Source alsa_input.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02.iec958-stereo becomes idle, timeout in 5 seconds.
(   3.494|   0.000) D: [pulseaudio] module-suspend-on-idle.c: Source alsa_input.usb-0d8c_C-Media_USB_Audio_Device-00.analog-mono becomes idle, timeout in 5 seconds.
(   3.494|   0.000) D: [pulseaudio] module-suspend-on-idle.c: Source alsa_input.pci-0000_00_1b.0.analog-stereo becomes idle, timeout in 5 seconds.
(   3.494|   0.000) I: [pulseaudio] module.c: Loaded "module-suspend-on-idle" (index: #19; argument: "").
(   3.494|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/lib/pulse-6.0/modules/module-console-kit.so': failure
(   3.494|   0.000) D: [pulseaudio] module.c: Checking for existence of '/usr/lib/pulse-6.0/modules/module-systemd-login.so': success
(   3.494|   0.000) I: [pulseaudio] client.c: Created 0 "Login Session c2"
(   3.494|   0.000) D: [pulseaudio] module-systemd-login.c: Added new session c2
(   3.494|   0.000) I: [pulseaudio] module.c: Loaded "module-systemd-login" (index: #20; argument: "").
(   3.495|   0.000) I: [pulseaudio] module.c: Loaded "module-position-event-sounds" (index: #21; argument: "").
(   3.495|   0.000) I: [pulseaudio] module.c: Loaded "module-filter-heuristics" (index: #22; argument: "").
(   3.495|   0.000) I: [pulseaudio] module.c: Loaded "module-filter-apply" (index: #23; argument: "").
(   3.496|   0.000) D: [pulseaudio] main.c: Got org.PulseAudio1!
(   3.496|   0.000) D: [pulseaudio] main.c: Got org.pulseaudio.Server!
(   3.496|   0.000) I: [pulseaudio] main.c: Daemon startup complete.
(   3.497|   0.000) I: [pulseaudio] client.c: Created 1 "Native client (UNIX socket client)"
(   3.497|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC1 is accessible: yes
(   3.497|   0.000) D: [pulseaudio] module-udev-detect.c: Resuming all sinks and sources of card alsa_card.pci-0000_06_00.1.
(   3.497|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC3 is accessible: yes
(   3.497|   0.000) D: [pulseaudio] module-udev-detect.c: Resuming all sinks and sources of card alsa_card.usb-Yoyodyne_Consulting_ODAC-revB-01.
(   3.497|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC2 is accessible: yes
(   3.497|   0.000) D: [pulseaudio] module-udev-detect.c: Resuming all sinks and sources of card alsa_card.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02.
(   3.497|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC4 is accessible: yes
(   3.497|   0.000) D: [pulseaudio] module-udev-detect.c: Resuming all sinks and sources of card alsa_card.usb-0d8c_C-Media_USB_Audio_Device-00.
(   3.497|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC0 is accessible: yes
(   3.497|   0.000) D: [pulseaudio] module-udev-detect.c: Resuming all sinks and sources of card alsa_card.pci-0000_00_1b.0.
(   3.497|   0.000) I: [pulseaudio] client.c: Created 2 "Native client (UNIX socket client)"
(   3.498|   0.000) D: [pulseaudio] protocol-native.c: Protocol version: remote 30, local 30
(   3.498|   0.000) I: [pulseaudio] protocol-native.c: Got credentials: uid=1000 gid=1000 success=1
(   3.498|   0.000) D: [pulseaudio] protocol-native.c: SHM possible: yes
(   3.498|   0.000) D: [pulseaudio] protocol-native.c: Negotiated SHM: yes
(   3.498|   0.000) D: [pulseaudio] protocol-native.c: Disabling srbchannel, reason: Must be enabled by module parameter
(   3.498|   0.000) D: [pulseaudio] protocol-native.c: Protocol version: remote 30, local 30
(   3.498|   0.000) I: [pulseaudio] protocol-native.c: Got credentials: uid=1000 gid=1000 success=1
(   3.498|   0.000) D: [pulseaudio] protocol-native.c: SHM possible: yes
(   3.498|   0.000) D: [pulseaudio] protocol-native.c: Negotiated SHM: yes
(   3.498|   0.000) D: [pulseaudio] protocol-native.c: Disabling srbchannel, reason: Must be enabled by module parameter
(   3.498|   0.000) D: [pulseaudio] module-augment-properties.c: Looking for .desktop file for unity-settings-daemon
(   3.498|   0.000) D: [pulseaudio] module-augment-properties.c: Looking for .desktop file for indicator-sound-service
(   7.976|   4.477) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC5 is accessible: yes
(   7.977|   0.000) D: [pulseaudio] module-udev-detect.c: /devices/pci0000:00/0000:00:14.0/usb1/1-14/1-14:1.0/sound/card5 is busy: no
(   7.977|   0.000) D: [pulseaudio] module-udev-detect.c: Loading module-alsa-card with arguments 'device_id="5" name="usb-TOPPING_VX2-00" card_name="alsa_card.usb-TOPPING_VX2-00" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1"'
(   7.977|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully acquired reservation lock on device 'Audio5'
(   7.977|   0.000) I: [pulseaudio] (alsa-lib)utils.c: could not open configuration file /usr/share/alsa/ucm/VX2/VX2.conf
(   7.977|   0.000) I: [pulseaudio] (alsa-lib)parser.c: error: could not parse configuration for card VX2
(   7.978|   0.000) I: [pulseaudio] (alsa-lib)main.c: error: failed to import VX2 use case configuration -2
(   7.978|   0.000) I: [pulseaudio] alsa-ucm.c: UCM not available for card VX2
(   7.978|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/profile-sets/default.conf'
(   7.980|   0.001) D: [pulseaudio] alsa-mixer.c: Looking at profile input:analog-mono
(   7.980|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Mono (analog-mono)
(   7.980|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:5 with SND_PCM_NO_AUTO_FORMAT ...
(   7.980|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC5D0c' failed (-2)
(   7.980|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hw:5: No such file or directory
(   7.980|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:analog-mono
(   7.980|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:analog-stereo
(   7.980|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Analog Stereo (analog-stereo)
(   7.980|   0.000) D: [pulseaudio] alsa-util.c: Trying front:5 with SND_PCM_NO_AUTO_FORMAT ...
(   7.980|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC5D0c' failed (-2)
(   7.980|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device front:5: No such file or directory
(   7.980|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:5 with SND_PCM_NO_AUTO_FORMAT ...
(   7.980|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC5D0c' failed (-2)
(   7.981|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hw:5: No such file or directory
(   7.981|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:analog-stereo
(   7.981|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:iec958-stereo
(   7.981|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Digital Stereo (IEC958) (iec958-stereo)
(   7.981|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:5 with SND_PCM_NO_AUTO_FORMAT ...
(   7.981|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC5D0c' failed (-2)
(   7.981|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device iec958:5: No such file or directory
(   7.981|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:iec958-stereo
(   7.981|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-mono
(   7.981|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Mono (analog-mono)
(   7.981|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:5 with SND_PCM_NO_AUTO_FORMAT ...
(   7.981|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:5
(   7.981|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   7.981|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   7.981|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:5 without SND_PCM_NO_AUTO_FORMAT ...
(   7.982|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:5
(   7.982|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   7.982|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   7.982|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:5 with SND_PCM_NO_AUTO_FORMAT ...
(   7.982|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:5
(   7.982|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   7.982|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   7.982|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:5 without SND_PCM_NO_AUTO_FORMAT ...
(   7.982|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:5
(   7.982|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   7.982|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   7.982|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:hw:5: Invalid argument
(   7.982|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-mono
(   7.982|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:analog-mono - will not be able to open output:analog-mono
(   7.982|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:analog-stereo - will not be able to open output:analog-mono
(   7.982|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:iec958-stereo - will not be able to open output:analog-mono
(   7.982|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-stereo
(   7.982|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Stereo (analog-stereo)
(   7.982|   0.000) D: [pulseaudio] alsa-util.c: Trying front:5 with SND_PCM_NO_AUTO_FORMAT ...
(   7.983|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:5
(   7.983|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   7.983|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
(   7.987|   0.004) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   7.990|   0.002) D: [pulseaudio] alsa-mixer.c: Profile output:analog-stereo supported.
(   7.990|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf'
(   7.990|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   7.990|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-lineout.conf'
(   7.990|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   7.991|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-speaker.conf'
(   7.991|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   7.991|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-headphones.conf'
(   7.991|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   7.991|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output-headphones-2.conf'
(   7.992|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common'
(   7.992|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL front:5
(   7.992|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer front:5: No such file or directory
(   7.992|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:5'
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output'
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=0, switch=1, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-lineout'
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Jack' succeeded (not found)
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Phantom Jack' succeeded (not found)
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Front Jack' succeeded (not found)
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Front Phantom Jack' succeeded (not found)
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out CLFE Jack' succeeded (not found)
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out CLFE Phantom Jack' succeeded (not found)
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Surround Jack' succeeded (not found)
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Surround Phantom Jack' succeeded (not found)
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Side Jack' succeeded (not found)
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Side Phantom Jack' succeeded (not found)
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   7.992|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line HP Swap' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Front' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Surround' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Side' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=0, switch=1, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-output-lineout', none of required-any elements preset.
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-speaker'
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Headphone Jack' succeeded (not found)
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Headphone Jack' succeeded (not found)
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Jack' succeeded (not found)
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line Out Front Jack' succeeded (not found)
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Speaker Phantom Jack' succeeded (not found)
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Speaker Front Phantom Jack' succeeded (not found)
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Front' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Surround' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Side' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   7.993|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=0, switch=1, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-output-speaker', none of required-any elements preset.
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-headphones'
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Headphone Jack' succeeded (not found)
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock Headphone Phantom Jack' succeeded (not found)
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Headphone Jack' succeeded (not found)
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front Headphone Phantom Jack' succeeded (not found)
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Jack' succeeded (not found)
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Phantom Jack' succeeded (not found)
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Headphone Mic Jack' succeeded (not found)
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headset' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Line HP Swap' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Front' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Surround' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Side' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Center' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'LFE' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Front' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Surround' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker Side' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'PCM' succeeded (volume=0, switch=1, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path 'analog-output-headphones', none of required-any elements preset.
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output-headphones-2'
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone+LO' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Speaker+LO' succeeded (volume=0, switch=0, enumeration=0).
(   7.994|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Headphone2' failed.
(   7.995|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   7.995|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0x1030c20, direction=1
(   7.995|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output (Analog Output), direction=1, priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   7.995|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM, direction=1, switch=1, volume=0, volume_limit=-1, enumeration=0, required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0, override_map=yes
(   7.995|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:analog-mono - will not be able to open input:analog-mono
(   7.995|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:analog-stereo - will not be able to open input:analog-stereo
(   7.995|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:iec958-stereo - will not be able to open input:iec958-stereo
(   7.998|   0.003) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-21
(   7.998|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 2.1 (analog-surround-21)
(   7.998|   0.000) D: [pulseaudio] alsa-util.c: Trying surround21:5 with SND_PCM_NO_AUTO_FORMAT ...
(   7.998|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state for chmap_get: OPEN
(   7.998|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround21:5
(   7.998|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   7.998|   0.000) D: [pulseaudio] alsa-util.c: Trying surround21:5 without SND_PCM_NO_AUTO_FORMAT ...
(   7.999|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state for chmap_get: OPEN
(   7.999|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround21:5
(   7.999|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   7.999|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround21:5 with SND_PCM_NO_AUTO_FORMAT ...
(   7.999|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state for chmap_get: OPEN
(   7.999|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround21:5
(   7.999|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   7.999|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   7.999|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround21:5 without SND_PCM_NO_AUTO_FORMAT ...
(   8.000|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid PCM state for chmap_get: OPEN
(   8.000|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround21:5
(   8.000|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   8.000|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.000|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround21:5: Invalid argument
(   8.000|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-21
(   8.000|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:analog-mono - will not be able to open output:analog-surround-21
(   8.000|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:analog-stereo - will not be able to open output:analog-surround-21
(   8.000|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:iec958-stereo - will not be able to open output:analog-surround-21
(   8.000|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-40
(   8.000|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 4.0 (analog-surround-40)
(   8.000|   0.000) D: [pulseaudio] alsa-util.c: Trying surround40:5 with SND_PCM_NO_AUTO_FORMAT ...
(   8.000|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround40:5
(   8.000|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   8.000|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(4) failed: Invalid argument
(   8.000|   0.000) D: [pulseaudio] alsa-util.c: Trying surround40:5 without SND_PCM_NO_AUTO_FORMAT ...
(   8.001|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround40:5
(   8.001|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   8.001|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(4) failed: Invalid argument
(   8.001|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround40:5 with SND_PCM_NO_AUTO_FORMAT ...
(   8.001|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround40:5
(   8.001|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   8.001|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(4) failed: Invalid argument
(   8.001|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround40:5 without SND_PCM_NO_AUTO_FORMAT ...
(   8.002|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround40:5
(   8.002|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   8.002|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_channels(4) failed: Invalid argument
(   8.002|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround40:5: Invalid argument
(   8.002|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-40
(   8.002|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:analog-mono - will not be able to open output:analog-surround-40
(   8.002|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:analog-stereo - will not be able to open output:analog-surround-40
(   8.002|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:iec958-stereo - will not be able to open output:analog-surround-40
(   8.002|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-41
(   8.002|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 4.1 (analog-surround-41)
(   8.002|   0.000) D: [pulseaudio] alsa-util.c: Trying surround41:5 with SND_PCM_NO_AUTO_FORMAT ...
(   8.003|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround41:5
(   8.003|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.003|   0.000) D: [pulseaudio] alsa-util.c: Trying surround41:5 without SND_PCM_NO_AUTO_FORMAT ...
(   8.003|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround41:5
(   8.003|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.003|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround41:5 with SND_PCM_NO_AUTO_FORMAT ...
(   8.003|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround41:5
(   8.003|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   8.003|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.003|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround41:5 without SND_PCM_NO_AUTO_FORMAT ...
(   8.004|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround41:5
(   8.004|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   8.004|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.004|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround41:5: Invalid argument
(   8.004|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-41
(   8.004|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:analog-mono - will not be able to open output:analog-surround-41
(   8.004|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:analog-stereo - will not be able to open output:analog-surround-41
(   8.004|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:iec958-stereo - will not be able to open output:analog-surround-41
(   8.004|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-50
(   8.004|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 5.0 (analog-surround-50)
(   8.004|   0.000) D: [pulseaudio] alsa-util.c: Trying surround50:5 with SND_PCM_NO_AUTO_FORMAT ...
(   8.004|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround50:5
(   8.004|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.004|   0.000) D: [pulseaudio] alsa-util.c: Trying surround50:5 without SND_PCM_NO_AUTO_FORMAT ...
(   8.005|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround50:5
(   8.005|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.005|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround50:5 with SND_PCM_NO_AUTO_FORMAT ...
(   8.005|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround50:5
(   8.005|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   8.005|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.005|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround50:5 without SND_PCM_NO_AUTO_FORMAT ...
(   8.006|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround50:5
(   8.006|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   8.006|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.006|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround50:5: Invalid argument
(   8.006|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-50
(   8.006|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:analog-mono - will not be able to open output:analog-surround-50
(   8.006|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:analog-stereo - will not be able to open output:analog-surround-50
(   8.006|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:iec958-stereo - will not be able to open output:analog-surround-50
(   8.006|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-51
(   8.006|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 5.1 (analog-surround-51)
(   8.006|   0.000) D: [pulseaudio] alsa-util.c: Trying surround51:5 with SND_PCM_NO_AUTO_FORMAT ...
(   8.006|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround51:5
(   8.006|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.006|   0.000) D: [pulseaudio] alsa-util.c: Trying surround51:5 without SND_PCM_NO_AUTO_FORMAT ...
(   8.007|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround51:5
(   8.007|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.007|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround51:5 with SND_PCM_NO_AUTO_FORMAT ...
(   8.007|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround51:5
(   8.007|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   8.007|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.007|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround51:5 without SND_PCM_NO_AUTO_FORMAT ...
(   8.007|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround51:5
(   8.007|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   8.007|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.007|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround51:5: Invalid argument
(   8.007|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-51
(   8.007|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:analog-mono - will not be able to open output:analog-surround-51
(   8.007|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:analog-stereo - will not be able to open output:analog-surround-51
(   8.008|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:iec958-stereo - will not be able to open output:analog-surround-51
(   8.008|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:analog-surround-71
(   8.008|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Surround 7.1 (analog-surround-71)
(   8.008|   0.000) D: [pulseaudio] alsa-util.c: Trying surround71:5 with SND_PCM_NO_AUTO_FORMAT ...
(   8.008|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround71:5
(   8.008|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.008|   0.000) D: [pulseaudio] alsa-util.c: Trying surround71:5 without SND_PCM_NO_AUTO_FORMAT ...
(   8.008|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround71:5
(   8.008|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.008|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround71:5 with SND_PCM_NO_AUTO_FORMAT ...
(   8.009|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround71:5
(   8.009|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   8.009|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.009|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:surround71:5 without SND_PCM_NO_AUTO_FORMAT ...
(   8.009|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:surround71:5
(   8.009|   0.000) I: [pulseaudio] (alsa-lib)pcm_params.c: Slave PCM not usable
(   8.009|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_hw_params_any() failed: Invalid argument
(   8.009|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:surround71:5: Invalid argument
(   8.009|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:analog-surround-71
(   8.009|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:analog-mono - will not be able to open output:analog-surround-71
(   8.009|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:analog-stereo - will not be able to open output:analog-surround-71
(   8.009|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:iec958-stereo - will not be able to open output:analog-surround-71
(   8.009|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-stereo
(   8.009|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (IEC958) (iec958-stereo)
(   8.009|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:5 with SND_PCM_NO_AUTO_FORMAT ...
(   8.010|   0.000) D: [pulseaudio] alsa-util.c: Managed to open iec958:5
(   8.010|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(   8.010|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
(   8.014|   0.004) D: [pulseaudio] alsa-util.c: Set buffer size first (to 4408 samples), period size second (to 1102 samples).
(   8.017|   0.002) D: [pulseaudio] alsa-mixer.c: Profile output:iec958-stereo supported.
(   8.017|   0.000) D: [pulseaudio] conf-parser.c: Parsing configuration file '/usr/share/pulseaudio/alsa-mixer/paths/iec958-stereo-output.conf'
(   8.017|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL iec958:5
(   8.017|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to mixer iec958:5: No such file or directory
(   8.017|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:5'
(   8.017|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'iec958-stereo-output'
(   8.017|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'IEC958' succeeded (volume=0, switch=0, enumeration=0).
(   8.017|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer paths (after tidying):
(   8.017|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xf1a280, direction=1
(   8.017|   0.000) D: [pulseaudio] alsa-mixer.c: Path iec958-stereo-output (Digital Output (S/PDIF)), direction=1, priority=0, probed=yes, supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   8.017|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:analog-mono - will not be able to open input:analog-mono
(   8.017|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:analog-stereo - will not be able to open input:analog-stereo
(   8.017|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:iec958-stereo - will not be able to open input:iec958-stereo
(  13.021|   5.003) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-ac3-surround-40
(  13.021|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 4.0 (IEC958/AC3) (iec958-ac3-surround-40)
(  13.021|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:5 with SND_PCM_NO_AUTO_FORMAT ...
(  13.021|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:5
(  13.021|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device a52:5: No such file or directory
(  13.021|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-ac3-surround-40
(  13.021|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:analog-mono - will not be able to open output:iec958-ac3-surround-40
(  13.021|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:analog-stereo - will not be able to open output:iec958-ac3-surround-40
(  13.021|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:iec958-stereo - will not be able to open output:iec958-ac3-surround-40
(  13.021|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-ac3-surround-51
(  13.021|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (IEC958/AC3) (iec958-ac3-surround-51)
(  13.021|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:5 with SND_PCM_NO_AUTO_FORMAT ...
(  13.021|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:5
(  13.021|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device a52:5: No such file or directory
(  13.021|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-ac3-surround-51
(  13.021|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:analog-mono - will not be able to open output:iec958-ac3-surround-51
(  13.021|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:analog-stereo - will not be able to open output:iec958-ac3-surround-51
(  13.021|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:iec958-stereo - will not be able to open output:iec958-ac3-surround-51
(  13.021|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:iec958-dts-surround-51
(  13.021|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (IEC958/DTS) (iec958-dts-surround-51)
(  13.021|   0.000) D: [pulseaudio] alsa-util.c: Trying dca:5 with SND_PCM_NO_AUTO_FORMAT ...
(  13.022|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dca:5
(  13.022|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dca:5: No such file or directory
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:iec958-dts-surround-51
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:analog-mono - will not be able to open output:iec958-dts-surround-51
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:analog-stereo - will not be able to open output:iec958-dts-surround-51
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:iec958-stereo - will not be able to open output:iec958-dts-surround-51
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI) (hdmi-stereo)
(  13.022|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5 with SND_PCM_NO_AUTO_FORMAT ...
(  13.022|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.0:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.022|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.022|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.022|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5
(  13.022|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5: No such file or directory
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:analog-mono - will not be able to open output:hdmi-stereo
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:analog-stereo - will not be able to open output:hdmi-stereo
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:iec958-stereo - will not be able to open output:hdmi-stereo
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI) (hdmi-surround)
(  13.022|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5 with SND_PCM_NO_AUTO_FORMAT ...
(  13.022|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.0:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.022|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.022|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.022|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5
(  13.022|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5: No such file or directory
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:analog-mono - will not be able to open output:hdmi-surround
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:analog-stereo - will not be able to open output:hdmi-surround
(  13.022|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:iec958-stereo - will not be able to open output:hdmi-surround
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI) (hdmi-surround71)
(  13.023|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5 with SND_PCM_NO_AUTO_FORMAT ...
(  13.023|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.0:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.023|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.023|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.023|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5
(  13.023|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5: No such file or directory
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:analog-mono - will not be able to open output:hdmi-surround71
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:analog-stereo - will not be able to open output:hdmi-surround71
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:iec958-stereo - will not be able to open output:hdmi-surround71
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI/DTS) (hdmi-dts-surround)
(  13.023|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:5 with SND_PCM_NO_AUTO_FORMAT ...
(  13.023|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:5
(  13.023|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:5: No such file or directory
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:analog-mono - will not be able to open output:hdmi-dts-surround
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:analog-stereo - will not be able to open output:hdmi-dts-surround
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:iec958-stereo - will not be able to open output:hdmi-dts-surround
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra1
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 2) (hdmi-stereo-extra1)
(  13.023|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,1 with SND_PCM_NO_AUTO_FORMAT ...
(  13.023|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.1:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.023|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.023|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.023|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,1
(  13.023|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,1: No such file or directory
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra1
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:analog-mono - will not be able to open output:hdmi-stereo-extra1
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:analog-stereo - will not be able to open output:hdmi-stereo-extra1
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra1
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra1
(  13.023|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 2) (hdmi-surround-extra1)
(  13.023|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,1 with SND_PCM_NO_AUTO_FORMAT ...
(  13.024|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.1:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.024|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.024|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.024|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,1
(  13.024|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,1: No such file or directory
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra1
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:analog-mono - will not be able to open output:hdmi-surround-extra1
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:analog-stereo - will not be able to open output:hdmi-surround-extra1
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:iec958-stereo - will not be able to open output:hdmi-surround-extra1
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra1
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 2) (hdmi-surround71-extra1)
(  13.024|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,1 with SND_PCM_NO_AUTO_FORMAT ...
(  13.024|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.1:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.024|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.024|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.024|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,1
(  13.024|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,1: No such file or directory
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra1
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:analog-mono - will not be able to open output:hdmi-surround71-extra1
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:analog-stereo - will not be able to open output:hdmi-surround71-extra1
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra1
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra1
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 2/DTS) (hdmi-dts-surround-extra1)
(  13.024|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:5,1 with SND_PCM_NO_AUTO_FORMAT ...
(  13.024|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:5,1
(  13.024|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:5,1: No such file or directory
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra1
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra1
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra1
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra1
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra2
(  13.024|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 3) (hdmi-stereo-extra2)
(  13.024|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,2 with SND_PCM_NO_AUTO_FORMAT ...
(  13.025|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.2:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.025|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.025|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.025|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,2
(  13.025|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,2: No such file or directory
(  13.025|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra2
(  13.025|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:analog-mono - will not be able to open output:hdmi-stereo-extra2
(  13.025|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:analog-stereo - will not be able to open output:hdmi-stereo-extra2
(  13.025|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra2
(  13.025|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra2
(  13.025|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 3) (hdmi-surround-extra2)
(  13.025|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,2 with SND_PCM_NO_AUTO_FORMAT ...
(  13.025|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.2:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.025|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.025|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.025|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,2
(  13.025|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,2: No such file or directory
(  13.025|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra2
(  13.025|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:analog-mono - will not be able to open output:hdmi-surround-extra2
(  13.025|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:analog-stereo - will not be able to open output:hdmi-surround-extra2
(  13.025|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:iec958-stereo - will not be able to open output:hdmi-surround-extra2
(  13.025|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra2
(  13.025|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 3) (hdmi-surround71-extra2)
(  13.025|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,2 with SND_PCM_NO_AUTO_FORMAT ...
(  13.025|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.2:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.025|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.025|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.025|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,2
(  13.025|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,2: No such file or directory
(  13.025|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra2
(  13.025|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:analog-mono - will not be able to open output:hdmi-surround71-extra2
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:analog-stereo - will not be able to open output:hdmi-surround71-extra2
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra2
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra2
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 3/DTS) (hdmi-dts-surround-extra2)
(  13.026|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:5,2 with SND_PCM_NO_AUTO_FORMAT ...
(  13.026|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:5,2
(  13.026|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:5,2: No such file or directory
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra2
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra2
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra2
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra2
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra3
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 4) (hdmi-stereo-extra3)
(  13.026|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,3 with SND_PCM_NO_AUTO_FORMAT ...
(  13.026|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.3:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.026|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.026|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.026|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,3
(  13.026|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,3: No such file or directory
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra3
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:analog-mono - will not be able to open output:hdmi-stereo-extra3
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:analog-stereo - will not be able to open output:hdmi-stereo-extra3
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra3
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra3
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 4) (hdmi-surround-extra3)
(  13.026|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,3 with SND_PCM_NO_AUTO_FORMAT ...
(  13.026|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.3:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.026|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.026|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.026|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,3
(  13.026|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,3: No such file or directory
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra3
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:analog-mono - will not be able to open output:hdmi-surround-extra3
(  13.026|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:analog-stereo - will not be able to open output:hdmi-surround-extra3
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:iec958-stereo - will not be able to open output:hdmi-surround-extra3
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra3
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 4) (hdmi-surround71-extra3)
(  13.027|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,3 with SND_PCM_NO_AUTO_FORMAT ...
(  13.027|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.3:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.027|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.027|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.027|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,3
(  13.027|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,3: No such file or directory
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra3
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:analog-mono - will not be able to open output:hdmi-surround71-extra3
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:analog-stereo - will not be able to open output:hdmi-surround71-extra3
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra3
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra3
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 4/DTS) (hdmi-dts-surround-extra3)
(  13.027|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:5,3 with SND_PCM_NO_AUTO_FORMAT ...
(  13.027|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:5,3
(  13.027|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:5,3: No such file or directory
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra3
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra3
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra3
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra3
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra4
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 5) (hdmi-stereo-extra4)
(  13.027|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,4 with SND_PCM_NO_AUTO_FORMAT ...
(  13.027|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.4:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.027|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.027|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.027|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,4
(  13.027|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,4: No such file or directory
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra4
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:analog-mono - will not be able to open output:hdmi-stereo-extra4
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:analog-stereo - will not be able to open output:hdmi-stereo-extra4
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra4
(  13.027|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 5) (hdmi-surround-extra4)
(  13.028|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,4 with SND_PCM_NO_AUTO_FORMAT ...
(  13.028|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.4:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.028|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.028|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.028|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,4
(  13.028|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,4: No such file or directory
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:analog-mono - will not be able to open output:hdmi-surround-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:analog-stereo - will not be able to open output:hdmi-surround-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:iec958-stereo - will not be able to open output:hdmi-surround-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 5) (hdmi-surround71-extra4)
(  13.028|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,4 with SND_PCM_NO_AUTO_FORMAT ...
(  13.028|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.4:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.028|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.028|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.028|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,4
(  13.028|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,4: No such file or directory
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:analog-mono - will not be able to open output:hdmi-surround71-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:analog-stereo - will not be able to open output:hdmi-surround71-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 5/DTS) (hdmi-dts-surround-extra4)
(  13.028|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:5,4 with SND_PCM_NO_AUTO_FORMAT ...
(  13.028|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:5,4
(  13.028|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:5,4: No such file or directory
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra4
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra5
(  13.028|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 6) (hdmi-stereo-extra5)
(  13.028|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,5 with SND_PCM_NO_AUTO_FORMAT ...
(  13.029|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.5:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.029|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.029|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.029|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,5
(  13.029|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,5: No such file or directory
(  13.029|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra5
(  13.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:analog-mono - will not be able to open output:hdmi-stereo-extra5
(  13.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:analog-stereo - will not be able to open output:hdmi-stereo-extra5
(  13.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra5
(  13.029|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra5
(  13.029|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 6) (hdmi-surround-extra5)
(  13.029|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,5 with SND_PCM_NO_AUTO_FORMAT ...
(  13.029|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.5:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.029|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.029|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.029|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,5
(  13.029|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,5: No such file or directory
(  13.029|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra5
(  13.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:analog-mono - will not be able to open output:hdmi-surround-extra5
(  13.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:analog-stereo - will not be able to open output:hdmi-surround-extra5
(  13.029|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:iec958-stereo - will not be able to open output:hdmi-surround-extra5
(  13.029|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra5
(  13.029|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 6) (hdmi-surround71-extra5)
(  13.029|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,5 with SND_PCM_NO_AUTO_FORMAT ...
(  13.029|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.5:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.029|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.030|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.030|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,5
(  13.030|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,5: No such file or directory
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra5
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:analog-mono - will not be able to open output:hdmi-surround71-extra5
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:analog-stereo - will not be able to open output:hdmi-surround71-extra5
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra5
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra5
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 6/DTS) (hdmi-dts-surround-extra5)
(  13.030|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:5,5 with SND_PCM_NO_AUTO_FORMAT ...
(  13.030|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:5,5
(  13.030|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:5,5: No such file or directory
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra5
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra5
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra5
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra5
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra6
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 7) (hdmi-stereo-extra6)
(  13.030|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,6 with SND_PCM_NO_AUTO_FORMAT ...
(  13.030|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.6:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.030|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.030|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.030|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,6
(  13.030|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,6: No such file or directory
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra6
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:analog-mono - will not be able to open output:hdmi-stereo-extra6
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:analog-stereo - will not be able to open output:hdmi-stereo-extra6
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra6
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra6
(  13.030|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 7) (hdmi-surround-extra6)
(  13.030|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,6 with SND_PCM_NO_AUTO_FORMAT ...
(  13.030|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.6:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.030|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.030|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.030|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,6
(  13.031|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,6: No such file or directory
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra6
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:analog-mono - will not be able to open output:hdmi-surround-extra6
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:analog-stereo - will not be able to open output:hdmi-surround-extra6
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:iec958-stereo - will not be able to open output:hdmi-surround-extra6
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra6
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 7) (hdmi-surround71-extra6)
(  13.031|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,6 with SND_PCM_NO_AUTO_FORMAT ...
(  13.031|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.6:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.031|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.031|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.031|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,6
(  13.031|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,6: No such file or directory
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra6
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:analog-mono - will not be able to open output:hdmi-surround71-extra6
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:analog-stereo - will not be able to open output:hdmi-surround71-extra6
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra6
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra6
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 7/DTS) (hdmi-dts-surround-extra6)
(  13.031|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:5,6 with SND_PCM_NO_AUTO_FORMAT ...
(  13.031|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:5,6
(  13.031|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:5,6: No such file or directory
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra6
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra6
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra6
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra6
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-stereo-extra7
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo (HDMI 8) (hdmi-stereo-extra7)
(  13.031|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,7 with SND_PCM_NO_AUTO_FORMAT ...
(  13.031|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.7:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.031|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.031|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.031|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,7
(  13.031|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,7: No such file or directory
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-stereo-extra7
(  13.031|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:analog-mono - will not be able to open output:hdmi-stereo-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:analog-stereo - will not be able to open output:hdmi-stereo-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:iec958-stereo - will not be able to open output:hdmi-stereo-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 8) (hdmi-surround-extra7)
(  13.032|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,7 with SND_PCM_NO_AUTO_FORMAT ...
(  13.032|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.7:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.032|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.032|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.032|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,7
(  13.032|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,7: No such file or directory
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:analog-mono - will not be able to open output:hdmi-surround-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:analog-stereo - will not be able to open output:hdmi-surround-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:iec958-stereo - will not be able to open output:hdmi-surround-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-surround71-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 7.1 (HDMI 8) (hdmi-surround71-extra7)
(  13.032|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:5,7 with SND_PCM_NO_AUTO_FORMAT ...
(  13.032|   0.000) I: [pulseaudio] (alsa-lib)confmisc.c: Unable to find definition 'cards.USB-Audio.pcm.hdmi.7:CARD=5,AES0=4,AES1=130,AES2=0,AES3=2'
(  13.032|   0.000) I: [pulseaudio] (alsa-lib)conf.c: function snd_func_refer returned error: No such file or directory
(  13.032|   0.000) I: [pulseaudio] (alsa-lib)conf.c: Evaluate error: No such file or directory
(  13.032|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:5,7
(  13.032|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:5,7: No such file or directory
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-surround71-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:analog-mono - will not be able to open output:hdmi-surround71-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:analog-stereo - will not be able to open output:hdmi-surround71-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:iec958-stereo - will not be able to open output:hdmi-surround71-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile output:hdmi-dts-surround-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Surround 5.1 (HDMI 8/DTS) (hdmi-dts-surround-extra7)
(  13.032|   0.000) D: [pulseaudio] alsa-util.c: Trying dcahdmi:5,7 with SND_PCM_NO_AUTO_FORMAT ...
(  13.032|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:5,7
(  13.032|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:5,7: No such file or directory
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open output:hdmi-dts-surround-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:analog-mono - will not be able to open output:hdmi-dts-surround-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:analog-stereo - will not be able to open output:hdmi-dts-surround-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:iec958-stereo - will not be able to open output:hdmi-dts-surround-extra7
(  13.032|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile input:multichannel
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for recording on Multichannel (multichannel)
(  13.033|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:5 with SND_PCM_NO_AUTO_FORMAT ...
(  13.033|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC5D0c' failed (-2)
(  13.033|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device hw:5: No such file or directory
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to open input:multichannel
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-mono+input:multichannel - will not be able to open output:analog-mono
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-stereo+input:multichannel - will not be able to open input:multichannel
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-21+input:multichannel - will not be able to open output:analog-surround-21
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-40+input:multichannel - will not be able to open output:analog-surround-40
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-41+input:multichannel - will not be able to open output:analog-surround-41
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-50+input:multichannel - will not be able to open output:analog-surround-50
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-51+input:multichannel - will not be able to open output:analog-surround-51
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:analog-surround-71+input:multichannel - will not be able to open output:analog-surround-71
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-stereo+input:multichannel - will not be able to open input:multichannel
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-40+input:multichannel - will not be able to open output:iec958-ac3-surround-40
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-ac3-surround-51+input:multichannel - will not be able to open output:iec958-ac3-surround-51
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:iec958-dts-surround-51+input:multichannel - will not be able to open output:iec958-dts-surround-51
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo+input:multichannel - will not be able to open output:hdmi-stereo
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround+input:multichannel - will not be able to open output:hdmi-surround
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71+input:multichannel - will not be able to open output:hdmi-surround71
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround+input:multichannel - will not be able to open output:hdmi-dts-surround
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra1+input:multichannel - will not be able to open output:hdmi-stereo-extra1
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra1+input:multichannel - will not be able to open output:hdmi-surround-extra1
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra1+input:multichannel - will not be able to open output:hdmi-surround71-extra1
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra1+input:multichannel - will not be able to open output:hdmi-dts-surround-extra1
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra2+input:multichannel - will not be able to open output:hdmi-stereo-extra2
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra2+input:multichannel - will not be able to open output:hdmi-surround-extra2
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra2+input:multichannel - will not be able to open output:hdmi-surround71-extra2
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra2+input:multichannel - will not be able to open output:hdmi-dts-surround-extra2
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra3+input:multichannel - will not be able to open output:hdmi-stereo-extra3
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra3+input:multichannel - will not be able to open output:hdmi-surround-extra3
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra3+input:multichannel - will not be able to open output:hdmi-surround71-extra3
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra3+input:multichannel - will not be able to open output:hdmi-dts-surround-extra3
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra4+input:multichannel - will not be able to open output:hdmi-stereo-extra4
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra4+input:multichannel - will not be able to open output:hdmi-surround-extra4
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra4+input:multichannel - will not be able to open output:hdmi-surround71-extra4
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra4+input:multichannel - will not be able to open output:hdmi-dts-surround-extra4
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra5+input:multichannel - will not be able to open output:hdmi-stereo-extra5
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra5+input:multichannel - will not be able to open output:hdmi-surround-extra5
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra5+input:multichannel - will not be able to open output:hdmi-surround71-extra5
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra5+input:multichannel - will not be able to open output:hdmi-dts-surround-extra5
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra6+input:multichannel - will not be able to open output:hdmi-stereo-extra6
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra6+input:multichannel - will not be able to open output:hdmi-surround-extra6
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra6+input:multichannel - will not be able to open output:hdmi-surround71-extra6
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra6+input:multichannel - will not be able to open output:hdmi-dts-surround-extra6
(  13.033|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-stereo-extra7+input:multichannel - will not be able to open output:hdmi-stereo-extra7
(  13.034|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround-extra7+input:multichannel - will not be able to open output:hdmi-surround-extra7
(  13.034|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-surround71-extra7+input:multichannel - will not be able to open output:hdmi-surround71-extra7
(  13.034|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile output:hdmi-dts-surround-extra7+input:multichannel - will not be able to open output:hdmi-dts-surround-extra7
(  13.034|   0.000) D: [pulseaudio] ratelimit.c: 1071 events suppressed
(  13.034|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(  13.034|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(  13.034|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(  13.034|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(  13.034|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(  13.034|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(  13.034|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(  13.034|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(  13.034|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(  13.034|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(  13.034|   0.000) D: [pulseaudio] flist.c: pulsecore/idxset.c: entries flist is full (don't worry)
(  13.035|   0.000) D: [pulseaudio] alsa-mixer.c: Profile set 0xeb7900, auto_profiles=yes, probed=yes, n_mappings=2, n_profiles=2, n_decibel_fixes=0
(  13.035|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping analog-stereo (Analog Stereo), priority=60, channel_map=front-left,front-right, supported=yes, direction=0
(  13.035|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping iec958-stereo (Digital Stereo (IEC958)), priority=55, channel_map=front-left,front-right, supported=yes, direction=0
(  13.035|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:analog-stereo (Analog Stereo Output), priority=6000, supported=yes n_input_mappings=0, n_output_mappings=1
(  13.035|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-stereo
(  13.035|   0.000) D: [pulseaudio] alsa-mixer.c: Profile output:iec958-stereo (Digital Stereo (IEC958) Output), priority=5500, supported=yes n_input_mappings=0, n_output_mappings=1
(  13.035|   0.000) D: [pulseaudio] alsa-mixer.c: Output iec958-stereo
(  13.035|   0.000) I: [pulseaudio] module-card-restore.c: Restored profile 'output:analog-stereo' for card alsa_card.usb-TOPPING_VX2-00.
(  13.035|   0.000) I: [pulseaudio] module-card-restore.c: Restoring port latency offsets for card alsa_card.usb-TOPPING_VX2-00.
(  13.035|   0.000) I: [pulseaudio] card.c: Created 5 "alsa_card.usb-TOPPING_VX2-00"
(  13.035|   0.000) D: [pulseaudio] module-alsa-card.c: Found 0 jacks.
(  13.036|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully create reservation lock monitor for device 'Audio5'
(  13.036|   0.000) D: [pulseaudio] alsa-util.c: Trying front:5 with SND_PCM_NO_AUTO_FORMAT ...
(  13.036|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:5
(  13.036|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(  13.036|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
(  18.037|   5.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  23.037|   5.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  28.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  33.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  33.037|   0.000) D: [pulseaudio] alsa-util.c: Set neither period nor buffer size.
(  38.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  38.037|   0.000) I: [pulseaudio] alsa-util.c: snd_pcm_hw_params failed: Input/output error
(  38.037|   0.000) D: [pulseaudio] alsa-util.c: Trying front:5 without SND_PCM_NO_AUTO_FORMAT ...
(  38.038|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:5
(  38.038|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(  38.038|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
(  43.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  48.037|   5.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  53.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  58.037|   5.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  58.037|   0.000) D: [pulseaudio] alsa-util.c: Set neither period nor buffer size.
(  63.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  63.037|   0.000) I: [pulseaudio] alsa-util.c: snd_pcm_hw_params failed: Input/output error
(  63.037|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:front:5 with SND_PCM_NO_AUTO_FORMAT ...
(  63.038|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:front:5
(  63.038|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(  63.038|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
(  68.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  73.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  78.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  83.037|   5.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  83.037|   0.000) D: [pulseaudio] alsa-util.c: Set neither period nor buffer size.
(  88.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  88.037|   0.000) I: [pulseaudio] alsa-util.c: snd_pcm_hw_params failed: Input/output error
(  88.037|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:front:5 without SND_PCM_NO_AUTO_FORMAT ...
(  88.038|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:front:5
(  88.038|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
(  88.038|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
(  93.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
(  98.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 103.037|   5.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 108.037|   5.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 108.037|   0.000) D: [pulseaudio] alsa-util.c: Set neither period nor buffer size.
( 113.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 113.037|   0.000) I: [pulseaudio] alsa-util.c: snd_pcm_hw_params failed: Input/output error
( 113.037|   0.000) I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:front:5: Input/output error
( 113.037|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:5 with SND_PCM_NO_AUTO_FORMAT ...
( 113.037|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:5
( 113.038|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
( 113.038|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
( 118.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 123.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 128.037|   5.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 133.037|   5.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 133.037|   0.000) D: [pulseaudio] alsa-util.c: Set neither period nor buffer size.
( 138.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 138.037|   0.000) I: [pulseaudio] alsa-util.c: snd_pcm_hw_params failed: Input/output error
( 138.037|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:5 without SND_PCM_NO_AUTO_FORMAT ...
( 138.038|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:5
( 138.038|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
( 138.038|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
( 143.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 148.037|   5.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 153.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 158.037|   5.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 158.037|   0.000) D: [pulseaudio] alsa-util.c: Set neither period nor buffer size.
( 163.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 163.037|   0.000) I: [pulseaudio] alsa-util.c: snd_pcm_hw_params failed: Input/output error
( 163.037|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:5 with SND_PCM_NO_AUTO_FORMAT ...
( 163.038|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:5
( 163.038|   0.000) I: [pulseaudio] alsa-util.c: Disabling tsched mode since BATCH flag is set
( 163.038|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 5944 ms
( 168.037|   4.999) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 173.037|   5.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 178.037|   5.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 179.944|   1.907) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 179.945|   0.000) D: [pulseaudio] alsa-util.c: Set neither period nor buffer size.
( 179.946|   0.001) I: [pulseaudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed (-5)
( 179.946|   0.000) I: [pulseaudio] alsa-util.c: snd_pcm_hw_params failed: Input/output error
( 179.946|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:5 without SND_PCM_NO_AUTO_FORMAT ...
( 179.946|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: Invalid value for card
( 179.946|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM device plug:hw:5: No such file or directory
( 179.947|   0.000) I: [pulseaudio] module.c: Loaded "module-alsa-card" (index: #24; argument: "device_id="5" name="usb-TOPPING_VX2-00" card_name="alsa_card.usb-TOPPING_VX2-00" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1"").
( 179.947|   0.000) I: [pulseaudio] module-udev-detect.c: Card /devices/pci0000:00/0000:00:14.0/usb1/1-14/1-14:1.0/sound/card5 (alsa_card.usb-TOPPING_VX2-00) module loaded.
( 179.948|   0.000) I: [pulseaudio] module-suspend-on-idle.c: Source alsa_input.pci-0000_00_1b.0.analog-stereo idle for too long, suspending ...
( 179.948|   0.000) D: [pulseaudio] source.c: Suspend cause of source alsa_input.pci-0000_00_1b.0.analog-stereo is 0x0004, suspending
( 179.948|   0.000) I: [alsa-source-ALC1150 Analog] alsa-source.c: Device suspended...
( 179.948|   0.000) D: [pulseaudio] core.c: Hmm, no streams around, trying to vacuum.
( 179.948|   0.000) I: [pulseaudio] module-suspend-on-idle.c: Source alsa_input.usb-0d8c_C-Media_USB_Audio_Device-00.analog-mono idle for too long, suspending ...
( 179.948|   0.000) D: [pulseaudio] source.c: Suspend cause of source alsa_input.usb-0d8c_C-Media_USB_Audio_Device-00.analog-mono is 0x0004, suspending
( 179.953|   0.004) I: [alsa-source-USB Audio] alsa-source.c: Device suspended...
( 179.953|   0.000) D: [pulseaudio] core.c: Hmm, no streams around, trying to vacuum.
( 179.953|   0.000) I: [pulseaudio] module-suspend-on-idle.c: Source alsa_input.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02.iec958-stereo idle for too long, suspending ...
( 179.953|   0.000) D: [pulseaudio] source.c: Suspend cause of source alsa_input.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02.iec958-stereo is 0x0004, suspending
( 179.955|   0.001) I: [alsa-source-USB Audio] alsa-source.c: Device suspended...
( 179.955|   0.000) D: [pulseaudio] core.c: Hmm, no streams around, trying to vacuum.
( 179.955|   0.000) I: [pulseaudio] module-suspend-on-idle.c: Sink alsa_output.pci-0000_00_1b.0.iec958-stereo idle for too long, suspending ...
( 179.955|   0.000) D: [pulseaudio] sink.c: Suspend cause of sink alsa_output.pci-0000_00_1b.0.iec958-stereo is 0x0004, suspending
( 179.956|   0.000) I: [alsa-sink-ALC1150 Digital] alsa-sink.c: Device suspended...
( 179.956|   0.000) D: [pulseaudio] core.c: Hmm, no streams around, trying to vacuum.
( 179.957|   0.000) I: [pulseaudio] module-suspend-on-idle.c: Sink alsa_output.usb-0d8c_C-Media_USB_Audio_Device-00.analog-stereo idle for too long, suspending ...
( 179.957|   0.000) D: [pulseaudio] sink.c: Suspend cause of sink alsa_output.usb-0d8c_C-Media_USB_Audio_Device-00.analog-stereo is 0x0004, suspending
( 179.961|   0.004) I: [alsa-sink-USB Audio] alsa-sink.c: Device suspended...
( 179.961|   0.000) D: [pulseaudio] core.c: Hmm, no streams around, trying to vacuum.
( 179.961|   0.000) I: [pulseaudio] module-suspend-on-idle.c: Sink alsa_output.usb-Yoyodyne_Consulting_ODAC-revB-01.iec958-stereo idle for too long, suspending ...
( 179.961|   0.000) D: [pulseaudio] sink.c: Suspend cause of sink alsa_output.usb-Yoyodyne_Consulting_ODAC-revB-01.iec958-stereo is 0x0004, suspending
( 179.963|   0.001) I: [alsa-sink-USB Audio] alsa-sink.c: Device suspended...
( 179.963|   0.000) D: [pulseaudio] core.c: Hmm, no streams around, trying to vacuum.
( 179.963|   0.000) I: [pulseaudio] module-suspend-on-idle.c: Sink alsa_output.pci-0000_06_00.1.hdmi-stereo idle for too long, suspending ...
( 179.963|   0.000) D: [pulseaudio] sink.c: Suspend cause of sink alsa_output.pci-0000_06_00.1.hdmi-stereo is 0x0004, suspending
( 179.969|   0.005) I: [alsa-sink-HDMI 0] alsa-sink.c: Device suspended...
( 179.969|   0.000) D: [pulseaudio] core.c: Hmm, no streams around, trying to vacuum.
( 179.969|   0.000) I: [pulseaudio] client.c: Created 3 "Native client (UNIX socket client)"
( 179.969|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC1 is accessible: yes
( 179.969|   0.000) D: [pulseaudio] module-udev-detect.c: Resuming all sinks and sources of card alsa_card.pci-0000_06_00.1.
( 179.969|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC3 is accessible: yes
( 179.969|   0.000) D: [pulseaudio] module-udev-detect.c: Resuming all sinks and sources of card alsa_card.usb-Yoyodyne_Consulting_ODAC-revB-01.
( 179.969|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC2 is accessible: yes
( 179.969|   0.000) D: [pulseaudio] module-udev-detect.c: Resuming all sinks and sources of card alsa_card.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02.
( 179.969|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC4 is accessible: yes
( 179.969|   0.000) D: [pulseaudio] module-udev-detect.c: Resuming all sinks and sources of card alsa_card.usb-0d8c_C-Media_USB_Audio_Device-00.
( 179.969|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC0 is accessible: yes
( 179.969|   0.000) D: [pulseaudio] module-udev-detect.c: Resuming all sinks and sources of card alsa_card.pci-0000_00_1b.0.
( 179.970|   0.000) D: [pulseaudio] module-udev-detect.c: /dev/snd/controlC5 is accessible: no
( 179.970|   0.000) D: [pulseaudio] module-udev-detect.c: Suspending all sinks and sources of card alsa_card.usb-TOPPING_VX2-00.
( 179.970|   0.000) I: [pulseaudio] main.c: Got signal SIGINT.
( 179.970|   0.000) I: [pulseaudio] main.c: Exiting.
( 179.970|   0.000) I: [pulseaudio] main.c: Daemon shutdown initiated.
( 179.970|   0.000) I: [pulseaudio] module.c: Unloading "module-alsa-card" (index: #24).
( 179.970|   0.000) I: [pulseaudio] card.c: Freed 5 "alsa_card.usb-TOPPING_VX2-00"
( 179.970|   0.000) D: [pulseaudio] ratelimit.c: 209 events suppressed
( 179.970|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c: entries flist is full (don't worry)
( 179.970|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c: entries flist is full (don't worry)
( 179.970|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c: entries flist is full (don't worry)
( 179.970|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c: entries flist is full (don't worry)
( 179.970|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c: entries flist is full (don't worry)
( 179.970|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c: entries flist is full (don't worry)
( 179.970|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c: entries flist is full (don't worry)
( 179.970|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c: entries flist is full (don't worry)
( 179.970|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c: entries flist is full (don't worry)
( 179.970|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c: entries flist is full (don't worry)
( 179.970|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c: entries flist is full (don't worry)
( 179.970|   0.000) I: [pulseaudio] module.c: Unloaded "module-alsa-card" (index: #24).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloading "module-filter-apply" (index: #23).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloaded "module-filter-apply" (index: #23).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloading "module-filter-heuristics" (index: #22).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloaded "module-filter-heuristics" (index: #22).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloading "module-position-event-sounds" (index: #21).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloaded "module-position-event-sounds" (index: #21).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloading "module-systemd-login" (index: #20).
( 179.970|   0.000) D: [pulseaudio] module-systemd-login.c: Removing session c2
( 179.970|   0.000) I: [pulseaudio] client.c: Freed 0 "Login Session c2"
( 179.970|   0.000) I: [pulseaudio] module.c: Unloaded "module-systemd-login" (index: #20).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloading "module-suspend-on-idle" (index: #19).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloaded "module-suspend-on-idle" (index: #19).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloading "module-intended-roles" (index: #18).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloaded "module-intended-roles" (index: #18).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloading "module-always-sink" (index: #17).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloaded "module-always-sink" (index: #17).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloading "module-rescue-streams" (index: #16).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloaded "module-rescue-streams" (index: #16).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloading "module-default-device-restore" (index: #15).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloaded "module-default-device-restore" (index: #15).
( 179.970|   0.000) I: [pulseaudio] module.c: Unloading "module-native-protocol-unix" (index: #14).
( 179.971|   0.000) I: [pulseaudio] client.c: Freed 1 "GNOME Volume Control Media Keys"
( 179.971|   0.000) I: [pulseaudio] client.c: Freed 2 "Ubuntu Audio Settings"
( 179.971|   0.000) I: [pulseaudio] client.c: Freed 3 "Native client (UNIX socket client)"
( 179.971|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to remove event.
( 179.971|   0.000) I: [pulseaudio] module.c: Unloaded "module-native-protocol-unix" (index: #14).
( 179.971|   0.000) I: [pulseaudio] module.c: Unloading "module-bluez5-discover" (index: #13).
( 179.971|   0.000) I: [pulseaudio] module.c: Unloaded "module-bluez5-discover" (index: #13).
( 179.971|   0.000) I: [pulseaudio] module.c: Unloading "module-bluetooth-discover" (index: #12).
( 179.971|   0.000) I: [pulseaudio] module.c: Unloaded "module-bluetooth-discover" (index: #12).
( 179.971|   0.000) I: [pulseaudio] module.c: Unloading "module-bluetooth-policy" (index: #11).
( 179.971|   0.000) I: [pulseaudio] module.c: Unloaded "module-bluetooth-policy" (index: #11).
( 179.971|   0.000) I: [pulseaudio] module.c: Unloading "module-alsa-card" (index: #10).
( 179.971|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to remove event.
( 179.971|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to remove event.
( 179.971|   0.000) D: [alsa-sink-ALC1150 Digital] alsa-sink.c: Thread shutting down
( 179.971|   0.000) I: [pulseaudio] sink.c: Freeing sink 3 "alsa_output.pci-0000_00_1b.0.iec958-stereo"
( 179.971|   0.000) I: [pulseaudio] source.c: Freeing source 5 "alsa_output.pci-0000_00_1b.0.iec958-stereo.monitor"
( 179.972|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to remove event.
( 179.972|   0.000) D: [alsa-source-ALC1150 Analog] alsa-source.c: Thread shutting down
( 179.972|   0.000) I: [pulseaudio] source.c: Freeing source 6 "alsa_input.pci-0000_00_1b.0.analog-stereo"
( 179.972|   0.000) I: [pulseaudio] card.c: Freed 4 "alsa_card.pci-0000_00_1b.0"
( 179.972|   0.000) I: [pulseaudio] module.c: Unloaded "module-alsa-card" (index: #10).
( 179.973|   0.000) I: [pulseaudio] module.c: Unloading "module-alsa-card" (index: #9).
( 179.973|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to remove event.
( 179.973|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to remove event.
( 179.973|   0.000) D: [alsa-sink-USB Audio] alsa-sink.c: Thread shutting down
( 179.973|   0.000) I: [pulseaudio] sink.c: Freeing sink 2 "alsa_output.usb-0d8c_C-Media_USB_Audio_Device-00.analog-stereo"
( 179.973|   0.000) I: [pulseaudio] source.c: Freeing source 3 "alsa_output.usb-0d8c_C-Media_USB_Audio_Device-00.analog-stereo.monitor"
( 179.973|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to change event.
( 179.973|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to remove event.
( 179.973|   0.000) D: [alsa-source-USB Audio] alsa-source.c: Thread shutting down
( 179.973|   0.000) I: [pulseaudio] source.c: Freeing source 4 "alsa_input.usb-0d8c_C-Media_USB_Audio_Device-00.analog-mono"
( 179.973|   0.000) I: [pulseaudio] card.c: Freed 3 "alsa_card.usb-0d8c_C-Media_USB_Audio_Device-00"
( 179.973|   0.000) I: [pulseaudio] module.c: Unloaded "module-alsa-card" (index: #9).
( 179.973|   0.000) I: [pulseaudio] module.c: Unloading "module-alsa-card" (index: #8).
( 179.974|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to remove event.
( 179.974|   0.000) D: [alsa-source-USB Audio] alsa-source.c: Thread shutting down
( 179.974|   0.000) I: [pulseaudio] source.c: Freeing source 2 "alsa_input.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02.iec958-stereo"
( 179.974|   0.000) I: [pulseaudio] card.c: Freed 2 "alsa_card.usb-046d_HD_Pro_Webcam_C920_9DADF56F-02"
( 179.974|   0.000) I: [pulseaudio] module.c: Unloaded "module-alsa-card" (index: #8).
( 179.974|   0.000) I: [pulseaudio] module.c: Unloading "module-alsa-card" (index: #7).
( 179.974|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to remove event.
( 179.974|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to remove event.
( 179.974|   0.000) D: [alsa-sink-USB Audio] alsa-sink.c: Thread shutting down
( 179.974|   0.000) I: [pulseaudio] sink.c: Freeing sink 1 "alsa_output.usb-Yoyodyne_Consulting_ODAC-revB-01.iec958-stereo"
( 179.974|   0.000) I: [pulseaudio] source.c: Freeing source 1 "alsa_output.usb-Yoyodyne_Consulting_ODAC-revB-01.iec958-stereo.monitor"
( 179.974|   0.000) I: [pulseaudio] card.c: Freed 1 "alsa_card.usb-Yoyodyne_Consulting_ODAC-revB-01"
( 179.974|   0.000) I: [pulseaudio] module.c: Unloaded "module-alsa-card" (index: #7).
( 179.974|   0.000) I: [pulseaudio] module.c: Unloading "module-alsa-card" (index: #6).
( 179.975|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to remove event.
( 179.975|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant event due to remove event.
( 179.975|   0.000) D: [alsa-sink-HDMI 0] alsa-sink.c: Thread shutting down
( 179.975|   0.000) I: [pulseaudio] sink.c: Freeing sink 0 "alsa_output.pci-0000_06_00.1.hdmi-stereo"
( 179.975|   0.000) I: [pulseaudio] source.c: Freeing source 0 "alsa_output.pci-0000_06_00.1.hdmi-stereo.monitor"
( 179.975|   0.000) I: [pulseaudio] card.c: Freed 0 "alsa_card.pci-0000_06_00.1"
( 179.976|   0.000) I: [pulseaudio] module.c: Unloaded "module-alsa-card" (index: #6).
( 179.976|   0.000) I: [pulseaudio] module.c: Unloading "module-udev-detect" (index: #5).
( 179.976|   0.000) I: [pulseaudio] module.c: Unloaded "module-udev-detect" (index: #5).
( 179.976|   0.000) I: [pulseaudio] module.c: Unloading "module-switch-on-port-available" (index: #4).
( 179.976|   0.000) I: [pulseaudio] module.c: Unloaded "module-switch-on-port-available" (index: #4).
( 179.976|   0.000) I: [pulseaudio] module.c: Unloading "module-augment-properties" (index: #3).
( 179.976|   0.000) I: [pulseaudio] module.c: Unloaded "module-augment-properties" (index: #3).
( 179.976|   0.000) I: [pulseaudio] module.c: Unloading "module-card-restore" (index: #2).
( 179.976|   0.000) I: [pulseaudio] module.c: Unloaded "module-card-restore" (index: #2).
( 179.976|   0.000) I: [pulseaudio] module.c: Unloading "module-stream-restore" (index: #1).
( 179.976|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1 removed from object /org/pulseaudio/stream_restore1
( 179.976|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object /org/pulseaudio/stream_restore1/entry0
( 179.976|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object /org/pulseaudio/stream_restore1/entry1
( 179.976|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object /org/pulseaudio/stream_restore1/entry2
( 179.976|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object /org/pulseaudio/stream_restore1/entry3
( 179.976|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object /org/pulseaudio/stream_restore1/entry4
( 179.977|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object /org/pulseaudio/stream_restore1/entry5
( 179.977|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object /org/pulseaudio/stream_restore1/entry6
( 179.977|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object /org/pulseaudio/stream_restore1/entry7
( 179.977|   0.000) D: [pulseaudio] protocol-dbus.c: Interface org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object /org/pulseaudio/stream_restore1/entry8
( 179.977|   0.000) I: [pulseaudio] module.c: Unloaded "module-stream-restore" (index: #1).
( 179.977|   0.000) I: [pulseaudio] module.c: Unloading "module-device-restore" (index: #0).
( 179.977|   0.000) I: [pulseaudio] module.c: Unloaded "module-device-restore" (index: #0).
( 179.977|   0.000) I: [pulseaudio] main.c: Daemon terminated.

--------------080700050906060100010905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080700050906060100010905--
