From: Peter-Jan Deweirdt <deweirdt@gmail.com>
Subject: Re: Cirrus Logic CS4207
Date: Tue, 21 Apr 2009 13:49:17 +0200
Message-ID: <268FD6BD-CA15-4AD0-B71D-CA85F9423D37@gmail.com>
References: <625B7AA8-CE98-4B12-A664-27A8B6599E7B@gmail.com>
	<s5hd4bbuyjh.wl%tiwai@suse.de>
	<C92A6B7E-231B-435A-93D0-4B50A590B35A@gmail.com>
	<s5h8wlui695.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 373C82466A
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Apr 2009 13:49:20 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 26so436678eyw.56
	for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2009 04:49:19 -0700 (PDT)
In-Reply-To: <s5h8wlui695.wl%tiwai@suse.de>
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


On 21 Apr 2009, at 13:41, Takashi Iwai wrote:

> At Tue, 21 Apr 2009 09:24:31 +0200,
> Peter-Jan Deweirdt wrote:
>>
>> Hi,
>>
>> This is the patch that I've changed to the 2.6.29 kernel. However I
>> need some more help for playing the audio. Since I don't really know
>> what is happening.
>>
>> It's detecting my audio chip. (a part of dmesg)
>> [    5.171478] Advanced Linux Sound Architecture Driver Version  
>> 1.0.18a.
>> [    5.176635] HDA Intel 0000:00:1b.0: setting latency timer to 64
>> [    5.220417] ALSA device list:
>> [    5.220434]   #0: HDA Intel MID at 0xd0010000 irq 22
>>
>> So it looks like my audio card is found. Some more outputs
>>
>> lspci -v
>> 00:1b.0 Audio device: Intel Corporation System Controller Hub (SCH
>> Poulsbo) HD Audio Controller (rev 06)
>> 	Subsystem: Intel Corporation Unknown device 8119
>> 	Flags: bus master, fast devsel, latency 0, IRQ 22
>> 	Memory at d0010000 (64-bit, non-prefetchable) [size=16K]
>> 	Capabilities: [50] Power Management version 2
>> 	Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
>> 	Kernel driver in use: HDA Intel
>>
>>
>> [root@localhost ~]# cat /proc/asound/cards
>>  0 [MID            ]: HDA-Intel - HDA Intel MID
>>                       HDA Intel MID at 0xd0010000 irq 22
>> [root@localhost ~]#
>>
>> [root@localhost ~]# aplay -l
>> **** List of PLAYBACK Hardware Devices ****
>> card 0: MID [HDA Intel MID], device 0: CS4207 Analog [CS4207 Analog]
>>   Subdevices: 1/1
>>   Subdevice #0: subdevice #0
>> card 0: MID [HDA Intel MID], device 1: CS4207 Digital [CS4207  
>> Digital]
>>   Subdevices: 1/1
>>   Subdevice #0: subdevice #0
>> [root@localhost ~]#
>>
>>
>> [root@localhost ~]# aplay -L
>> front:CARD=MID,DEV=0
>>     HDA Intel MID, CS4207 Analog
>>     Front speakers
>> surround40:CARD=MID,DEV=0
>>     HDA Intel MID, CS4207 Analog
>>     4.0 Surround output to Front and Rear speakers
>> surround41:CARD=MID,DEV=0
>>     HDA Intel MID, CS4207 Analog
>>     4.1 Surround output to Front, Rear and Subwoofer speakers
>> surround50:CARD=MID,DEV=0
>>     HDA Intel MID, CS4207 Analog
>>     5.0 Surround output to Front, Center and Rear speakers
>> surround51:CARD=MID,DEV=0
>>     HDA Intel MID, CS4207 Analog
>>     5.1 Surround output to Front, Center, Rear and Subwoofer speakers
>> surround71:CARD=MID,DEV=0
>>     HDA Intel MID, CS4207 Analog
>>     7.1 Surround output to Front, Center, Side, Rear and Woofer
>> speakers
>> iec958:CARD=MID,DEV=0
>>     HDA Intel MID, CS4207 Digital
>>     IEC958 (S/PDIF) Digital Audio Output
>> null
>>     Discard all samples (playback) or generate zero samples (capture)
>> pulse
>>     PulseAudio Sound Server
>> default
>>     Default
>> [root@localhost ~]#
>>
>> [root@localhost ~]# ls -al /dev/snd/
>> total 0
>> drwxr-xr-x  2 root root     200 Mar 24 20:00 .
>> drwxr-xr-x 15 root root    3360 Mar 24 20:00 ..
>> crw-rw----  1 root audio 116, 9 Mar 24 20:00 controlC0
>> crw-rw----  1 root audio 116, 8 Mar 24 20:00 hwC0D0
>> crw-rw----  1 root audio 116, 7 Mar 24 20:00 pcmC0D0c
>> crw-rw----  1 root audio 116, 6 Mar 24 20:58 pcmC0D0p
>> crw-rw----  1 root audio 116, 5 Mar 24 20:00 pcmC0D1c
>> crw-rw----  1 root audio 116, 4 Mar 24 20:30 pcmC0D1p
>> crw-rw----  1 root audio 116, 3 Mar 24 20:00 seq
>> crw-rw----  1 root audio 116, 2 Mar 24 20:00 timer
>> [root@localhost ~]#
>
> All look good, so far.

Why am I missing /dev/dsp, /dev/audio, ...


>
>
>
>> The problems that I'm having is:
>> - How to play audio?
>
> 	% aplay foo.wav

[root@localhost ~]# aplay tara.wav
ALSA lib pulse.c:272:(pulse_connect) PulseAudio: Unable to connect:  
Connection refused

aplay: main:590: audio open error: Connection refused
[root@localhost ~]#

Looks like PulseAudio is not running. When I try to start it I get this:
[root@localhost ~]# pulseaudio
W: ltdl-bind-now.c: Failed to find original dlopen loader.
W: main.c: This program is not intended to be run as root (unless -- 
system is specified).
W: pid.c: Stale PID file, overwriting.
N: module-alsa-sink.c: Disabling timer-based scheduling because high- 
resolution timers are not available from the kernel.
Soft CPU time limit exhausted, terminating.
Hard CPU time limit exhausted, terminating forcibly.
Aborted (core dumped)
[root@localhost ~]#

dump from dmesg
[  610.355008] ALSA sound/pci/hda/hda_intel.c:648: hda_intel:  
azx_get_response timeout, switching to single_cmd mode: last  
cmd=0x009f000c


>
>
>> - I am seeing 2 playback devices (what is correct) but no headphones
>
> The streams are just for analog and digital outputs.
> The analog outputs are switched either by the automatic HP jack
> detection or manual switch (if any).

So this means that I'm nog going to be able to play audio on the  
LineOut1, LineOut2 and HP at the same time?

>
>
>> - How can I see the difference between the MIC in and LINE IN?
>
> Via mixer controls.

How can I use the mixer controls? Do I need some specific devices?

Sorry for my questions but I'm missing some items to complete my audio  
part.

>
>
>
> Takashi
