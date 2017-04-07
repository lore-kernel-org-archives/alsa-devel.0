From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2] aplay: Fix error message when writing
 captured data
Date: Fri, 7 Apr 2017 18:00:06 +0300
Message-ID: <CAEnQRZDuUKH2iBNPq=je7zbjwcEHycb74sej6Orxu9WVk5JJBw@mail.gmail.com>
References: <1491571236-23476-1-git-send-email-daniel.baluta@nxp.com>
 <s5h8tnc8i08.wl-tiwai@suse.de>
 <CAEnQRZCvZ5p=DeTXG5h_hEKW=Bo5oFDRdBMjDGbMF+K0Kjt0RQ@mail.gmail.com>
 <s5h60ig8f3i.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
 [209.85.214.66])
 by alsa0.perex.cz (Postfix) with ESMTP id AAFA4266A89
 for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2017 17:00:07 +0200 (CEST)
Received: by mail-it0-f66.google.com with SMTP id y18so7822594itc.2
 for <alsa-devel@alsa-project.org>; Fri, 07 Apr 2017 08:00:07 -0700 (PDT)
In-Reply-To: <s5h60ig8f3i.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, shengjiu.wang@nxp.com, o-takashi@sakamocchi.jp, Mark Brown <broonie@kernel.org>, viorel.suman@nxp.com, mihai.serban@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 7, 2017 at 5:30 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 07 Apr 2017 15:45:42 +0200,
> Daniel Baluta wrote:
>>
>> On Fri, Apr 7, 2017 at 4:27 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Fri, 07 Apr 2017 15:20:36 +0200,
>> > Daniel Baluta wrote:
>> >>
>> >> Read can return less then requested bytes, but we treat
>> >> this as an error.
>> >
>> s/read/write here :)).
>>
>> > Actually that's the bug -- we should loop the write until it reaches
>> > to the real error.  Once when we get the proper errno, the error
>> > message via perror() itself will be enough.
>>
>> Correct. But I think aplay decided to keep things simple and fail in case
>> couldn't write all requested bytes.
>
> And that's wrong.  We should loop instead.
>
>> This pattern can be noticed all over the places where write is used.
>
> All wrong :)
>
> We can implement a simple helper function and replace each write call
> with it.
>
>> Given the fact that write is blocking (meaning that it must write
>> at least one byte until return) this should work most of the time,
>> excepting corner cases like disk full, etc.
>
> Yes, and such corner cases must be handled properly, too -- in the
> end, it's what you wanted to achieve by your patch, but into a
> different direction.

:), all right. Will fix this the correct way and resend.

thanks,
Daniel.
