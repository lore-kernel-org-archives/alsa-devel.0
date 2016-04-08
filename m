From: Adam Goode <agoode@google.com>
Subject: Re: [PATCH - alsa-lib 1/1] Change card/pid get
 functions to return -ENOSYS if the kernel is too old
Date: Fri, 8 Apr 2016 15:53:53 -0400
Message-ID: <CAOf41Nn-vtZp+po5=_5CwejXh+5Q7LyAXeZav82+T3jf1tBJ7A@mail.gmail.com>
References: <1459532030-6387-1-git-send-email-agoode@google.com>
 <20160401211558.GA20661@mail.zuhause> <s5hpou5a0g0.wl-tiwai@suse.de>
 <CAOf41NmK6V1MMUrQ=UwO=nttYuk3a5b63jH5VTBxeJM9px1yow@mail.gmail.com>
 <20160407201041.GB26683@mail.zuhause> <s5hpou0mm87.wl-tiwai@suse.de>
 <5707AA7C.5030804@perex.cz> <s5hegagmekc.wl-tiwai@suse.de>
 <CAOf41N=vdhUu+y08JZLs7c=DL_LYx4wQgxxnMkWw-eQCUT-etw@mail.gmail.com>
 <20160408175633.GA14123@mail.zuhause>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com
 [209.85.213.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 36F83265132
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2016 21:54:34 +0200 (CEST)
Received: by mail-vk0-f51.google.com with SMTP id k1so150725596vkb.0
 for <alsa-devel@alsa-project.org>; Fri, 08 Apr 2016 12:54:34 -0700 (PDT)
In-Reply-To: <20160408175633.GA14123@mail.zuhause>
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

On Fri, Apr 8, 2016 at 1:56 PM, Martin Koegler <martin.koegler@chello.at>
wrote:

> On Fri, Apr 08, 2016 at 11:21:57AM -0400, Adam Goode wrote:
> > So there are 2 alternatives I can think of:
> >
> > option 1: introduce snd_seq_client_info_get_pid_2() and leave the
> existing
> > function alone. This new function can return a new constant,
> > SND_SEQ_CLIENT_INFO_PID_UNKNOWN for missing kernel support. Same for
> card.
> > option 2: introduce snd_seq_client_info_pid_known() that returns a bool
> if
> > there is kernel support. Same for card.
>
> I wouldn't implement option 1. Using that methode for API changes will
> result in lots of rarely used functions.
>
> Chrome will probable need that information to enable a fallback-code - if
> a application has no fallback code,
> it has no need for different returncodes. In a few years, most
> distributions will likely ship kernel including that functions,
> so there is no need to for fallback-code and the kernel support check any
> more.
>
> Why not a snd_seq_client_info_get_capatibilites() returing bit flags:
> .._CAP_CARD_NUMBER | .._CAP_PID ?
>
>
This approach is fine by me as well, though it does introduce more
constants and bitwise logic.


Adam




> Regards,
> Martin
>
