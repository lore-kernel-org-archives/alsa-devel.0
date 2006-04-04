From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001987]: Upmix Feature Request
Date: Tue, 4 Apr 2006 09:33:17 +0200
Message-ID: <f8212a10cf87b8d4831b48918dd40768@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5829C1AB
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2006 09:33:17 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1987> 
======================================================================
Reported By:                the-me
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1987
Category:                   CORE - control
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               Debian
Kernel Version:             2.6.16.1
======================================================================
Date Submitted:             03-31-2006 20:38 CEST
Last Modified:              04-04-2006 09:33 CEST
======================================================================
Summary:                    Upmix Feature Request
Description: 
Hi,

I, and many users more, want a feature at the alsamixer, called Upmix.
I've got an Terratec Aureon 5.1 Fun and I tried many things, but it's not
able, that I can hear an mp3 with upmixed 5.1 sound. Here is my actual
.asoundrc:

pcm.ch51upmix {
        type route
        slave.pcm surround51
        slave.channels 6
        ttable.0.0 1
        ttable.1.1 1
        ttable.0.2 1
        ttable.1.3 1
        ttable.0.4 0.5
        ttable.1.4 0.5
        ttable.0.5 0.5
        ttable.1.5 0.5
}
pcm.!default
{
        type plug
        slave.pcm ch51upmix
}
pcm.lowpass {
type ladspa
path "/usr/lib/ladspa"
plugins [ {
label lpf
input {
controls [ 50 ]
}
} ]
}


With this .asoundrc, all speakers work, but my subwoofer doesn't play only
low frequen...

Can you please add such a feature?


Greetz, Patrick
======================================================================

----------------------------------------------------------------------
 Raymond - 04-02-06 16:26 
----------------------------------------------------------------------
the lowpass filter with 50Hz cutoff seem unable to filter the human voice,
I still see peaks above 125Hz on the 10-bands graphic equalizer of
au8830.



aplay -v -Dplug:lowpass test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
Plug PCM: Linear Integer <-> Linear Float conversion PCM (FLOAT_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 23219
  tick_time    : 10000
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
Slave: LADSPA PCM
  Playback:
    Policy: duplicate
    Filename: /usr/local/lib/ladspa/filter.so
    Plugin Name: Simple Low Pass Filter
    Plugin Label: lpf
    Plugin Unique ID: 1041
    Instances:
      Depth: 0
         InChannels: 0
         InPorts: 1 "Input"
         OutChannels: 0
         OutPorts: 2 "Output"
      Depth: 0
         InChannels: 1
         InPorts: 1 "Input"
         OutChannels: 1
         OutPorts: 2 "Output"
    Control input port initial values:
      0 "Cutoff Frequency (Hz)" = 50.00000000
  Capture:
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_NONINTERLEAVED
  format       : FLOAT_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 32
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 23219
  tick_time    : 10000
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
Slave: Plug PCM: Linear Integer <-> Linear Float conversion PCM (S16_LE)
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_NONINTERLEAVED
  format       : FLOAT_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 32
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 23219
  tick_time    : 10000
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
Slave: Hardware PCM card 0 'au8830' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 23219
  tick_time    : 10000
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

----------------------------------------------------------------------
 Raymond - 04-04-06 09:33 
----------------------------------------------------------------------
The second thing is to test the route plugin

It seem to me that it need a hw device with 6 channels

speaker-test -D hw:0,0 -c 6 -t wav

Which alsa driver are you using ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-06 20:38 the-me         New Issue                                    
03-31-06 20:38 the-me         Distribution              => Debian          
03-31-06 20:38 the-me         Kernel Version            => 2.6.16.1        
03-31-06 20:40 the-me         Note Added: 0009048                          
03-31-06 21:02 rlrevell       Status                   new => closed       
03-31-06 21:02 rlrevell       Note Added: 0009049                          
03-31-06 21:15 the-me         Status                   closed => feedback  
03-31-06 21:15 the-me         Resolution               open => reopened    
03-31-06 21:15 the-me         Note Added: 0009050                          
04-01-06 01:03 Raymond        Note Added: 0009052                          
04-01-06 10:39 the-me         Note Added: 0009053                          
04-02-06 10:42 Raymond        Note Added: 0009059                          
04-02-06 11:44 the-me         Note Added: 0009060                          
04-02-06 14:36 Raymond        Note Added: 0009061                          
04-02-06 14:57 the-me         Note Added: 0009062                          
04-02-06 16:26 Raymond        Note Added: 0009063                          
04-04-06 09:33 Raymond        Note Added: 0009111                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
