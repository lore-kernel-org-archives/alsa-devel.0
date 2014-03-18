From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 1/3] ASoC: davinci-mcasp: Constraint on
 the period and buffer size based on FIFO usage
Date: Tue, 18 Mar 2014 16:28:55 +0200
Message-ID: <53285827.1070709@ti.com>
References: <1395148837-20850-1-git-send-email-peter.ujfalusi@ti.com>
 <1395148837-20850-2-git-send-email-peter.ujfalusi@ti.com>
 <532848D5.30806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id A1B42261A03
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 15:29:00 +0100 (CET)
In-Reply-To: <532848D5.30806@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Takashi Iwai <tiwai@suse.de>, nsekhar@ti.com, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

On 03/18/2014 03:23 PM, Peter Ujfalusi wrote:
> On 03/18/2014 03:20 PM, Peter Ujfalusi wrote:
>> We need to place constraint on the period if the read or write AFIFO
>> is enabled and it is configured for more than one word otherwise
>> the DMA will fail in buffer configuration where the sizes are not
>> aligned with the requested FIFO configuration.
> =

> Oh, I edited the commit message and removed the text related to buffer si=
ze
> but I failed to do that for the commit title :(

Actually I still have issue with the constraint.
If I play a 48KHz sample with mplayer it is fine:
Trying preferred audio driver 'alsa', options '[none]'
alsa-init: requested format: 48000 Hz, 2 channels, 9
alsa-init: using ALSA 1.0.27.2
alsa-init: setup for 1/2 channel(s)
alsa-init: using device default
alsa-init: opening device in blocking mode
alsa-init: device reopened in blocking mode
alsa-init: got buffersize=3D96000
alsa-init: got period size 1600
alsa: 48000 Hz/2 channels/4 bpf/96000 bytes buffer/Signed 16 bit Little End=
ian
AO: [alsa] 48000Hz 2ch s16le (2 bytes per sample)
AO: Description: ALSA-0.9.x-1.x audio output
AO: Author: Alex Beregszaszi, Zsolt Barat <joy@streamminister.de>
AO: Comment: under development
Building audio filter chain for 48000Hz/2ch/s16le -> 48000Hz/2ch/s16le...


However if I play 44.1KHz sample with mplayer:
Trying preferred audio driver 'alsa', options '[none]'
alsa-init: requested format: 44100 Hz, 2 channels, 9
alsa-init: using ALSA 1.0.27.2
alsa-init: setup for 1/2 channel(s)
alsa-init: using device default
alsa-init: opening device in blocking mode
alsa-init: device reopened in blocking mode
ALSA ERROR hw_params: set_near (BUFFER_TIME)
           value =3D 500000 : Invalid argument
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: 50000
PERIOD_SIZE: NONE
PERIOD_BYTES: [4736 65536]
PERIODS: (1 19)
BUFFER_TIME: 500000
BUFFER_SIZE: 22050
BUFFER_BYTES: 88200
TICK_TIME: ALL
[AO_ALSA] Unable to set buffer time near: Invalid argument
Failed to initialize audio driver 'alsa'


Now if I place the same constraint to the buffer size as well and playing t=
he
same 44.1KHz sample:
Trying preferred audio driver 'alsa', options '[none]'
alsa-init: requested format: 44100 Hz, 2 channels, 9
alsa-init: using ALSA 1.0.27.2
alsa-init: setup for 1/2 channel(s)
alsa-init: using device default
alsa-init: opening device in blocking mode
alsa-init: device reopened in blocking mode
alsa-init: got buffersize=3D88192
alsa-init: got period size 1696
alsa: 44100 Hz/2 channels/4 bpf/88192 bytes buffer/Signed 16 bit Little End=
ian
AO: [alsa] 44100Hz 2ch s16le (2 bytes per sample)
AO: Description: ALSA-0.9.x-1.x audio output
AO: Author: Alex Beregszaszi, Zsolt Barat <joy@streamminister.de>
AO: Comment: under development
Building audio filter chain for 44100Hz/2ch/s16le -> 44100Hz/2ch/s16le...

It seams that I need to place the same constraint step to both period size =
and
buffer size.
For some reason snd_pcm_hw_params_set_buffer_time_near() fails in case of
44.1KHz when asking for 0.5s buffer when I placed step 32 constraint to per=
iod
size. Placing the same 32 steps constraint to the buffer size as well will
make things working (for mplayer at least)

-- =

P=E9ter
