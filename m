From: David Dillow <dave@thedillows.org>
Subject: Re: [PATCH] ALSA: pcm_lib: avoid timing jitter in
 snd_pcm_read/write()
Date: Sun, 27 Jun 2010 18:46:13 -0400
Message-ID: <1277678773.2438.103.camel@obelisk.thedillows.org>
References: <1277590400.2438.15.camel@obelisk.thedillows.org>
	<AANLkTil91moJgRh51QFgvSFd47MzQxzxty1H2RzKK5nF@mail.gmail.com>
	<1277648967.2438.32.camel@obelisk.thedillows.org>
	<alpine.LNX.2.00.1006271942500.15497@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from amavis-smtp.knology.net (amavis-smtp.knology.net [75.76.199.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CB8D24542
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 00:46:28 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1006271942500.15497@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, linux@schou.dk
List-Id: alsa-devel@alsa-project.org

On Sun, 2010-06-27 at 20:01 +0200, Jaroslav Kysela wrote:
> On Sun, 27 Jun 2010, David Dillow wrote:
> 
> > On Sun, 2010-06-27 at 12:29 +0900, Jassi Brar wrote:
> >> On Sun, Jun 27, 2010 at 7:13 AM, David Dillow <dave@thedillows.org> wrote:
> >>> This is solved by using runtime->twake as the number of samples needed
> >>> for a wakeup in addition to selecting the proper wait queue to wake in
> >>> snd_pcm_update_state(). This requires twake to be non-zero when used
> >>> by snd_pcm_lib_{read,write}1() even if avail_min is zero.
> >>
> >> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-June/028786.html
> >
> > Hmm, yes, I should have search the archives a bit. I originally tuned
> > out the thread you listed as a request for parameter help, and missed
> > your original postings.
> >
> > I think my patch is pretty close to preserving the existing semantics as
> > it doesn't change poll() at all, but I do see a case where the user
> > could get a read/write back prior to avail_min samples being ready. I
> > think that's fixable -- if the user is requesting a read/write of less
> > than avail_min samples, then we have to wait for avail_min regardless.
> >
> > Takashi, is your concern about semantics the proper honoring of
> > avail_min in all cases, or preserving the current behavior of waiting
> > for two periods when avail_min is set to the size of one period?
> 
> I think that the avail_min semantics is quite clear. The problem is 
> caused by the hw transfer acknowledge interrupt jitter. It seems that
> the only good solution is to postpone the wake_up() call to time when the 
> avail_min condition becomes true - using an extra timing source (system 
> timer for example).

I think the avail_min is quite clear for poll() usage -- in that case,
we get the expected behavior for wake ups. I believe the semantics are
currently less well defined for read/write --  is the guarantee that at
the end of the write call, there will be room for avail_min samples in
the buffer, or is it guaranteed that there will be space for 
(avail_min - (size % avail_min)) samples, where size is the number of
samples in the read/write call?

The current code gives no guarantee either way if the size of the call
fits in the buffer. And there are cases where it doesn't give a
guarantee that another write of avail_min will fit.

The only documentation a quick Google search turns up is the ALSA HOWTO,
which only discusses poll().

> Another possibility is to keep thing asis and keep to applications to 
> handle this situation - use a different timing source than interrupts 
> from soundcard for scheduling of I/O operations. But it's right that most 
> of simple applications and use cases expect that I/O transfers will work 
> even with 2 periods.

Indeed, that is how I noticed this issue -- capture running with 2
periods was causing unexpected overruns. As a user, I expected a read of
avail_min (== period_size) samples to return when the period was up, not
after a second period had elapsed.

Things can be easily changed so that case works as expected, the hard
part is clarifying/defining the semantics for other cases, and ensuring
those guarantees are met.

Perhaps documentation that recommends setting avail_min to 1 when using
read/write to avoid this issue would be helpful, in lieu of changing the
ALSA code or giving concrete guarantees.

Dave
