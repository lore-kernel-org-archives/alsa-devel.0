From: VDR User <user.vdr@gmail.com>
Subject: Re: Missing surround channels with Nvidia HDMI &
 snd-hda-intel driver
Date: Tue, 14 Nov 2017 07:22:13 -0800
Message-ID: <CAA7C2qg7RsJRsTFu03KRwTeBjcN5LK7m-b22iyw6kp5x4ymuBw@mail.gmail.com>
References: <CAA7C2qgvC65Cjbf=AsUWd3gFCqAgHpctA=CnnfAD9E9Z0bxJQw@mail.gmail.com>
 <s5hr2t29loc.wl-tiwai@suse.de>
 <CAA7C2qiGQ-VuCFPG51kXaB7bCSyC+nQvWgF=EeUSwdkybXZ=wQ@mail.gmail.com>
 <s5ha7zqt310.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f45.google.com (mail-lf0-f45.google.com
 [209.85.215.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 9391C266A73
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 16:22:15 +0100 (CET)
Received: by mail-lf0-f45.google.com with SMTP id e143so22715968lfg.12
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 07:22:15 -0800 (PST)
In-Reply-To: <s5ha7zqt310.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ok so after compiling a bunch of older kernels, I found that the
problem started with 4.6.0. Kernel 4.5.7 worked fine. With 4.6.0 I
get:

~$ speaker-test -c 6 -t wav

speaker-test 1.1.3

Playback device is default
Stream parameters are 48000Hz, S16_LE, 6 channels
WAV file(s)
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 64 to 5440
Period size range from 32 to 2720
Using max buffer size 5440
Periods = 4
was set period_size = 1088
was set buffer_size = 5440
 0 - Front Left
 1 - Front Right
 3 - Rear Right
 2 - Rear Left
 4 - Unknown
 5 - Unknown
Time per period = 8.524856


However, with 4.5.7 it was:

~$ speaker-test -c 6 -t wav

speaker-test 1.1.3

Playback device is default
Stream parameters are 48000Hz, S16_LE, 6 channels
WAV file(s)
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 64 to 5440
Period size range from 32 to 2720
Using max buffer size 5440
Periods = 4
was set period_size = 1088
was set buffer_size = 5440
 0 - Front Left
 4 - Front Center
 1 - Front Right
 3 - Rear Right
 2 - Rear Left
 5 - LFE
Time per period = 8.524740

In both cases the audio announced the correct speaker position, but
the Front Center & LFE channels are labeled/reported incorrectly as
"Unknown" starting in 4.6.0. I looked at the 4.6 changelog audio
section (https://kernelnewbies.org/Linux_4.6#head-59f6bad0670ddd6511d239b83c36575b139798bf)
but didn't see anything Nvidia-specific, or anything that sounded like
it would cause this problem. Any ideas on the best way to proceed
finding the offending commit?

Thanks!
Derek


On Mon, Nov 13, 2017 at 11:03 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 13 Nov 2017 18:18:39 +0100,
> VDR User wrote:
>>
>> Hi Takashi,
>>
>> Thanks for your reply. I have no clue unfortunately as I just noticed
>> it now. Is there a previous kernel you could recommend I try prior to
>> any or big changes to how snd-hda-intel works?
>
> Well, nothing I can think of for now, that's why I asked about testing
> the older kernel.  I'd do a bisection, e.g. try stable kernels like
> 4.4.x or 4.9.x, depending on the "previously working" version you
> remember, then go to the middle between them if it hits the
> regression.
>
>
> Takashi
>
>>
>> -Derek
>>
>> On Mon, Nov 13, 2017 at 8:40 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Sun, 12 Nov 2017 19:01:14 +0100,
>> > VDR User wrote:
>> >>
>> >> Hi. I just noticed that I'm missing some surround channels and I think
>> >> it may be a bug in the alsa drivers because my current setup used to
>> >> work just fine.
>> >
>> > If it's a regression, which kernel did work and which started a
>> > regression?  This alone would be a good help for tracking down the
>> > problem.
>> >
>> >
>> > Takashi
>> >
>> >> I'm running Debian Testing, stable kernel 4.13.12,
>> >> alsa-utils 1.1.3-1. My ~/.asoundrc is:
>> >>
>> >> ~$ cat .asoundrc
>> >> pcm.!default "hdmi:NVidia,1"
>> >> ~$
>> >>
>> >> I am not setting anything on my kernel load line:
>> >>
>> >>         echo    'Loading Linux 4.13.12-amd ...'
>> >>         linux   /vmlinuz-4.13.12-amd
>> >> root=UUID=6df5733d-b089-450c-9ec6-661dd013c7c0 ro
>> >>         echo    'Loading initial ramdisk ...'
>> >>         initrd  /initrd.img-4.13.12-amd
>> >>
>> >> The driver being used is snd-hda-intel with an Nvidia GT520 video
>> >> card. And lastly I do not have Pulse or a desktop environment. This is
>> >> a minimal HTPC setup that runs only an xserver to provide video
>> >> output, with audio/video being sent to my surround receiver via HDMI.
>> >>
>> >> The first thing I noticed was mpv-player was downmixing 5.1 to 3.1 and
>> >> giving the following log message:
>> >>
>> >> [ao/alsa] trying to set ALSA channel map: FL FR FC LFE RL RR
>> >> [ao/alsa] channel map reported by ALSA: FL FR FC LFE UNKNOWN UNKNOWN
>> >> [ao/alsa] which we understand as: fl-fr-fc-lfe-na-na
>> >> [ao/alsa] using the ALSA channel map.
>> >> [ao/alsa] hw pausing supported: yes
>> >> [ao/alsa] buffersize: 2720 samples
>> >> [ao/alsa] period size: 160 samples
>> >> [ao/alsa] device buffer: 2720 samples.
>> >> [ao/alsa] using soft-buffer of 8820 samples.
>> >> [cplayer] AO: [alsa] 44100Hz fl-fr-fc-lfe-na-na (3.1) 6ch s32
>> >> [cplayer] AO: Description: ALSA audio output
>> >> [af] Adding filter lavrresample
>> >> [lavrresample] Remix: 5.1 -> 3.1
>> >> [af] Audio filter chain:
>> >> [af]   [in] 44100Hz 5.1 6ch floatp
>> >> [af]   [lavrresample] 44100Hz fl-fr-fc-lfe-na-na (3.1) 6ch s32 [a]
>> >> [af]   [out] 44100Hz fl-fr-fc-lfe-na-na (3.1) 6ch s32
>> >> [af]   [ao] 44100Hz fl-fr-fc-lfe-na-na (3.1) 6ch s32
>> >>
>> >> That makes it look like Rear Left/Right channels are absent. I think
>> >> ran speaker-test. 4 and 5 show as "Unknown" but correctly audibly
>> >> announced as "front center" and "subwoofer" respectively:
>> >>
>> >> ~$ speaker-test -c 6 -t wav
>> >>
>> >> speaker-test 1.1.3
>> >>
>> >> Playback device is default
>> >> Stream parameters are 48000Hz, S16_LE, 6 channels
>> >> WAV file(s)
>> >> Rate set to 48000Hz (requested 48000Hz)
>> >> Buffer size range from 64 to 5440
>> >> Period size range from 32 to 2720
>> >> Using max buffer size 5440
>> >> Periods = 4
>> >> was set period_size = 1088
>> >> was set buffer_size = 5440
>> >>  0 - Front Left
>> >>  1 - Front Right
>> >>  3 - Rear Right
>> >>  2 - Rear Left
>> >>  4 - Unknown
>> >>  5 - Unknown
>> >>
>> >> Additional information that may be of use:
>> >>
>> >> ~$ aplay -l
>> >> **** List of PLAYBACK Hardware Devices ****
>> >> card 1: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
>> >>   Subdevices: 1/1
>> >>   Subdevice #0: subdevice #0
>> >> card 1: NVidia [HDA NVidia], device 7: HDMI 1 [HDMI 1]
>> >>   Subdevices: 0/1
>> >>   Subdevice #0: subdevice #0
>> >>
>> >> ~$ cat /proc/asound/card1/eld#0.1
>> >> monitor_present         1
>> >> eld_valid               1
>> >> monitor_name            SONY AVAMP
>> >>
>> >> connection_type         HDMI
>> >> eld_version             [0x2] CEA-861D or below
>> >> edid_version            [0x3] CEA-861-B, C or D
>> >> manufacture_id          0xd94d
>> >> product_id              0xf02
>> >> port_id                 0x200
>> >> support_hdcp            0
>> >> support_ai              0
>> >> audio_sync_delay        0
>> >> speakers                [0x5f] FL/FR LFE FC RL/RR RC RLC/RRC
>> >> sad_count               12
>> >> sad0_coding_type        [0xc] MLP (Dolby TrueHD)
>> >> sad0_channels           2
>> >> sad0_rates              [0x1ec0] 44100 48000 88200 96000 176400 192000
>> >> sad1_coding_type        [0xc] MLP (Dolby TrueHD)
>> >> sad1_channels           6
>> >> sad1_rates              [0x1ec0] 44100 48000 88200 96000 176400 192000
>> >> sad2_coding_type        [0xc] MLP (Dolby TrueHD)
>> >> sad2_channels           8
>> >> sad2_rates              [0x6c0] 44100 48000 88200 96000
>> >> sad3_coding_type        [0xb] DTS-HD
>> >> sad3_channels           2
>> >> sad3_rates              [0x1ec0] 44100 48000 88200 96000 176400 192000
>> >> sad4_coding_type        [0xb] DTS-HD
>> >> sad4_channels           6
>> >> sad4_rates              [0x1ec0] 44100 48000 88200 96000 176400 192000
>> >> sad5_coding_type        [0xb] DTS-HD
>> >> sad5_channels           8
>> >> sad5_rates              [0x6c0] 44100 48000 88200 96000
>> >> sad6_coding_type        [0x1] LPCM
>> >> sad6_channels           2
>> >> sad6_rates              [0x1ee0] 32000 44100 48000 88200 96000 176400 192000
>> >> sad6_bits               [0xe0000] 16 20 24
>> >> sad7_coding_type        [0x1] LPCM
>> >> sad7_channels           6
>> >> sad7_rates              [0x1ee0] 32000 44100 48000 88200 96000 176400 192000
>> >> sad7_bits               [0xe0000] 16 20 24
>> >> sad8_coding_type        [0x1] LPCM
>> >> sad8_channels           8
>> >> sad8_rates              [0x1ee0] 32000 44100 48000 88200 96000 176400 192000
>> >> sad8_bits               [0xe0000] 16 20 24
>> >> sad9_coding_type        [0x2] AC-3
>> >> sad9_channels           6
>> >> sad9_rates              [0xe0] 32000 44100 48000
>> >> sad9_max_bitrate        680000
>> >> sad10_coding_type       [0x7] DTS
>> >> sad10_channels          6
>> >> sad10_rates             [0x6e0] 32000 44100 48000 88200 96000
>> >> sad10_max_bitrate       1536000
>> >> sad11_coding_type       [0xa] E-AC-3/DD+ (Dolby Digital Plus)
>> >> sad11_channels          8
>> >> sad11_rates             [0xc0] 44100 48000
>> >>
>> >> 02:00.0 VGA compatible controller: NVIDIA Corporation GF119 [GeForce
>> >> GT 520] (rev a1) (prog-if 00 [VGA controller])
>> >>         Subsystem: eVga.com. Corp. GF119 [GeForce GT 520]
>> >>         Flags: bus master, fast devsel, latency 0, IRQ 25
>> >>         Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
>> >>         Memory at f0000000 (64-bit, prefetchable) [size=128M]
>> >>         Memory at fa000000 (64-bit, prefetchable) [size=32M]
>> >>         I/O ports at ec00 [size=128]
>> >>         [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
>> >>         Capabilities: <access denied>
>> >>         Kernel driver in use: nvidia
>> >>         Kernel modules: nvidia
>> >>
>> >> 02:00.1 Audio device: NVIDIA Corporation GF119 HDMI Audio Controller (rev a1)
>> >>         Subsystem: eVga.com. Corp. GF119 HDMI Audio Controller
>> >>         Flags: bus master, fast devsel, latency 0, IRQ 17
>> >>         Memory at fea7c000 (32-bit, non-prefetchable) [size=16K]
>> >>         Capabilities: <access denied>
>> >>         Kernel driver in use: snd_hda_intel
>> >>         Kernel modules: snd_hda_intel
>> >> _______________________________________________
>> >> Alsa-devel mailing list
>> >> Alsa-devel@alsa-project.org
>> >> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>> >>
>>
