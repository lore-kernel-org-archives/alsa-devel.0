From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: Xrun stack trace for 1010LT
Date: Fri, 5 Dec 2008 15:17:10 +0000
Message-ID: <20081205151709.GA3160@localhost>
References: <s5hr64mitp9.wl%tiwai@suse.de>
	<21718.84876.qm@web65413.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 5467024523
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 16:04:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <21718.84876.qm@web65413.mail.ac4.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pete cat <peterpion@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 05, 2008 at 06:48:43AM -0800, Pete cat wrote:
> I understand. Im only a fairly basic C coder and such, so could you
> recommend a tool which is fairly easy to use? Or would it be better
> to revert to a non RT kernel (there did not seem to be much improvement
> when I moved to the RT kernel)?

FWIW I've never been able to run an RT-patched kernel with pcm_multi.
I've been using a non-rt preempt SMP kernel with three Delta 1010s for
about three years now without too many problems, currently with
alsa-lib-1.0.16 and 2.6.25.x kernel.

John
