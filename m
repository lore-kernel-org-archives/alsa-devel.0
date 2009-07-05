From: Karl Kleinpaste <karl@kleinpaste.org>
Subject: pulseaudio complains of bad pcm delay values
Date: Sun, 05 Jul 2009 09:24:08 -0400
Message-ID: <vxkab3j2rgn.fsf@awol.kleinpaste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mesquite.kleinpaste.org (ZIMBS2.SRV.CS.CMU.EDU [128.2.220.246])
	by alsa0.perex.cz (Postfix) with ESMTP id B36A92414C
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 15:24:13 +0200 (CEST)
Received: from awol.kleinpaste.org.kleinpaste.org (localhost [127.0.0.1])
	by mesquite.kleinpaste.org (8.14.2/8.14.2) with ESMTP id n65DO8p4006433
	for <alsa-devel@alsa-project.org>; Sun, 5 Jul 2009 09:24:10 -0400
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

I'm sending this somewhat blindly, due to messages from the nightly log
summary.  I'm just cut/pasting what is there.  It says "report this to
alsa developers," but it would have been kinda cool if somebody would
have included a definite address to which such a report should be sent.

(First try, I sent this to alsa-devel@sourceforge.  Got a bounce about
the list having moved.  Resending as indicated.  No, I'm not subscribing
to the list.  Sorry, but I'm offering a bug report per request, not
trying to engage in general devel conversation on this topic.)

Hardware is a Toshiba Satellite P205 series, with this sound hardware:

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 03)
        Subsystem: Toshiba America Info Systems Device ff00
        Flags: bus master, fast devsel, latency 0, IRQ 22
        Memory at f8500000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] MSI: Mask- 64bit+ Count=1/1 Enable-
        Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [130] Root Complex Link <?>
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel

This is Fedora11, 2.6.29.5-191.fc11.i686.PAE (32-bit, obviously).

Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c: snd_pcm_delay() returned a value that is exceptionally large: 1480877280 bytes (8394995 ms).
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c: Most likely this is a bug in the ALSA driver 'snd_hda_intel'. Please report this issue to the ALSA developers.
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c: snd_pcm_dump():
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c: Soft volume PCM
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c: Control: PCM Playback Volume
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c: min_dB: -51
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c: max_dB: 0
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c: resolution: 256
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c: Its setup is:
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   stream       : CAPTURE
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   access       : MMAP_INTERLEAVED
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   format       : S16_LE
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   subformat    : STD
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   channels     : 2
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   rate         : 44100
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   exact rate   : 44100 (44100/1)
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   msbits       : 16
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   buffer_size  : 88192
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   period_size  : 44096
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   period_time  : 999909
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   tstamp_mode  : ENABLE
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   period_step  : 1
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   avail_min    : 87310
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   period_event : 0
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   start_threshold  : -1
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   stop_threshold   : 1444937728
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   silence_threshold: 0
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   silence_size : 0
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   boundary     : 1444937728
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c: Slave: Hardware PCM card 0 'HDA Intel' device 0 subdevice 0
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c: Its setup is:
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   stream       : CAPTURE
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   access       : MMAP_INTERLEAVED
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   format       : S16_LE
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   subformat    : STD
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   channels     : 2
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   rate         : 44100
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   exact rate   : 44100 (44100/1)
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   msbits       : 16
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   buffer_size  : 88192
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   period_size  : 44096
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   period_time  : 999909
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   tstamp_mode  : ENABLE
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   period_step  : 1
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   avail_min    : 87310
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   period_event : 0
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   start_threshold  : -1
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   stop_threshold   : 1444937728
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   silence_threshold: 0
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   silence_size : 0
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   boundary     : 1444937728
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   appl_ptr     : 932488
Jul  4 09:20:35 awol pulseaudio[2835]: alsa-util.c:   hw_ptr       : 1444893632
Jul  4 09:20:40 awol pulseaudio[2835]: ratelimit.c: 1106 events suppressed
Jul  4 09:20:45 awol pulseaudio[2835]: cpulimit.c: Received request to terminate due to CPU overload.
Jul  4 09:20:47 awol pulseaudio[2835]: memblock.c: Memory pool destroyed but not all memory blocks freed! 236 remain.
Jul  4 09:26:13 awol pulseaudio[17025]: alsa-sink.c: Increasing minimal latency to 1.00 ms
Jul  4 09:26:13 awol pulseaudio[17025]: alsa-sink.c: Increasing minimal latency to 2.00 ms
Jul  4 09:36:02 awol pulseaudio[17025]: alsa-source.c: Increasing minimal latency to 1.00 ms
Jul  4 09:36:02 awol pulseaudio[17025]: alsa-source.c: Increasing minimal latency to 2.00 ms
Jul  4 09:36:03 awol pulseaudio[17025]: alsa-source.c: Increasing minimal latency to 4.00 ms
Jul  4 09:36:08 awol pulseaudio[17025]: alsa-source.c: Increasing minimal latency to 8.00 ms
Jul  4 09:36:09 awol pulseaudio[17025]: alsa-source.c: Increasing minimal latency to 16.00 ms
Jul  4 09:36:11 awol pulseaudio[17025]: alsa-source.c: Increasing minimal latency to 26.00 ms
Jul  4 09:36:12 awol pulseaudio[17025]: alsa-source.c: Increasing wakeup watermark to 15.99 ms
Jul  4 09:36:14 awol pulseaudio[17025]: alsa-source.c: Increasing minimal latency to 36.00 ms
Jul  4 09:36:26 awol pulseaudio[17025]: alsa-source.c: Increasing wakeup watermark to 25.99 ms
Jul  4 09:36:33 awol pulseaudio[17025]: alsa-source.c: Increasing minimal latency to 46.00 ms
Jul  4 09:36:44 awol pulseaudio[17025]: alsa-source.c: Increasing wakeup watermark to 35.99 ms
Jul  4 09:38:48 awol pulseaudio[17025]: alsa-source.c: Increasing minimal latency to 56.00 ms
