From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH - alsa-lib 1/1] Patch for another bug in
	snd_pcm_area_silence().
Date: Mon, 5 Feb 2018 10:30:50 +0100
Message-ID: <CAOf5uwmfdcV+kVNSqPK-cY98yBoet5+KNJRD=3b5uZ-F=wUvpA@mail.gmail.com>
References: <1517508732-27545-1-git-send-email-alsa2@bushytails.net>
 <7892ed61-e1fc-47ac-406e-dfeba468f9b7@sakamocchi.jp>
 <cd542140-1fce-f8d0-723d-69ac9c597fe5@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f195.google.com (mail-io0-f195.google.com
 [209.85.223.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A623266F3E
 for <alsa-devel@alsa-project.org>; Mon,  5 Feb 2018 10:30:51 +0100 (CET)
Received: by mail-io0-f195.google.com with SMTP id d13so29570904iog.5
 for <alsa-devel@alsa-project.org>; Mon, 05 Feb 2018 01:30:51 -0800 (PST)
In-Reply-To: <cd542140-1fce-f8d0-723d-69ac9c597fe5@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: furrywolf <alsa2@bushytails.net>, Linux-ALSA <alsa-devel@alsa-project.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Hi

On Mon, Feb 5, 2018 at 10:06 AM, Jaroslav Kysela <perex@perex.cz> wrote:
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

Can I know what is the best approach to have silence before the
beginning on next stream. I have designed a player
that can play dsd and pcm over i2s and I don't know if the silence
should be sent by the prepare function of the soc or there
is a way to configure it in alsa user space part. Any help can be useful

Michael



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
>
>                                 Thanks,
>                                         Jaroslav
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
