From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002203]: Segmentation fault and exact
	rate : nan (0/0)
Date: Tue, 13 Jun 2006 04:13:31 +0200
Message-ID: <9ce318685090c18840f0d88f9aa06d93@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7559014F
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jun 2006 04:13:31 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2203> 
======================================================================
Reported By:                Raymond
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   2203
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             06-12-2006 16:44 CEST
Last Modified:              06-13-2006 04:13 CEST
======================================================================
Summary:                    Segmentation fault and exact rate   : nan (0/0)
Description: 
Running two instance of aplay in two different terminals, the second
instance of aplay segmentation fault.


aplay -v -Ddefault:1 *.wav

Playing WAVE 'test.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
Plug PCM: Rate conversion PCM (48000, sformat=U8)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : U8
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 8
  buffer_size  : 2730
  period_size  : 170
  period_time  : 21333
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 170
  xfer_align   : 170
  start_threshold  : 2720
  stop_threshold   : 2730
  silence_threshold: 0
  silence_size : 0
  boundary     : 178913280
Slave: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0
    1 <- 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : U8
  subformat    : STD
  channels     : 1
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 8
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 1024
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 1024
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Hardware PCM card 1 'Intel 82801BA-ICH2' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 0
  exact rate   : nan (0/0)
  msbits       : 0
  buffer_size  : 16384
  period_size  : 0
  period_time  : 0
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 0
  sleep_min    : 0
  avail_min    : 0
  xfer_align   : 0
  start_threshold  : 0
  stop_threshold   : 0
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Mono
Segmentation fault

======================================================================

----------------------------------------------------------------------
 rlrevell - 06-12-06 17:19 
----------------------------------------------------------------------
Please post the gdb backtrace

----------------------------------------------------------------------
 Raymond - 06-13-06 04:13 
----------------------------------------------------------------------
gdb --args aplay -v -Ddefault:1 *.wav
GNU gdb Red Hat Linux (5.3.90-0.20030710.41rh)
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you
are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for
details.
This GDB was configured as "i386-redhat-linux-gnu"...Using host
libthread_db library "/lib/tls/libthread_db.so.1".
 
...

(gdb) run

...

Warning: format is changed to U8
Playing WAVE 'atmos30.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
Plug PCM: Rate conversion PCM (48000, sformat=U8)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : U8
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 8
  buffer_size  : 2730
  period_size  : 170
  period_time  : 21333
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 170
  xfer_align   : 170
  start_threshold  : 2720
  stop_threshold   : 2730
  silence_threshold: 0
  silence_size : 0
  boundary     : 178913280
Slave: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0
    1 <- 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : U8
  subformat    : STD
  channels     : 1
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 8
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 1024
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 1024
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Hardware PCM card 1 'Intel 82801BA-ICH2' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 0
  exact rate   : nan (0/0)
  msbits       : 0
  buffer_size  : 16384
  period_size  : 0
  period_time  : 0
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 0
  sleep_min    : 0
  avail_min    : 0
  xfer_align   : 0
  start_threshold  : 0
  stop_threshold   : 0
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824

Playing WAVE 'beat2.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Mono

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread -1084836288 (LWP 5379)]
0x0022504c in _int_free () from /lib/tls/libc.so.6
(gdb) bt
#0  0x0022504c in _int_free () from /lib/tls/libc.so.6
#1  0x0022401b in free () from /lib/tls/libc.so.6
#2  0x006caef2 in snd_pcm_rate_hw_free (pcm=0x48) at pcm_rate.c:330
#3  0x006b07de in snd_pcm_hw_free (pcm=0x82dc028) at pcm.c:853
#4  0x006cfb65 in snd_pcm_plug_hw_free (pcm=0x82f2a30) at pcm_plug.c:976
#5  0x006b07de in snd_pcm_hw_free (pcm=0x82f2a30) at pcm.c:853
#6  0x006bd0b1 in sndrv_pcm_hw_params (pcm=0x82f2a30, params=0xbfed1080)
    at pcm_params.c:2312
#7  0x006b0751 in snd_pcm_hw_params (pcm=0x82f2a30, params=0x48) at
pcm.c:830
#8  0x0804c6ec in set_params () at aplay.c:960
#9  0x0804ef95 in playback_go (fd=7, loaded=0, count=326252, rtype=2,
    name=0xbff20788 "beat2.wav") at aplay.c:1949
#10 0x0804f230 in playback (name=0xbff20788 "beat2.wav") at aplay.c:2022
#11 0x0804b8bf in main (argc=57, argv=0xbfed15b4) at aplay.c:599
(gdb)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-12-06 16:44 Raymond        New Issue                                    
06-12-06 17:19 rlrevell       Note Added: 0010171                          
06-13-06 04:13 Raymond        Note Added: 0010184                          
======================================================================
