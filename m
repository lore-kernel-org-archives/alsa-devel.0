From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: alsa-lib pcm not starting
Date: Sun, 29 Feb 2004 10:53:43 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040229105343.A28963@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

Could someone enlighten me about the way alsa-lib / alsa-driver are
supposed to work when using mmap mode please?  I'm looking at the 1.0.2
code, along with madplay and Linux 2.6.4-rc1.

madplay sets the start_threshold to the size of the buffer, and min_avail
to one period size - in much the same way as the alsa-lib test/pcm.c
program.

However, there appears to be a case where if snd_pcm_write_areas is called
with non-period-sized blocks of samples, we end up waiting for the buffer
to be emptied without starting the hardware.

This can be clearly seen from a couple of fprintf's placed into this
function (buffer size 16384, start threshold 16384, min_avail = 2047)

snd_pcm_write_areas: offset 0 size 480
snd_pcm_write_areas: avail = e80 avail_min = 7ff size = 480 xfer_align = 1
snd_pcm_write_areas: hw_avail = 3600 start_threshold = 4000
snd_pcm_write_areas: offset 0 size 480
snd_pcm_write_areas: avail = a00 avail_min = 7ff size = 480 xfer_align = 1
snd_pcm_write_areas: hw_avail = 3a80 start_threshold = 4000
snd_pcm_write_areas: offset 0 size 480
snd_pcm_write_areas: avail = 580 avail_min = 7ff size = 480 xfer_align = 1
snd_pcm_write_areas: hw_avail = 3f00 start_threshold = 4000
snd_pcm_write_areas: offset 0 size 480
snd_pcm_write_areas: avail = 100 avail_min = 7ff size = 480 xfer_align = 1

Here, (avail < pcm->avail_min && size > avail) is true, so we end up calling
snd_pcm_wait().  However, because hw_avail < start_threshold, we haven't
called snd_pcm_start().

Here's the output of the /proc *_params and status files while the device
is in this state:

/proc/asound/card0/pcm0p/sub0/hw_params:access: MMAP_INTERLEAVED
/proc/asound/card0/pcm0p/sub0/hw_params:format: S16_LE
/proc/asound/card0/pcm0p/sub0/hw_params:subformat: STD
/proc/asound/card0/pcm0p/sub0/hw_params:channels: 2
/proc/asound/card0/pcm0p/sub0/hw_params:rate: 44100 (44100/1)
/proc/asound/card0/pcm0p/sub0/hw_params:period_size: 2047
/proc/asound/card0/pcm0p/sub0/hw_params:buffer_size: 16384
/proc/asound/card0/pcm0p/sub0/hw_params:tick_time: 10000
/proc/asound/card0/pcm0p/sub0/status:state: PREPARED
/proc/asound/card0/pcm0p/sub0/status:trigger_time: 0.000000000
/proc/asound/card0/pcm0p/sub0/status:tstamp      : 1078051902.544283000
/proc/asound/card0/pcm0p/sub0/status:delay       : 0
/proc/asound/card0/pcm0p/sub0/status:avail       : 256
/proc/asound/card0/pcm0p/sub0/status:avail_max   : 0
/proc/asound/card0/pcm0p/sub0/status:-----
/proc/asound/card0/pcm0p/sub0/status:hw_ptr      : 0
/proc/asound/card0/pcm0p/sub0/status:appl_ptr    : 16128
/proc/asound/card0/pcm0p/sub0/sw_params:tstamp_mode: NONE
/proc/asound/card0/pcm0p/sub0/sw_params:period_step: 1
/proc/asound/card0/pcm0p/sub0/sw_params:sleep_min: 0
/proc/asound/card0/pcm0p/sub0/sw_params:avail_min: 2047
/proc/asound/card0/pcm0p/sub0/sw_params:xfer_align: 1
/proc/asound/card0/pcm0p/sub0/sw_params:start_threshold: 16384
/proc/asound/card0/pcm0p/sub0/sw_params:stop_threshold: 16384
/proc/asound/card0/pcm0p/sub0/sw_params:silence_threshold: 0
/proc/asound/card0/pcm0p/sub0/sw_params:silence_size: 0
/proc/asound/card0/pcm0p/sub0/sw_params:boundary: 1073741824

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
