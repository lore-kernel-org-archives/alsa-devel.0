From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [pulseaudio-discuss] pulseaudio fails to start
 with kernel 4.11, caused by new snd_hdmi_lpe_audio module)
Date: Tue, 21 Mar 2017 09:56:48 +0100
Message-ID: <bba100b1-5e74-093a-7625-a7feaba1a065@redhat.com>
References: <2549c113-f06b-f22e-d36e-f59fc2969bcb@redhat.com>
 <s5h8to0w4fs.wl-tiwai@suse.de>
 <6754b5cd-f6d0-e2e3-0f01-992946ec1b92@linux.intel.com>
 <s5hk27jjigd.wl-tiwai@suse.de>
 <1490082870.1321124.918129488.4F3143F8@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 79450266CE6
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 09:56:52 +0100 (CET)
In-Reply-To: <1490082870.1321124.918129488.4F3143F8@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun@arunraghavan.net>, Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 21-03-17 08:54, Arun Raghavan wrote:
> On Tue, 21 Mar 2017, at 11:10 AM, Takashi Iwai wrote:
>> On Tue, 21 Mar 2017 00:09:22 +0100,
>> Pierre-Louis Bossart wrote:
>>>
>>> On 3/20/17 4:52 AM, Takashi Iwai wrote:
>>>> On Mon, 20 Mar 2017 12:42:58 +0100,
>>>> Hans de Goede wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> Lately I've been working on fixing various issues people
>>>>> are having with baytrail / cherrytrail devices. One thing
>>>>> I noticed when moving my testing / development to 4.11 is
>>>>> that pulseaudio does not work (it aborts while starting)
>>>>> this seemed to be caused by the new snd_hdmi_lpe_audio
>>>>> module. If I blacklist that all is fine. Any idea what
>>>>> is causing this ?
>>>>
>>>> I noticed it once, too, but I had no time to check further.
>>>> More interestingly, PA works fine when LPE audio is the single driver
>>>> (i.e. blacklist Intel SST instead), too.  So it's more likely a bug in
>>>> PA.
>>>>
>>>> What happens when you modprobe LPE audio driver after starting the
>>>> session?  If it kills PA, we can debug more easily :)
>>>
>>> I've seen this as well, I could get either one of the two but not
>>> both, could this be due to the fact that one set of mixers is
>>> configured with UCM and the other driver isn't configured by UCM?
>>
>> No idea, and I had still no time to check (still processing the
>> pile of pending mails and other bugs :).  Let me add PA guys to Cc.
>
> Not sure if anyone here has the hardware and I haven't seen any
> complaints either -- having a backtrace (or even location of the assert)
> would be a good start.

Ok, this is weird. Since you were asking for more info I tried to
collect a backtrace / logs. But what is happening is that after
the snd_hdmi_lpe_audio module loads, pulse does its thing and
then exits with a message of "killed" in gdb / on the terminal
from which I started it. I don't get a chance to get a backtrace
in gdb ...  So this does feel like a kernel bug to me, normally
this sort of "killed" behavior is seen on some kernel oopses...

But dmesg is free of any oopses ?

Anyways here is a log of pulseaudio -v first without the
hdmi module and then the module gets probed. Where the log
abruptly ends is where I got the "Killed" message on the
terminal.

I: [pulseaudio] main.c: setrlimit(RLIMIT_NICE, (31, 31)) failed: Operation not permitted
I: [pulseaudio] main.c: setrlimit(RLIMIT_RTPRIO, (9, 9)) failed: Operation not permitted
I: [pulseaudio] core-util.c: Successfully gained nice level -11.
I: [pulseaudio] main.c: This is PulseAudio 10.0
I: [pulseaudio] main.c: Page size is 4096 bytes
I: [pulseaudio] main.c: Machine ID is ea8812c830d64c42bbac77fda93c3850.
I: [pulseaudio] main.c: Session ID is 2.
I: [pulseaudio] main.c: Using runtime directory /run/user/1000/pulse.
I: [pulseaudio] main.c: Using state directory /home/hans/.config/pulse.
I: [pulseaudio] main.c: Using modules directory /usr/lib64/pulse-10.0/modules.
I: [pulseaudio] main.c: Running in system mode: no
W: [pulseaudio] pid.c: Stale PID file, overwriting.
I: [pulseaudio] main.c: System supports high resolution timers
I: [pulseaudio] cpu-x86.c: CPU flags: CMOV MMX SSE SSE2 SSE3 SSSE3 SSE4_1 SSE4_2
I: [pulseaudio] svolume_mmx.c: Initialising MMX optimized volume functions.
I: [pulseaudio] remap_mmx.c: Initialising MMX optimized remappers.
I: [pulseaudio] svolume_sse.c: Initialising SSE2 optimized volume functions.
I: [pulseaudio] remap_sse.c: Initialising SSE2 optimized remappers.
I: [pulseaudio] sconv_sse.c: Initialising SSE2 optimized conversions.
I: [pulseaudio] svolume_orc.c: Initialising ORC optimized volume functions.
I: [pulseaudio] module-device-restore.c: Successfully opened database file '/home/hans/.config/pulse/ea8812c830d64c42bbac77fda93c3850-device-volumes'.
I: [pulseaudio] module.c: Loaded "module-device-restore" (index: #0; argument: "").
I: [pulseaudio] module-stream-restore.c: Successfully opened database file '/home/hans/.config/pulse/ea8812c830d64c42bbac77fda93c3850-stream-volumes'.
I: [pulseaudio] module.c: Loaded "module-stream-restore" (index: #1; argument: "").
I: [pulseaudio] module-card-restore.c: Successfully opened database file '/home/hans/.config/pulse/ea8812c830d64c42bbac77fda93c3850-card-database'.
I: [pulseaudio] module.c: Loaded "module-card-restore" (index: #2; argument: "").
I: [pulseaudio] module.c: Loaded "module-augment-properties" (index: #3; argument: "").
I: [pulseaudio] module.c: Loaded "module-switch-on-port-available" (index: #4; argument: "").
I: [pulseaudio] alsa-ucm.c: UCM available for card chtrt5645
I: [pulseaudio] alsa-ucm.c: Set UCM verb to HiFi
I: [pulseaudio] module-alsa-card.c: Found UCM profiles
I: [pulseaudio] alsa-ucm.c: Set ucm verb to HiFi
I: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_buffer_size_near() failed: Invalid argument
I: [pulseaudio] alsa-util.c: Device hw:chtrt5645 doesn't support 44100 Hz, changed to 48000 Hz.
I: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_buffer_size_near() failed: Invalid argument
I: [pulseaudio] alsa-util.c: Device hw:chtrt5645 doesn't support 44100 Hz, changed to 48000 Hz.
I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:chtrt5645'
I: [pulseaudio] alsa-ucm.c: UCM jack Headphones has_control=0
I: [pulseaudio] alsa-ucm.c: UCM jack Speaker has_control=0
I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:chtrt5645'
I: [pulseaudio] alsa-ucm.c: UCM jack Headset Mic has_control=1
I: [pulseaudio] alsa-ucm.c: UCM jack DMic has_control=0
I: [pulseaudio] alsa-ucm.c: UCM jack Mic has_control=0
I: [pulseaudio] module-card-restore.c: Restoring port latency offsets for card alsa_card.platform-cht-bsw-rt5645.
I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:0'
I: [pulseaudio] card.c: Created 0 "alsa_card.platform-cht-bsw-rt5645"
I: [pulseaudio] alsa-ucm.c: Set UCM verb to HiFi
I: [pulseaudio] alsa-util.c: Cannot disable ALSA period wakeups
I: [pulseaudio] alsa-util.c: Device hw:chtrt5645 doesn't support 44100 Hz, changed to 48000 Hz.
I: [pulseaudio] alsa-util.c: ALSA period wakeups were not disabled
I: [pulseaudio] alsa-sink.c: Successfully opened device hw:chtrt5645.
I: [pulseaudio] alsa-sink.c: Selected mapping 'Headphones + Speaker' (HiFi: hw:chtrt5645: sink).
I: [pulseaudio] alsa-sink.c: Successfully enabled mmap() mode.
I: [pulseaudio] alsa-sink.c: Successfully enabled timer-based scheduling mode.
I: [pulseaudio] alsa-ucm.c: ALSA device hw:chtrt5645 roles: (null)
I: [pulseaudio] module-device-restore.c: Restoring port for sink sink:alsa_output.platform-cht-bsw-rt5645.HiFi__hw_chtrt5645__sink.
W: [pulseaudio] sink.c: Default and alternate sample rates are the same.
I: [pulseaudio] sink.c: Created sink 0 "alsa_output.platform-cht-bsw-rt5645.HiFi__hw_chtrt5645__sink" with sample spec s16le 2ch 48000Hz and channel map front-left,front-right
I: [pulseaudio] sink.c:     alsa.resolution_bits = "16"
I: [pulseaudio] sink.c:     device.api = "alsa"
I: [pulseaudio] sink.c:     device.class = "sound"
I: [pulseaudio] sink.c:     alsa.class = "generic"
I: [pulseaudio] sink.c:     alsa.subclass = "generic-mix"
I: [pulseaudio] sink.c:     alsa.name = ""
I: [pulseaudio] sink.c:     alsa.id = "1"
I: [pulseaudio] sink.c:     alsa.subdevice = "0"
I: [pulseaudio] sink.c:     alsa.subdevice_name = "subdevice #0"
I: [pulseaudio] sink.c:     alsa.device = "0"
I: [pulseaudio] sink.c:     alsa.card = "0"
I: [pulseaudio] sink.c:     alsa.card_name = "chtrt5645"
I: [pulseaudio] sink.c:     alsa.long_card_name = "chtrt5645"
I: [pulseaudio] sink.c:     alsa.driver_name = "snd_soc_sst_cht_bsw_rt5645"
I: [pulseaudio] sink.c:     device.bus_path = "platform-cht-bsw-rt5645"
I: [pulseaudio] sink.c:     sysfs.path = "/devices/pci0000:00/808622A8:00/cht-bsw-rt5645/sound/card0"
I: [pulseaudio] sink.c:     device.string = "hw:chtrt5645"
I: [pulseaudio] sink.c:     device.buffering.buffer_size = "384000"
I: [pulseaudio] sink.c:     device.buffering.fragment_size = "192000"
I: [pulseaudio] sink.c:     device.access_mode = "mmap+timer"
I: [pulseaudio] sink.c:     device.profile.name = "HiFi: hw:chtrt5645: sink"
I: [pulseaudio] sink.c:     device.profile.description = "Headphones + Speaker"
I: [pulseaudio] sink.c:     device.description = "chtrt5645 Headphones + Speaker"
I: [pulseaudio] sink.c:     module-udev-detect.discovered = "1"
I: [pulseaudio] sink.c:     device.icon_name = "audio-card"
I: [pulseaudio] source.c: Created source 0 "alsa_output.platform-cht-bsw-rt5645.HiFi__hw_chtrt5645__sink.monitor" with sample spec s16le 2ch 48000Hz and channel map front-left,front-right
I: [pulseaudio] source.c:     device.description = "Monitor of chtrt5645 Headphones + Speaker"
I: [pulseaudio] source.c:     device.class = "monitor"
I: [pulseaudio] source.c:     alsa.card = "0"
I: [pulseaudio] source.c:     alsa.card_name = "chtrt5645"
I: [pulseaudio] source.c:     alsa.long_card_name = "chtrt5645"
I: [pulseaudio] source.c:     alsa.driver_name = "snd_soc_sst_cht_bsw_rt5645"
I: [pulseaudio] source.c:     device.bus_path = "platform-cht-bsw-rt5645"
I: [pulseaudio] source.c:     sysfs.path = "/devices/pci0000:00/808622A8:00/cht-bsw-rt5645/sound/card0"
I: [pulseaudio] source.c:     device.string = "0"
I: [pulseaudio] source.c:     module-udev-detect.discovered = "1"
I: [pulseaudio] source.c:     device.icon_name = "audio-card"
I: [pulseaudio] alsa-sink.c: Using 2.0 fragments of size 192000 bytes (1000.00ms), buffer size is 384000 bytes (2000.00ms)
I: [pulseaudio] alsa-sink.c: Time scheduling watermark is 18.38ms
I: [alsa-sink-1] core-util.c: Successfully enabled SCHED_RR scheduling for thread, with priority 5.
I: [alsa-sink-1] alsa-sink.c: Starting playback.
I: [pulseaudio] alsa-util.c: Cannot disable ALSA period wakeups
I: [pulseaudio] alsa-util.c: Device hw:chtrt5645 doesn't support 44100 Hz, changed to 48000 Hz.
I: [pulseaudio] alsa-util.c: ALSA period wakeups were not disabled
I: [pulseaudio] alsa-source.c: Successfully opened device hw:chtrt5645.
I: [pulseaudio] alsa-source.c: Selected mapping 'Headset Microphone + Internal Digital Microphones + Internal Analog Microphones' (HiFi: hw:chtrt5645: source).
I: [pulseaudio] alsa-source.c: Successfully enabled mmap() mode.
I: [pulseaudio] alsa-source.c: Successfully enabled timer-based scheduling mode.
I: [pulseaudio] alsa-ucm.c: ALSA device hw:chtrt5645 roles: (null)
W: [pulseaudio] source.c: Default and alternate sample rates are the same.
I: [pulseaudio] source.c: Created source 1 "alsa_input.platform-cht-bsw-rt5645.HiFi__hw_chtrt5645__source" with sample spec s16le 2ch 48000Hz and channel map front-left,front-right
I: [pulseaudio] source.c:     alsa.resolution_bits = "16"
I: [pulseaudio] source.c:     device.api = "alsa"
I: [pulseaudio] source.c:     device.class = "sound"
I: [pulseaudio] source.c:     alsa.class = "generic"
I: [pulseaudio] source.c:     alsa.subclass = "generic-mix"
I: [pulseaudio] source.c:     alsa.name = ""
I: [pulseaudio] source.c:     alsa.id = "3"
I: [pulseaudio] source.c:     alsa.subdevice = "0"
I: [pulseaudio] source.c:     alsa.subdevice_name = "subdevice #0"
I: [pulseaudio] source.c:     alsa.device = "0"
I: [pulseaudio] source.c:     alsa.card = "0"
I: [pulseaudio] source.c:     alsa.card_name = "chtrt5645"
I: [pulseaudio] source.c:     alsa.long_card_name = "chtrt5645"
I: [pulseaudio] source.c:     alsa.driver_name = "snd_soc_sst_cht_bsw_rt5645"
I: [pulseaudio] source.c:     device.bus_path = "platform-cht-bsw-rt5645"
I: [pulseaudio] source.c:     sysfs.path = "/devices/pci0000:00/808622A8:00/cht-bsw-rt5645/sound/card0"
I: [pulseaudio] source.c:     device.string = "hw:chtrt5645"
I: [pulseaudio] source.c:     device.buffering.buffer_size = "384000"
I: [pulseaudio] source.c:     device.buffering.fragment_size = "192000"
I: [pulseaudio] source.c:     device.access_mode = "mmap+timer"
I: [pulseaudio] source.c:     device.profile.name = "HiFi: hw:chtrt5645: source"
I: [pulseaudio] source.c:     device.profile.description = "Headset Microphone + Internal Digital Microphones + Internal Analog Microphones"
I: [pulseaudio] source.c:     device.description = "chtrt5645 Headset Microphone + Internal Digital Microphones + Internal Analog Microphones"
I: [pulseaudio] source.c:     module-udev-detect.discovered = "1"
I: [pulseaudio] source.c:     device.icon_name = "audio-card"
I: [pulseaudio] alsa-source.c: Using 2.0 fragments of size 192000 bytes (1000.00ms), buffer size is 384000 bytes (2000.00ms)
I: [pulseaudio] alsa-source.c: Time scheduling watermark is 18.38ms
I: [alsa-source-3] core-util.c: Successfully enabled SCHED_RR scheduling for thread, with priority 5.
I: [alsa-source-3] alsa-source.c: Starting capture.
I: [pulseaudio] module.c: Loaded "module-alsa-card" (index: #6; argument: "device_id="0" name="platform-cht-bsw-rt5645" card_name="alsa_card.platform-cht-bsw-rt5645" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1"").
I: [pulseaudio] module-udev-detect.c: Card /devices/pci0000:00/808622A8:00/cht-bsw-rt5645/sound/card0 (alsa_card.platform-cht-bsw-rt5645) module loaded.
I: [pulseaudio] module-udev-detect.c: Found 1 cards.
I: [pulseaudio] module.c: Loaded "module-udev-detect" (index: #5; argument: "").
I: [pulseaudio] module.c: Loaded "module-bluetooth-policy" (index: #7; argument: "").
I: [pulseaudio] module.c: Loaded "module-bluez5-discover" (index: #9; argument: "").
I: [pulseaudio] module.c: Loaded "module-bluetooth-discover" (index: #8; argument: "").
I: [pulseaudio] module.c: Loaded "module-esound-protocol-unix" (index: #10; argument: "").
I: [pulseaudio] module.c: Loaded "module-native-protocol-unix" (index: #11; argument: "").
I: [pulseaudio] module-default-device-restore.c: Restored default sink 'alsa_output.platform-cht-bsw-rt5645.HiFi__hw_chtrt5645__sink'.
I: [pulseaudio] module-default-device-restore.c: Restored default source 'alsa_input.platform-cht-bsw-rt5645.HiFi__hw_chtrt5645__source'.
I: [pulseaudio] module.c: Loaded "module-default-device-restore" (index: #12; argument: "").
I: [pulseaudio] module.c: Loaded "module-rescue-streams" (index: #13; argument: "").
I: [pulseaudio] module.c: Loaded "module-always-sink" (index: #14; argument: "").
I: [pulseaudio] module.c: Loaded "module-intended-roles" (index: #15; argument: "").
I: [pulseaudio] module.c: Loaded "module-suspend-on-idle" (index: #16; argument: "").
I: [pulseaudio] client.c: Created 0 "Login Session 2"
I: [pulseaudio] module.c: Loaded "module-systemd-login" (index: #17; argument: "").
I: [pulseaudio] module.c: Loaded "module-position-event-sounds" (index: #18; argument: "").
I: [pulseaudio] module.c: Loaded "module-role-cork" (index: #19; argument: "").
I: [pulseaudio] module.c: Loaded "module-filter-heuristics" (index: #20; argument: "").
I: [pulseaudio] module.c: Loaded "module-filter-apply" (index: #21; argument: "").
I: [pulseaudio] main.c: Daemon startup complete.
I: [pulseaudio] module-suspend-on-idle.c: Source alsa_input.platform-cht-bsw-rt5645.HiFi__hw_chtrt5645__source idle for too long, suspending ...
I: [alsa-source-3] alsa-source.c: Device suspended...
I: [pulseaudio] module-suspend-on-idle.c: Sink alsa_output.platform-cht-bsw-rt5645.HiFi__hw_chtrt5645__sink idle for too long, suspending ...
I: [alsa-sink-1] alsa-sink.c: Device suspended...
I: [pulseaudio] (alsa-lib)utils.c: could not open configuration file /usr/share/alsa/ucm/Intel HDMI/DP LPE Audio/Intel HDMI/DP LPE Audio.conf
I: [pulseaudio] (alsa-lib)parser.c: error: could not parse configuration for card Intel HDMI/DP LPE Audio
I: [pulseaudio] (alsa-lib)main.c: error: failed to import Intel HDMI/DP LPE Audio use case configuration -2
I: [pulseaudio] alsa-ucm.c: UCM not available for card Intel HDMI/DP LPE Audio
I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0c' failed (-2)
I: [pulseaudio] alsa-util.c: Error opening PCM device hw:1: No such file or directory
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM front:1
I: [pulseaudio] alsa-util.c: Error opening PCM device front:1: Invalid argument
I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0c' failed (-2)
I: [pulseaudio] alsa-util.c: Error opening PCM device hw:1: No such file or directory
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM iec958:1
I: [pulseaudio] alsa-util.c: Error opening PCM device iec958:1: Invalid argument
I: [pulseaudio] alsa-util.c: Failed to set hardware parameters on plug:hw:1: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM front:1
I: [pulseaudio] alsa-util.c: Error opening PCM device front:1: Invalid argument
I: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_buffer_size_near() failed: Invalid argument
I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:1'
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM surround21:1
I: [pulseaudio] alsa-util.c: Error opening PCM device surround21:1: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM surround40:1
I: [pulseaudio] alsa-util.c: Error opening PCM device surround40:1: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM surround41:1
I: [pulseaudio] alsa-util.c: Error opening PCM device surround41:1: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM surround50:1
I: [pulseaudio] alsa-util.c: Error opening PCM device surround50:1: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM surround51:1
I: [pulseaudio] alsa-util.c: Error opening PCM device surround51:1: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM surround71:1
I: [pulseaudio] alsa-util.c: Error opening PCM device surround71:1: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM iec958:1
I: [pulseaudio] alsa-util.c: Error opening PCM device iec958:1: Invalid argument
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:1
I: [pulseaudio] alsa-util.c: Error opening PCM device a52:1: No such file or directory
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:1
I: [pulseaudio] alsa-util.c: Error opening PCM device a52:1: No such file or directory
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dca:1
I: [pulseaudio] alsa-util.c: Error opening PCM device dca:1: No such file or directory
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1: Invalid argument
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1
I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1: No such file or directory
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,1
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,1: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,1
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,1: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,1
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,1: Invalid argument
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1,1
I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1,1: No such file or directory
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,2
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,2
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,2: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,2
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,2
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,2: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,2
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,2
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,2: Invalid argument
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1,2
I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1,2: No such file or directory
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,3
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,3
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,3: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,3
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,3
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,3: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,3
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,3
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,3: Invalid argument
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1,3
I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1,3: No such file or directory
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,4
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,4
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,4: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,4
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,4
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,4: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,4
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,4
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,4: Invalid argument
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1,4
I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1,4: No such file or directory
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,5
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,5
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,5: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,5
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,5
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,5: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,5
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,5
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,5: Invalid argument
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1,5
I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1,5: No such file or directory
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,6
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,6
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,6: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,6
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,6
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,6: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,6
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,6
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,6: Invalid argument
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1,6
I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1,6: No such file or directory
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,7
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,7
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,7: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,7
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,7
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,7: Invalid argument
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1,7
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:1,7
I: [pulseaudio] alsa-util.c: Error opening PCM device hdmi:1,7: Invalid argument
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dcahdmi:1,7
I: [pulseaudio] alsa-util.c: Error opening PCM device dcahdmi:1,7: No such file or directory
I: [pulseaudio] (alsa-lib)pcm_hw.c: open '/dev/snd/pcmC1D0c' failed (-2)
I: [pulseaudio] alsa-util.c: Error opening PCM device hw:1: No such file or directory
I: [pulseaudio] module-card-restore.c: Restoring port latency offsets for card alsa_card.pci-0000_00_02.0-platform-hdmi-lpe-audio.
I: [pulseaudio] card.c: Created 1 "alsa_card.pci-0000_00_02.0-platform-hdmi-lpe-audio"
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 1
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM front:1
I: [pulseaudio] alsa-util.c: Error opening PCM device front:1: Invalid argument
I: [pulseaudio] alsa-util.c: Trying to disable ALSA period wakeups, using timers only
I: [pulseaudio] alsa-util.c: snd_pcm_hw_params_set_buffer_size_near() failed: Invalid argument
I: [pulseaudio] alsa-util.c: ALSA period wakeups disabled
I: [pulseaudio] alsa-sink.c: Successfully opened device hw:1.
I: [pulseaudio] alsa-sink.c: Selected mapping 'Analog Stereo' (analog-stereo).
I: [pulseaudio] alsa-sink.c: Successfully enabled mmap() mode.
I: [pulseaudio] alsa-sink.c: Successfully enabled timer-based scheduling mode.
I: [pulseaudio] alsa-util.c: Successfully attached to mixer 'hw:1'
I: [pulseaudio] sink.c: Created sink 1 "alsa_output.pci-0000_00_02.0-platform-hdmi-lpe-audio.analog-stereo" with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
I: [pulseaudio] sink.c:     alsa.resolution_bits = "16"
I: [pulseaudio] sink.c:     device.api = "alsa"
I: [pulseaudio] sink.c:     device.class = "sound"
I: [pulseaudio] sink.c:     alsa.class = "generic"
I: [pulseaudio] sink.c:     alsa.subclass = "generic-mix"
I: [pulseaudio] sink.c:     alsa.name = "Intel HDMI/DP LPE Audio"
I: [pulseaudio] sink.c:     alsa.id = "HdmiLpeAudio"
I: [pulseaudio] sink.c:     alsa.subdevice = "0"
I: [pulseaudio] sink.c:     alsa.subdevice_name = "subdevice #0"
I: [pulseaudio] sink.c:     alsa.device = "0"
I: [pulseaudio] sink.c:     alsa.card = "1"
I: [pulseaudio] sink.c:     alsa.card_name = "Intel HDMI/DP LPE Audio"
I: [pulseaudio] sink.c:     alsa.long_card_name = "Intel HDMI/DP LPE Audio"
I: [pulseaudio] sink.c:     alsa.driver_name = "snd_hdmi_lpe_audio"
I: [pulseaudio] sink.c:     device.bus_path = "pci-0000:00:02.0-platform-hdmi-lpe-audio"
I: [pulseaudio] sink.c:     sysfs.path = "/devices/pci0000:00/0000:00:02.0/hdmi-lpe-audio/sound/card1"
I: [pulseaudio] sink.c:     device.bus = "pci"
I: [pulseaudio] sink.c:     device.vendor.id = "8086"
I: [pulseaudio] sink.c:     device.vendor.name = "Intel Corporation"
I: [pulseaudio] sink.c:     device.product.id = "22b0"
I: [pulseaudio] sink.c:     device.product.name = "Atom/Celeron/Pentium Processor x5-E8000/J3xxx/N3xxx Series PCI Configuration Registers"
I: [pulseaudio] sink.c:     device.string = "hw:1"
I: [pulseaudio] sink.c:     device.buffering.buffer_size = "352832"
I: [pulseaudio] sink.c:     device.buffering.fragment_size = "352832"
I: [pulseaudio] sink.c:     device.access_mode = "mmap+timer"
I: [pulseaudio] sink.c:     device.profile.name = "analog-stereo"
I: [pulseaudio] sink.c:     device.profile.description = "Analog Stereo"
I: [pulseaudio] sink.c:     device.description = "Atom/Celeron/Pentium Processor x5-E8000/J3xxx/N3xxx Series PCI Configuration Registers Analog Stereo"
I: [pulseaudio] sink.c:     module-udev-detect.discovered = "1"
I: [pulseaudio] sink.c:     device.icon_name = "audio-card-pci"
I: [pulseaudio] source.c: Created source 2 "alsa_output.pci-0000_00_02.0-platform-hdmi-lpe-audio.analog-stereo.monitor" with sample spec s16le 2ch 44100Hz and channel map front-left,front-right
I: [pulseaudio] source.c:     device.description = "Monitor of Atom/Celeron/Pentium Processor x5-E8000/J3xxx/N3xxx Series PCI Configuration Registers Analog Stereo"
I: [pulseaudio] source.c:     device.class = "monitor"
I: [pulseaudio] source.c:     alsa.card = "1"
I: [pulseaudio] source.c:     alsa.card_name = "Intel HDMI/DP LPE Audio"
I: [pulseaudio] source.c:     alsa.long_card_name = "Intel HDMI/DP LPE Audio"
I: [pulseaudio] source.c:     alsa.driver_name = "snd_hdmi_lpe_audio"
I: [pulseaudio] source.c:     device.bus_path = "pci-0000:00:02.0-platform-hdmi-lpe-audio"
I: [pulseaudio] source.c:     sysfs.path = "/devices/pci0000:00/0000:00:02.0/hdmi-lpe-audio/sound/card1"
I: [pulseaudio] source.c:     device.bus = "pci"
I: [pulseaudio] source.c:     device.vendor.id = "8086"
I: [pulseaudio] source.c:     device.vendor.name = "Intel Corporation"
I: [pulseaudio] source.c:     device.product.id = "22b0"
I: [pulseaudio] source.c:     device.product.name = "Atom/Celeron/Pentium Processor x5-E8000/J3xxx/N3xxx Series PCI Configuration Registers"
I: [pulseaudio] source.c:     device.string = "1"
I: [pulseaudio] source.c:     module-udev-detect.discovered = "1"
I: [pulseaudio] source.c:     device.icon_name = "audio-card-pci"
I: [pulseaudio] alsa-sink.c: Using 1.0 fragments of size 352832 bytes (2000.18ms), buffer size is 352832 bytes (2000.18ms)
I: [pulseaudio] alsa-sink.c: Time scheduling watermark is 20.00ms
I: [pulseaudio] alsa-sink.c: Driver does not support hardware volume control, falling back to software volume control.
I: [pulseaudio] alsa-sink.c: Driver does not support hardware mute control, falling back to software mute control.
I: [alsa-sink-HdmiLpeAudio] core-util.c: Successfully enabled SCHED_RR scheduling for thread, with priority 5.
I: [alsa-sink-HdmiLpeAudio] alsa-sink.c: Starting playback.
I: [alsa-sink-HdmiLpeAudio] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HWSYNC failed (-32)
I: [pulseaudio] module.c: Loaded "module-alsa-card" (index: #22; argument: "device_id="1" name="pci-0000_00_02.0-platform-hdmi-lpe-audio" card_name="alsa_card.pci-0000_00_02.0-platform-hdmi-lpe-audio" namereg_fail=false tsched=yes fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes card_properties="module-udev-detect.discovered=1"").
I: [pulseaudio] module-udev-detect.c: Card /devices/pci0000:00/0000:00:02.0/hdmi-lpe-audio/sound/card1 (alsa_card.pci-0000_00_02.0-platform-hdmi-lpe-audio) module loaded.
I: [alsa-sink-HdmiLpeAudio] alsa-sink.c: Starting playback.
I: [alsa-sink-HdmiLpeAudio] alsa-sink.c: Starting playback.
I: [alsa-sink-HdmiLpeAudio] alsa-sink.c: Starting playback.
I: [alsa-sink-HdmiLpeAudio] alsa-sink.c: Starting playback.
I: [alsa-sink-HdmiLpeAudio] alsa-sink.c: Starting playback.
I: [alsa-sink-HdmiLpeAudio] alsa-sink.c: Starting playback.

Note I'm seeing this on multiple Cherry Trail devices as well
as on a Bay Trail Asus T100TA (if I remember correctly, not sure about
that last one).

Regards,

Hans
