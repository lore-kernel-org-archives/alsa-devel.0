From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: locking looks odd
Date: Tue, 30 Aug 2016 16:54:22 +0100
Message-ID: <201608301654.22583.gineera@aspect135.co.uk>
References: <20160816210322.GD4466@var.home> <20160826190212.GR5165@var>
 <s5h1t16jq31.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 2.array2.smtp.34sp.com (2.array2.smtp.34sp.com [46.183.9.2])
 by alsa0.perex.cz (Postfix) with ESMTP id A00B9267D19
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 17:50:49 +0200 (CEST)
Received: from smtpauth2.array1.smtp.34sp.com (lvs6.34sp.com [46.183.13.74])
 by 2.array2.smtp.34sp.com (Postfix) with ESMTP id B6A11FEA5B
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 16:50:47 +0100 (BST)
In-Reply-To: <s5h1t16jq31.wl-tiwai@suse.de>
Content-Disposition: inline
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 30 August 2016 15:20, Takashi Iwai wrote:
> (Adding Alan to Cc)
>
> On Fri, 26 Aug 2016 21:02:12 +0200,
>
> Samuel Thibault wrote:
> > Samuel Thibault, on Sat 20 Aug 2016 14:12:05 +0200, wrote:
> > > I'd just like to check something: do we agree that libasound must be
> > > thread-safe by default (otherwise it breaks the application assumption
> > > that it's thread-safe)?  If so, then there are thread-safety bugs:
> >
> > Ok, now with the discussion on the portaudio list starting at
> >
> > https://lists.columbia.edu/pipermail/portaudio/2016-August/000599.html
> >
> > it seems the issue was in portaudio, which was hit by the locking
> > behavior change.
>
> Good to hear that it's been addressed in portaudio side.
>
> But I still wonder in which code path the deadlock was triggered.
> Can anyone give the stack traces of deadlocked (multi-)threads?

Actually, it wasn't so much the locking itself, but thread cancellation during 
one call (snd_pcm_mmap_commit()) leaving the lock held and not released, 
which then balked when a cleanup call to snd_pcm_drop() attempted to aquire 
the lock.  This occurred as a result of an 'Abort' action in Portaudio.  It 
can be avoided by disabling cancelablity at all times except when waiting on 
poll(), though I have yet to be completely satisfied  there are no snags in 
this approach, as cancelability is new to me!

Regards

Alan
