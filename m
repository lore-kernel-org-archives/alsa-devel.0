From: John Lindgren <john.lindgren@tds.net>
Subject: Re: [PATCH] alsa-lib: snd_pcm_delay and friends do not
 account for a write being currently in progress
Date: Thu, 03 Jun 2010 12:10:13 -0400
Message-ID: <1275581413.15555.2.camel@satellite>
References: <1275514176.8032.42.camel@satellite>
	<AANLkTind6KbV7bpBhG1WK716EsTVCYrjIso3nuuOuBdo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5711B24133
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 18:10:27 +0200 (CEST)
Received: by gwj15 with SMTP id 15so194895gwj.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 09:10:25 -0700 (PDT)
In-Reply-To: <AANLkTind6KbV7bpBhG1WK716EsTVCYrjIso3nuuOuBdo@mail.gmail.com>
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

On Thu, 2010-06-03 at 15:40 +0100, James Courtier-Dutton wrote:
> On 2 June 2010 22:29, John Lindgren <john.lindgren@tds.net> wrote:
> > Hi,
> >
> > In a multi-threaded application it is possible for snd_pcm_delay or an
> > equivalent function to be called by one thread while another is sitting
> > in snd_pcm_writei.  In this case, snd_pcm_delay does not take into
> > account that there may not be enough space for all the data passed to
> > snd_pcm_writei to be written to the ring buffer at once, and will return
> > incorrect values.
> 
> I believe the definition of snd_pcm_delay() is it returns a value that
> would be fairly accurate at this instance of time. If you followed the
> snd_pcm_delay() with a snd_pcm_writei(), the samples would reach the
> speaker "delay" time later.
> 
> I think it would be fair to say that the value of snd_pcm_delay() is
> undefined if called during a snd_pcm_writei() call, because you will
> get a return value from snd_pcm_delay() but you will have no idea how
> many samples of the current snd_pcm_writei() have been written and
> thus no idea what the delay will be on the next snd_pcm_writei().
> 
> Even in multi-threaded applications calling two functions at the same
> time that interfere with each other it not good.
> If a function is re-entrant it is generally considered to be thread
> safe. It does not necessarily mean that it is sensible to call two
> different functions at the same time.

I understand that snd_pcm_delay and snd_pcm_writei currently "interfere
with each other" in that snd_pcm_delay returns wrong values if called
during snd_pcm_writei.  That is the problem my patch tries to correct.
Do you disagree with this improvement?  If so, why?

John Lindgren
