From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Monotonic timestamps
Date: Thu, 10 Apr 2008 09:48:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804100929390.13990@tm8103.perex-int.cz>
References: <20080409213602.GA2589@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 533EC10381F
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Apr 2008 09:48:20 +0200 (CEST)
In-Reply-To: <20080409213602.GA2589@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 9 Apr 2008, Lennart Poettering wrote:

> Hey!

Hi,

> The problem with this is that there seems to be no way to determine
> from an application if monotonic timestamps are enabled in an
> snd_pcm_t or not, ALSA just switches over to them, making the
> timestamps relatively useless, because we cannot reliable relate them
> to timestamps we query from the kernel ourselves -- because we just
> don't know if we need to use CLOCK_MONOTONIC or CLOCK_REALTIME.

Application can just do a simple comparsion between ALSA timestamp and 
gettimeofday() output. The gettimeofday() returns value since the Epoch, 
but CLOCK_MONOTONIC returns time since start of system. Thus, it's really 
easy to see if time matches or not (difference will be very big) to 
detect the time source. Value from gettimeofday() does not make much sense 
in audio (real time) environment.

> I find it very strange that ALSA just switches to monotonic timestamps
> just like that, anyway. Programs written for wallclack timestamps will
> break if they run on a system where ALSA uses monotonic timestamps!

It's true, but so far - I don't know about any program using timestamps in 
serious way. Also, timestamps from gettimeofday() are not reliable (for 
example when NTP time synchronization is used in system).

> Could anybody please explain the difference between status->tstamp and
> status->trigger_tstamp for me, please? The doxygen docs are bit too
> terse on this, I fear.

I added just these words to trigger tstamp:

+ * Trigger means a PCM state transition (from stopped to running or
+ * versa vice). It applies also to pause and suspend. In other words,
+ * timestamp contains time when stream started or when it was stopped.

The "now" tstamp is obvious, or not? It's just timestamp related to 
current stream position reported in other ALSA functions.

> Oh, and the code I pasted above will not compile if the #ifdef check
> fails, because of the "else". The "else" should be moved inside of
> #ifddef block.

Thanks. Fixed in our repo.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
