From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 2/2] Improve hw_params documentation
Date: Sat, 19 Nov 2011 09:28:43 +0800
Message-ID: <CAN8ccibGDw5PK6BBujcBshk7yDQNgVJM9PTP8JtEJKqC=QcuCw@mail.gmail.com>
References: <20111116195607.GI30602@foghorn.codeweavers.com>
	<4EC42907.80104@ladisch.de>
	<20111116213135.GJ30602@foghorn.codeweavers.com>
	<CAN8cciYAvUuBScTDTVsuBVaUwvisizgX8TKtyrH9faS5J9090w@mail.gmail.com>
	<4EC50BD7.1050703@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 28651244E8
	for <alsa-devel@alsa-project.org>; Sat, 19 Nov 2011 02:28:44 +0100 (CET)
Received: by bkat8 with SMTP id t8so4080468bka.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 17:28:43 -0800 (PST)
In-Reply-To: <4EC50BD7.1050703@ladisch.de>
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

2011/11/17 Clemens Ladisch <clemens@ladisch.de>:
> Raymond Yau wrote:
>> The logic of your program is wrong since your program did not set
>> channel, rate and format
>
> It is allowed to not set some parameters; snd_pcm_hw_params() then
> chooses some random values for them.
>
>> The buffer and period calculation is only valid after you have choose
>> the format and channels
>
> This is wrong; parameters can be set in any order.
> (As long as format/channels are not yet set, the exact relationship
> between frames and bytes is not yet known, but this is handled by
> the parameters being intervals.)
>
>

it return error at snd_pcm_hw_params_set_periods( 10,0)

after I reverted commit 6dab1a91cbbd40d2f52a0c5a1bd961a1db7bb319

pcm: recalculate all rules after changing hw_params flags

                params->flags |= SND_PCM_HW_PARAMS_EXPORT_BUFFER;
        else
                params->flags &= ~SND_PCM_HW_PARAMS_EXPORT_BUFFER;
-       params->rmask = ~0;
        return snd_pcm_hw_refine(pcm, params);
 }



/alsa_period_count plug:dmix:1
min periods 0
max periods 8623621
ALSA ERROR hw_params: set (PERIODS)
           value = 10 : Invalid argument
ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED MMAP_COMPLEX
RW_INTERLEAVED RW_NONINTERLEAVED
FORMAT:  S8 U8 S16_LE S16_BE U16_LE U16_BE S24_LE S24_BE U24_LE U24_BE
S32_LE S32_BE U32_LE U32_BE FLOAT_LE FLOAT_BE FLOAT64_LE FLOAT64_BE
MU_LAW A_LAW IMA_ADPCM S24_3LE S24_3BE U24_3LE U24_3BE S20_3LE S20_3BE
U20_3LE U20_3BE S18_3LE S18_3BE U18_3LE U18_3BE
SUBFORMAT:  STD
SAMPLE_BITS: [4 64]
FRAME_BITS: [4 640000]
CHANNELS: [1 10000]
RATE: [4000 4294967295)
PERIOD_TIME: (21333 21334)
PERIOD_SIZE: (85 91628833)
PERIOD_BYTES: (42 4294967295)
PERIODS: (0 8623621)
BUFFER_TIME: [1 4294967295]
BUFFER_SIZE: [170 733007751]
BUFFER_BYTES: [85 4294967295]
TICK_TIME: ALL
snd_pcm_hw_params_set_periods: -22


default prealloc of snd-hda-intel is 64Kbytes, 10 periods of 1024
frame for S32_LE and 2 channels is 80Kbytes

aplay -v --buffer-size=10240 --period-size=1024 -D"plug:'dmix:1'" any.wav
Playing WAVE 'any.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Plug PCM: Rate conversion PCM (48000, sformat=S32_LE)
Converter: libspeex (builtin)
Protocol version: 10002
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
  boundary     : 986447872
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
  boundary     : 1073741824
Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
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
  stop_threshold   : 1073741824
  silence_threshold: 0
  silence_size : 1073741824
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0
