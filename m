From: "Vitaly V. Ch" <vitaly.v.ch@gmail.com>
Subject: Re: [RFC] XEN support in aserver
Date: Wed, 28 Jan 2015 19:20:33 +0200
Message-ID: <CAJKxXouJeN6kBwrOECTDULJvJm1SofmeWXKjUpsQg6tjAsB3hg@mail.gmail.com>
References: <CAJKxXovW8LWVWSUoYRZt6RR9-=UdVCNCYDzr+hS6Gmx7jH=WMA@mail.gmail.com>
 <54C9087A.1020303@gmail.com> <s5ha912yjd6.wl-tiwai@suse.de>
Reply-To: vitaly.v.ch@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 55472261B35
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 18:20:34 +0100 (CET)
Received: by mail-pa0-f48.google.com with SMTP id ey11so27639828pad.7
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 09:20:33 -0800 (PST)
In-Reply-To: <s5ha912yjd6.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, "Alexander E. Patrakov" <patrakov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hm. Ok. So I choose to see in pulse direction.

With best regards,

Vitaly

On Wed, Jan 28, 2015 at 6:12 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 28 Jan 2015 21:04:10 +0500,
> Alexander E. Patrakov wrote:
> >
> > 28.01.2015 20:52, Vitaly V. Ch wrote:
> > > Hi all!
> > >
> > > What do you think about introducing XEN support into aserver? It will
> allow
> > > to share sound between domains with few little changes.
> >
> > It seems that you are the only person who cares about aserver.
> > Seriously, try to valgrind it and the related "share" and "shm" plugins,
> > and you'll understand why I propose to remove it instead of fixing.
>
> Yes, it'd make really little sense.
>
> BTW, just right now I started clean up of aserver and shm plugin codes
> (with a hope that no one is actually using it :)
>
>
> Takashi
>
