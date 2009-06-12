From: "Steve Langstaff" <steve.langstaff@pebblebay.com>
Subject: plug:dmix slows playback
Date: Fri, 12 Jun 2009 11:11:22 +0100
Message-ID: <20071.8664368198$1244801496@news.gmane.org>
Reply-To: steve.langstaff@pebblebay.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ares.krystal.co.uk (ares.krystal.co.uk [77.72.0.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 940F124656
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Jun 2009 12:11:27 +0200 (CEST)
Received: from 82-69-75-230.dsl.in-addr.zen.co.uk ([82.69.75.230]
	helo=pbclwarlap3) by ares.krystal.co.uk with esmtpa (Exim 4.69)
	(envelope-from <steve.langstaff@pebblebay.com>) id 1MF3jC-0003qM-9M
	for alsa-devel@alsa-project.org; Fri, 12 Jun 2009 11:11:18 +0100
Content-Language: en-gb
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

Hi All.

I've got an installation of ALSA (1.0.19 on an embedded device) where using
plug and dmix as my output device slows down playback - voices and tones are
lower in pitch and the playback takes longer than when not using plug:dmix,
e.g.

/usr/share/sounds/alsa # time aplay ignition.wav
Playing WAVE 'ignition.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
real    0m 3.08s
user    0m 0.04s
sys     0m 0.07s

/usr/share/sounds/alsa # time aplay -D plug:dmix ignition.wav
Playing WAVE 'ignition.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
real    0m 6.00s
user    0m 0.09s
sys     0m 0.08s

See how the 'real' time for playing the file goes from 3.08s to 6.00s

I have also noticed that the audio is played out of both (L+R) channels when
not using -D plug:dmix, but is only played out of the right channel when
using -D plug:dmix.

I am an ALSA beginner - any ideas where I should start looking?

Using the -v option on aplay we get more output...

/usr/share/sounds/alsa # aplay -v ignition.wav
Playing WAVE 'ignition.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
Plug PCM: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0
    1 <- 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : U8
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 8
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
Slave: Hardware PCM card 0 'LM4549' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
  appl_ptr     : 0
  hw_ptr       : 0

/usr/share/sounds/alsa # aplay -v -D plug:dmix ignition.wav
Playing WAVE 'ignition.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
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
  buffer_size  : 2720
  period_size  : 170
  period_time  : 21250
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 170
  period_event : 0
  start_threshold  : 2720
  stop_threshold   : 2720
  silence_threshold: 0
  silence_size : 0
  boundary     : 356515840
Slave: Route conversion PCM (sformat=S32_LE)
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
  buffer_size  : 16320
  period_size  : 1020
  period_time  : 21250
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1020
  period_event : 0
  start_threshold  : 16320
  stop_threshold   : 16320
  silence_threshold: 0
  silence_size : 0
  boundary     : 2139095040
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 16320
  period_size  : 1020
  period_time  : 21250
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1020
  period_event : 0
  start_threshold  : 16320
  stop_threshold   : 16320
  silence_threshold: 0
  silence_size : 0
  boundary     : 2139095040
Hardware PCM card 0 'LM4549' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 16320
  period_size  : 1020
  period_time  : 21250
  tstamp_mode  : ENABLE
  period_step  : 1
  avail_min    : 1020
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 2139095040
  silence_threshold: 0
  silence_size : 2139095040
  boundary     : 2139095040
  appl_ptr     : 0
  hw_ptr       : 0 
