From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002203]: Segmentation fault and exact
	rate : nan (0/0)
Date: Sat, 17 Jun 2006 04:51:48 +0200
Message-ID: <5ea262f895b0e534c43e1850f810fabf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C820517C
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jun 2006 04:51:48 +0200 (MEST)
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


The following issue has been REOPENED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2203> 
======================================================================
Reported By:                Raymond
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   2203
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             06-12-2006 16:44 CEST
Last Modified:              06-17-2006 04:51 CEST
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
 tiwai - 06-16-06 18:55 
----------------------------------------------------------------------
The missing uniniaizlied fields in the slave PCM are fixed on HG repo now.

----------------------------------------------------------------------
 Raymond - 06-17-06 04:51 
----------------------------------------------------------------------
It seem that your patch break dmix/dsnoop

aplay -v -Ddefault:1 *.wav
ALSA lib pcm_dmix.c:914:(snd_pcm_dmix_open) unable to open slave
aplay: main:548: audio open error: Device or resource busy

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-12-06 16:44 Raymond        New Issue                                    
06-12-06 17:19 rlrevell       Note Added: 0010171                          
06-13-06 04:13 Raymond        Note Added: 0010184                          
06-14-06 14:14 Raymond        Note Added: 0010211                          
06-16-06 11:27 Raymond        Note Added: 0010249                          
06-16-06 18:55 tiwai          Status                   assigned => resolved
06-16-06 18:55 tiwai          Resolution               open => fixed       
06-16-06 18:55 tiwai          Note Added: 0010257                          
06-17-06 04:51 Raymond        Assigned To              perex => tiwai      
06-17-06 04:51 Raymond        Status                   resolved => feedback
06-17-06 04:51 Raymond        Resolution               fixed => reopened   
06-17-06 04:51 Raymond        Note Added: 0010263                          
======================================================================
