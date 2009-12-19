From: Chris <cpollock@embarqmail.com>
Subject: alsa-util.c: snd_pcm_avail() returned a value that is
 exceptionally large: 349696 bytes (1821 ms).
Date: Fri, 18 Dec 2009 21:02:46 -0600
Message-ID: <1261191766.18070.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay.embarq.synacor.com (mailrelay.embarq.synacor.com
	[208.47.184.3]) by alsa0.perex.cz (Postfix) with ESMTP id 6B1741037F9
	for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2009 04:02:49 +0100 (CET)
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

Mandriva 2010.0, Gnome 2.28, pulseaudio
0.9.19-7mdv2010.0. With pulseaudio enabled in MCC periodically the hd
light will constantly be on for a period of 4 or 5 minutes and system will slow
down to a crawl. Also these comments will be in syslog:

pulseaudio[4331]: alsa-util.c: snd_pcm_avail() returned a value that is
exceptionally large: 349696 bytes (1821 ms).
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c: Most likely this is a
bug in the ALSA driver 'snd_via82xx'. Please report this issue to the ALSA
developers.
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c: snd_pcm_dump():
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c: Hardware PCM card 1
'VIA 8237' device 0 subdevice 0
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c: Its setup is:
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   stream       :
PLAYBACK
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   access       :
MMAP_INTERLEAVED
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   format       :
S16_LE
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   subformat    : STD
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   channels     : 2
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   rate         : 48000
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   exact rate   : 48000
(48000/1)
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   msbits       : 16
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   buffer_size  : 16384
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   period_size  : 8192
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   period_time  :
170666
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   tstamp_mode  :
ENABLE
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   period_step  : 1
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   avail_min    : 9665
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   period_event : 0
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   start_threshold  :
-1
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   stop_threshold   :
1073741824
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   silence_threshold: 0
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   silence_size : 0
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   boundary     :
1073741824
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   appl_ptr     :
767919576
Dec 14 20:26:29 localhost pulseaudio[4331]: alsa-util.c:   hw_ptr       :
767990616
Dec 14 20:26:29 localhost pulseaudio[4331]: ratelimit.c: 7 events suppressed
Dec 14 20:26:31 localhost pulseaudio[4331]: asyncq.c: q overrun, queuing
locally

I also see this quite frequently:

Dec 14 20:15:29 localhost pulseaudio[4331]: asyncq.c: q overrun, queuing
locally
Dec 14 20:15:34 localhost pulseaudio[4331]: ratelimit.c: 657 events suppressed
Dec 14 20:15:34 localhost pulseaudio[4331]: asyncq.c: q overrun, queuing
locally
Dec 14 20:15:39 localhost pulseaudio[4331]: ratelimit.c: 2508 events suppressed
Dec 14 20:15:39 localhost pulseaudio[4331]: asyncq.c: q overrun, queuing
locally
Dec 14 20:15:44 localhost pulseaudio[4331]: ratelimit.c: 3530 events suppressed
Dec 14 20:15:44 localhost pulseaudio[4331]: asyncq.c: q overrun, queuing
locally
Dec 14 20:15:44 localhost pulseaudio[4331]: asyncq.c: q overrun, queuing
locally
Dec 14 20:15:49 localhost pulseaudio[4331]: ratelimit.c: 2672 events suppressed
Dec 14 20:15:49 localhost pulseaudio[4331]: asyncq.c: q overrun, queuing
locally
Dec 14 20:16:05 localhost pulseaudio[4331]: ratelimit.c: 2244 events suppressed
Dec 14 20:16:18 localhost pulseaudio[4331]: ratelimit.c: 1 events suppressed
Dec 14 20:16:23 localhost pulseaudio[4331]: ratelimit.c: 1 events suppressed
Dec 14 20:16:34 localhost pulseaudio[4331]: ratelimit.c: 5 events suppressed
Dec 14 20:16:39 localhost pulseaudio[4331]: ratelimit.c: 9 events suppressed
Dec 14 20:16:45 localhost pulseaudio[4331]: ratelimit.c: 11 events suppressed
Dec 14 20:16:50 localhost pulseaudio[4331]: ratelimit.c: 13 events suppressed
Dec 14 20:16:55 localhost pulseaudio[4331]: ratelimit.c: 16 events suppressed
Dec 14 20:17:01 localhost pulseaudio[4331]: ratelimit.c: 17 events suppressed
Dec 14 20:17:06 localhost pulseaudio[4331]: ratelimit.c: 23 events suppressed
Dec 14 20:17:11 localhost pulseaudio[4331]: ratelimit.c: 19 events suppressed
Dec 14 20:17:31 localhost pulseaudio[4331]: ratelimit.c: 23 events suppressed
Dec 14 20:17:36 localhost pulseaudio[4331]: ratelimit.c: 19 events suppressed
Dec 14 20:17:42 localhost pulseaudio[4331]: ratelimit.c: 21 events suppressed
Dec 14 20:17:47 localhost pulseaudio[4331]: ratelimit.c: 19 events suppressed

I have pulseaudio enabled but have glitch-free mode disabled. Any assistance
in troubleshooting this would be appreciated.

Chris

-- 
KeyID 0xE372A7DA98E6705C
