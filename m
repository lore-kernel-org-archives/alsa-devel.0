From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 2/2] Improve hw_params documentation
Date: Tue, 22 Nov 2011 06:31:03 +0800
Message-ID: <CAN8ccib-EYr1QzRapcsRT9NMM12xY7V5OL2M07KahkNC_Vr55g@mail.gmail.com>
References: <20111116195607.GI30602@foghorn.codeweavers.com>
	<4EC42907.80104@ladisch.de>
	<20111116213135.GJ30602@foghorn.codeweavers.com>
	<4EC43465.5060901@ladisch.de>
	<20111117140243.GK30602@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 294CB244F1
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 23:31:05 +0100 (CET)
Received: by bkat8 with SMTP id t8so7129772bka.38
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 14:31:03 -0800 (PST)
In-Reply-To: <20111117140243.GK30602@foghorn.codeweavers.com>
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

2011/11/17 Andrew Eikum <aeikum@codeweavers.com>:
> On Wed, Nov 16, 2011 at 11:08:37PM +0100, Clemens Ladisch wrote:
>> On 11/16/2011 10:31 PM, Andrew Eikum wrote:
>> > On Wed, Nov 16, 2011 at 10:20:07PM +0100, Clemens Ladisch wrote:
>> >> Andrew Eikum wrote:
>> >>> +++ b/include/pcm.h
>> >>> @@ -44,8 +44,20 @@ extern "C" {
>> >>>
>> >>> =A0/** PCM generic info container */
>> >>> =A0typedef struct _snd_pcm_info snd_pcm_info_t;
>> >>> -/** PCM hardware configuration space container */
>> >>> +
>> >>> +/** PCM hardware configuration space container
>> >>> + *
>> >>> + * =A0snd_pcm_hw_params_t is an opaque structure which contains a s=
et of possible
>> >>> + * =A0PCM hardware configurations. For example, a given instance mi=
ght include a
>> >>> + * =A0range of buffer sizes, a range of period sizes, and a set of =
several sample
>> >>> + * =A0formats. Some subset of all possible combinations these sets =
may be valid,
>> >>> + * =A0but not necessarily any combination will be valid.
>> >>> + *
>> >>> + * =A0No validation is done by the various snd_pcm_hw_params_set* f=
unctions.
>> >>
>> >> These functions do validate the value that the application is trying =
to set
>> >> and adjust all other dependent limits.
>> >
>> > I didn't find that to be the case in my testing, at least between
>> > periods, period_size, and buffer_size. I've attached a test program
>> > here.
>>
>> I can reproduce this.
>>
>> Try running the program with LIBASOUND_DEBUG=3D1; it appears that there =
is
>> a bug in the rate plugin. =A0(Normal programs actually set their rate ..=
.)
>
> This doesn't change the output in any way. I checked the Arch Linux
> alsa-lib build script[1] and it doesn't seem to disable debugging in
> any obvious way. Do I have to explicitly enable debugging output and
> rebuild?
>
> $ LIBASOUND_DEBUG=3D1 ./alsa_period_count
> min_buffer_frames: 80
> set max buffer size: 80
> snd_pcm_hw_params: -12
> $
>
> [1] http://projects.archlinux.org/svntogit/packages.git/tree/trunk/PKGBUI=
LD?h=3Dpackages/alsa-lib
>

There is a bug in your program which set the buffer_size_max to buffer_size=
_min

    err =3D snd_pcm_hw_params_set_periods(pcm, hw_params, 10, 0);
    if(err < 0){
        printf("snd_pcm_hw_params_set_periods: %d\n", err);
        return 1;
    }

    err =3D snd_pcm_hw_params_set_period_size(pcm, hw_params, 1024, 0);
    if(err < 0){
        printf("snd_pcm_hw_params_set_period_size: %d\n", err);
        return 1;
    }

The above already set buffer size to 10240, but you set
buffer_size_max to buffer_size_min (80)

    err =3D snd_pcm_hw_params_get_buffer_size_min(hw_params, &buffer_frames=
);
    if(err < 0){
        printf("snd_pcm_hw_params_get_buffer_size: %d\n", err);
        return 1;
    }
    printf("min_buffer_frames: %u\n", buffer_frames);

    err =3D snd_pcm_hw_params_set_buffer_size_max(pcm, hw_params, &buffer_f=
rames);
    if(err < 0){
        printf("snd_pcm_hw_params_get_buffer_size: %d\n", err);
        return 1;
    }
    printf("set max buffer size: %u\n", buffer_frames);



./alsa_period_count pulse
refine_soft 'pulse' (begin)
ACCESS:  RW_INTERLEAVED
FORMAT:  U8 S16_LE S16_BE S32_LE S32_BE FLOAT_LE FLOAT_BE MU_LAW A_LAW
SUBFORMAT:  ALL
SAMPLE_BITS: ALL
FRAME_BITS: ALL
CHANNELS: [1 32]
RATE: [1 192000]
PERIOD_TIME: ALL
PERIOD_SIZE: ALL
PERIOD_BYTES: ALL
PERIODS: ALL
BUFFER_TIME: ALL
BUFFER_SIZE: ALL
BUFFER_BYTES: ALL
TICK_TIME: ALL
Rule 0 (0x160f80): FORMAT=3D U8 S16_LE S16_BE S32_LE S32_BE FLOAT_LE
FLOAT_BE MU_LAW A_LAW ->  U8 S16_LE S16_BE S32_LE S32_BE FLOAT_LE
FLOAT_BE MU_LAW A_LAW SAMPLE_BITS=3D[1 4294967295]
Rule 1 (0x160e70): SAMPLE_BITS=3D[1 4294967295] -> [8 32] FORMAT=3D U8
S16_LE S16_BE S32_LE S32_BE FLOAT_LE FLOAT_BE MU_LAW A_LAW
SAMPLE_BITS=3D[8 32]
Rule 2 (0x160df0): SAMPLE_BITS=3D[8 32] -> [8 32] FRAME_BITS=3D[1
4294967295] CHANNELS=3D[1 32]
Rule 3 (0x160d70): FRAME_BITS=3D[1 4294967295] -> [8 1024]
SAMPLE_BITS=3D[8 32] CHANNELS=3D[1 32]
Rule 4 (0x160cf0): FRAME_BITS=3D[8 1024] -> [8 1024] PERIOD_BYTES=3DALL
PERIOD_SIZE=3DALL
Rule 5 (0x160cf0): FRAME_BITS=3D[8 1024] -> [8 1024] BUFFER_BYTES=3D[1
4294967295] BUFFER_SIZE=3D[1 4294967295]
Rule 6 (0x160df0): CHANNELS=3D[1 32] -> [1 32] FRAME_BITS=3D[8 1024]
SAMPLE_BITS=3D[8 32]
Rule 7 (0x160cf0): RATE=3D[1 192000] -> [1 192000] PERIOD_SIZE=3DALL PERIOD=
_TIME=3DALL
Rule 8 (0x160cf0): RATE=3D[1 192000] -> [1 192000] BUFFER_SIZE=3D[1
4294967295] BUFFER_TIME=3D[1 4294967295]
Rule 9 (0x160df0): PERIODS=3DALL -> (0 4294967295] BUFFER_SIZE=3D[1
4294967295] PERIOD_SIZE=3DALL
Rule 10 (0x160df0): PERIOD_SIZE=3DALL -> (0 4294967295] BUFFER_SIZE=3D[1
4294967295] PERIODS=3D(0 4294967295]
Rule 11 (0x160cf0): PERIOD_SIZE=3D(0 4294967295] -> (0 4294967295]
PERIOD_BYTES=3DALL FRAME_BITS=3D[8 1024]
Rule 12 (0x160c70): PERIOD_SIZE=3D(0 4294967295] -> (0 824633721)
PERIOD_TIME=3DALL RATE=3D[1 192000]
Rule 13 (0x160d70): BUFFER_SIZE=3D[1 4294967295] -> [1 4294967294]
PERIOD_SIZE=3D(0 824633721) PERIODS=3D(0 4294967295]
Rule 14 (0x160cf0): BUFFER_SIZE=3D[1 4294967294] -> [1 4294967294]
BUFFER_BYTES=3D[1 4294967295] FRAME_BITS=3D[8 1024]
Rule 15 (0x160c70): BUFFER_SIZE=3D[1 4294967294] -> [1 824633720]
BUFFER_TIME=3D[1 4294967295] RATE=3D[1 192000]
Rule 16 (0x160c70): PERIOD_BYTES=3DALL -> (0 4294967295) PERIOD_SIZE=3D(0
824633721) FRAME_BITS=3D[8 1024]
Rule 17 (0x160c70): BUFFER_BYTES=3D[1 4294967295] -> [1 4294967295]
BUFFER_SIZE=3D[1 824633720] FRAME_BITS=3D[8 1024]
Rule 18 (0x160cf0): PERIOD_TIME=3DALL -> (0 4294967295) PERIOD_SIZE=3D(0
824633721) RATE=3D[1 192000]
Rule 19 (0x160cf0): BUFFER_TIME=3D[1 4294967295] -> (5 4294967295]
BUFFER_SIZE=3D[1 824633720] RATE=3D[1 192000]
Rule 0 (0x160f80): FORMAT=3D U8 S16_LE S16_BE S32_LE S32_BE FLOAT_LE
FLOAT_BE MU_LAW A_LAW ->  U8 S16_LE S16_BE S32_LE S32_BE FLOAT_LE
FLOAT_BE MU_LAW A_LAW SAMPLE_BITS=3D[8 32]
Rule 2 (0x160df0): SAMPLE_BITS=3D[8 32] -> [8 32] FRAME_BITS=3D[8 1024]
CHANNELS=3D[1 32]
Rule 4 (0x160cf0): FRAME_BITS=3D[8 1024] -> [8 1024] PERIOD_BYTES=3D(0
4294967295) PERIOD_SIZE=3D(0 824633721)
Rule 5 (0x160cf0): FRAME_BITS=3D[8 1024] -> [8 1024] BUFFER_BYTES=3D[1
4294967295] BUFFER_SIZE=3D[1 824633720]
Rule 7 (0x160cf0): RATE=3D[1 192000] -> [1 192000] PERIOD_SIZE=3D(0
824633721) PERIOD_TIME=3D(0 4294967295)
Rule 8 (0x160cf0): RATE=3D[1 192000] -> [1 192000] BUFFER_SIZE=3D[1
824633720] BUFFER_TIME=3D(5 4294967295]
Rule 9 (0x160df0): PERIODS=3D(0 4294967295] -> (0 4294967295]
BUFFER_SIZE=3D[1 824633720] PERIOD_SIZE=3D(0 824633721)
Rule 10 (0x160df0): PERIOD_SIZE=3D(0 824633721) -> (0 824633721)
BUFFER_SIZE=3D[1 824633720] PERIODS=3D(0 4294967295]
Rule 11 (0x160cf0): PERIOD_SIZE=3D(0 824633721) -> (0 824633721)
PERIOD_BYTES=3D(0 4294967295) FRAME_BITS=3D[8 1024]
Rule 12 (0x160c70): PERIOD_SIZE=3D(0 824633721) -> (0 824633721)
PERIOD_TIME=3D(0 4294967295) RATE=3D[1 192000]
Rule 15 (0x160c70): BUFFER_SIZE=3D[1 824633720] -> [1 824633720]
BUFFER_TIME=3D(5 4294967295] RATE=3D[1 192000]
min periods 3
max periods 1024
min_buffer_frames: 80
set max buffer size: 80
refine_soft 'pulse' (begin)
ACCESS:  RW_INTERLEAVED
FORMAT:  U8
SUBFORMAT:  STD
SAMPLE_BITS: [8 32]
FRAME_BITS: [8 1024]
CHANNELS: [1 32]
RATE: [1 192000]
PERIOD_TIME: (5333 1024000000]
PERIOD_SIZE: 1024
PERIOD_BYTES: 1024
PERIODS: 10
BUFFER_TIME: (416 80000000]
BUFFER_SIZE: 80
BUFFER_BYTES: 10240
TICK_TIME: ALL
Rule 1 (0x160e70): SAMPLE_BITS=3D[8 32] -> 8 FORMAT=3D U8 SAMPLE_BITS=3D8
Rule 3 (0x160d70): FRAME_BITS=3D[8 1024] -> [8 256] SAMPLE_BITS=3D8 CHANNEL=
S=3D[1 32]
Rule 4 (0x160cf0): FRAME_BITS=3D[8 256] -> 8 PERIOD_BYTES=3D1024 PERIOD_SIZ=
E=3D1024
Rule 5 (0x160cf0): FRAME_BITS=3D8 -> NONE BUFFER_BYTES=3D10240 BUFFER_SIZE=
=3D80
refine_soft 'pulse' (end--22)
ACCESS:  RW_INTERLEAVED
FORMAT:  U8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: NONE
CHANNELS: [1 32]
RATE: [1 192000]
PERIOD_TIME: (5333 1024000000]
PERIOD_SIZE: 1024
PERIOD_BYTES: 1024
PERIODS: 10
BUFFER_TIME: (416 80000000]
BUFFER_SIZE: 80
BUFFER_BYTES: 10240
TICK_TIME: ALL
snd_pcm_hw_params: -12
