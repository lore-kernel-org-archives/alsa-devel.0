From: Carlo Wood <carlo@alinoe.com>
Subject: Re: Bug in OSS simulation (ALSA 0.9.4)
Date: Fri, 11 Jul 2003 00:36:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030710223640.GB20402@alinoe.com>
References: <20030710013326.GA12086@alinoe.com> <3F0D66ED.3090509@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3F0D66ED.3090509@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 10, 2003 at 02:15:25PM +0100, James Courtier-Dutton wrote:
> Why don't you just use /proc/asound to gather all the info you need, 
> like buffer and period sizes.
> E.g.
> While playing a sound file: -
> cat /proc/asound/oss/sndstat
> cat /proc/asound/card0/pcm0p/info
> 
> cat /proc/asound/card0/pcm0p/sub0/hw_params
> cat /proc/asound/card0/pcm0p/sub0/info
> cat /proc/asound/card0/pcm0p/sub0/status
> cat /proc/asound/card0/pcm0p/sub0/sw_params
> 
> If recording a sound, use pcm0c instead of pcm0p

I am recording.  This is the result:

>cat /proc/asound/oss/sndstat
Sound Driver:3.8.1a-980706 (ALSA v0.9.4 emulation code)
Kernel: Linux ansset 2.5.74-debug #3 Wed Jul 9 14:16:52 CEST 2003 i686
Config options: 0

Installed drivers:
Type 10: ALSA emulation

Card config:
Sound Blaster Live! (rev.8) at 0xa400, irq 9

Audio devices:
0: EMU10K1 (DUPLEX)

Synth devices: NOT ENABLED IN CONFIG

Midi devices:
0: EMU10K1 MPU-401 (UART)

Timers:
7: system timer

Mixers:
0: TriTech TR28602

>cat /proc/asound/card0/pcm0c/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: emu10k1
name: EMU10K1
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0

>cat /proc/asound/card0/pcm0c/sub0/hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 1
rate: 22050 (22050/1)
period_size: 512
buffer_size: 1024
tick_time: 1000
OSS format: S16_LE
OSS channels: 1
OSS rate: 22050
OSS period bytes: 1024
OSS periods: 2

>cat /proc/asound/card0/pcm0c/sub0/status
state: XRUN
trigger_time: 1057875818.000705646
tstamp      : 1057875855.000974402
delay       : 0
avail       : 1024
avail_max   : 0
-----
hw_ptr      : 1536
appl_ptr    : 512

>cat /proc/asound/card0/pcm0c/sub0/sw_params
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 512
xfer_align: 1
start_threshold: 1
stop_threshold: 1024
silence_threshold: 0
silence_size: 0
boundary: 1073741824



At this moment the application (of which I have no source code
thus) is calling

  audio_buf_info info;
  ioctl(fd, SNDCTL_DSP_GETISPACE, &info);

in a loop and get returned in 'info'
that there is no data to be read (info.bytes == 0).

This seems to be caused by the fact that more than 2048
bytes of data were available before the application started
to actually read data; and because there is only a buffer
of 2048 bytes:

OSS period bytes: 1024
OSS periods: 2

Increasing the number of 'periods' would be nice.
But I have no idea why I only GET 2 period - the request is
for 'as much as possible' (0x7fff).
See the call
    res = 0x7fff000a;
    if (ioctl(fd, SNDCTL_DSP_SETFRAGMENT, &res) == -1)
in my test program.

Changing that value to say '0x4000a' also just gives 2 'periods'
instead of the requested 4.

Can you please analyse the data of /proc/asound above
and give a new hint of what to do next?

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
