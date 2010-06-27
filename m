From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: pcm_lib: avoid timing jitter in
 snd_pcm_read/write()
Date: Sun, 27 Jun 2010 20:01:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1006271942500.15497@eeebox2.perex-int.cz>
References: <1277590400.2438.15.camel@obelisk.thedillows.org>
	<AANLkTil91moJgRh51QFgvSFd47MzQxzxty1H2RzKK5nF@mail.gmail.com>
	<1277648967.2438.32.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BBA4243BC
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 20:01:17 +0200 (CEST)
In-Reply-To: <1277648967.2438.32.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Dillow <dave@thedillows.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, linux@schou.dk
List-Id: alsa-devel@alsa-project.org

On Sun, 27 Jun 2010, David Dillow wrote:

> On Sun, 2010-06-27 at 12:29 +0900, Jassi Brar wrote:
>> On Sun, Jun 27, 2010 at 7:13 AM, David Dillow <dave@thedillows.org> wrote:
>>> This is solved by using runtime->twake as the number of samples needed
>>> for a wakeup in addition to selecting the proper wait queue to wake in
>>> snd_pcm_update_state(). This requires twake to be non-zero when used
>>> by snd_pcm_lib_{read,write}1() even if avail_min is zero.
>>
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2010-June/028786.html
>
> Hmm, yes, I should have search the archives a bit. I originally tuned
> out the thread you listed as a request for parameter help, and missed
> your original postings.
>
> I think my patch is pretty close to preserving the existing semantics as
> it doesn't change poll() at all, but I do see a case where the user
> could get a read/write back prior to avail_min samples being ready. I
> think that's fixable -- if the user is requesting a read/write of less
> than avail_min samples, then we have to wait for avail_min regardless.
>
> Takashi, is your concern about semantics the proper honoring of
> avail_min in all cases, or preserving the current behavior of waiting
> for two periods when avail_min is set to the size of one period?

I think that the avail_min semantics is quite clear. The problem is 
caused by the hw transfer acknowledge interrupt jitter. It seems that
the only good solution is to postpone the wake_up() call to time when the 
avail_min condition becomes true - using an extra timing source (system 
timer for example).

Another possibility is to keep thing asis and keep to applications to 
handle this situation - use a different timing source than interrupts 
from soundcard for scheduling of I/O operations. But it's right that most 
of simple applications and use cases expect that I/O transfers will work 
even with 2 periods.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
