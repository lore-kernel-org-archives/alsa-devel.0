From: =?ISO-8859-1?Q?Jean-Pierre_Andr=E9?= <jean-pierre.andre@wanadoo.fr>
Subject: Re: Intel 82801I (ICH9 Family) HD Audio Controller on
 a HP	dv4 computer
Date: Sun, 14 Dec 2008 11:52:29 +0100
Message-ID: <4944E56D.9020505@wanadoo.fr>
References: <7342920.39901.1229168483619.JavaMail.www@wwinf1b34>
	<s5hvdtn15ps.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2f.orange.fr (smtp2f.orange.fr [80.12.242.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D8401037F1
	for <alsa-devel@alsa-project.org>; Sun, 14 Dec 2008 11:52:31 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f26.orange.fr (SMTP Server) with ESMTP id B38FB700008B
	for <alsa-devel@alsa-project.org>; Sun, 14 Dec 2008 11:52:30 +0100 (CET)
Received: from [10.0.0.10] (ASt-Lambert-153-1-110-188.w90-2.abo.wanadoo.fr
	[90.2.97.188])
	by mwinf2f26.orange.fr (SMTP Server) with ESMTP id 27134700008A
	for <alsa-devel@alsa-project.org>; Sun, 14 Dec 2008 11:52:30 +0100 (CET)
In-Reply-To: <s5hvdtn15ps.wl%tiwai@suse.de>
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

Hi Takashi,

Takashi Iwai wrote:
> At Sat, 13 Dec 2008 12:41:23 +0100 (CET),
> Jean-Pierre ANDRE wrote:
>   
>> Hi,
>>
>> I am getting difficulty setting up ALSA for my new HP portable computer.
>> lspci displays the audio chip as :
>> Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Controller (rev 03)
>> and /proc/asound displays the codec as IDT 92HD71B7X
>>
>> I have uploaded the detailed hardware and configuration parameters to
>> http://pagesperso-orange.fr/b.andre/visits.html/92HD71B7X
>>
>> I am using Fedora 10 x86_64 without pulseaudio and with the latest alsa-driver :
>> alsa-driver-1.0.18a.16.g4012f.139.g6e583.tar.bz2
>>
>> I have googled for a similar problem, but did not get to an actual fix,
>> the following thread appears to deal with a most similar situation :
>> http://forums.opensuse.org/pre-release-beta/399731-beta-5-no-sound.html
>>
>> After several tries, I have set modprobe.conf as
>> alias snd-card-0 snd-hda-intel
>> options sound slots=snd-hda-intel
>> options snd-hda-intel model=hp-m4 single_cmd=1 enable_msi=1
>>     
>
> Don't use single_cmd=1 option.  If this is needed, it's already
> something very wrong, most likely a deeper problem like ACPI.
>
>
> Takashi
>   
Thank you for your help.

I had already tested without the single_cmd=1 option, and
the only difference I see is the " azx_get_response timeout,
switching to polling mode" warning. Probably related is the
fact that I have never seen an IRQ 22. 

from proc/interrupts :

 22:          0          0   IO-APIC-fasteoi   uhci_hcd:usb6, HDA Intel

For your information, the initial log shows the following :

<-------
HDA Intel 0000:00:1b.0: power state changed by ACPI to D0
HDA Intel 0000:00:1b.0: PCI INT B -> GSI 22 (level, low) -> IRQ 22
HDA Intel 0000:00:1b.0: setting latency timer to 64
ALSA /home/linux/rpmbuild/BUILD/alsa-driver-1.0.18a17/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:627: hda_intel: azx_get_response timeout, switching to polling mode: last cmd=0x000f0000
input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input17
input: HDA Intel at 0xdf300000 irq 22 Line In at Ext Rear Jack as /devices/pci0000:00/0000:00:1b.0/input/input18
input: HDA Intel at 0xdf300000 irq 22 Mic at Ext Front Jack as /devices/pci0000:00/0000:00:1b.0/input/input19
input: HDA Intel at 0xdf300000 irq 22 Line In at Ext Rear Jack as /devices/pci0000:00/0000:00:1b.0/input/input20
input: HDA Intel at 0xdf300000 irq 22 HP Out at Ext Front Jack as /devices/pci0000:00/0000:00:1b.0/input/input21
-------->

As i said, mplayer outputs the sound correctly, this is what
it logs :

<------
Playing try.wav.
Audio only file format detected.
==========================================================================
Opening audio decoder: [pcm] Uncompressed PCM audio decoder
AUDIO: 44100 Hz, 2 ch, s16le, 1411.2 kbit/100.00% (ratio: 176400->176400)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
==========================================================================
E: context.c: waitpid(): No child processes
AO: [pulse] Init failed: Internal error
Failed to initialize audio driver 'pulse'
AO: [alsa] 48000Hz 2ch s16le (2 bytes per sample)
Video: no video
Starting playback...
----->

whereas aplay gets stuck, and repeats the first sound
samples (so do most players) :

<-----
Playing WAVE '/shared/audio/try.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Plug PCM: Rate conversion PCM (48000, sformat=S32_LE)
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 7526
  period_size  : 940
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 940
  period_event : 0
  start_threshold  : 7526
  stop_threshold   : 7526
  silence_threshold: 0
  silence_size : 0
  boundary     : 4236761349448794112
Slave: Soft volume PCM
Control: PCM Playback Volume
min_dB: -51
max_dB: 0
resolution: 256
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 8192
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 8192
  stop_threshold   : 8192
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 8192
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 8192
  stop_threshold   : 8192
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
Hardware PCM card 0 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 8192
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : ENABLE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 4611686018427387904
  silence_threshold: 0
  silence_size : 4611686018427387904
  boundary     : 4611686018427387904
###### +                                           | 13%^C
Aborted by signal Interrupt...
------->

I am at a loss about what to try, do not hesitate
making suggestions.

Regards

Jean-Pierre
