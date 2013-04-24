From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Asynchronous audio USB chips: choppy playback
 since 3.8-rc7
Date: Wed, 24 Apr 2013 15:11:48 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1304241504580.1548-100000@iolanthe.rowland.org>
References: <517824CB.8050309@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id 0AC962625CF
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 21:11:49 +0200 (CEST)
In-Reply-To: <517824CB.8050309@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, 1136110@bugs.launchpad.net, Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>, Tyson Tan <tysontan@mail.com>, Joseph Salisbury <joseph.salisbury@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 24 Apr 2013, David Henningsson wrote:

> >> Ok, Joseph Salisbury has build some bisection kernels, and Tyson Tan
> >> relentlessly tested all of them, and it turns out that
> >>
> >> 3e619d0415 ("USB: EHCI: fix bug in scheduling periodic split transfers")
> >>
> >> Is the first bad commit. Also, reverting this commit from the current
> >> mainline head makes the problem disappear.
> >>
> >> Alan, any idea?
> >>
> >>    https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1136110
> >
> > No ideas as to the cause.
> >
> > For debugging, it would help to see a usbmon trace from a kernel where
> > the problem occurs, together with a trace from another kernel where the
> > problem does not occur.
> >
> > Alan Stern
> 
> First, thanks for looking at this bug.
> 
> While a long-term solution is being discussed, this patch went to stable 
> too, where it is causing regressions. Would it be okay just to revert 
> this patch in the next stable series? (Even if this was a bug fix, few 
> people seem to have noticed?) Or do you envision something else 
> happening but the original -ENOSPC error showing up, due to other stuff 
> that went to stable at the same time?

I think reverting it from stable won't cause any new problems to show 
up (although the original problem will return, obviously).  Go ahead.

At the same time, it would be nice to know that some people are really
carrying out tests to find the reason for the new problem.  Otherwise
we end up with this commit reverted and nobody trying to figure out how
to fix the original bug correctly.

Alan Stern
