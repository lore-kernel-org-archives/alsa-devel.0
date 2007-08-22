From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: problems writing pcm driver
Date: Tue, 21 Aug 2007 22:13:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0708212144090.30669@shell2.speakeasy.net>
References: <Pine.LNX.4.58.0708201250360.30669@shell2.speakeasy.net>
	<s5hd4xhkytk.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0708210907460.30669@shell2.speakeasy.net>
	<46CB60E0.7000805@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.sea5.speakeasy.net (mail3.sea5.speakeasy.net
	[69.17.117.5]) by alsa0.perex.cz (Postfix) with ESMTP id 1E6332437E
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 07:13:47 +0200 (CEST)
In-Reply-To: <46CB60E0.7000805@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 22 Aug 2007, Eliot Blennerhassett wrote:
> >> (snip)
> >>> exited, it's called again.  What is the purpose of this?  Is it ok that
> >>> I return the same value as the previous time it was called?
> >> The pointer callback isn't necessarily to be so accurate, but it's
> >> supposed to be fast.  Hence, yes, it's fine that you return the same
> >> value as before unless updated via IRQ if the operation takes long
> >> time.
>
> > I have the pointer callback read a hardware register to get the number of
> > frames transferred.
>
> Does this report partial periods (ie count 0,1,2,3,4 rather than 0,256, > etc).
> If so, it is better to read the register in the pointer callback.
> (unless as Takashi mentions, it is an expensive operation)

It returns the number of periods transferred.  e.g. 1 = 256 frames of data, 2
= 512 frames of data, etc.  Not high resolution.  Right now the driver only
supports periods of 1k bytes.  I could extend it to support periods that are
multiples of 1k and program the counter to keep counting 1k blocks or to count
whole periods.  I'm trying to get the simplest stuff working correctly first.

> > This means I have to use locking between the irq handler
> > and the pointer callback, which I have been able to avoid so far.
>
> ?? probably not as long as you only read the cached value from the chip
> struct once in the pointer callback.
> However you might need locking to provide exclusive access to the
> hardware if there are accesses that have to happen in sequence.

I was under the impression that one should not count on writing to an integer
on one while cpu reading from the same integer on another cpu at the same time
working correctly.  If you want to do this, you have to use atomic_t and
related functions.

I think on X86, atomic_read and atomic_set are nothing more than simple moves
with the lock prefix set.  The important part is compiler optimization
barriers.  Just because you only only read from the variable once in the C
code, does not mean the compiler will not turn it into multiple reads.
Something like:

count = chip->count;
if(count == 1) {...}
else if(count == 2) {...}

Could be turned by the compiler into:

register = &(chip->count);
if(*register == 1) { ... }
else if(*register == 2) { ... }

Just because you pulled a value out of the chip struct and put it in a local,
doesn't mean the compiler will actually emit code to do that.  If the compiler
thinks the value can't change, and it doesn't know about other threads or
interrupt handlers, it's free to remove reads or insert extra reads.
