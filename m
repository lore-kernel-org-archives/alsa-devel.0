From: Joel Metelius <joel.metelius@home.se>
Subject: No sound with alsa and intel8x0 on Intel ICH5R
Date: Thu, 15 Jan 2004 13:49:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074170953.17555.10.camel@p4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

I have a Gigabyte GA-8IK1100 motherboard with an onboard ICH5R chip and
the AC97 CODEC. With ALSA I get no sound at all and with OSS I get sound
but at wrong frequency (playing too slow).

I haved tried alsa with gentoo kernel 2.6.1 and 2.6.1-r1 and also with
2.6.1-mm3 from kernel.org.

When trying to compile alsa-drivers separately it complains about
linux/arch/x86 not existing (and it doesn't). This was after resolving
issues with PDE not detected OK by ./configure.

thanks

/joel 

parts of output from dmesg:
***************************

ICH5: IDE controller at PCI slot 0000:00:1f.1
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
intel8x0_measure_ac97_clock: measured 25120 usecs
intel8x0: clocking to 48000
ALSA sound/pci/intel8x0.c:2695: joystick(s) found
ALSA sound/core/pcm_lib.c:224: Unexpected hw_pointer value [2] (stream =
0, delta: -16, max jitter = 4352): wrong interrupt acknowledge?

/var/log/messages after "alsasound restart":
*******************************************
Jan 15 13:35:18 p4 PCI: Setting latency timer of device 0000:00:1f.5 to
64
Jan 15 13:35:18 p4 intel8x0_measure_ac97_clock: measured 37636 usecs
Jan 15 13:35:18 p4 intel8x0: clocking to 48000
Jan 15 13:35:18 p4 ALSA sound/pci/intel8x0.c:2695: joystick(s) found

aplay -v:
*********
p4 root # aplay -v /usr/share/sounds/startup3.wav
Playing WAVE '/usr/share/sounds/startup3.wav' : Signed 16 bit Little
Endian, Rat e 44100 Hz, Stereo
Plug PCM: Rate conversion PCM (48000, sformat=S16_LE)
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 11025
period_size  : 5512
period_time  : 125000
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 5512
xfer_align   : 5512
start_threshold  : 11024
stop_threshold   : 11025
silence_threshold: 0
silence_size : 0
boundary     : 1445068800
Slave: Hardware PCM card 0 'Intel ICH5' device 0 subdevice 0
 
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 48000
exact rate   : 48000 (48000/1)
msbits       : 16
buffer_size  : 12000
period_size  : 6000
period_time  : 125000
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 6000
xfer_align   : 6000
start_threshold  : 12000
stop_threshold   : 12000
silence_threshold: 0
silence_size : 0
boundary     : 1572864000

when running mplayer on /dev/dvd using OSS:
*******************************************
--
Opening audio decoder: [liba52] AC3 decoding with liba52
Using SSE optimized IMDCT transform
AC3: 2.0 (stereo)  48000 Hz  192.0 kbit/s
Using MMX optimized resampler
AUDIO: 48000 Hz, 2 ch, 16 bit (0x10), ratio: 24000->192000 (192.0 kbit)
Selected audio codec: [a52] afm:liba52 (AC3-liba52)
==========================================================================
Checking audio filter chain for 48000Hz/2ch/16bit ->
48000Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 48000 hz, little endian signed int
AF_pre: 48000Hz 2ch Signed 16-bit (Little-Endian)
AO: [oss] 4013Hz 2ch Signed 16-bit (Little-Endian) (2 bps)
Building audio filter chain for 48000Hz/2ch/16bit -> 4013Hz/2ch/16bit...
[resample] The output sample frequency must be between 8kHz and 192kHz.
Current value is 4013
Couldn't find matching filter / ao format!




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
