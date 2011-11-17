From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 2/2] Improve hw_params documentation
Date: Thu, 17 Nov 2011 08:45:22 +0800
Message-ID: <CAN8cciYAvUuBScTDTVsuBVaUwvisizgX8TKtyrH9faS5J9090w@mail.gmail.com>
References: <20111116195607.GI30602@foghorn.codeweavers.com>
	<4EC42907.80104@ladisch.de>
	<20111116213135.GJ30602@foghorn.codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A30A103A0A
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 01:45:23 +0100 (CET)
Received: by bkat8 with SMTP id t8so1292776bka.38
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 16:45:22 -0800 (PST)
In-Reply-To: <20111116213135.GJ30602@foghorn.codeweavers.com>
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
> On Wed, Nov 16, 2011 at 10:20:07PM +0100, Clemens Ladisch wrote:
>> Andrew Eikum wrote:
>> > +++ b/include/pcm.h
>> > @@ -44,8 +44,20 @@ extern "C" {
>> >
>> > =A0/** PCM generic info container */
>> > =A0typedef struct _snd_pcm_info snd_pcm_info_t;
>> > -/** PCM hardware configuration space container */
>> > +
>> > +/** PCM hardware configuration space container
>> > + *
>> > + * =A0snd_pcm_hw_params_t is an opaque structure which contains a set=
 of possible
>> > + * =A0PCM hardware configurations. For example, a given instance migh=
t include a
>> > + * =A0range of buffer sizes, a range of period sizes, and a set of se=
veral sample
>> > + * =A0formats. Some subset of all possible combinations these sets ma=
y be valid,
>> > + * =A0but not necessarily any combination will be valid.
>> > + *
>> > + * =A0No validation is done by the various snd_pcm_hw_params_set* fun=
ctions.
>>
>> These functions do validate the value that the application is trying to =
set
>> and adjust all other dependent limits.
>>
>
> I didn't find that to be the case in my testing, at least between
> periods, period_size, and buffer_size. I've attached a test program
> here. It sets periods to 10, period_size to 1024, and buffer_size_max
> to be the same as the return from get_buffer_size_min (in my case,
> 80). The first call to fail is snd_pcm_hw_params(). If what you said
> is true, I would expect the set_buffer_size_max() call to fail.
>
> $ gcc -I /usr/include/alsa -lasound -o alsa_period_count alsa_period_coun=
t.c
> $ ./alsa_period_count
> min_buffer_frames: 80
> set max buffer size: 80
> snd_pcm_hw_params: -12
> $
>
> Andrew
>

The logic of your program is wrong since your program did not set
channel, rate and format

There are sound cards which support S16 and U8, mono and stereo.

As  "default" device using "plug:dmix" , "pulse" or "hw"

The buffer and period calculation is only valid after you have choose
the format and channels

http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html

Hardware related parameters
The ALSA PCM devices use the parameter refining system for hardware
parameters - snd_pcm_hw_params_t. It means, that application choose
the full-range of configurations at first and then application sets
single parameters until all parameters are elementary (definite).
