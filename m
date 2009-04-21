From: Peter-Jan Deweirdt <deweirdt@gmail.com>
Subject: Re: Cirrus Logic CS4207
Date: Tue, 21 Apr 2009 14:09:36 +0200
Message-ID: <CF6329B1-EA28-4D24-9270-53337BD153C2@gmail.com>
References: <625B7AA8-CE98-4B12-A664-27A8B6599E7B@gmail.com>
	<s5hd4bbuyjh.wl%tiwai@suse.de>
	<C92A6B7E-231B-435A-93D0-4B50A590B35A@gmail.com>
	<s5h8wlui695.wl%tiwai@suse.de>
	<268FD6BD-CA15-4AD0-B71D-CA85F9423D37@gmail.com>
	<s5h7i1ei5da.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D3C3103842
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Apr 2009 14:09:39 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 26so438308eyw.56
	for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2009 05:09:39 -0700 (PDT)
In-Reply-To: <s5h7i1ei5da.wl%tiwai@suse.de>
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


On 21 Apr 2009, at 14:00, Takashi Iwai wrote:

> At Tue, 21 Apr 2009 13:49:17 +0200,
> Peter-Jan Deweirdt wrote:
>>
>>
>> On 21 Apr 2009, at 13:41, Takashi Iwai wrote:
>>
>>> At Tue, 21 Apr 2009 09:24:31 +0200,
>>> Peter-Jan Deweirdt wrote:
>>>>
>>>> Hi,
>>>>
>>>> This is the patch that I've changed to the 2.6.29 kernel. However I
>>>> need some more help for playing the audio. Since I don't really  
>>>> know
>>>> what is happening.
>>>>
>>>> It's detecting my audio chip. (a part of dmesg)
>>>> [    5.171478] Advanced Linux Sound Architecture Driver Version
>>>> 1.0.18a.
>>>> [    5.176635] HDA Intel 0000:00:1b.0: setting latency timer to 64
>>>> [    5.220417] ALSA device list:
>>>> [    5.220434]   #0: HDA Intel MID at 0xd0010000 irq 22
>>>>
>>>> So it looks like my audio card is found. Some more outputs
>>>>
>>>> lspci -v
>>>> 00:1b.0 Audio device: Intel Corporation System Controller Hub (SCH
>>>> Poulsbo) HD Audio Controller (rev 06)
>>>> 	Subsystem: Intel Corporation Unknown device 8119
>>>> 	Flags: bus master, fast devsel, latency 0, IRQ 22
>>>> 	Memory at d0010000 (64-bit, non-prefetchable) [size=16K]
>>>> 	Capabilities: [50] Power Management version 2
>>>> 	Capabilities: [70] Express Root Complex Integrated Endpoint, MSI  
>>>> 00
>>>> 	Kernel driver in use: HDA Intel
>>>>
>>>>
>>>> [root@localhost ~]# cat /proc/asound/cards
>>>> 0 [MID            ]: HDA-Intel - HDA Intel MID
>>>>                      HDA Intel MID at 0xd0010000 irq 22
>>>> [root@localhost ~]#
>>>>
>>>> [root@localhost ~]# aplay -l
>>>> **** List of PLAYBACK Hardware Devices ****
>>>> card 0: MID [HDA Intel MID], device 0: CS4207 Analog [CS4207  
>>>> Analog]
>>>>  Subdevices: 1/1
>>>>  Subdevice #0: subdevice #0
>>>> card 0: MID [HDA Intel MID], device 1: CS4207 Digital [CS4207
>>>> Digital]
>>>>  Subdevices: 1/1
>>>>  Subdevice #0: subdevice #0
>>>> [root@localhost ~]#
>>>>
>>>>
>>>> [root@localhost ~]# aplay -L
>>>> front:CARD=MID,DEV=0
>>>>    HDA Intel MID, CS4207 Analog
>>>>    Front speakers
>>>> surround40:CARD=MID,DEV=0
>>>>    HDA Intel MID, CS4207 Analog
>>>>    4.0 Surround output to Front and Rear speakers
>>>> surround41:CARD=MID,DEV=0
>>>>    HDA Intel MID, CS4207 Analog
>>>>    4.1 Surround output to Front, Rear and Subwoofer speakers
>>>> surround50:CARD=MID,DEV=0
>>>>    HDA Intel MID, CS4207 Analog
>>>>    5.0 Surround output to Front, Center and Rear speakers
>>>> surround51:CARD=MID,DEV=0
>>>>    HDA Intel MID, CS4207 Analog
>>>>    5.1 Surround output to Front, Center, Rear and Subwoofer  
>>>> speakers
>>>> surround71:CARD=MID,DEV=0
>>>>    HDA Intel MID, CS4207 Analog
>>>>    7.1 Surround output to Front, Center, Side, Rear and Woofer
>>>> speakers
>>>> iec958:CARD=MID,DEV=0
>>>>    HDA Intel MID, CS4207 Digital
>>>>    IEC958 (S/PDIF) Digital Audio Output
>>>> null
>>>>    Discard all samples (playback) or generate zero samples  
>>>> (capture)
>>>> pulse
>>>>    PulseAudio Sound Server
>>>> default
>>>>    Default
>>>> [root@localhost ~]#
>>>>
>>>> [root@localhost ~]# ls -al /dev/snd/
>>>> total 0
>>>> drwxr-xr-x  2 root root     200 Mar 24 20:00 .
>>>> drwxr-xr-x 15 root root    3360 Mar 24 20:00 ..
>>>> crw-rw----  1 root audio 116, 9 Mar 24 20:00 controlC0
>>>> crw-rw----  1 root audio 116, 8 Mar 24 20:00 hwC0D0
>>>> crw-rw----  1 root audio 116, 7 Mar 24 20:00 pcmC0D0c
>>>> crw-rw----  1 root audio 116, 6 Mar 24 20:58 pcmC0D0p
>>>> crw-rw----  1 root audio 116, 5 Mar 24 20:00 pcmC0D1c
>>>> crw-rw----  1 root audio 116, 4 Mar 24 20:30 pcmC0D1p
>>>> crw-rw----  1 root audio 116, 3 Mar 24 20:00 seq
>>>> crw-rw----  1 root audio 116, 2 Mar 24 20:00 timer
>>>> [root@localhost ~]#
>>>
>>> All look good, so far.
>>
>> Why am I missing /dev/dsp, /dev/audio, ...
>
> You didn't load OSS emulation modules, such as snd-pcm-oss.

Well I'm using moblin. I tried with the kernel that you can download  
from the site but that was also no go. Why would I need OSS emulation?  
What is that?




>
>
>>
>>
>>>
>>>
>>>
>>>> The problems that I'm having is:
>>>> - How to play audio?
>>>
>>> 	% aplay foo.wav
>>
>> [root@localhost ~]# aplay tara.wav
>> ALSA lib pulse.c:272:(pulse_connect) PulseAudio: Unable to connect:
>> Connection refused
>>
>> aplay: main:590: audio open error: Connection refused
>
> It's a problem of pulseaudio, for example, PA isn't started
> automatically by some reason.

This is the output from pulseaudio with the verbose flag:
[root@localhost ~]# pulseaudio -v
I: core-util.c: Successfully gained nice level -11.
W: ltdl-bind-now.c: Failed to find original dlopen loader.
W: main.c: This program is not intended to be run as root (unless -- 
system is specified).
I: main.c: This is PulseAudio 0.9.14
I: main.c: Page size is 4096 bytes
I: main.c: Machine ID is 061605e6c528796142fe9e3249c97497.
I: main.c: Using runtime directory /root/.pulse/ 
061605e6c528796142fe9e3249c97497:runtime.
I: main.c: Using state directory /root/.pulse.
I: main.c: Running in system mode: no
W: pid.c: Stale PID file, overwriting.
I: main.c: Dude, your kernel stinks! The chef's recommendation today  
is Linux with high-resolution timers enabled!
I: module-hal-detect.c: Trying capability alsa
N: module-alsa-sink.c: Disabling timer-based scheduling because high- 
resolution timers are not available from the kernel.
I: module-alsa-sink.c: Successfully opened device front:0.
I: module-alsa-sink.c: Successfully enabled mmap() mode.
I: (alsa-lib)control.c: Invalid CTL front:0
I: alsa-util.c: Unable to attach to mixer front:0: No such file or  
directory
I: alsa-util.c: Successfully attached to mixer 'hw:0'
I: alsa-util.c: Cannot find mixer control "Master".
I: alsa-util.c: Using mixer control "PCM".
I: sink.c: Created sink 0  
"alsa_output.pci_8086_811b_sound_card_0_alsa_playback_0" with sample  
spec s16le 2ch 44100Hz and channel map front-left,front-right
I: source.c: Created source 0  
"alsa_output.pci_8086_811b_sound_card_0_alsa_playback_0.monitor" with  
sample spec s16le 2ch 44100Hz and channel map front-left,front-right
I: module-alsa-sink.c: Using 4 fragments of size 4352 bytes, buffer  
time is 98.68ms
I: module-alsa-sink.c: Volume ranges from 0 to 255.
I: module-alsa-sink.c: Volume ranges from -51.00 dB to 0.00 dB.
I: alsa-util.c: All 2 channels can be mapped to mixer channels.
I: module-alsa-sink.c: Using hardware volume control. Hardware dB  
scale supported.
I: module-alsa-sink.c: Using software mute control.
I: module-alsa-sink.c: Starting playback.
Soft CPU time limit exhausted, terminating.
Hard CPU time limit exhausted, terminating forcibly.
Aborted (core dumped)
[root@localhost ~]#

Any suggestions?


>
>
>> [root@localhost ~]#
>>
>> Looks like PulseAudio is not running. When I try to start it I get  
>> this:
>> [root@localhost ~]# pulseaudio
>> W: ltdl-bind-now.c: Failed to find original dlopen loader.
>> W: main.c: This program is not intended to be run as root (unless --
>> system is specified).
>> W: pid.c: Stale PID file, overwriting.
>> N: module-alsa-sink.c: Disabling timer-based scheduling because high-
>> resolution timers are not available from the kernel.
>> Soft CPU time limit exhausted, terminating.
>> Hard CPU time limit exhausted, terminating forcibly.
>> Aborted (core dumped)
>> [root@localhost ~]#
>>
>> dump from dmesg
>> [  610.355008] ALSA sound/pci/hda/hda_intel.c:648: hda_intel:
>> azx_get_response timeout, switching to single_cmd mode: last
>> cmd=0x009f000c
>
> Looks like an invalid verb.  Maybe an error in the cirrus patch.
> This is the likely reason why PA got screwed, too.
> But, you should try really later version of the kernel if you use PA.
>
> Or, avoid PA for the primary testing unless all things are sorted
> out.
>
I'm not sure if I need PA. But with on my development platform it was  
very easy to test by writing a wav file to /dev/audio and I had sound.  
I don't know if this has anything to do with PA.

>
>>>> - I am seeing 2 playback devices (what is correct) but no  
>>>> headphones
>>>
>>> The streams are just for analog and digital outputs.
>>> The analog outputs are switched either by the automatic HP jack
>>> detection or manual switch (if any).
>>
>> So this means that I'm nog going to be able to play audio on the
>> LineOut1, LineOut2 and HP at the same time?
>
> Depending on the implementation, but usually yes.
>
>
>>>> - How can I see the difference between the MIC in and LINE IN?
>>>
>>> Via mixer controls.
>>
>> How can I use the mixer controls? Do I need some specific devices?
>
> Via a mixer app.  And, no, no special device is needed.  The mixer
> is controlled over the control device, /dev/snd/control*.


Can you guide me trough to verify why PA is not working and how I can  
play and capture audio?

PJ

>
>
>
> Takashi
