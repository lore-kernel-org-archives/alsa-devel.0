From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: ALSA skipping samples
Date: Fri, 6 Jun 2003 00:54:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030606005423.B27256@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Resent-To: alsa-devel@lists.sourceforge.net
Resent-Message-Id: <E19O54e-0007bG-L0@flint.arm.linux.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm working on some drivers for some custom AC'97 hardware on a
development platform, and am seeing some weird behaviour.

The development platform is mostly FPGA-based, so it isn't the worlds
most fastest machine.  However, running madplay against the OSS
emulation results in the following:

# time madplay sample.mp3
...
8670 frames decoded (0:03:46.4), +2.2 dB peak amplitude, 3882 clipped samples
133.99user 19.92system 2:33.95elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (1498major+69minor)pagefaults 0swaps

Note that the mp3 is 3mins46 long, but we took only 2mins33 to play it!

When listening to the output, it appears that we're randomly missing
chunks of samples; when I added a printk into my PCM's trigger function,
I noticed that we were frequently calling it with TRIGGER_START/
TRIGGER_STOP.  I suspect this is because the mp3 player can't keep
ALSAs buffers full.

The driver source can be found at:

  http://patches.arm.linux.org.uk/alsa/aaci.c

(its not ready for release yet tho.  oh, and yes, dma is missing off
the hardware implementation so its currently using PIO, but it is
expected that in real CPUs the device will have DMA available.)

The contents of /proc/asound/AACI/pcm0p/sub0/ while "playing":

hw_params:access: RW_INTERLEAVED
hw_params:format: S16_LE
hw_params:subformat: STD
hw_params:channels: 2
hw_params:rate: 44100 (44100/1)
hw_params:period_size: 1024
hw_params:buffer_size: 16384
hw_params:tick_time: 10000
hw_params:OSS format: S16_LE
hw_params:OSS channels: 2
hw_params:OSS rate: 44100
hw_params:OSS period bytes: 4096
hw_params:OSS periods: 16
info:card: 0
info:device: 0
info:subdevice: 0
info:stream: PLAYBACK
info:id: PCM0
info:name:
info:subname: subdevice #0
info:class: 0
info:subclass: 0
info:subdevices_count: 1
info:subdevices_avail: 0
prealloc:64
status:state: XRUN
status:trigger_time: 5365.000116784
status:tstamp      : 5365.000119486
status:delay       : 0
status:avail       : 16384
status:avail_max   : 16384
status:-----
status:hw_ptr      : 1024
status:appl_ptr    : 1024
sw_params:tstamp_mode: NONE
sw_params:period_step: 1
sw_params:sleep_min: 0
sw_params:avail_min: 1024
sw_params:xfer_align: 1
sw_params:start_threshold: 1
sw_params:stop_threshold: 16384
sw_params:silence_threshold: 0
sw_params:silence_size: 0
sw_params:boundary: 1073741824

(PS, playing the same mp3 using the same mp3 player binary on a
faster system using real OSS drivers but different hardware has
the expected results.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
