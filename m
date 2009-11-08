From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd-hdsp driver error?
Date: Sun, 8 Nov 2009 08:42:46 +0800
Message-ID: <4f3252890911071642o32124202l18217c2895143ac7@mail.gmail.com>
References: <933ed0910911020433j59c4907q94ee073e5f09e328@mail.gmail.com>
	<4f3252890911022248w5d2a2d73s74bb0412e8f4e0c7@mail.gmail.com>
	<933ed0910911031105m608009cbg2ccd1c543887befa@mail.gmail.com>
	<4f3252890911042029m18db97d0qc324b37d1c1dd330@mail.gmail.com>
	<933ed0910911051646u71594153ue23984ae32c70d8e@mail.gmail.com>
	<4f3252890911051753x650bc617te8086af4fc3a745f@mail.gmail.com>
	<933ed0910911060823x4f512b32h546167eea73050df@mail.gmail.com>
	<4f3252890911061512i5f6c439cyd977e5fb67c84693@mail.gmail.com>
	<933ed0910911061523u2b592454ladd8b8cb7d8e2284@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f187.google.com (mail-px0-f187.google.com
	[209.85.216.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 92DAE103894
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2009 01:42:47 +0100 (CET)
Received: by pxi17 with SMTP id 17so371309pxi.16
	for <alsa-devel@alsa-project.org>; Sat, 07 Nov 2009 16:42:46 -0800 (PST)
In-Reply-To: <933ed0910911061523u2b592454ladd8b8cb7d8e2284@mail.gmail.com>
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

Not sure the H-DSP.conf uploaded by tom-ipp is OK since I don't have this
card

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4650

http://pulseaudio.org/ticket/564

The problem of using your card with pulseaudio

1) No front device defined
2) No master volume control
3) The card only support SNDRV_PCM_INFO_NONINTERLEAVED but seem PA only
support SNDRV_PCM_INFO_INTERLEAVED
4) PA expect your card support stereo but your card did not support stereo


2009/11/7 Lars Zobbe <fedesensfar@gmail.com>

> Thanks a lot Raymond. Now that's good news. Something that can be fixed is
> always good news.
>
> And Takashi and Jaroslav? Are they on this mailing list. I suppose it would
> just be a cuestion of putting their names in the subject field then.
>
> It would be so great if you could find a fix for this legendary card.
> Crossing my fingers.
>
> Thanks again. You've been a great help (I hope), now I'll just have to find
> those two guys.
>
> Lars.
>
>
>
> On Sat, Nov 7, 2009 at 12:12 AM, Raymond Yau <superquad.vortex2@gmail.com>wrote:
>
>> AFAIK , alsa-lib use the driver name to find the name of corresponding
>> conf file from /usr/share/alsa/cards/aliases.conf
>> In your case , H-DSP.conf does not exist and there is no aliases in
>> /usr/share/alsa/cards/aliases.conf
>>
>> You have to ask Takashi or Jaroslav to fix this issue for your card
>>
>> open("/usr/share/alsa/cards/aliases.conf", O_RDONLY) = 3
>>
>>
>> access("/usr/share/alsa/cards/H-DSP.conf", R_OK) = -1 ENOENT (No such
>> file or directory)
>> open("/dev/snd/controlC1", O_RDONLY)    = 3
>> close(3)                                = 0
>>
>>
>> write(2, "ALSA lib confmisc.c:1286:(snd_fu"..., 42ALSA lib
>> confmisc.c:1286:(snd_func_refer) ) = 42
>> write(2, "Unable to find definition 'cards"..., 58Unable to find
>> definition 'cards.H-DSP.pcm.front.0:CARD=0') = 58
>> write(2, "\n", 1
>>
>>
>>
>> 2009/11/7 Lars Zobbe <fedesensfar@gmail.com>
>>
>> > It is a clean install.
>> > lars@lars-desktop:~$ lsb_release -a && uname -a
>> > No LSB modules are available.
>> > Distributor ID:    Ubuntu
>> > Description:    Ubuntu 9.10
>> > Release:    9.10
>> > Codename:    karmic
>> > Linux lars-desktop 2.6.31-14-generic #48-Ubuntu SMP Fri Oct 16 14:05:01
>> UTC
>> > 2009 x86_64 GNU/Linux
>> >
>> > It didn't work with pulseaudio in any previos version (of ubuntu or any
>> > other distro I've tried) either.
>> > And the standard answer from people "out there" is "forget about pulse
>> it
>> > doesn't work with the HDSP" f.x. this guy
>> > http://ubuntuforums.org/showpost.php?p=7578331&postcount=10
>> > And that's why I contacted pulseaudio developers first when I found out
>> the
>> > it was because snd_hdsp didn't load with the preferred udev but only
>> with
>> > module-detect (se my first post). They said that I should inform Alsa
>> > developers as there seems to be a problem with the alsa driver.
>> >
>> > I've attached the strace output.
>> >
>> > Thanks.
>> > Lars.
>> >
>> >
>> >
>> >
>> > On Fri, Nov 6, 2009 at 2:53 AM, Raymond Yau <
>> superquad.vortex2@gmail.com>wrote:
>> >
>> >> Is it a clean install of Ubuntu 9.10 or upgrade from previous Ubuntu ?
>> >>
>> >> you may need to find out why aplay -v -Dfront 32bit.wav fail ?
>> >>
>> >> strace aplay -v -Dfront 32bit.wav
>> >>
>> >>
>> >>
>> >>
>> >>
>> >> !!Linux Distribution
>> >>
>> >> !!------------------
>> >>
>> >> Ubuntu 9.10 \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 9.10"
>> >>
>> >> !!Sound Servers on this system
>> >> !!----------------------------
>> >>
>> >> Pulseaudio:
>> >>       Installed - Yes (/usr/bin/pulseaudio)
>> >>
>> >>
>> >>       Running - Yes
>> >>
>> >> ESound Daemon:
>> >>       Installed - Yes (/usr/bin/esd)
>> >>       Running - No
>> >>
>> >> Jack:
>> >>       Installed - Yes (/usr/bin/jackd)
>> >>       Running - No
>> >>
>> >>
>> >> !!ALSA configuration files
>> >>
>> >>
>> >> !!------------------------
>> >>
>> >> !!User specific config file (~/.asoundrc)
>> >>
>> >> pcm.!default {
>> >>     type plug
>> >>     slave { pcm "jack" }
>> >> }
>> >>
>> >> pcm.jack {
>> >>     type jack
>> >>     playback_ports {
>> >>
>> >>         0 alsa_pcm:playback_1
>> >>
>> >>         1 alsa_pcm:playback_2
>> >>     }
>> >>     capture_ports {
>> >>         0 alsa_pcm:capture_1
>> >>         1 alsa_pcm:capture_2
>> >>     }
>> >> }
>> >>
>> >> ctl.mixer0 {
>> >>     type hw
>> >>     card 0
>> >> }
>> >>
>> >>
>> >> lars@lars-desktop:~$ aplay -v -Dfront:0 32bit.wav
>> >> ALSA lib confmisc.c:1286:(snd_func_refer) Unable to find definition
>> >> 'cards.H-DSP.pcm.front.0:CARD=0'
>> >> ALSA lib conf.c:3513:(_snd_config_evaluate) function snd_func_refer
>> >> returned error: No such file or directory
>> >> ALSA lib conf.c:3985:(snd_config_expand) Evaluate error: No such file
>> or
>> >> directory
>> >> ALSA lib pcm.c:2211:(snd_pcm_open_noupdate) Unknown PCM front:0
>> >> aplay: main:608: audio open error: No such file or directory
>> >>
>> >>
>> >> Did PA developer tell you not to load oss module ?
>> >>
>> >>
>> >>
>> >> D: alsa-util.c: Checking for subset analog-mono (hw:%f)
>> >> D: alsa-util.c: Trying hw:0 with SND_PCM_NO_AUTO_FORMAT ...
>> >> D: alsa-util.c: Managed to open hw:0
>> >> D: alsa-util.c: snd_pcm_hw_params_set_access() failed: Invalid argument
>> >> D: alsa-util.c: Trying hw:0 without SND_PCM_NO_AUTO_FORMAT ...
>> >> D: alsa-util.c: Managed to open hw:0
>> >> D: alsa-util.c: snd_pcm_hw_params_set_access() failed: Invalid argument
>> >> D: alsa-util.c: Trying plug:hw:0 with SND_PCM_NO_AUTO_FORMAT ...
>> >> D: alsa-util.c: Managed to open plug:hw:0
>> >> D: alsa-util.c: snd_pcm_hw_params_set_format(Signed 16 bit Little
>> Endian)
>> >> failed: Invalid argument
>> >> D: alsa-util.c: snd_pcm_hw_params_set_format(Signed 16 bit Big Endian)
>> >> failed: Invalid argument
>> >> D: alsa-util.c: snd_pcm_hw_params_set_format(Float 32 bit Little
>> Endian)
>> >> failed: Invalid argument
>> >> D: alsa-util.c: snd_pcm_hw_params_set_format(Float 32 bit Big Endian)
>> >> failed: Invalid argument
>> >> D: alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid
>> argument
>> >> D: alsa-util.c: Trying plug:hw:0 without SND_PCM_NO_AUTO_FORMAT ...
>> >> D: alsa-util.c: Managed to open plug:hw:0
>> >> D: alsa-util.c: snd_pcm_hw_params_set_channels(1) failed: Invalid
>> argument
>> >> I: alsa-util.c: Failed to set hardware parameters on plug:hw:0: Invalid
>> >> argument
>> >> D: alsa-util.c: Trying hw:0 as last resort...
>> >> D: alsa-util.c: Trying hw:0 with SND_PCM_NO_AUTO_FORMAT ...
>> >> D: alsa-util.c: Managed to open hw:0
>> >> D: alsa-util.c: snd_pcm_hw_params_set_access() failed: Invalid argument
>> >> D: alsa-util.c: Trying hw:0 without SND_PCM_NO_AUTO_FORMAT ...
>> >> D: alsa-util.c: Managed to open hw:0
>> >> D: alsa-util.c: snd_pcm_hw_params_set_access() failed: Invalid argument
>> >> D: alsa-util.c: Trying plug:hw:0 with SND_PCM_NO_AUTO_FORMAT ...
>> >> D: alsa-util.c: Managed to open plug:hw:0
>> >> D: alsa-util.c: snd_pcm_hw_params_set_format(Signed 16 bit Little
>> Endian)
>> >> failed: Invalid argument
>> >> D: alsa-util.c: snd_pcm_hw_params_set_format(Signed 16 bit Big Endian)
>> >> failed: Invalid argument
>> >> D: alsa-util.c: snd_pcm_hw_params_set_format(Float 32 bit Little
>> Endian)
>> >> failed: Invalid argument
>> >> D: alsa-util.c: snd_pcm_hw_params_set_format(Float 32 bit Big Endian)
>> >> failed: Invalid argument
>> >> D: alsa-util.c: Maximum hw buffer size is 371 ms
>> >> I: (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed
>> >> I: (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed
>> >> I: (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed
>> >> I: (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed
>> >> D: alsa-util.c: Set neither period nor buffer size.
>> >> I: (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed
>> >> I: alsa-util.c: snd_pcm_hw_params failed: Device or resource busy
>> >> D: alsa-util.c: Trying plug:hw:0 without SND_PCM_NO_AUTO_FORMAT ...
>> >> D: alsa-util.c: Managed to open plug:hw:0
>> >> D: alsa-util.c: Maximum hw buffer size is 371 ms
>> >> I: (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed
>> >> I: (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed
>> >> I: (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed
>> >> I: (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed
>> >> D: alsa-util.c: Set neither period nor buffer size.
>> >> I: (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_HW_PARAMS failed
>> >> I: alsa-util.c: snd_pcm_hw_params failed: Device or resource busy
>> >> I: alsa-util.c: Failed to set hardware parameters on plug:hw:0: Device
>> or
>> >> resource busy
>> >> E: module.c: Failed to load  module "module-alsa-source" (argument:
>> >> "device_id=0"): initialization failed.
>> >> W: module.c: module-oss is deprecated: Please use module-alsa-card
>> instead
>> >> of module-oss!
>> >> D: oss-util.c: capabilities: MMAP REALTIME TRIGGER
>> >> I: module-oss.c: Device opened in O_RDONLY mode.
>> >> D: oss-util.c: Asking for 4 fragments of size 512 (requested 880)
>> >> E: oss-util.c: SNDCTL_DSP_SETFMT: Device or resource busy
>> >> E: module.c: Failed to load  module "module-oss" (argument:
>> >> "device=/dev/dsp"): initialization failed.
>> >> W: module-detect.c: failed to detect any sound hardware.
>> >>
>> >>
>> >> 2009/11/6 Lars Zobbe <fedesensfar@gmail.com>
>> >>
>> >> Sorry. I didn't realise that it was a bash script. Here is the link to
>> my
>> >>> alsa-info
>> >>>
>> >>>
>> http://www.alsa-project.org/db/?f=d3728557be71067e2ed0920747118ae7efff2829
>> >>>
>> >>> Thanks again.
>> >>> Lars.
>> >>>
>> >>>
>> >>> On Thu, Nov 5, 2009 at 5:29 AM, Raymond Yau <
>> superquad.vortex2@gmail.com
>> >>> > wrote:
>> >>>
>> >>>> Please provide the full pulseaudio log and output of alsa-info.sh
>> >>>>
>> >>>> http://www.pulseaudio.org/wiki/Troubleshooting
>> >>>>
>> >>>> pulseaudio -k; pulseaudio -vvv
>> >>>>
>> >>>> and
>> >>>>
>> >>>> aplay -v -Dfront:0 32bit.wav
>> >>>>
>> >>>> aplay -v -M -Dfront:0 32bit.wav
>> >>>>
>> >>>> aplay -v -Dplughw:0 any.wav
>> >>>>
>> >>>> aplay -v -M -Dplughw:0 any.wav
>> >>>>
>> >>>>
>> >>>> 2009/11/4 Lars Zobbe <fedesensfar@gmail.com>
>> >>>>
>> >>>> > Hi Raymond.
>> >>>> >
>> >>>> > I so sorry Raymond. But I'm not sure what to do with this info. Is
>> >>>> there
>> >>>> > something more I have to tell you? Is there anything I can do to
>> make
>> >>>> > pulseaudio able to detect via udev? Can I copy-paste that bit of
>> code
>> >>>> you
>> >>>> > sent me somewhere?
>> >>>> > Please tell me if there's more you need to know.
>> >>>> > Greetings.
>> >>>> > Lars.
>> >>>> >
>> >>>> >
>> >>>> >
>> >>>> >
>> >>>> > On Tue, Nov 3, 2009 at 7:48 AM, Raymond Yau <
>> >>>> superquad.vortex2@gmail.com>wrote:
>> >>>> >
>> >>>> >> I guess route plugin used by RME96*.conf does not support mmap
>> when
>> >>>> there
>> >>>> >> is
>> >>>> >> channel conversion since minimum channels supported by hdsp is 14
>> >>>> >>
>> >>>> >>
>> >>>> >> static struct snd_pcm_hardware snd_hdsp_playback_subinfo =
>> >>>> >> {
>> >>>> >>    .info = (SNDRV_PCM_INFO_MMAP |
>> >>>> >>                 SNDRV_PCM_INFO_MMAP_VALID |
>> >>>> >>                 SNDRV_PCM_INFO_NONINTERLEAVED |
>> >>>> >>                 SNDRV_PCM_INFO_SYNC_START |
>> >>>> >>                 SNDRV_PCM_INFO_DOUBLE),
>> >>>> >> #ifdef SNDRV_BIG_ENDIAN
>> >>>> >>    .formats = SNDRV_PCM_FMTBIT_S32_BE,
>> >>>> >> #else
>> >>>> >>    .formats = SNDRV_PCM_FMTBIT_S32_LE,
>> >>>> >> #endif
>> >>>> >>    .rates = (SNDRV_PCM_RATE_32000 |
>> >>>> >>                 SNDRV_PCM_RATE_44100 |
>> >>>> >>                 SNDRV_PCM_RATE_48000 |
>> >>>> >>                 SNDRV_PCM_RATE_64000 |
>> >>>> >>                 SNDRV_PCM_RATE_88200 |
>> >>>> >>                 SNDRV_PCM_RATE_96000),
>> >>>> >>    .rate_min = 32000,
>> >>>> >>    .rate_max = 96000,
>> >>>> >>    .channels_min = 14,
>> >>>> >>    .channels_max = HDSP_MAX_CHANNELS,
>> >>>> >>    .buffer_bytes_max = HDSP_CHANNEL_BUFFER_BYTES *
>> HDSP_MAX_CHANNELS,
>> >>>> >>    .period_bytes_min = (64 * 4) * 10,
>> >>>> >>    .period_bytes_max = (8192 * 4) * HDSP_MAX_CHANNELS,
>> >>>> >>    .periods_min = 2,
>> >>>> >>    .periods_max = 2,
>> >>>> >>    .fifo_size = 0
>> >>>> >> };
>> >>>> >>
>> >>>> >> 2009/11/2 Lars Zobbe <fedesensfar@gmail.com>
>> >>>> >>
>> >>>> >> > Hi.
>> >>>> >> >
>> >>>> >> > Talking to one of the pulseaudio developers (*Colin Guthrie*)
>> about
>> >>>> a
>> >>>> >> > problem with pulseaudio loading modules and my sound card (RME
>> HDSP
>> >>>> >> 9632),
>> >>>> >> > I
>> >>>> >> > was adviced to inform you about the problem.
>> >>>> >> >
>> >>>> >> > I'm on ubuntu 9.10, 64bit, kernel 2.6.31 with an amd64 x2 3800+
>> >>>> >> processor.
>> >>>> >> >
>> >>>> >> >
>> >>>> >> > Symptoms are:
>> >>>> >> > Can only make pulseaudio load modules with the deprecated
>> >>>> load-module
>> >>>> >> > module-detect command, module-udev-detect doesn't detect
>> anything
>> >>>> (no
>> >>>> >> sound
>> >>>> >> > - only null sink output in padevchooser).
>> >>>> >> > I get terrible stuttering.
>> >>>> >> > I can remove pulseaudio and make things work, more or less.
>> >>>> However,
>> >>>> >> that
>> >>>> >> > leaves me without software mixing and apps fighting for the
>> rights
>> >>>> to
>> >>>> >> make
>> >>>> >> > sound. And more inconveniences (fx. no volume-control).
>> >>>> >> > I can play sound from audacity without stuttering by choosing
>> the
>> >>>> >> cardname
>> >>>> >> > directly in output HDSP, not ALSA, not pulseaudio.
>> >>>> >> >
>> >>>> >> >
>> >>>> >> > When trying to run alsa-info.sh I get a lot of "not found"
>> errors.
>> >>>> So
>> >>>> >> > you'll
>> >>>> >> > get some manual info (they might have moved som files around in
>> >>>> ubuntu
>> >>>> >> > 9.10).
>> >>>> >> >
>> >>>> >> > This is part of my syslog during a boot. (I did the formatting
>> to
>> >>>> bold).
>> >>>> >> >
>> >>>> >> > Nov  2 10:57:32 lars-desktop pulseaudio[1524]: module.c:
>> >>>> module-detect
>> >>>> >> is
>> >>>> >> > deprecated: Please use module-udev-detect instead of
>> module-detect!
>> >>>> >> > Nov  2 10:57:37 lars-desktop pulseaudio[1524]: ratelimit.c: 27
>> >>>> events
>> >>>> >> > suppressed
>> >>>> >> > Nov  2 10:57:39 lars-desktop pulseaudio[1612]: module.c:
>> >>>> module-detect
>> >>>> >> is
>> >>>> >> > deprecated: Please use module-udev-detect instead of
>> module-detect!
>> >>>> >> > Nov  2 10:57:44 lars-desktop pulseaudio[1612]: ratelimit.c: 23
>> >>>> events
>> >>>> >> > suppressed
>> >>>> >> > Nov  2 10:57:44 lars-desktop pulseaudio[1612]: alsa-sink.c: ALSA
>> >>>> woke us
>> >>>> >> up
>> >>>> >> > to write new data to the device, but there was actually nothing
>> to
>> >>>> >> write!
>> >>>> >> > Nov  2 10:57:44 lars-desktop pulseaudio[1612]: alsa-sink.c:
>> *Most
>> >>>> likely
>> >>>> >> > this is a bug in the ALSA driver 'snd_hdsp'. Please report this
>> >>>> issue to
>> >>>> >> > the
>> >>>> >> > ALSA developers.*
>> >>>> >> > Nov  2 10:57:44 lars-desktop pulseaudio[1612]: alsa-sink.c: We
>> were
>> >>>> >> woken
>> >>>> >> > up
>> >>>> >> > with POLLOUT set -- however a subsequent snd_pcm_avail()
>> returned 0
>> >>>> or
>> >>>> >> > another value < min_avail.
>> >>>> >> > Nov  2 10:57:49 lars-desktop pulseaudio[1612]: ratelimit.c: 99
>> >>>> events
>> >>>> >> > suppressed
>> >>>> >> >
>> >>>> >> > Later if I try to play audio I get terrible skipping or
>> stuttering
>> >>>> and
>> >>>> >> my
>> >>>> >> > syslog (in less than a minute) writes:
>> >>>> >> > Nov  2 11:55:16 lars-desktop pulseaudio[1612]: ratelimit.c: 16
>> >>>> events
>> >>>> >> > suppressed
>> >>>> >> > Nov  2 11:55:21 lars-desktop pulseaudio[1612]: ratelimit.c: 34
>> >>>> events
>> >>>> >> > suppressed
>> >>>> >> > Nov  2 11:55:26 lars-desktop pulseaudio[1612]: ratelimit.c: 70
>> >>>> events
>> >>>> >> > suppressed
>> >>>> >> > Nov  2 11:55:31 lars-desktop pulseaudio[1612]: ratelimit.c: 29
>> >>>> events
>> >>>> >> > suppressed
>> >>>> >> > Nov  2 11:55:36 lars-desktop pulseaudio[1612]: ratelimit.c: 43
>> >>>> events
>> >>>> >> > suppressed
>> >>>> >> > Nov  2 11:55:41 lars-desktop pulseaudio[1612]: ratelimit.c: 161
>> >>>> events
>> >>>> >> > suppressed
>> >>>> >> > Nov  2 11:55:46 lars-desktop pulseaudio[1612]: ratelimit.c: 28
>> >>>> events
>> >>>> >> > suppressed
>> >>>> >> > Nov  2 11:55:51 lars-desktop pulseaudio[1612]: ratelimit.c: 18
>> >>>> events
>> >>>> >> > suppressed
>> >>>> >> > Nov  2 11:55:56 lars-desktop pulseaudio[1612]: ratelimit.c: 16
>> >>>> events
>> >>>> >> > suppressed
>> >>>> >> >
>> >>>> >> > Here's the relevant part (concerning my sound card) of lspci
>> -vvv
>> >>>> >> >
>> >>>> >> > 02:09.0 Multimedia audio controller: Xilinx Corporation RME
>> >>>> Hammerfall
>> >>>> >> DSP
>> >>>> >> > (rev 9a)
>> >>>> >> >    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> >>>> ParErr-
>> >>>> >> > Stepping- SERR- FastB2B- DisINTx-
>> >>>> >> >    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>> >TAbort-
>> >>>> >> > <TAbort- <MAbort- >SERR- <PERR- INTx-
>> >>>> >> >    Latency: 255
>> >>>> >> >    Interrupt: pin A routed to IRQ 19
>> >>>> >> >    Region 0: Memory at fdff0000 (32-bit, non-prefetchable)
>> >>>> [size=64K]
>> >>>> >> >    Kernel driver in use: RME Hammerfall DSP
>> >>>> >> >    Kernel modules: snd-hdsp
>> >>>> >> >
>> >>>> >> > And:
>> >>>> >> > lars@lars-desktop:~$ aplay -l
>> >>>> >> > **** List of PLAYBACK Hardware Devices ****
>> >>>> >> > card 0: DSP [Hammerfall DSP], device 0: RME Hammerfall HDSP 9632
>> >>>> [RME
>> >>>> >> > Hammerfall HDSP 9632]
>> >>>> >> >  Subdevices: 1/1
>> >>>> >> >  Subdevice #0: subdevice #0
>> >>>> >> >
>> >>>> >> >
>> >>>> >> > lars@lars-desktop:~$ cat /proc/asound/version
>> >>>> >> > Advanced Linux Sound Architecture Driver Version 1.0.21.
>> >>>> >> > Compiled on Oct 15 2009 for kernel 2.6.31-14-generic (SMP).
>> >>>> >> >
>> >>>> >> > lars@lars-desktop:~$ cat /proc/asound/cards
>> >>>> >> >  0 [DSP            ]: H-DSP - Hammerfall DSP
>> >>>> >> >                      RME Hammerfall HDSP 9632 at 0xfdff0000, irq
>> 19
>> >>>> >> >
>> >>>> >> >
>> >>>> >> > lars@lars-desktop:~$ cat /proc/asound/modules
>> >>>> >> >  0 snd_hdsp
>> >>>> >> >
>> >>>> >> > I don't have .asound.conf files.
>> >>>> >> >
>> >>>> >> > lars@lars-desktop:~$ hdsploader
>> >>>> >> > hdsploader - firmware loader for RME Hammerfall DSP cards
>> >>>> >> > Looking for HDSP + Multiface or Digiface cards :
>> >>>> >> > Card 0 : RME Hammerfall HDSP 9632 at 0xfdff0000, irq 19
>> >>>> >> >
>> >>>> >> > And of course. My computer makes no sound if I don't load the
>> >>>> hdspmixer
>> >>>> >> at
>> >>>> >> > startup. I guess that's just normal for this card though.
>> >>>> >> >
>> >>>> >> > Please let me know, if you need more info. I really hope you can
>> >>>> help
>> >>>> >> out
>> >>>> >> > here. And that this might help you to.
>> >>>> >> >
>> >>>> >> > Thanks for the great work you do. Greetings.
>> >>>> >> > Lars Zobbe.
>> >>>> >> > _______________________________________________
>> >>>> >> > Alsa-devel mailing list
>> >>>> >> > Alsa-devel@alsa-project.org
>> >>>> >> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >>>> >> >
>> >>>> >> _______________________________________________
>> >>>> >> Alsa-devel mailing list
>> >>>> >> Alsa-devel@alsa-project.org
>> >>>> >> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >>>> >>
>> >>>> >
>> >>>> >
>> >>>> _______________________________________________
>> >>>> Alsa-devel mailing list
>> >>>> Alsa-devel@alsa-project.org
>> >>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >>>>
>> >>>
>> >>>
>> >>
>> >
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
>
