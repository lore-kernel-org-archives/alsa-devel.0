From: John Lindgren <john.lindgren@tds.net>
Subject: Re: [PATCH] alsa-lib: snd_pcm_delay and friends do not
 account for a write being currently in progress
Date: Thu, 03 Jun 2010 14:06:57 -0400
Message-ID: <1275588417.20342.18.camel@satellite>
References: <1275514176.8032.42.camel@satellite>
	<AANLkTind6KbV7bpBhG1WK716EsTVCYrjIso3nuuOuBdo@mail.gmail.com>
	<1275581413.15555.2.camel@satellite>
	<AANLkTilcRfntO-8vmOCIlFdlLSeyNxd3fJR_8RgfmWNa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f194.google.com (mail-yw0-f194.google.com
	[209.85.211.194])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DBE0103B0F
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 20:07:02 +0200 (CEST)
Received: by ywh32 with SMTP id 32so336603ywh.5
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 11:07:01 -0700 (PDT)
In-Reply-To: <AANLkTilcRfntO-8vmOCIlFdlLSeyNxd3fJR_8RgfmWNa@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-06-03 at 17:34 +0100, James Courtier-Dutton wrote:
> On 3 June 2010 17:10, John Lindgren <john.lindgren@tds.net> wrote:
> >
> > I understand that snd_pcm_delay and snd_pcm_writei currently "interfere
> > with each other" in that snd_pcm_delay returns wrong values if called
> > during snd_pcm_writei.  That is the problem my patch tries to correct.
> > Do you disagree with this improvement?  If so, why?
> 
> I disagree because I believe the changes are unnecessary.
> The alsa api is big enough already, so adding anything extra must have
> an extremely good reason for it.

I thought there was good enough reason, but I won't argue the point.

> snd_pcm_writei and snd_pcm_delay were always intended to be used in
> the same thread.
> Calling snd_pcm_writei and snd_pcm_delay at the same time is
> non-deterministic so fairly pointless to do.

All you're saying is that because it currently doesn't work, it's
pointless to make it work.

> Adding more locks just makes another hit on performances so should be avoided.
> Locks really kill performance on a multi processor SMP machine.

The locks have to be there somewhere; it's just a question of whether
that will be on the application side or the ALSA side.  We have an
interface running in one thread, and an audio decoder running in
another.  As long as output time is calculated from written time +
delay, there must be some thread interaction to ensure that those values
are in sync.

> I would argue that modifying your program to fit in the the above
> contraints is the way to go.

That will be ugly, but it seems that is what I will have to do.

John Lindgren
