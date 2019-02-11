From: Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH 1/1] seq: arecordmidi: Add num-events option
Date: Sun, 10 Feb 2019 20:23:36 -0800
Message-ID: <CACeCKaf2w5xEW4hHxGQ7jbzKHwfQYRJ7gud9p8jEkVVV=Zq3Vg@mail.gmail.com>
References: <5c4fb010.1c69fb81.94ca0.01ae@mx.google.com>
 <f0c4b673-52a2-fc1d-c9d8-4e4b42f999f1@sakamocchi.jp>
 <CACeCKacREMJDGWNJrdydu3+P1EZ81AyaY0sPfBhuiT11nnvV5A@mail.gmail.com>
 <20190129084502.GA9419@workstation>
 <ef5b180f-e1da-7ec9-9e2b-0b5b4b86ac14@ladisch.de>
 <CACeCKadEU4i5d82pMwnU1y_f9_Rw+cgG7PROjP5a2B_dzj0qHw@mail.gmail.com>
 <CACeCKacepsxaQOofD86Mo0MrCAduw4aAf1cANRebeeK_z=i07A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 19BDA267488
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2019 05:23:48 +0100 (CET)
Received: by mail-qt1-f195.google.com with SMTP id v10so983566qtp.8
 for <alsa-devel@alsa-project.org>; Sun, 10 Feb 2019 20:23:48 -0800 (PST)
In-Reply-To: <CACeCKacepsxaQOofD86Mo0MrCAduw4aAf1cANRebeeK_z=i07A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Friendly ping.

On Mon, Feb 4, 2019 at 12:20 PM Prashant Malani <pmalani@chromium.org>
wrote:

> Friendly ping. Sounds like Clemens mentioned atoi() should be OK (given
> his explanation regarding non-numeric strings, along with consistency with
> the rest of the utility).
> Are there any other concerns with this patchset?
>
> Thanks once again for taking the time to review.
>
> Best regards,
>
> On Tue, Jan 29, 2019 at 3:42 PM Prashant Malani <pmalani@chromium.org>
> wrote:
>
>> Interesting. Thanks for pointing that out, Clemens.
>>
>> In any case, I've sent both versions (atoi v/s strtol), so whichever one
>> is preferred can be used (would be slightly inclined towards atoi, since
>> it's used elsewhere in the file, and because of Clemens' comment;
>> additionally, there is less code duplication with the atoi version).
>>
>> Best regards,
>>
>> On Tue, Jan 29, 2019 at 8:19 AM Clemens Ladisch <clemens@ladisch.de>
>> wrote:
>>
>>> Takashi Sakamoto wrote:
>>> > When parsing string with non-numeric characters, the behaviour of
>>> > atoi() is undefined still in C11.
>>>
>>> A completely non-numeric string is specified to return zero.
>>>
>>> The behaviour is undefined only if the value cannot be represented, i.e.,
>>> if it overflows.
>>>
>>>
>>> Regards,
>>> Clemens
>>>
>>
