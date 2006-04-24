From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001990]: aplay/arecord cannot play/capture A_LAW
Date: Mon, 24 Apr 2006 15:48:22 +0200
Message-ID: <fbb78b16ed502e6f51fc8ad52f847db3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4110C192
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2006 15:48:22 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1990> 
======================================================================
Reported By:                Raymond
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1990
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             04-01-2006 04:26 CEST
Last Modified:              04-24-2006 15:48 CEST
======================================================================
Summary:                    aplay/arecord cannot play/capture A_LAW
Description: 
aplay/arecord can play MU_LAW and the sound card support MU_LAW and A_LAW

arecord -D hw:0,0 -f MU_LAW -t au -c 1 -r 8000 test.au

aplay -D hw:0,0 test.au


Try to use -t raw but the quality of A_LAW is very bad when compare with
MU_LAW

arecord -D hw:0,0 -f A_LAW -t raw -c 1 -r 8000 test.raw

aplay -D hw:0,0 test.raw


======================================================================

----------------------------------------------------------------------
 Raymond - 04-24-06 15:07 
----------------------------------------------------------------------
Do "type oss" plugin support mu-law ?

It is ok to play mu-law using au88xx driver
http://sourceforge.net/projects/aureal

play mulaw.au 


au88xx, alsa-lib-1.0.11 and alsa-plugins-1.0.11 ( oss )

pcm.ossdriver {
	type oss
	device /dev/dsp
}


aplay -v -Dossdriver test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Mono
ALSA <-> OSS PCM I/O Plugin
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 4096
  period_time  : 92879
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 4096
  xfer_align   : 4096
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824


aplay -Dossdriver mulaw.au
Playing Sparc Audio 'mulaw.au' : Mu-Law, Rate 8000 Hz, Mono
*** OSS: unsupported format MU_LAW
aplay: set_params:961: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  MU_LAW
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 128000
PERIOD_SIZE: 1024
PERIOD_BYTES: 1024
PERIODS: 4
BUFFER_TIME: 512000
BUFFER_SIZE: 4096
BUFFER_BYTES: 4096
TICK_TIME: [0 0]


aplay -Dplug:ossdriver mulaw.au
Playing Sparc Audio 'mulaw.au' : Mu-Law, Rate 8000 Hz, Mono
*** OSS: unsupported format MU_LAW
aplay: set_params:961: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  MU_LAW
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 128000
PERIOD_SIZE: 1024
PERIOD_BYTES: 1024
PERIODS: 4
BUFFER_TIME: 512000
BUFFER_SIZE: 4096
BUFFER_BYTES: 4096
TICK_TIME: 0

----------------------------------------------------------------------
 tiwai - 04-24-06 15:48 
----------------------------------------------------------------------
Not supported properly by oss plugin.  Open another bug if you want to fix
it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-01-06 04:26 Raymond        New Issue                                    
04-03-06 07:16 Raymond        Note Added: 0009085                          
04-03-06 07:36 Raymond        Note Added: 0009086                          
04-07-06 19:32 tiwai          Note Added: 0009152                          
04-08-06 07:47 Raymond        Note Added: 0009171                          
04-10-06 16:52 tiwai          Note Added: 0009199                          
04-11-06 07:46 Raymond        Note Added: 0009229                          
04-11-06 07:55 Raymond        Note Edited: 0009229                         
04-11-06 09:41 Raymond        Note Edited: 0009229                         
04-20-06 15:29 tiwai          Status                   new => resolved     
04-20-06 15:29 tiwai          Resolution               open => not an issue
04-20-06 15:29 tiwai          Assigned To               => tiwai           
04-20-06 15:29 tiwai          Note Added: 0009384                          
04-24-06 15:07 Raymond        Status                   resolved => feedback
04-24-06 15:07 Raymond        Resolution               not an issue => reopened
04-24-06 15:07 Raymond        Note Added: 0009451                          
04-24-06 15:48 tiwai          Status                   feedback => resolved
04-24-06 15:48 tiwai          Resolution               reopened => not an issue
04-24-06 15:48 tiwai          Note Added: 0009453                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
