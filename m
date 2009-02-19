From: Wu Fengguang <fengguang.wu@intel.com>
Subject: zero appl_ptr reported
Date: Thu, 19 Feb 2009 13:20:16 +0800
Message-ID: <20090219052016.GA31253@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 3581D103803
	for <alsa-devel@alsa-project.org>; Thu, 19 Feb 2009 06:20:19 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I noticed that 'appl_ptr' is always 0 during playback, whether it be
mplayer or aplay, T61 or DG45ID. Is this a bug?

        % grep -r . /proc/asound/card0/pcm0p
        /proc/asound/card0/pcm0p/sub0/prealloc_max:32768
        /proc/asound/card0/pcm0p/sub0/prealloc:64
        /proc/asound/card0/pcm0p/sub0/status:state: RUNNING
        /proc/asound/card0/pcm0p/sub0/status:trigger_time: 260.550520867
        /proc/asound/card0/pcm0p/sub0/status:tstamp      : 264.361429403
        /proc/asound/card0/pcm0p/sub0/status:delay       : -182952
        /proc/asound/card0/pcm0p/sub0/status:avail       : 191144
        /proc/asound/card0/pcm0p/sub0/status:avail_max   : 191144
        /proc/asound/card0/pcm0p/sub0/status:-----
        /proc/asound/card0/pcm0p/sub0/status:hw_ptr      : 182952
        /proc/asound/card0/pcm0p/sub0/status:appl_ptr    : 0
        /proc/asound/card0/pcm0p/sub0/sw_params:tstamp_mode: ENABLE
        /proc/asound/card0/pcm0p/sub0/sw_params:period_step: 1
        /proc/asound/card0/pcm0p/sub0/sw_params:avail_min: 1024
        /proc/asound/card0/pcm0p/sub0/sw_params:start_threshold: 1
        /proc/asound/card0/pcm0p/sub0/sw_params:stop_threshold: 4611686018427387904
        /proc/asound/card0/pcm0p/sub0/sw_params:silence_threshold: 0
        /proc/asound/card0/pcm0p/sub0/sw_params:silence_size: 4611686018427387904
        /proc/asound/card0/pcm0p/sub0/sw_params:boundary: 4611686018427387904
        /proc/asound/card0/pcm0p/sub0/hw_params:access: MMAP_INTERLEAVED
        /proc/asound/card0/pcm0p/sub0/hw_params:format: S32_LE
        /proc/asound/card0/pcm0p/sub0/hw_params:subformat: STD
        /proc/asound/card0/pcm0p/sub0/hw_params:channels: 2
        /proc/asound/card0/pcm0p/sub0/hw_params:rate: 48000 (48000/1)
        /proc/asound/card0/pcm0p/sub0/hw_params:period_size: 1024
        /proc/asound/card0/pcm0p/sub0/hw_params:buffer_size: 8192
        /proc/asound/card0/pcm0p/sub0/info:card: 0
        /proc/asound/card0/pcm0p/sub0/info:device: 0
        /proc/asound/card0/pcm0p/sub0/info:subdevice: 0
        /proc/asound/card0/pcm0p/sub0/info:stream: PLAYBACK
        /proc/asound/card0/pcm0p/sub0/info:id: STAC92xx Analog
        /proc/asound/card0/pcm0p/sub0/info:name: STAC92xx Analog
        /proc/asound/card0/pcm0p/sub0/info:subname: subdevice #0
        /proc/asound/card0/pcm0p/sub0/info:class: 0
        /proc/asound/card0/pcm0p/sub0/info:subclass: 0
        /proc/asound/card0/pcm0p/sub0/info:subdevices_count: 1
        /proc/asound/card0/pcm0p/sub0/info:subdevices_avail: 0
        /proc/asound/card0/pcm0p/xrun_debug:0
        /proc/asound/card0/pcm0p/info:card: 0
        /proc/asound/card0/pcm0p/info:device: 0
        /proc/asound/card0/pcm0p/info:subdevice: 0
        /proc/asound/card0/pcm0p/info:stream: PLAYBACK
        /proc/asound/card0/pcm0p/info:id: STAC92xx Analog
        /proc/asound/card0/pcm0p/info:name: STAC92xx Analog
        /proc/asound/card0/pcm0p/info:subname: subdevice #0
        /proc/asound/card0/pcm0p/info:class: 0
        /proc/asound/card0/pcm0p/info:subclass: 0
        /proc/asound/card0/pcm0p/info:subdevices_count: 1
        /proc/asound/card0/pcm0p/info:subdevices_avail: 0


Interestingly DG45ID HDMI audio playback does not have this problem:

        /proc/asound/card0/pcm3p/sub0/prealloc_max:32768
        /proc/asound/card0/pcm3p/sub0/prealloc:64
        /proc/asound/card0/pcm3p/sub0/status:state: RUNNING
        /proc/asound/card0/pcm3p/sub0/status:trigger_time: 441.375970806
        /proc/asound/card0/pcm3p/sub0/status:tstamp      : 447.039903859
        /proc/asound/card0/pcm3p/sub0/status:delay       : 16096
        /proc/asound/card0/pcm3p/sub0/status:avail       : 288
        /proc/asound/card0/pcm3p/sub0/status:avail_max   : 288
        /proc/asound/card0/pcm3p/sub0/status:-----
        /proc/asound/card0/pcm3p/sub0/status:hw_ptr      : 249824
        /proc/asound/card0/pcm3p/sub0/status:appl_ptr    : 265920
        /proc/asound/card0/pcm3p/sub0/sw_params:tstamp_mode: NONE
        /proc/asound/card0/pcm3p/sub0/sw_params:period_step: 1
        /proc/asound/card0/pcm3p/sub0/sw_params:avail_min: 1024
        /proc/asound/card0/pcm3p/sub0/sw_params:start_threshold: 1024
        /proc/asound/card0/pcm3p/sub0/sw_params:stop_threshold: 4611686018427387904
        /proc/asound/card0/pcm3p/sub0/sw_params:silence_threshold: 0
        /proc/asound/card0/pcm3p/sub0/sw_params:silence_size: 4611686018427387904
        /proc/asound/card0/pcm3p/sub0/sw_params:boundary: 4611686018427387904
        /proc/asound/card0/pcm3p/sub0/hw_params:access: RW_INTERLEAVED
        /proc/asound/card0/pcm3p/sub0/hw_params:format: S16_LE
        /proc/asound/card0/pcm3p/sub0/hw_params:subformat: STD
        /proc/asound/card0/pcm3p/sub0/hw_params:channels: 2
        /proc/asound/card0/pcm3p/sub0/hw_params:rate: 44100 (44100/1)
        /proc/asound/card0/pcm3p/sub0/hw_params:period_size: 1024
        /proc/asound/card0/pcm3p/sub0/hw_params:buffer_size: 16384
        /proc/asound/card0/pcm3p/sub0/info:card: 0
        /proc/asound/card0/pcm3p/sub0/info:device: 3
        /proc/asound/card0/pcm3p/sub0/info:subdevice: 0
        /proc/asound/card0/pcm3p/sub0/info:stream: PLAYBACK
        /proc/asound/card0/pcm3p/sub0/info:id: INTEL HDMI
        /proc/asound/card0/pcm3p/sub0/info:name: INTEL HDMI
        /proc/asound/card0/pcm3p/sub0/info:subname: subdevice #0
        /proc/asound/card0/pcm3p/sub0/info:class: 0
        /proc/asound/card0/pcm3p/sub0/info:subclass: 0
        /proc/asound/card0/pcm3p/sub0/info:subdevices_count: 1
        /proc/asound/card0/pcm3p/sub0/info:subdevices_avail: 0
        /proc/asound/card0/pcm3p/xrun_debug:0
        /proc/asound/card0/pcm3p/info:card: 0
        /proc/asound/card0/pcm3p/info:device: 3
        /proc/asound/card0/pcm3p/info:subdevice: 0
        /proc/asound/card0/pcm3p/info:stream: PLAYBACK
        /proc/asound/card0/pcm3p/info:id: INTEL HDMI
        /proc/asound/card0/pcm3p/info:name: INTEL HDMI
        /proc/asound/card0/pcm3p/info:subname: subdevice #0
        /proc/asound/card0/pcm3p/info:class: 0
        /proc/asound/card0/pcm3p/info:subclass: 0
        /proc/asound/card0/pcm3p/info:subdevices_count: 1
        /proc/asound/card0/pcm3p/info:subdevices_avail: 0

Thanks,
Fengguang
