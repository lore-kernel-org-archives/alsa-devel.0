From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Question about
	snd_mixer_selem_get_playback_dB_range()
Date: Mon, 11 Apr 2011 10:19:25 +0800
Message-ID: <BANLkTikiL5D8SB6oaqHgHYHDfBQ67XcGng@mail.gmail.com>
References: <1300711933.24854.263.camel@IT-W2076>
	<AANLkTi=jXgTmNUM=RG=AuToV9Z-gNpVAmPWSk8Zq4GSs@mail.gmail.com>
	<1300715722.24854.290.camel@IT-W2076> <4D876303.3090100@ladisch.de>
	<1300718695.24854.310.camel@IT-W2076> <4D88497A.4090702@nokia.com>
	<4D884B8D.1000103@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 48C141037FF
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 04:19:28 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3797160fxm.38
	for <alsa-devel@alsa-project.org>; Sun, 10 Apr 2011 19:19:25 -0700 (PDT)
In-Reply-To: <4D884B8D.1000103@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/3/22 Clemens Ladisch <clemens@ladisch.de>

> Peter Ujfalusi wrote:
> > Looking at the patch itself, it does going to return
> > min=SND_CTL_TLV_DB_GAIN_MUTE from snd_tlv_get_dB_range function.
> >
> > However I have my doubts, if this is the correct way...
> >
> > Take these two gain controls for example:
> > RAW value   GAIN1  GAIN2
> >    0        mute   mute
> >    1        -2dB   0dB
> >    2         0dB   1dB
> >    3         2dB   2dB
> >
> > If user space asks for the dB_range:
> >         min    max
> > GAIN1   mute   2dB
> > GAIN2   mute   2dB
> >
> > They are going to return with the same range, however if you ask for
> > -2dB on both:
> > GAIN1 will be -2dB
> > GAIN2 will be muted
>
> Or not, depending on which direction you instruct it to round.
>
> > So we are kind of hiding the dB range for the control.
>
> This is unavoidable if the only information returned is min/max.
> To get the entire curve and resolution, you'd have to get the dB value
> for each raw volume value.
>
>
Should the application include the dB range of "Virtual Master" ?

e.g. pulseaudio calculate the dB range (-168dB to 0dB ) on my ad1988 HDA
codec
which "front", "surround", "center/lfe" and "side" have (-58.0 to 0dB)


D: alsa-mixer.c: Activating path analog-output
D: alsa-mixer.c: Path analog-output (Analog Output), direction=1,
priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes,
has_dB=yes, min_volume=0, max_volume=39, min_dB=-168, max_dB=0
D: alsa-mixer.c: Element Master, direction=1, switch=1, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x7ffffffffffff, n_channels=1, override_map=yes
D: alsa-mixer.c: Element Headphone, direction=1, switch=1, volume=0,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x0, n_channels=0, override_map=no
D: alsa-mixer.c: Element Front, direction=1, switch=1, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x6, n_channels=2, override_map=yes
D: alsa-mixer.c: Element Surround, direction=1, switch=1, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x60, n_channels=2, override_map=yes
D: alsa-mixer.c: Element Side, direction=1, switch=1, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0xc00, n_channels=2, override_map=yes
D: alsa-mixer.c: Element Center, direction=1, switch=1, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x4900000000018, n_channels=1, override_map=yes
D: alsa-mixer.c: Element LFE, direction=1, switch=1, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x80, n_channels=1, override_map=yes
D: alsa-mixer.c: Element PCM, direction=1, switch=0, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
I: alsa-sink.c: Hardware volume ranges from -168.00 dB to 0.00 dB.
I: alsa-sink.c: Fixing base volume to 0.00 dB
I: alsa-sink.c: Successfully enabled synchronous volume.
I: alsa-sink.c: Using hardware volume control. Hardware dB scale supported.
I: alsa-sink.c: Using hardware mute control.
D: alsa-util.c: snd_pcm_dump():
D: alsa-util.c: Soft volume PCM
D: alsa-util.c: Control: PCM Playback Volume
D: alsa-util.c: min_dB: -51
D: alsa-util.c: max_dB: 0
D: alsa-util.c: resolution: 256
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
D: alsa-util.c:   period_size  : 8192
D: alsa-util.c:   period_time  : 185759
D: alsa-util.c:   tstamp_mode  : ENABLE
D: alsa-util.c:   period_step  : 1
D: alsa-util.c:   avail_min    : 15502
D: alsa-util.c:   period_event : 0
D: alsa-util.c:   start_threshold  : -1
D: alsa-util.c:   stop_threshold   : 1073741824
D: alsa-util.c:   silence_threshold: 0
D: alsa-util.c:   silence_size : 0
D: alsa-util.c:   boundary     : 1073741824
D: alsa-util.c: Slave: Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
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
D: alsa-util.c:   period_size  : 8192
D: alsa-util.c:   period_time  : 185759
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
D: alsa-sink.c: Read hardware volume: 0: 100% 1: 100%


SB Live! platinum (CT4760P) which has "Surround Playback Volume" with
SND_CTL_TLV_DB_GAIN_MUTE , "Master and PCM Playback Volume" of stac9721

and PA report (-100081dB to +12 dB)

D: alsa-mixer.c: Activating path analog-output
D: alsa-mixer.c: Path analog-output (Analog Output), direction=1,
priority=99, probed=yes, supported=yes, has_mute=yes, has_volume=yes,
has_dB=yes, min_volume=0, max_volume=31, min_dB=-100081, max_dB=12
D: alsa-mixer.c: Element Master, direction=1, switch=1, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
D: alsa-mixer.c: Element Surround, direction=1, switch=0, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x60, n_channels=2, override_map=yes
D: alsa-mixer.c: Element PCM, direction=1, switch=1, volume=1,
volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x3600000000f66, n_channels=2, override_map=yes
D: alsa-mixer.c: Element External Amplifier, direction=1, switch=4,
volume=0, volume_limit=-1, enumeration=0, required=0, required_any=0,
required_absent=0, mask=0x0, n_channels=0, override_map=no
D: alsa-mixer.c: Option on (output-amplifier-on/Amplifier) index=1,
priority=10
D: alsa-mixer.c: Option off (output-amplifier-off/No Amplifier) index=0,
priority=0
D: alsa-mixer.c: Setting output-amplifier-on (Amplifier) priority=10
D: alsa-mixer.c: Setting output-amplifier-off (No Amplifier) priority=0
I: alsa-sink.c: Hardware volume ranges from -100080.99 dB to 12.00 dB.
I: alsa-sink.c: Fixing base volume to -12.00 dB
