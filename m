From: kieran magee <kiergbm@gmail.com>
Subject: Bug in alsa drivers reported when launching pulseaudio
Date: Sat, 4 Dec 2010 13:54:43 -0500
Message-ID: <AANLkTi=Oeek9Di8bbck=245YYa=YLxfO9pMWmOXb-og4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id A4829244D2
	for <alsa-devel@alsa-project.org>; Sat,  4 Dec 2010 19:54:44 +0100 (CET)
Received: by bwz8 with SMTP id 8so9728480bwz.38
	for <alsa-devel@alsa-project.org>; Sat, 04 Dec 2010 10:54:44 -0800 (PST)
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

Some strange anomalies were occuring in my audio systems, namely, volume
fluctuations during playback.  Attempted to access sound in preferences, had
disabled pulseaudio a while back with no ill effects, (weeks back), I
couldn't access the menu Item.  I was instructed that pulseaudio not running
may be the issue, so attempted to launch that and came upon this worrying
error message,

E: alsa-util.c: snd_pcm_avail_delay() returned strange values: delay 0 is
less than avail 16.
E: alsa-util.c: Most likely this is a bug in the ALSA driver
'snd_hda_intel'. Please report this issue to the ALSA developers.
E: alsa-util.c: snd_pcm_dump():
E: alsa-util.c: Soft volume PCM
E: alsa-util.c: Control: PCM Playback Volume
E: alsa-util.c: min_dB: -51
E: alsa-util.c: max_dB: 0
E: alsa-util.c: resolution: 256
E: alsa-util.c: Its setup is:
E: alsa-util.c:   stream       : CAPTURE
E: alsa-util.c:   access       : MMAP_INTERLEAVED
E: alsa-util.c:   format       : S16_LE
E: alsa-util.c:   subformat    : STD
E: alsa-util.c:   channels     : 2
E: alsa-util.c:   rate         : 44100
E: alsa-util.c:   exact rate   : 44100 (44100/1)
E: alsa-util.c:   msbits       : 16
E: alsa-util.c:   buffer_size  : 88192
E: alsa-util.c:   period_size  : 44096
E: alsa-util.c:   period_time  : 999909
E: alsa-util.c:   tstamp_mode  : ENABLE
E: alsa-util.c:   period_step  : 1
E: alsa-util.c:   avail_min    : 87310
E: alsa-util.c:   period_event : 0
E: alsa-util.c:   start_threshold  : -1
E: alsa-util.c:   stop_threshold   : 6205960286516543488
E: alsa-util.c:   silence_threshold: 0
E: alsa-util.c:   silence_size : 0
E: alsa-util.c:   boundary     : 6205960286516543488
E: alsa-util.c: Slave: Hardware PCM card 0 'HDA Intel' device 0 subdevice 0
E: alsa-util.c: Its setup is:
E: alsa-util.c:   stream       : CAPTURE
E: alsa-util.c:   access       : MMAP_INTERLEAVED
E: alsa-util.c:   format       : S16_LE
E: alsa-util.c:   subformat    : STD
E: alsa-util.c:   channels     : 2
E: alsa-util.c:   rate         : 44100
E: alsa-util.c:   exact rate   : 44100 (44100/1)
E: alsa-util.c:   msbits       : 16
E: alsa-util.c:   buffer_size  : 88192
E: alsa-util.c:   period_size  : 44096
E: alsa-util.c:   period_time  : 999909
E: alsa-util.c:   tstamp_mode  : ENABLE
E: alsa-util.c:   period_step  : 1
E: alsa-util.c:   avail_min    : 87310
E: alsa-util.c:   period_event : 0
E: alsa-util.c:   start_threshold  : -1
E: alsa-util.c:   stop_threshold   : 6205960286516543488
E: alsa-util.c:   silence_threshold: 0
E: alsa-util.c:   silence_size : 0
E: alsa-util.c:   boundary     : 6205960286516543488
E: alsa-util.c:   appl_ptr     : 87328
E: alsa-util.c:   hw_ptr       : 87328


If you need any system information, please feel free to ask.  I'm not
subscribed to the mailing list, as a note, so responses need to be cc'd
directly to me if I am to get them.  Thanks for any help you can give me,

Best,
Kieran Brantner-Magee

(the system is ubuntu 10.10 kernel 2.6.35-23 )
