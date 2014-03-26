From: andoru <andoru.blah@gmail.com>
Subject: Invalid PCM pointer with CMI8738 and pcm.c buffer
	underuns
Date: Wed, 26 Mar 2014 16:02:58 +0000 (UTC)
Message-ID: <loom.20140326T163743-253@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 83B60265013
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 17:05:04 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WSqK7-0006Fj-IT
 for alsa-devel@alsa-project.org; Wed, 26 Mar 2014 17:05:03 +0100
Received: from cl-86-125-137-76.cablelink.mures.rdsnet.ro ([86.125.137.76])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 17:05:03 +0100
Received: from andoru.blah by cl-86-125-137-76.cablelink.mures.rdsnet.ro with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 17:05:03 +0100
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

I've previously posted under ALSA's user mailing list so to avoid the
clutter, the details about what's happening is here:
http://article.gmane.org/gmane.linux.alsa.user/38258
http://article.gmane.org/gmane.linux.alsa.user/38260

There was no debug info under /proc/asound/card0/ so nothing to give from
there unless you guys need something specific.

Output of alsa-debug.sh:
http://www.alsa-project.org/db/?f=26187faadd47f3626029ba667cb004e74695f2b2

aplay returns:
________________________________________________________________________
$ aplay -vv 03\ paris\ match-\ Bikeride.wav
Playing WAVE '03 paris match- Bikeride.wav' : Signed 16 bit Little Endian,
Rate 44100 Hz, Stereo
Plug PCM: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 4096
  period_size  : 1024
  period_time  : 23219
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 4096
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Hardware PCM card 0 'C-Media CMI8738' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 4096
  period_size  : 1024
  period_time  : 23219
  tstamp_mode  : ENABLE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 1073741824
  silence_threshold: 0
  silence_size : 1073741824
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0
#+                                                 | 00%
_____________________________________________________________________
