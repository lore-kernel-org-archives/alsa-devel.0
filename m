From: Darsen Lu <darsenlu@gmail.com>
Subject: ALSA Driver 1.0.22.1
Date: Sun, 7 Feb 2010 03:20:35 -0500
Message-ID: <c75a76611002070020v245a4edckb6b85dbd187365db@mail.gmail.com>
Reply-To: darsen@berkeley.edu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f198.google.com (mail-pz0-f198.google.com
	[209.85.222.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 50195243A0
	for <alsa-devel@alsa-project.org>; Sun,  7 Feb 2010 09:20:37 +0100 (CET)
Received: by pzk36 with SMTP id 36so5691263pzk.23
	for <alsa-devel@alsa-project.org>; Sun, 07 Feb 2010 00:20:36 -0800 (PST)
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

I just installed alsa-drivers 1.0.22.1 (the latest version to my
understanding) on Ubuntu 9.10.

After that I started noticing conflicts between different sound-playback
applications.
For example, if I watch a Flash video on Firefox, stop it, and then start
playing an MP3 file on Totem (a Media Player), I don't hear any sound.
Once I close Firefox the music from Totem starts coming out.
This never happened before on my Linux system. I'd be very grateful if
someone could give me advices!


My /var/log/syslog shows the following whenever this happens:

Feb  7 02:42:36 darsen-laptop pulseaudio[1789]: alsa-sink.c: Error opening
PCM device front:0: Device or resource busy
Feb  7 02:42:36 darsen-laptop pulseaudio[1789]: alsa-sink.c: Error opening
PCM device front:0: Device or resource busy


I also noticed the following message during bootup and was asked to report
this issue to ALSA Developers.

Feb  7 02:17:31 darsen-laptop pulseaudio[1789]: ratelimit.c: 179 events
suppressed
Feb  7 02:17:35 darsen-laptop pulseaudio[1789]: alsa-sink.c: ALSA woke us up
to write new data to the device, but there was actually nothing to write!
Feb  7 02:17:35 darsen-laptop pulseaudio[1789]: alsa-sink.c: Most likely
this is a bug in the ALSA driver 'snd_hda_intel'. Please report this issue
to the ALSA developers.
Feb  7 02:17:35 darsen-laptop pulseaudio[1789]: alsa-sink.c: We were woken
up with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or
another value < min_avail.
Feb  7 02:17:36 darsen-laptop pulseaudio[1789]: ratelimit.c: 182 events
suppressed


The good news is my microphone started working with the newly-installed ALSA
drivers (It did not work with ALSA v1.0.20)


My Linux kernel version is 2.6.31-19.general.  I installed it using the
Ubuntu Package Manager.
On the other hand the ALSA driver was compiled from source code.  ALSA was
configured with the following options
           sudo ./configure -with-kernel=/usr/src/linux-headers-`uname -r`
--with-cards=hda-intel


"lspci -v" shows the following

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio
Controller (rev 03)
    Subsystem: Dell Device 02cf
    Flags: bus master, fast devsel, latency 0, IRQ 31
    Memory at f6afc000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: <access denied>
    Kernel driver in use: HDA Intel
    Kernel modules: snd-hda-intel


I confirmed that the correct version of driver was loaded into the kernel by
typing "cat /proc/asound/version":

Advanced Linux Sound Architecture Driver Version 1.0.22.1.
Compiled on Feb  7 2010 for kernel 2.6.31-19-generic (SMP).

Thanks,
Darsen
