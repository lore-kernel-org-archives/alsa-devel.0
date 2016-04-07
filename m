From: Adam Goode <agoode@google.com>
Subject: Re: [PATCH - alsa-lib 1/1] Change card/pid get
 functions to return -ENOSYS if the kernel is too old
Date: Thu, 7 Apr 2016 15:23:01 -0400
Message-ID: <CAOf41NmK6V1MMUrQ=UwO=nttYuk3a5b63jH5VTBxeJM9px1yow@mail.gmail.com>
References: <1459532030-6387-1-git-send-email-agoode@google.com>
 <20160401211558.GA20661@mail.zuhause> <s5hpou5a0g0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com
 [209.85.213.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E7DA2650F7
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 21:23:42 +0200 (CEST)
Received: by mail-vk0-f51.google.com with SMTP id k1so112215850vkb.0
 for <alsa-devel@alsa-project.org>; Thu, 07 Apr 2016 12:23:42 -0700 (PDT)
In-Reply-To: <s5hpou5a0g0.wl-tiwai@suse.de>
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

On Mon, Apr 4, 2016 at 10:54 AM, Takashi Iwai <tiwai@suse.de> wrote:

> On Fri, 01 Apr 2016 23:15:58 +0200,
> Martin Koegler wrote:
> >
> > On Fri, Apr 01, 2016 at 01:33:50PM -0400, Adam Goode wrote:
> > > When trying to get the pid or card of a client, the get functions will
> > > return -1 if there is no pid or card for a client. Clients have zero or
> > > one of these, so -1 is correct for these cases. But we also need to
> detect
> > > the case where the kernel cannot tell us if there is a card or pid, so
> > > that userspace can fallback to probing this information in the old way.
> >
> > Its a pity, that alsa-lib 1.1.1 has just been released, which just
> returns -1.
> > If the time between releases is really about 2 kernel releases, you will
> very likely
> > have to cope with the old API for some time.
>
> Strictly speaking, for the function behavior change, we'd need a new
> API function and deprecated the old one eventually.  But, this case is
> in a gray zone; the function definition doesn't prohibit to return an
> error value yet, but the change like this is incompatible with the
> current aconnect code, which is likely regarded as a template for
> other programs.
>
> OTOH, this is a pretty new API function, and it might be not too bad
> to fix the usage in the early stage, especially when it's a good
> improvement of the function behavior.
>
> So, for now, I'm inclined to take this change with a slight risk of
> breakage.  But I'm open for more arguments, and would like to hear any
> objections.
>
>
Hi Takashi,

Have you heard any objections?

Also, would you plan to do a 1.1.2 release soon after accepting this, to
get this functionality out quickly?


Thanks,

Adam




>
> thanks,
>
> Takashi
>
