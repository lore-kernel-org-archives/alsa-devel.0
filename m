From: "Jason E. Aten" <j.e.aten@gmail.com>
Subject: syslog requested reporting this to ALSA developers
 (ubuntu 10.04 inside virtualbox)
Date: Thu, 17 Mar 2011 14:14:30 -0500
Message-ID: <AANLkTingNU5fuLRQ0+-_ugqRtqdj8bd_-MWhaP3Ag5-h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DD181037F5
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 20:14:32 +0100 (CET)
Received: by wyj26 with SMTP id 26so2844436wyj.38
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 12:14:31 -0700 (PDT)
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

from my syslog, it requests a report to ALSA developers. Let me know if I
can provide further assistance. -Jason

$ tail /var/log/syslog
Mar 17 13:58:25 virtub pulseaudio[1038]: alsa-source.c: ALSA woke us up to
read new data from the device, but there was actually nothing to read!
Mar 17 13:58:25 virtub pulseaudio[1038]: alsa-source.c: Most likely this is
a bug in the ALSA driver 'snd_intel8x0'. Please report this issue to the
ALSA developers.
Mar 17 13:58:25 virtub pulseaudio[1038]: alsa-source.c: We were woken up
with POLLIN set -- however a subsequent snd_pcm_avail() returned 0 or
another value < min_avail.
Mar 17 13:58:26 virtub pulseaudio[1038]: alsa-sink.c: ALSA woke us up to
write new data to the device, but there was actually nothing to write!
Mar 17 13:58:26 virtub pulseaudio[1038]: alsa-sink.c: Most likely this is a
bug in the ALSA driver 'snd_intel8x0'. Please report this issue to the ALSA
developers.
Mar 17 13:58:26 virtub pulseaudio[1038]: alsa-sink.c: We were woken up with
POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or another
value < min_avail.
Mar 17 13:58:29 virtub gdm-session-worker[1030]: GLib-GObject-CRITICAL:
g_value_get_boolean: assertion `G_VALUE_HOLDS_BOOLEAN (value)' failed
Mar 17 13:58:35 virtub rtkit-daemon[1043]: Sucessfully made thread 1256 of
process 1256 (n/a) owned by '1000' high priority at nice level -11.
Mar 17 13:58:35 virtub rtkit-daemon[1043]: Supervising 4 threads of 2
processes of 2 users.
Mar 17 13:58:35 virtub pulseaudio[1256]: alsa-util.c: Disabling timer-based
scheduling because running inside a VM.
Mar 17 13:58:35 virtub rtkit-daemon[1043]: Sucessfully made thread 1257 of
process 1256 (n/a) owned by '1000' RT at priority 5.
Mar 17 13:58:35 virtub rtkit-daemon[1043]: Supervising 5 threads of 2
processes of 2 users.
Mar 17 13:58:35 virtub pulseaudio[1256]: alsa-util.c: Disabling timer-based
scheduling because running inside a VM.
Mar 17 13:58:35 virtub rtkit-daemon[1043]: Sucessfully made thread 1258 of
process 1256 (n/a) owned by '1000' RT at priority 5.
Mar 17 13:58:35 virtub rtkit-daemon[1043]: Supervising 6 threads of 2
processes of 2 users.
Mar 17 13:58:35 virtub pulseaudio[1256]: alsa-sink.c: ALSA woke us up to
write new data to the device, but there was actually nothing to write!
Mar 17 13:58:35 virtub pulseaudio[1256]: alsa-sink.c: Most likely this is a
bug in the ALSA driver 'snd_intel8x0'. Please report this issue to the ALSA
developers.
Mar 17 13:58:35 virtub pulseaudio[1256]: alsa-sink.c: We were woken up with
POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or another
value < min_avail.
Mar 17 13:59:40 virtub AptDaemon: INFO: Initializing daemon

root@virtub:/var/log# uname -a
Linux virtub 2.6.32-29-generic #58-Ubuntu SMP Fri Feb 11 20:52:10 UTC 2011
x86_64 GNU/Linux

root@virtub:/var/log# dpkg -s pulseaudio
Package: pulseaudio
Status: install ok installed
Priority: optional
Section: sound
Installed-Size: 4540
Maintainer: Ubuntu Core Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: amd64
Version: 1:0.9.22~0.9.21+stable-queue-32-g8478-0ubuntu14
Replaces: pulseaudio-module-hal, pulseaudio-module-rygel-media-server (<<
1:0.9.22~0.9.21+stable-queue-32-g8478-0ubuntu14), pulseaudio-module-udev (<<
1:0.9.22~0.9.21+stable-qu\
eue-32-g8478-0ubuntu14)
Provides: pulseaudio-module-hal, pulseaudio-module-rygel-media-server,
pulseaudio-module-udev
Depends: libasound2 (>> 1.0.22), libc6 (>= 2.9), libdbus-1-3 (>= 1.0.2),
libice6 (>= 1:1.0.0), libltdl7 (>= 2.2.6b), libpulse0 (=
1:0.9.22~0.9.21+stable-queue-32-g8478-0ubuntu1\
4), libsamplerate0, libsm6, libsndfile1 (>= 1.0.20), libspeexdsp1 (>=
1.2~beta3.2-1), libtdb1 (>= 1.1.2~git20080520), libudev0 (>= 147), libx11-6
(>= 0), libxtst6, adduser, lsb\
-base (>= 3), consolekit, libasound2-plugins, pulseaudio-utils
Recommends: pulseaudio-module-x11, gstreamer0.10-pulseaudio,
pulseaudio-esound-compat, rtkit
Suggests: pavumeter, paman, paprefs
Conflicts: libltdl3 (<< 1.5.24-1), pulseaudio-module-rygel-media-server (<<
1:0.9.22~0.9.21+stable-queue-32-g8478-0ubuntu14), pulseaudio-module-udev (<<
1:0.9.22~0.9.21+stable-\
queue-32-g8478-0ubuntu14)
Conffiles:
 /etc/default/pulseaudio 5ac1e3004508adbb816e9b1af352617e
 /etc/init.d/pulseaudio bd6ccc065d494d8baac1d823521833b4
 /etc/pulse/default.pa d2d623c97aef9f81f5b55f2d7e736c87
 /etc/pulse/system.pa 182fbc3ba3449027c4d1e39a150c8396
 /etc/pulse/daemon.conf ed3746b9cd3ba486184128fd611b73c9
 /etc/dbus-1/system.d/pulseaudio-system.conf
69d56dc5342bf589a2e199541709a452
 /etc/xdg/autostart/pulseaudio.desktop 1310d377ad0d534f699e864037f66bd2
Description: PulseAudio sound server
 PulseAudio, previously known as Polypaudio, is a sound server for POSIX and
 WIN32 systems. It is a drop in replacement for the ESD sound server with
 much better latency, mixing/re-sampling quality and overall architecture.
 .
 These are some of PulseAudio's features:
 .
   * High quality software mixing of multiple audio streams with support for
     more than one sink/source. May be used to combine multiple sound cards
     into one (with sample rate adjustment).
 .
   * Wide range of supported client libraries. ESD, ALSA, oss, libao and
     GStreamer client applications are supported as-is. Native PulseAudio
     plug-ins are also available for xmms and mplayer.
 .
   * Good low latency behaviour and very accurate latency measurement for
     playback and recording. Ability to fully synchronize multiple playback
     streams.
 .
   * Network transparency, allowing an application to play back or record
     audio on a different machine than the one it is running on.
 .
   * Extensible plug-in architecture with plug-ins for jackd, multicast-rtp
     lirc and avahi, just to name a few.
 .
 This package contains the daemon and basic module set.
Homepage: http://www.pulseaudio.org
Original-Maintainer: Pulseaudio maintenance team <
pkg-pulseaudio-devel@lists.alioth.debian.org>
root@virtub:/var/log#
