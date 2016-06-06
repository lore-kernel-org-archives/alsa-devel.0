From: Adam Goode <agoode@google.com>
Subject: Re: [PATCH - alsa-lib 1/1] Change card/pid get
 functions to return -ENOSYS if the kernel is too old
Date: Mon, 6 Jun 2016 09:57:33 -0400
Message-ID: <CAOf41Nk+_j_AXd9PXOKd6HV3Tv7G+Nsf35+9p0NNrOEwGyN1SQ@mail.gmail.com>
References: <1459532030-6387-1-git-send-email-agoode@google.com>
 <20160401211558.GA20661@mail.zuhause> <s5hpou5a0g0.wl-tiwai@suse.de>
 <CAOf41NmK6V1MMUrQ=UwO=nttYuk3a5b63jH5VTBxeJM9px1yow@mail.gmail.com>
 <20160407201041.GB26683@mail.zuhause> <s5hpou0mm87.wl-tiwai@suse.de>
 <5707AA7C.5030804@perex.cz> <s5hegagmekc.wl-tiwai@suse.de>
 <CAOf41N=vdhUu+y08JZLs7c=DL_LYx4wQgxxnMkWw-eQCUT-etw@mail.gmail.com>
 <20160408175633.GA14123@mail.zuhause>
 <CAOf41Nn-vtZp+po5=_5CwejXh+5Q7LyAXeZav82+T3jf1tBJ7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f49.google.com (mail-vk0-f49.google.com
 [209.85.213.49])
 by alsa0.perex.cz (Postfix) with ESMTP id B054A265759
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2016 15:58:14 +0200 (CEST)
Received: by mail-vk0-f49.google.com with SMTP id c66so46552735vkb.3
 for <alsa-devel@alsa-project.org>; Mon, 06 Jun 2016 06:58:14 -0700 (PDT)
In-Reply-To: <CAOf41Nn-vtZp+po5=_5CwejXh+5Q7LyAXeZav82+T3jf1tBJ7A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Martin Koegler <martin.koegler@chello.at>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 8, 2016 at 3:53 PM, Adam Goode <agoode@google.com> wrote:

> On Fri, Apr 8, 2016 at 1:56 PM, Martin Koegler <martin.koegler@chello.at>
> wrote:
>
>> On Fri, Apr 08, 2016 at 11:21:57AM -0400, Adam Goode wrote:
>> > So there are 2 alternatives I can think of:
>> >
>> > option 1: introduce snd_seq_client_info_get_pid_2() and leave the
>> existing
>> > function alone. This new function can return a new constant,
>> > SND_SEQ_CLIENT_INFO_PID_UNKNOWN for missing kernel support. Same for
>> card.
>> > option 2: introduce snd_seq_client_info_pid_known() that returns a bool
>> if
>> > there is kernel support. Same for card.
>>
>> I wouldn't implement option 1. Using that methode for API changes will
>> result in lots of rarely used functions.
>>
>> Chrome will probable need that information to enable a fallback-code - if
>> a application has no fallback code,
>> it has no need for different returncodes. In a few years, most
>> distributions will likely ship kernel including that functions,
>> so there is no need to for fallback-code and the kernel support check any
>> more.
>>
>> Why not a snd_seq_client_info_get_capatibilites() returing bit flags:
>> .._CAP_CARD_NUMBER | .._CAP_PID ?
>>
>>
> This approach is fine by me as well, though it does introduce more
> constants and bitwise logic.
>
>
Since returning to this problem after a while, I've realized that we don't
need any changes at all to alsa-lib. This test is equivalent to what is
needed:

snd_seq_get_client_info(seq, info); // get our client's info
bool client_pid_supported = snd_seq_client_info_get_pid(info) != -1; // do
we know our own PID?

It might be helpful to put this into the documentation, but otherwise I
think this is fine.


Thanks,

Adam
