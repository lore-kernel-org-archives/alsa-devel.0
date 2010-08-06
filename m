From: sudarshan bisht <bisht.sudarshan@gmail.com>
Subject: Re: ALSA Mixer issue
Date: Fri, 6 Aug 2010 11:05:08 +0300
Message-ID: <AANLkTikFXVoGD9bBm8eCVWUFhp8T49M-G_j3ZCfKPuNm@mail.gmail.com>
References: <AANLkTi=5Cxxv6bCuFZ9TB7wOKo0m1FrNTvHiOqmhXMAu@mail.gmail.com>
	<alpine.LNX.2.00.1007301528130.4068@eeebox2.perex-int.cz>
	<AANLkTinG4CJi5k1DqJFNneDk+7Crk+k7zp+evPuFEPdQ@mail.gmail.com>
	<AANLkTi=QOc3_9SnKSD_ethGS+eTG8vEorUFn=yencSD1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B7DB103956
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Aug 2010 10:05:10 +0200 (CEST)
Received: by qwi2 with SMTP id 2so4872054qwi.38
	for <alsa-devel@alsa-project.org>; Fri, 06 Aug 2010 01:05:09 -0700 (PDT)
In-Reply-To: <AANLkTi=QOc3_9SnKSD_ethGS+eTG8vEorUFn=yencSD1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav ,

                      It works fine in my Linux PC but when I try to run
same on my target device , it gets into infinite loop and never comes out of
poll function.
Any suggestion to make it work on target device ?

On Tue, Aug 3, 2010 at 10:35 AM, sudarshan bisht
<bisht.sudarshan@gmail.com>wrote:

> Thanks Jaroslav ,
>
> It works for me !!!
>
>
>
> On Fri, Jul 30, 2010 at 5:36 PM, sudarshan bisht <
> bisht.sudarshan@gmail.com> wrote:
>
>> Thanks for the reply , I will try the same soon .
>>
>> On Fri, Jul 30, 2010 at 7:00 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>>
>>>  On Fri, 30 Jul 2010, sudarshan bisht wrote:
>>>
>>> Hi ,
>>>>
>>>> I wanted to know that can we use multiple handlers for the same ALSA
>>>> mixer ?
>>>>
>>>> My use case is something like this .
>>>>
>>>> I have two modules and having two different handlers for ALSA mixer.
>>>>  First
>>>> module does some volume change , and I try to read the latest volume
>>>> using
>>>> my second handler ( of first second module) .
>>>>
>>>> But I am not getting the most recent value in second handler ( the
>>>> volume
>>>> set by the first module )  so I feel there is some inconsistency when I
>>>> use
>>>> two handlers from two different modules in order to fetch volume
>>>> information
>>>> from the ALSA mixer.
>>>>
>>>
>>> You must sync the cached information using poll() or select() on file
>>> descriptors returned by snd_mixer_poll_descriptors_*() functions and call
>>> snd_mixer_handle_events() if any events are waiting.
>>>
>>>                                        Jaroslav
>>>
>>> -----
>>> Jaroslav Kysela <perex@perex.cz>
>>> Linux Kernel Sound Maintainer
>>> ALSA Project, Red Hat, Inc.
>>>
>>>
>>
>>
>> --
>> Regards,
>>
>> Sudarshan Bisht
>>
>
>
>
> --
> Regards,
>
> Sudarshan Bisht
>



-- 
Regards,

Sudarshan Bisht
