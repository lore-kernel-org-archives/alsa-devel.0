From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH] aplay: Fix header for raw format
Date: Fri, 30 Jun 2017 16:11:38 +0300
Message-ID: <CAEnQRZANk-SQ2oZNuWk9f2GcZ1Hqrs5v1sheoFop=LJ056+pqQ@mail.gmail.com>
References: <1498735036-26126-1-git-send-email-ion-horia.petrisor@nxp.com>
 <s5hwp7urmno.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 28B772674F0
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 15:38:21 +0200 (CEST)
Received: by mail-qt0-f195.google.com with SMTP id w12so15048460qta.2
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 06:38:21 -0700 (PDT)
In-Reply-To: <s5hwp7urmno.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Ion-Horia Petrisor <ion-horia.petrisor@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, =?UTF-8?B?5Z2C5pys6LK05Y+y?= <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thanks a lot for your feedback.

On Fri, Jun 30, 2017 at 9:54 AM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 29 Jun 2017 13:17:16 +0200,
> Ion-Horia Petrisor wrote:
>>
>> Raw format has no header, so use 0 when calling playback_go.
>
> It's the value passed for the length that has been already loaded.
> The program has read dta bytes for parsing the header, and it's raw
> data without header.  Thus you need to pass dta there.
>
With the current code we assume that the raw files have at least 26 bytes.
(sizeof (VocHeader).

I think it doesn't matter here that dta bytes has already been loaded. These
bytes useful to figure out the file header type.

To keep things simple we can assume that in the case of raw files there is no
header, so second parameter of playback_go (named loaded) can be set to 0.

The worst things that can happen is that we re-read the first 26 bytes
(previously
read as VoC header).

We are trying to introduce a new parameter --samples which tells aplay to  only
playback/record s number of samples.

We modified calc_count() accordingly so that when receives the
--samples parameter
computes the correct number of bytes to be read.

Anyhow, it doesn't work as expected because aplay expects files to have at least
26 bytes.

The correct solution would be that in the case of raw files not assume
any header
and read samples * sample_size bytes from the beginning of the file.

>
> thanks,
>
> Takashi
>
>>
>> Signed-off-by: Ion-Horia Petrisor <ion-horia.petrisor@nxp.com>
>> ---
>>  aplay/aplay.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/aplay/aplay.c b/aplay/aplay.c
>> index 00af662..fe274ed 100644
>> --- a/aplay/aplay.c
>> +++ b/aplay/aplay.c
>> @@ -2831,7 +2831,7 @@ static void playback(char *name)
>>               /* should be raw data */
>>               init_raw_data();
>>               pbrec_count = calc_count();
>> -             playback_go(fd, dta, pbrec_count, FORMAT_RAW, name);
>> +             playback_go(fd, 0, pbrec_count, FORMAT_RAW, name);
>>       }
>>        __end:
>>       if (fd != 0)
>> --
>> 2.7.4
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
