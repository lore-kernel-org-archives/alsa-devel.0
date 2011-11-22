From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 2/2] Improve hw_params documentation
Date: Wed, 23 Nov 2011 07:57:22 +0800
Message-ID: <CAN8cciY0zviz3-3G_s1RF1ukS6=NOVso2mWC1xDRTnWVUbrReA@mail.gmail.com>
References: <20111116195607.GI30602@foghorn.codeweavers.com>
	<4EC42907.80104@ladisch.de>
	<20111116213135.GJ30602@foghorn.codeweavers.com>
	<4EC43465.5060901@ladisch.de>
	<20111117140243.GK30602@foghorn.codeweavers.com>
	<CAN8ccib-EYr1QzRapcsRT9NMM12xY7V5OL2M07KahkNC_Vr55g@mail.gmail.com>
	<20111122134131.GA1570@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F2C2103AAC
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 00:57:23 +0100 (CET)
Received: by bkat8 with SMTP id t8so468935bka.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 15:57:23 -0800 (PST)
In-Reply-To: <20111122134131.GA1570@foghorn.codeweavers.com>
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

2011/11/22 Andrew Eikum <aeikum@codeweavers.com>:
> On Tue, Nov 22, 2011 at 06:31:03AM +0800, Raymond Yau wrote:
>> 2011/11/17 Andrew Eikum <aeikum@codeweavers.com>:
>> > On Wed, Nov 16, 2011 at 11:08:37PM +0100, Clemens Ladisch wrote:
>> >> On 11/16/2011 10:31 PM, Andrew Eikum wrote:
>> >> > On Wed, Nov 16, 2011 at 10:20:07PM +0100, Clemens Ladisch wrote:
>> >> >> Andrew Eikum wrote:
>> >> >>> +++ b/include/pcm.h
>> >> >>> @@ -44,8 +44,20 @@ extern "C" {
>> >> >>>
>> >> >>> =A0/** PCM generic info container */
>> >> >>> =A0typedef struct _snd_pcm_info snd_pcm_info_t;
>> >> >>> -/** PCM hardware configuration space container */
>> >> >>> +
>> >> >>> +/** PCM hardware configuration space container
>> >> >>> + *
>> >> >>> + * =A0snd_pcm_hw_params_t is an opaque structure which contains =
a set of possible
>> >> >>> + * =A0PCM hardware configurations. For example, a given instance=
 might include a
>> >> >>> + * =A0range of buffer sizes, a range of period sizes, and a set =
of several sample
>> >> >>> + * =A0formats. Some subset of all possible combinations these se=
ts may be valid,
>> >> >>> + * =A0but not necessarily any combination will be valid.
>> >> >>> + *
>> >> >>> + * =A0No validation is done by the various snd_pcm_hw_params_set=
* functions.
>> >> >>
>> >> >> These functions do validate the value that the application is tryi=
ng to set
>> >> >> and adjust all other dependent limits.
>> >> >
>> >> > I didn't find that to be the case in my testing, at least between
>> >> > periods, period_size, and buffer_size. I've attached a test program
>> >> > here.
>> >>
>> >> I can reproduce this.
>> >>
>> >> Try running the program with LIBASOUND_DEBUG=3D1; it appears that the=
re is
>> >> a bug in the rate plugin. =A0(Normal programs actually set their rate=
 ...)
>> >
>> > This doesn't change the output in any way. I checked the Arch Linux
>> > alsa-lib build script[1] and it doesn't seem to disable debugging in
>> > any obvious way. Do I have to explicitly enable debugging output and
>> > rebuild?
>> >
>> > $ LIBASOUND_DEBUG=3D1 ./alsa_period_count
>> > min_buffer_frames: 80
>> > set max buffer size: 80
>> > snd_pcm_hw_params: -12
>> > $
>> >
>> > [1] http://projects.archlinux.org/svntogit/packages.git/tree/trunk/PKG=
BUILD?h=3Dpackages/alsa-lib
>> >
>>
>> There is a bug in your program which set the buffer_size_max to buffer_s=
ize_min
>>
>> =A0 =A0 err =3D snd_pcm_hw_params_set_periods(pcm, hw_params, 10, 0);
>> =A0 =A0 if(err < 0){
>> =A0 =A0 =A0 =A0 printf("snd_pcm_hw_params_set_periods: %d\n", err);
>> =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 }
>>
>> =A0 =A0 err =3D snd_pcm_hw_params_set_period_size(pcm, hw_params, 1024, =
0);
>> =A0 =A0 if(err < 0){
>> =A0 =A0 =A0 =A0 printf("snd_pcm_hw_params_set_period_size: %d\n", err);
>> =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 }
>>
>> The above already set buffer size to 10240, but you set
>> buffer_size_max to buffer_size_min (80)
>>
>> =A0 =A0 err =3D snd_pcm_hw_params_get_buffer_size_min(hw_params, &buffer=
_frames);
>> =A0 =A0 if(err < 0){
>> =A0 =A0 =A0 =A0 printf("snd_pcm_hw_params_get_buffer_size: %d\n", err);
>> =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 }
>> =A0 =A0 printf("min_buffer_frames: %u\n", buffer_frames);
>>
>> =A0 =A0 err =3D snd_pcm_hw_params_set_buffer_size_max(pcm, hw_params, &b=
uffer_frames);
>> =A0 =A0 if(err < 0){
>> =A0 =A0 =A0 =A0 printf("snd_pcm_hw_params_get_buffer_size: %d\n", err);
>> =A0 =A0 =A0 =A0 return 1;
>> =A0 =A0 }
>> =A0 =A0 printf("set max buffer size: %u\n", buffer_frames);
>>
>
> Yes, that's exactly my point. I would expect set_buffer_size_max() to
> fail, since it's incompatible with the parameters set earlier.
> Instead, it succeeds.
>

snd_pcm_hw_params_get_buffer_size_min() return a wrong value (80)

so far , your program still work with "hw", "dmix" and "jack"

It seem the bug is only occur with "pulse" plugin.

"pulse" can get the correct value 10240 after you set the format ,
rate and channels

"dmix" has a default period size of 1024
"jack" support FLOAT only and a default rate obtained from jack server
and a channel map in .asoundrc

pcm.jack {
    type jack
    playback_ports {
        0 alsa_pcm:playback_1
        1 alsa_pcm:playback_2
    }
    capture_ports {
        0 alsa_pcm:capture_1
        1 alsa_pcm:capture_2
    }
}




./alsa_period_count jack
refine_soft 'jack' (begin)
ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED RW_INTERLEAVED RW_NONINTERLEA=
VED
FORMAT:  FLOAT_LE
SUBFORMAT:  ALL
SAMPLE_BITS: ALL
FRAME_BITS: ALL
CHANNELS: 2
RATE: 44100
PERIOD_TIME: ALL
PERIOD_SIZE: ALL
PERIOD_BYTES: ALL
PERIODS: ALL
BUFFER_TIME: ALL
BUFFER_SIZE: ALL
BUFFER_BYTES: ALL
TICK_TIME: ALL
Rule 0 (0xea7f80): FORMAT=3D FLOAT_LE ->  FLOAT_LE SAMPLE_BITS=3D[1 4294967=
295]
Rule 1 (0xea7e70): SAMPLE_BITS=3D[1 4294967295] -> 32 FORMAT=3D FLOAT_LE
SAMPLE_BITS=3D32
Rule 2 (0xea7df0): SAMPLE_BITS=3D32 -> 32 FRAME_BITS=3D[1 4294967295] CHANN=
ELS=3D2
Rule 3 (0xea7d70): FRAME_BITS=3D[1 4294967295] -> 64 SAMPLE_BITS=3D32 CHANN=
ELS=3D2
Rule 4 (0xea7cf0): FRAME_BITS=3D64 -> 64 PERIOD_BYTES=3DALL PERIOD_SIZE=3DA=
LL
Rule 5 (0xea7cf0): FRAME_BITS=3D64 -> 64 BUFFER_BYTES=3D[1 4294967295]
BUFFER_SIZE=3D[1 4294967295]
Rule 6 (0xea7df0): CHANNELS=3D2 -> 2 FRAME_BITS=3D64 SAMPLE_BITS=3D32
Rule 7 (0xea7cf0): RATE=3D44100 -> 44100 PERIOD_SIZE=3DALL PERIOD_TIME=3DALL
Rule 8 (0xea7cf0): RATE=3D44100 -> 44100 BUFFER_SIZE=3D[1 4294967295]
BUFFER_TIME=3D[1 4294967295]
Rule 9 (0xea7df0): PERIODS=3DALL -> (0 4294967295] BUFFER_SIZE=3D[1
4294967295] PERIOD_SIZE=3DALL
Rule 10 (0xea7df0): PERIOD_SIZE=3DALL -> (0 4294967295] BUFFER_SIZE=3D[1
4294967295] PERIODS=3D(0 4294967295]
Rule 11 (0xea7cf0): PERIOD_SIZE=3D(0 4294967295] -> (0 536870912)
PERIOD_BYTES=3DALL FRAME_BITS=3D64
Rule 12 (0xea7c70): PERIOD_SIZE=3D(0 536870912) -> (0 189408058)
PERIOD_TIME=3DALL RATE=3D44100
Rule 13 (0xea7d70): BUFFER_SIZE=3D[1 4294967295] -> [1 4294967294]
PERIOD_SIZE=3D(0 189408058) PERIODS=3D(0 4294967295]
Rule 14 (0xea7cf0): BUFFER_SIZE=3D[1 4294967294] -> [1 536870911]
BUFFER_BYTES=3D[1 4294967295] FRAME_BITS=3D64
Rule 15 (0xea7c70): BUFFER_SIZE=3D[1 536870911] -> [1 189408057]
BUFFER_TIME=3D[1 4294967295] RATE=3D44100
Rule 16 (0xea7c70): PERIOD_BYTES=3DALL -> (0 1515264464) PERIOD_SIZE=3D(0
189408058) FRAME_BITS=3D64
Rule 17 (0xea7c70): BUFFER_BYTES=3D[1 4294967295] -> [8 1515264456]
BUFFER_SIZE=3D[1 189408057] FRAME_BITS=3D64
Rule 18 (0xea7cf0): PERIOD_TIME=3DALL -> (0 4294967295) PERIOD_SIZE=3D(0
189408058) RATE=3D44100
Rule 19 (0xea7cf0): BUFFER_TIME=3D[1 4294967295] -> (22 4294967279)
BUFFER_SIZE=3D[1 189408057] RATE=3D44100
Rule 0 (0xea7f80): FORMAT=3D FLOAT_LE ->  FLOAT_LE SAMPLE_BITS=3D32
Rule 2 (0xea7df0): SAMPLE_BITS=3D32 -> 32 FRAME_BITS=3D64 CHANNELS=3D2
Rule 4 (0xea7cf0): FRAME_BITS=3D64 -> 64 PERIOD_BYTES=3D(0 1515264464)
PERIOD_SIZE=3D(0 189408058)
Rule 5 (0xea7cf0): FRAME_BITS=3D64 -> 64 BUFFER_BYTES=3D[8 1515264456]
BUFFER_SIZE=3D[1 189408057]
Rule 7 (0xea7cf0): RATE=3D44100 -> 44100 PERIOD_SIZE=3D(0 189408058)
PERIOD_TIME=3D(0 4294967295)
Rule 8 (0xea7cf0): RATE=3D44100 -> 44100 BUFFER_SIZE=3D[1 189408057]
BUFFER_TIME=3D(22 4294967279)
Rule 9 (0xea7df0): PERIODS=3D(0 4294967295] -> (0 4294967295]
BUFFER_SIZE=3D[1 189408057] PERIOD_SIZE=3D(0 189408058)
Rule 10 (0xea7df0): PERIOD_SIZE=3D(0 189408058) -> (0 189408058)
BUFFER_SIZE=3D[1 189408057] PERIODS=3D(0 4294967295]
Rule 11 (0xea7cf0): PERIOD_SIZE=3D(0 189408058) -> (0 189408058)
PERIOD_BYTES=3D(0 1515264464) FRAME_BITS=3D64
Rule 12 (0xea7c70): PERIOD_SIZE=3D(0 189408058) -> (0 189408058)
PERIOD_TIME=3D(0 4294967295) RATE=3D44100
Rule 14 (0xea7cf0): BUFFER_SIZE=3D[1 189408057] -> [1 189408057]
BUFFER_BYTES=3D[8 1515264456] FRAME_BITS=3D64
Rule 15 (0xea7c70): BUFFER_SIZE=3D[1 189408057] -> [1 189408057]
BUFFER_TIME=3D(22 4294967279) RATE=3D44100
min periods 2  dir 0
max periods 64 dir 0
min_buffer_frames: 10240
set max buffer size: 10240
refine_soft 'jack' (begin)
ACCESS:  MMAP_INTERLEAVED
FORMAT:  FLOAT_LE
SUBFORMAT:  STD
SAMPLE_BITS: 32
FRAME_BITS: 64
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (23219 23220)
PERIOD_SIZE: 1024
PERIOD_BYTES: 8192
PERIODS: 10
BUFFER_TIME: (232199 232200)
BUFFER_SIZE: 10240
BUFFER_BYTES: 81920
TICK_TIME: ALL
Rule 4 (0xea7cf0): FRAME_BITS=3D64 -> 64 PERIOD_BYTES=3D8192 PERIOD_SIZE=3D=
1024
Rule 7 (0xea7cf0): RATE=3D44100 -> 44100 PERIOD_SIZE=3D1024
PERIOD_TIME=3D(23219 23220)
Rule 9 (0xea7df0): PERIODS=3D10 -> 10 BUFFER_SIZE=3D10240 PERIOD_SIZE=3D1024
Rule 10 (0xea7df0): PERIOD_SIZE=3D1024 -> 1024 BUFFER_SIZE=3D10240 PERIODS=
=3D10
Rule 13 (0xea7d70): BUFFER_SIZE=3D10240 -> 10240 PERIOD_SIZE=3D1024 PERIODS=
=3D10
Rule 16 (0xea7c70): PERIOD_BYTES=3D8192 -> 8192 PERIOD_SIZE=3D1024 FRAME_BI=
TS=3D64
Rule 18 (0xea7cf0): PERIOD_TIME=3D(23219 23220) -> (23219 23220)
PERIOD_SIZE=3D1024 RATE=3D44100
min_periods: 2, max_periods: 64, buffer_frames: 10240, period_frames:
1024, buf/per: 10.000000, periods: 10, periods_dir: 0
ALSA <-> JACK PCM I/O Plugin
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : FLOAT_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 32
  buffer_size  : 10240
  period_size  : 1024
  period_time  : 23219
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 10240
  silence_threshold: 0
  silence_size : 0
  boundary     : 1342177280
