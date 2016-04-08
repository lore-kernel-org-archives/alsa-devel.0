From: Adam Goode <agoode@google.com>
Subject: Re: [PATCH - alsa-lib 1/1] Change card/pid get
 functions to return -ENOSYS if the kernel is too old
Date: Fri, 8 Apr 2016 11:21:57 -0400
Message-ID: <CAOf41N=vdhUu+y08JZLs7c=DL_LYx4wQgxxnMkWw-eQCUT-etw@mail.gmail.com>
References: <1459532030-6387-1-git-send-email-agoode@google.com>
 <20160401211558.GA20661@mail.zuhause> <s5hpou5a0g0.wl-tiwai@suse.de>
 <CAOf41NmK6V1MMUrQ=UwO=nttYuk3a5b63jH5VTBxeJM9px1yow@mail.gmail.com>
 <20160407201041.GB26683@mail.zuhause> <s5hpou0mm87.wl-tiwai@suse.de>
 <5707AA7C.5030804@perex.cz> <s5hegagmekc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com
 [209.85.213.46])
 by alsa0.perex.cz (Postfix) with ESMTP id ECDDD264F23
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2016 17:22:37 +0200 (CEST)
Received: by mail-vk0-f46.google.com with SMTP id k1so141946344vkb.0
 for <alsa-devel@alsa-project.org>; Fri, 08 Apr 2016 08:22:37 -0700 (PDT)
In-Reply-To: <s5hegagmekc.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Martin Koegler <martin.koegler@chello.at>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 8, 2016 at 9:10 AM, Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 08 Apr 2016 14:56:28 +0200,
> Jaroslav Kysela wrote:
> >
> > Dne 8.4.2016 v 12:24 Takashi Iwai napsal(a):
> > > On Thu, 07 Apr 2016 22:10:41 +0200,
> > > Martin Koegler wrote:
> > >>
> > >> On Thu, Apr 07, 2016 at 03:23:01PM -0400, Adam Goode wrote:
> > >>> Have you heard any objections?
> > >>>
> > >>> Also, would you plan to do a 1.1.2 release soon after accepting
> this, to
> > >>> get this functionality out quickly?
> > >>
> > >> Distributions already start to pick 1.1.1 up:
> > >> https://build.opensuse.org/request/show/382608
> > >> https://build.opensuse.org/request/show/382611
> > >>
> > >> I would object merging that patch, if there is no immediate patched
> 1.1.2 release available,
> > >> as otherwise 1.1.1 with a different API will get used by the mass.
> > >
> > > I have no strong opinion on this, so far.  Either way (a quick 1.1.2
> > > fix release, or introducing a new function in 1.1.2) isn't a big
> > > deal.  Maybe the former is easier, but the latter is safer.
> > >
> > > Jaroslav, what's your take?
> > > (And no, let's not use the versioned symbols again :)
> >
> > What about 1.1.1.2 ?
>
> Do you mean 1.1.1.1?  It's already confusing, as you see :)
>
> > This + "pcm_plugin: fix appl pointer not correct
> > when mmap_commit() return error" patch ?
>
> If you don't mind a quick release, we may do it, yes, no matter which
> version number is.
>
> But, meanwhile, I thought of the change again, and now wonder whether
> it's really right to return an error *and* -1.  -1 conflicts with
> EPERM.  And I thought there is no POSIX definition of error numbers,
> so in theory, -ENOSYS may be -1.
>
>
I agree now that -ENOSYS is probably wrong here. I think changing the
function's behavior at this point is now too late.

So there are 2 alternatives I can think of:

option 1: introduce snd_seq_client_info_get_pid_2() and leave the existing
function alone. This new function can return a new constant,
SND_SEQ_CLIENT_INFO_PID_UNKNOWN for missing kernel support. Same for card.
option 2: introduce snd_seq_client_info_pid_known() that returns a bool if
there is kernel support. Same for card.

Thoughts? Alternatives?


Thanks,

Adam



>
> thanks,
>
> Takashi
>
