From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH - alsa-lib 1/1] Patch for another bug in
 snd_pcm_area_silence().
Date: Mon, 5 Feb 2018 15:22:34 +0100
Message-ID: <af4d47de-5ea7-2a50-eb1c-a2c93da7dd6f@perex.cz>
References: <1517508732-27545-1-git-send-email-alsa2@bushytails.net>
 <7892ed61-e1fc-47ac-406e-dfeba468f9b7@sakamocchi.jp>
 <cd542140-1fce-f8d0-723d-69ac9c597fe5@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F2752673A1
 for <alsa-devel@alsa-project.org>; Mon,  5 Feb 2018 15:22:39 +0100 (CET)
In-Reply-To: <cd542140-1fce-f8d0-723d-69ac9c597fe5@perex.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, furrywolf <alsa2@bushytails.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 5.2.2018 v 10:06 Jaroslav Kysela napsal(a):
> Dne 2.2.2018 v 07:41 Takashi Sakamoto napsal(a):
>> Hi,
>>
>> On Feb 2 2018 03:12, furrywolf wrote:
>>  > Only silence areas 64 bits at a time if it's possible to do so, which is
>>  > when either the silence values are all zero, or when the format width
>>  > divides evenly into 64 bits.  For formats that are neither of these, let
>>  > the width-specific code handle the entire silencing.  Silencing formats
>>  > that are not evenly divisible into 64 bits in 64-bit chunks, when the
>>  > data isn't just zeroes, results in values being written to shifting
>>  > positions in the sample, giving garbage.
>>  >
>>  > Makes Takashi Sakamoto's tester happy for all tests.  Yay!  (And Thanks!)
>>  >
>>  > Signed-off-by: furrywolf <alsa2@bushytails.net>
>>  >
>>  > diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
>>  > index 1753cda..5f9bd9f 100644
>>  > --- a/src/pcm/pcm.c
>>  > +++ b/src/pcm/pcm.c
>>  > @@ -2947,7 +2947,7 @@ int snd_pcm_area_silence(const 
>> snd_pcm_channel_area_t *dst_area, snd_pcm_uframes
>>  >       dst = snd_pcm_channel_area_addr(dst_area, dst_offset);
>>  >       width = snd_pcm_format_physical_width(format);
>>  >       silence = snd_pcm_format_silence_64(format);
>>  > -     if (dst_area->step == (unsigned int) width) {
>>  > +     if (dst_area->step == (unsigned int) width && (!silence || !(64 
>> % width))) {
>>  >               unsigned int dwords = samples * width / 64;
>>  >               uint64_t *dstp = (uint64_t *)dst;
>>  >               samples -= dwords * 64 / width;
>>
>> A condition of '!silence' seems to skip cases of 'signed' format of PCM
>> samples; e.g. S16, because 'snd_pcm_format_silence_64()' returns 0 as
>> silent data for these samples. However, the above block of code is a
>> fast path for data samples which are 'divisors of 64 bit'. In the code
>> block, silent data is handled as 64 bit variable to be copied to given
>> buffer iteratively. In my understanding, the condition is not
>> appropriate to the code block.
>>
>> On the other hand, a condition of '!(64 % width)' is appropriate. If any
>> 24 bit data sample is handled in the block, copied silent data aligned
>> to 64 bit include invalid 8 bits. For example of 'U24_3LE':
>>
>> Given buffer, aligned 64 bit:
>>    0x'xxxx'xxxx'xxxx'xxxx'yyyy'yyyy'yyyy'yyyy'zzzz'zzzz'zzzz'zzzz
>>
>> Silent data for 'U24_3LE' returned from 'snd_pcm_format_silence_64():
>>    0x'0000'8000'0080'0000ull (little endian)
>>
>> As a result of the fast path:
>>    0x'xxxx'xxxx'xxxx'xxxx'yyyy'yyyy'yyyy'yyyy'zzzz'zzzz'zzzz'zzzz
>>    v                                                            v
>>    0x'0000'8000'0080'0000'0000'8000'0080'0000'0000'8000'0080'0000
>>    (sample data with 'x-z' represent data aligned to 64 bits)
>>
>> However, expected:
>>    0x'8000'0080'0000'8000'0080'0000'8000'0080'0000'8000'0080'0000
>>    0x'gggg'gghh'hhhh'iiii'iijj'jjjj'kkkk'kkll'llll'mmmm'mmnn'nnnn
>>    (sample data with 'g-n' represent data aligned to 24 bit)
>>
>> Practically, for any 24 bit sample data, we didn't see any issue caused
>> by the above mechanism because in most case 'signed' sample data is
>> handles by usual use cases, in my opinion.
>>
>> Of course, a condition of '!silence' is a good optimization for
>> cases of 'signed' PCM samples. But it's not good for the other kind of
>> data format (e.g. DSD). At present, there's no sample format which has
>> 24 bit data for non-PCM format, however it's better to avoid future
>> problem, unless we were astrologers.
>>
>> Overall, the fast path is not designed to handle any 24 bit sample data.
>> We _should_ skip the fast path for any 24 bit samples, regardless of
>> sign. Thus, below patch is enough for an issue to which I addressed in
>> my previous message[1]. I can pass my test[2] with this patch.\
> 
> I applied both patches (furrywolf's and yours). I think that there
> should be more work on the fast path, because 'dst' might not be aligned
> and some CPUs needs more time (and even show warnings) when the word is
> stored to an unaligned destination. Also, we may use memset() for the
> special case when all bytes are identical.

Here is the patch:

http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=af531606b73634b56ec0ec73fbea8297a7752172

It should resolve all fast path issues.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
