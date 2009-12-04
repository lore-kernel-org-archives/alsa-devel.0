From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: hw_ptr accuracy with intel8x0 -> PulseAudio issue
Date: Fri, 4 Dec 2009 17:43:57 +0800
Message-ID: <4f3252890912040143g5c1fba76g7bdee0e093f9b300@mail.gmail.com>
References: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>
	<4f3252890912021826g732292ecv8959a7cfbf574446@mail.gmail.com>
	<6160a5130912030828m5b2401f3w31a67b6b51e8d8b6@mail.gmail.com>
	<4f3252890912031442i56ccc905g935a4d6ed48f40c6@mail.gmail.com>
	<6160a5130912031650u5949c921jc86d0847b2844803@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id A63EE24570
	for <alsa-devel@alsa-project.org>; Fri,  4 Dec 2009 10:43:58 +0100 (CET)
Received: by pwj11 with SMTP id 11so4486517pwj.32
	for <alsa-devel@alsa-project.org>; Fri, 04 Dec 2009 01:43:57 -0800 (PST)
In-Reply-To: <6160a5130912031650u5949c921jc86d0847b2844803@mail.gmail.com>
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

2009/12/4 pl bossart <bossart.nospam@gmail.com>

> >>   17. hwptr 24351 buffer 16384 appl 24332, avail=16403
> >
> > appl pointer is behind hwprtr (  underrun ) , need timestamp to find out
> > whether PA is unable to write audio data in time since
>
> Nah, it's not an audio underflow. In the default PulseAudio code, the
> timer value is increased by 20ms each time this errror condition is
> reached. PA ends-up waking-up 150ms or so before the deadline and yet
> it still encounters this error. I don't think it's a problem with PA
> not refilling the buffer on time, it's more that the information
> provided by snd_pcm_avail() is misleading. I commented out the portion
> of the code that increases the watermark and clamped the number of
> available samples to the buffer size, and it works just fine, no audio
> underflows.
> - P
>


Since PA use one period per buffer for intel8x0 ( the hwptr is already at
the outside of the buffer )

It is hard to debug without timestamp since it is not easy to know the value
of sleeping time

Can you explain what is "hwbuf_unused" ?



   1. I: alsa-sink.c: Using 1.0 fragments of size 65536 bytes (371.52ms),
   buffer size is 65536 bytes (371.52ms)
   2. I: alsa-sink.c: Time scheduling watermark is 20.00ms
   3. D: alsa-sink.c: hwbuf_unused=0
   4. D: alsa-sink.c: Buffer time: 371 ms; Sleep time: 351 ms; Process time:
   20 ms
   5. D: alsa-sink.c: setting avail_min=15502
   6. D: alsa-mixer.c: Activating path analog-output
   7. D: alsa-mixer.c: Path analog-output (Analog Output), direction=1,
   priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes,
   has_dB=yes, min_volume=0, max_volume=31, min_dB=-81, max_dB=12
   8. D: alsa-mixer.c: Element Master, direction=1, switch=1, volume=1,
   enumeration=0, required=0, required_absent=0, mask=0x3600000000f66,
   n_channels=2, override_map=yes
   9. D: alsa-mixer.c: Element Master Mono, direction=1, switch=2, volume=2,
   enumeration=0, required=0, required_absent=0, mask=0x7ffffffffffff,
   n_channels=1, override_map=no
   10. D: alsa-mixer.c: Element Headphone, direction=1, switch=1, volume=3,
   enumeration=0, required=0, required_absent=0, mask=0x6, n_channels=2,
   override_map=no
   11. D: alsa-mixer.c: Element PCM, direction=1, switch=1, volume=1,
   enumeration=0, required=0, required_absent=0, mask=0x402b600000000f66,
   n_channels=2, override_map=yes
   12. D: alsa-mixer.c: Element External Amplifier, direction=1, switch=4,
   volume=0, enumeration=0, required=0, required_absent=0, mask=0x0,
   n_channels=0, override_map=no
   13. D: alsa-mixer.c: Option on (output-amplifier-on/Amplifier) index=1,
   priority=10
   14. D: alsa-mixer.c: Option off (output-amplifier-off/No Amplifier)
   index=0, priority=0
   15. D: alsa-mixer.c: Setting output-amplifier-on (Amplifier) priority=10
   16. D: alsa-mixer.c: Setting output-amplifier-off (No Amplifier)
   priority=0
   17. I: alsa-sink.c: Hardware volume ranges from -81.00 dB to 12.00 dB.
   18. I: alsa-sink.c: Fixing base volume to -12.00 dB
   19. I: alsa-sink.c: Using hardware volume control. Hardware dB scale
   supported.
   20. I: alsa-sink.c: Using hardware mute control.
   21. D: alsa-util.c: snd_pcm_dump():
   22. D: alsa-util.c: Hardware PCM card 0 'Intel ICH6' device 0 subdevice 0
   23. D: alsa-util.c: Its setup is:
   24. D: alsa-util.c:   stream       : PLAYBACK
   25. D: alsa-util.c:   access       : MMAP_INTERLEAVED
   26. D: alsa-util.c:   format       : S16_LE
   27. D: alsa-util.c:   subformat    : STD
   28. D: alsa-util.c:   channels     : 2
   29. D: alsa-util.c:   rate         : 44100
   30. D: alsa-util.c:   exact rate   : 44100 (44100/1)
   31. D: alsa-util.c:   msbits       : 16
   32. D: alsa-util.c:   buffer_size  : 16384
   33. D: alsa-util.c:   period_size  : 16384
   34. D: alsa-util.c:   period_time  : 371519
   35. D: alsa-util.c:   tstamp_mode  : ENABLE
   36. D: alsa-util.c:   period_step  : 1
   37. D: alsa-util.c:   avail_min    : 16384
   38. D: alsa-util.c:   period_event : 0
   39. D: alsa-util.c:   start_threshold  : -1
   40. D: alsa-util.c:   stop_threshold   : 1073741824
   41. D: alsa-util.c:   silence_threshold: 0
   42. D: alsa-util.c:   silence_size : 0
   43. D: alsa-util.c:   boundary     : 1073741824
   44. D: alsa-util.c:   appl_ptr     : 0
   45. D: alsa-util.c:   hw_ptr       : 0
   46. D: alsa-sink.c: Requested volume: 0:   3% 1:   3%
   47. D: alsa-sink.c: Got hardware volume: 0:   3% 1:   3%
   48. D: alsa-sink.c: Calculated software volume: 0: 100% 1: 100%
   (accurate-enough=yes)
   49. D: alsa-sink.c: Thread starting up
   50. I: core-util.c: Successfully enabled SCHED_RR scheduling for thread,
   with priority 4, which is lower than the requested 5.
   51. D: alsa-sink.c: Loop
   52. D: alsa-sink.c: Loop
   53. D: alsa-sink.c: Buffer time: 371 ms; Sleep time: 351 ms; Process
   time: 20 ms
   54. hwptr 0 buffer 16384 appl 0, avail=16384
   55. D: alsa-sink.c: avail: 65536 (samples 16384)
   56. D: alsa-sink.c: 0.00 ms left to play; inc threshold = 0.00 ms; dec
   threshold = 100.00 ms
   57. D: alsa-sink.c: Filling up
   58. hwptr 0 buffer 16384 appl 0, avail=16384
   59. hwptr 0 buffer 16384 appl 0, avail=16384
   60. D: alsa-sink.c: Wrote 65496 bytes (of possible 65536 bytes)
   61. hwptr 0 buffer 16384 appl 16374, avail=10
   62. hwptr 0 buffer 16384 appl 16374, avail=10
   63. D: alsa-sink.c: Wrote 40 bytes (of possible 40 bytes)
   64. hwptr 0 buffer 16384 appl 16384, avail=0
   65. D: alsa-sink.c: avail: 0 (samples 0)
   66. D: alsa-sink.c: 371.52 ms left to play; inc threshold = 0.00 ms; dec
   threshold = 100.00 ms
   67. D: alsa-sink.c: Not filling up, because too early.
   68. I: alsa-sink.c: Starting playback.
   69. D: alsa-sink.c: Cutting sleep time for the initial iterations by
   half.


In the default PulseAudio code, the
> timer value is increased by 20ms each time this errror condition is
> reached.


D: alsa-sink.c: Cutting sleep time for the initial iterations by half.

Are you sure the time value is increased by 20 ms in pulseaudio-0.9.21 ?


My au8830 work quite well on pulseaudio-0.9.14 ( Fedora 10 )  with 2
fragments


D: module-hal-detect.c: Loading module-alsa-sink with arguments 'device_id=0
sink_name=alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0 tsched=1'

D: alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
D: alsa-util.c: Maximum hw buffer size is 371 ms
I: module-alsa-sink.c: Successfully opened device front:0.
I: module-alsa-sink.c: Successfully enabled mmap() mode.
I: module-alsa-sink.c: Successfully enabled timer-based scheduling mode.
I: (alsa-lib)control.c: Invalid CTL front:0
I: alsa-util.c: Unable to attach to mixer front:0: No such file or directory
I: alsa-util.c: Successfully attached to mixer 'hw:0'
I: alsa-util.c: Using mixer control "Master".
I: sink.c: Created sink 0
"alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0" with sample spec s16le
2ch 44100Hz and channel map front-left,front-right
I: source.c: Created source 0
"alsa_output.pci_12eb_2_sound_card_0_alsa_playback_0.monitor" with sample
spec s16le 2ch 44100Hz and channel map front-left,front-right
I: module-alsa-sink.c: Using 2 fragments of size 4096 bytes, buffer time is
46.44ms
I: module-alsa-sink.c: Time scheduling watermark is 20.00ms
D: module-alsa-sink.c: hwbuf_unused_frames=0
D: module-alsa-sink.c: setting avail_min=4661
I: module-alsa-sink.c: Volume ranges from 0 to 31.
I: module-alsa-sink.c: Volume ranges from -46.50 dB to 0.00 dB.
I: alsa-util.c: All 2 channels can be mapped to mixer channels.
I: module-alsa-sink.c: Using hardware volume control. Hardware dB scale
supported.
D: alsa-util.c: snd_pcm_dump():
D: alsa-util.c: Hardware PCM card 0 'Aureal Vortex au8830' device 0
subdevice 0
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : PLAYBACK
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 2048
D: alsa-util.c:   period_size  : 1024
D: alsa-util.c:   period_time  : 23219
D: alsa-util.c:   tstamp_mode  : NONE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 4661
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : -1
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 1073741824
D: alsa-util.c:   appl_ptr     : 0
D: alsa-util.c:   hw_ptr       : 0
D: module-alsa-sink.c: Read hardware volume: 0:  72% 1:  72%
D: module-alsa-sink.c: Thread starting up
D: rtpoll.c: Acquired POSIX realtime signal SIGRTMIN+29
I: module-alsa-sink.c: Starting playback.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4776

hyper_sonic 's au8830 a bit lagged .But if switch to integrated i8x0 sound
chip music played very well. on pulseaudio 0.9.19 ( 16 fragments )



I: alsa-sink.c: Using 16,0 fragments of size 4096 bytes (23,22ms), buffer
size is 65536 bytes (371,52ms)
I: alsa-sink.c: Time scheduling watermark is 20,00ms
D: alsa-sink.c: hwbuf_unused=0
D: alsa-sink.c: setting avail_min=15502
D: alsa-mixer.c: Activating path analog-output-lfe-on-mono
D: alsa-mixer.c: Path analog-output-lfe-on-mono (Analog Output (LFE)),
direction=1, priority=40, probed=yes, supported=yes, has_mute=yes,
has_volume=yes, has_dB=yes, min_volume=0, max_volume=31, min_dB=-81,
max_dB=12
D: alsa-mixer.c: Element Master, direction=1, switch=1, volume=1,
enumeration=0, required=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
D: alsa-mixer.c: Element Master Mono, direction=1, switch=1, volume=1,
enumeration=0, required=4, required_absent=0, mask=0x80, n_channels=1,
override_map=yes
D: alsa-mixer.c: Element PCM, direction=1, switch=1, volume=1,
enumeration=0, required=0, required_absent=0, mask=0x402b600000000f66,
n_channels=2, override_map=yes
D: alsa-mixer.c: Element External Amplifier, direction=1, switch=4,
volume=0, enumeration=0, required=0, required_absent=0, mask=0x0,
n_channels=0, override_map=no
D: alsa-mixer.c: Option on (output-amplifier-on/Amplifier) index=1,
priority=10
D: alsa-mixer.c: Option off (output-amplifier-off/No Amplifier) index=0,
priority=0
D: alsa-mixer.c: Setting output-amplifier-on (Amplifier) priority=10
D: alsa-mixer.c: Setting output-amplifier-off (No Amplifier) priority=0
I: alsa-sink.c: Hardware volume ranges from -81,00 dB to 12,00 dB.
I: alsa-sink.c: Fixing base volume to -12,00 dB
I: alsa-sink.c: Using hardware volume control. Hardware dB scale supported.
I: alsa-sink.c: Using hardware mute control.
D: alsa-util.c: snd_pcm_dump():
D: alsa-util.c: Hardware PCM card 1 'Aureal Vortex au8830' device 0
subdevice 0
D: alsa-util.c: Its setup is:
D: alsa-util.c:   stream       : PLAYBACK
D: alsa-util.c:   access       : MMAP_INTERLEAVED
D: alsa-util.c:   format       : S16_LE
D: alsa-util.c:   subformat    : STD
D: alsa-util.c:   channels     : 2
D: alsa-util.c:   rate         : 44100
D: alsa-util.c:   exact rate   : 44100 (44100/1)
D: alsa-util.c:   msbits       : 16
D: alsa-util.c:   buffer_size  : 16384
D: alsa-util.c:   period_size  : 1024
D: alsa-util.c:   period_time  : 23219
D: alsa-util.c:   tstamp_mode  : ENABLE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 15502
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : 1073741824
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 1073741824
D: alsa-util.c:   appl_ptr     : 0
D: alsa-util.c:   hw_ptr       : 0
D: alsa-sink.c: Thread starting up
I: core-util.c: Successfully enabled SCHED_RR scheduling for thread, with
priority 4, which is lower than the requested 5.
D: alsa-sink.c: Requested volume: 0:  23% 1:  23%
D: alsa-sink.c: Got hardware volume: 0:  24% 1:  24%
D: alsa-sink.c: Calculated software volume: 0:  97% 1:  97%
(accurate-enough=no)
I: alsa-sink.c: Starting playback.
D: alsa-sink.c: Cutting sleep time for the initial iterations by half.
D: alsa-sink.c: Cutting sleep time for the initial iterations by half.
D: alsa-sink.c: Cutting sleep time for the initial iterations by half.


> PA ends-up waking-up 150ms or so before the deadline and yet
> it still encounters this error. I don't think it's a problem with PA
> not refilling the buffer on time, it's more that the information
> provided by snd_pcm_avail() is misleading. I commented out the portion
> of the code that increases the watermark and clamped the number of
> available samples to the buffer size, and it works just fine, no audio
> underflows.
> - P
>



Adding the timestamp is the easy way to prove the pulseaudio is writing the
audio in time

The problem may be the timer is not running at the same rate as the sound
card 's clock

or

snd_pcm_rewindable() and snd_pcm_rewind() has bug since PA server is the
only application use snd_pcm_rewind()



http://thread.gmane.org/gmane.linux.alsa.devel/66826/focus=66952

Unfortunately there is no test program to test the snd_pcm_rewind() function


http://thread.gmane.org/gmane.linux.alsa.devel/59470/focus=59641

PCI audio controllers fetch audio from memory in brust mode (i.e. fetch data
must faster than sampling rate 48000Hz) , it is doubt that the application
can really rewind the application pointer to hardware pointer and perform an
immedate rewrite
