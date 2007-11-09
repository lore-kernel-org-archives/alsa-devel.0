From: Piers O'Hanlon <p.ohanlon@cs.ucl.ac.uk>
Subject: Getting XRUN after writei in RUNNING state?
Date: Fri, 09 Nov 2007 16:34:53 +0000
Message-ID: <47348C2D.7020509@cs.ucl.ac.uk>
Reply-To: p.ohanlon@cs.ucl.ac.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bells.cs.ucl.ac.uk (bells.cs.ucl.ac.uk [128.16.5.31])
	by alsa0.perex.cz (Postfix) with SMTP id E750C244AF
	for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2007 17:35:27 +0100 (CET)
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

Hi folks,

I've trying to improve the ALSA driver for the Robust Audio Tool (RAT) tool:
http://frostie.cs.ucl.ac.uk/nets/mmedia/wiki/RatWiki

Specifically the code I'm talking about is:
http://frostie.cs.ucl.ac.uk/nets/mmedia/browser/rat/trunk/auddev_alsa.c

I've added some status dumps in the code that I'm running which aren't
in the repository version but basically the code is doing the same thing.

However I'm seeing weird XRUNs (under runs on the playback side) -
There's as couple of instances I don't understand: (The pcm device setup
is shown at the bottom);

1) RAT is happily writing audio to the playback device for while then
the device just seems to go in XRUN state after being in RUNNING state
and doing a writei()??:

[+945 auddev_alsa.c] Time since last write: 42734us, Trying to write 640
frames
  state       : RUNNING
  trigger_time: 1194622844.333930000
  tstamp      : 0.000000
  delay       : 121
  avail       : 1927
  avail_max   : 2043
[pid/9901 +954 auddev_alsa.c] Wrote 1280 bytes, frames: 640
  state       : XRUN
  trigger_time: 1194622844.333930000
  tstamp      : 0.000000
  delay       : 758
  avail       : 1290
  avail_max   : 2046

2) RAT is writing audio to the playback device for while then the device
just seems to go in XRUN state when there's still positive delay in the
buffer.

Here's last write that went ok - showing the snd_pcm_status_dump before
doing the write and afterwards:

[+945 auddev_alsa.c] Time since last write: 42635us, Trying to write 640
frames
  state       : RUNNING
  trigger_time: 1194622843.886113000
  tstamp      : 0.000000
  delay       : 275
  avail       : 1773
  avail_max   : 2041
[+954 auddev_alsa.c] Wrote 1280 bytes, frames: 640
  state       : RUNNING
  trigger_time: 1194622843.886113000
  tstamp      : 0.000000
  delay       : 907
  avail       : 1141
  avail_max   : 2043

The next time the audio write is called the state is checked and found
to be in XRUN with 225 delay in the buffer:??? (And yet I've seen other
writes find the device still running with alot less delay in the buffer??):

[ +936 auddev_alsa.c] In SND_PCM_STATE_XRUN  - preparing audio
[pid/9901 +945 auddev_alsa.c] Frames avail to be written=2048, time
diff=43182, Trying to write 640 frames, Curr delay 0
  state       : XRUN
  trigger_time: 1194622843.886113000
  tstamp      : 0.000000
  delay       : 225
  avail       : 1823
  avail_max   : 2049
[pid/9901 +954 auddev_alsa.c] Wrote 1280 bytes, frames: 640
  state       : RUNNING
  trigger_time: 1194622844.142516000
  tstamp      : 0.000000
  delay       : 637
  avail       : 1411
  avail_max   : 1708

Currently I'm stumped at to solve these problems.... And basically ALSA
sound quality as worse than the OSS driver for RAT as a result.

Any suggestions are to how improve or sort these problems is welcome.

Thanks,

Piers O'Hanlon.
University College London

===snd_pcm_dump_setup:===============
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 16000
  exact rate   : 16000 (16000/1)
  msbits       : 16
  buffer_size  : 2048
  period_size  : 341
  period_time  : 21333
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 341
  xfer_align   : 1
  start_threshold  : 341
  stop_threshold   : 2048
  silence_threshold: 0
  silence_size : 0
  boundary     : 536870912
