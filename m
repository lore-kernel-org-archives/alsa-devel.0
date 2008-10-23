From: Jason Harvey <softdevice@jasonline.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 23 Oct 2008 18:32:19 +0100
Message-ID: <4900B523.3020801@jasonline.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de>	<48F739F4.5070303@nostalgicnetworxx.org>	<48F74344.4090509@gmail.com>
	<s5hvdvs1wig.wl%tiwai@suse.de>	<5501535d0810220824o6b8bf427qd2c806783ec1e56f@mail.gmail.com>	<s5h4p34mz0j.wl%tiwai@suse.de>	<5501535d0810220907p2102afc2t13e47ff5309c01bc@mail.gmail.com>	<5501535d0810220924w66341ac6u4d4de4ed87243a7@mail.gmail.com>	<48FF7E17.9080601@gmail.com>
	<s5h4p3350o4.wl%tiwai@suse.de>	<5501535d0810230446j52de12aes885d066ea38cb240@mail.gmail.com>	<4900659E.90809@jasonline.co.uk>
	<s5hbpxb8lfe.wl%tiwai@suse.de>	<490071DC.6070607@jasonline.co.uk>
	<s5habcv5mu0.wl%tiwai@suse.de>	<490088DC.7090205@jasonline.co.uk>
	<s5hzlkv44v7.wl%tiwai@suse.de>	<s5hwsfz44i9.wl%tiwai@suse.de>
	<49009A26.3000201@jasonline.co.uk>	<s5hod1b436i.wl%tiwai@suse.de>
	<s5hljwf42x4.wl%tiwai@suse.de>	<4900A4FA.7020300@jasonline.co.uk>
	<s5h63njw2c0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homer.jasonline.co.uk (78-86-168-217.zone2.bethere.co.uk
	[78.86.168.217])
	by alsa0.perex.cz (Postfix) with ESMTP id D6222103924
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 19:32:30 +0200 (CEST)
In-Reply-To: <s5h63njw2c0.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 23 Oct 2008 17:23:22 +0100,
> Jason Harvey wrote:
>   
>> Takashi Iwai wrote:
>>     
>>> Fixed and uploaded now.
>>> It might take some time until the changes are sync'ed.
>>>   
>>>       
>> Thanks, downloaded, patched fine.
>> Attached dmesg_modprobe.txt shows output before playing anything.
>>
>> No sound now using  the oss workaround "echo mplayer 0 0 direct > 
>> /proc/asound/card0/pcm0p/oss"
>> Mplayer starts but doesn't increment shows 0% 0seconds etc etc, it can 
>> be interrupted ctrl-c, the PC remains functional, just no sound.
>> dmesg_after.txt is the tail end of dmesg after interrupting mplayer, I 
>> trimmed it as the first couple seven lines repeat for about 330K in the 
>> original log :)
>> Instant reboot when trying mplayer without the oss workaround.
>>     
>
> OK, so the patch doesn't help, and it brings another problem.
> What about debug=2?  This will give much less log, I guess.
>   
debug=2 is still too big to see the start of playback.
If I can get the buffer big enough to find the beginning I'll post it :)
>   
>> aplay -Dplug:dmix:0 wn.wav still works.
>> Trying mplayer after aplay freezes the machine with no output onto the 
>> console.
>>     
>
> Even with OSS proc hack?
>   
Yes, if I aplay first it locks up entirely when I issue OSS proc hack 
then run mplayer.
Without running aplay I can get a dmesg but mplayer makes no sound.
I've put the debug=1 output along with the commands etc below.

Regards, Jason

[root@sentry ~]# modprobe snd_sbxfi 
debug=1                                              
[root@sentry ~]# 
dmesg                                                                   
ACPI: PCI Interrupt 0000:04:01.0[A] -> GSI 22 (level, low) -> IRQ 
22                     
SBXFI: INIT 
HW                                                                            

SBXFI: INIT 
DAC                                                                           

SBXFI: SETUP 
I2S                                                                          

[root@sentry ~]# echo mplayer 0 0 direct > /proc/asound/card0/pcm0p/oss
[root@sentry ~]# mplayer wn.wav                                       
MPlayer dev-SVN-r26936-4.3.0 (C) 2000-2008 MPlayer Team               
CPU: Intel(R) Celeron(R) CPU 2.53GHz (Family: 15, Model: 4, Stepping: 9)
CPUflags:  MMX: 1 MMX2: 1 3DNow: 0 3DNow2: 0 SSE: 1 SSE2: 1            
Compiled with runtime CPU detection.                                   
mplayer: could not connect to socket                                   
mplayer: No such file or directory                                     
Failed to open LIRC support. You will not be able to use your remote 
control.

Playing wn.wav.
Audio file file format detected.
==========================================================================
Opening audio decoder: [pcm] Uncompressed PCM audio decoder              
AUDIO: 48000 Hz, 2 ch, s16le, 1536.0 kbit/100.00% (ratio: 192000->192000)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)                  
==========================================================================
AO: [pulse] Init failed: Connection refused                              
*** PULSEAUDIO: Unable to connect: Connection refused                    
*** Is your sound server running?
*** See: http://www.pulseaudio.org/wiki/Troubleshooting
[AO_ALSA] Playback open error: Connection refused
AO: [oss] 96000Hz 2ch s16le (2 bytes per sample)
Video: no video
Starting playback...
A:   0.0 (00.0) of 241.0 (04:01.0) ??,?%

MPlayer interrupted by signal 2 in module: play_audio


MPlayer interrupted by signal 2 in module: play_audio
[root@sentry ~]# dmesg
ACPI: PCI Interrupt 0000:04:01.0[A] -> GSI 22 (level, low) -> IRQ 22
SBXFI: INIT HW
SBXFI: INIT DAC
SBXFI: SETUP I2S
SBXFI: Allocate SRC 0
SBXFI: allocated TLB at 0 for 16 pages
SBXFI: Setting TLB buffer page 0x15a2c000
SBXFI: release TLB at 0 for 16 pages
SBXFI: Disabling TLB buffer
SBXFI: PLAYBACK PREPARE: rate=96000, period_size=1024, buffer_size=16384
SBXFI: Pitch [0:fa6] = 0x1000000
SBXFI: Pitch [80:7a6] = 0x1000000
SBXFI: Pitch [1:fb6] = 0x1000000
SBXFI: Pitch [81:7b6] = 0x1000000
SBXFI: Amp [00:0001] = 0x555
SBXFI: Amp [80:0801] = 0x555
SBXFI: Amp [01:0011] = 0x555
SBXFI: Amp [81:0811] = 0x555
SBXFI: PLAY TRIGGER START
SBXFI: PLAY UPDATE TIMER
ALSA /root/alsa-driver-unstable/acore/pcm_native.c:1498: playback drain 
error (DMA or IRQ trouble?)
SBXFI: PLAY TRIGGER STOP
SBXFI: PLAY UPDATE TIMER
SBXFI: Release SRC 0
[root@sentry ~]#
