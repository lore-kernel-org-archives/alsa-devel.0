From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: If /dev/snd/controlCx EACCES vs. ENODEV mixup
Date: Sun, 25 Nov 2007 23:10:32 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0711252304070.7688@tm8103.perex-int.cz>
References: <20071125210359.GB17108@tango.0pointer.de>
	<Pine.LNX.4.61.0711252240140.7688@tm8103.perex-int.cz>
	<20071125215300.GA22640@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BBAFF2461E
	for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2007 23:10:33 +0100 (CET)
In-Reply-To: <20071125215300.GA22640@tango.0pointer.de>
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

On Sun, 25 Nov 2007, Lennart Poettering wrote:

> On Sun, 25.11.07 22:42, Jaroslav Kysela (perex@perex.cz) wrote:
> 
> > 
> > On Sun, 25 Nov 2007, Lennart Poettering wrote:
> > 
> > > BTW, what's the status of the BTS? Takashi asked me to post all my
> > > issues on the ML instead of on the BTS. So why have the BTS at all?
> > > It's even linked on the alsa-project.org front page under "I found a
> > > bug!", which is a bit misleading. If this Mantis thing is not liked at
> > > all, would it be possible to make some replacement available? Maybe
> > > just use the kernel bugzilla on bugzilla.kernel.org? It's very fast,
> > > and certainly more fun to work with than with Mantis.
> > 
> > I prefer BTS but Takashi not. It's matter of personal preference. Mantis 
> > is easy maintainable and we have more projects (or packages) not only 
> > drivers.
> 
> The kernel bugzilla already is used for stuff like klibc and other
> userspace support code for the kernel. I am sure noone would oppose to
> move the complete bug tracking of ALSA to the kernel bz.

But why to change to bugzilla? The basic functions of both BTSes are very 
similar (except the fact I don't like perl at all). Actually, ALSA 
services (server) run on a dedicated virtual XEN machine, so we can 
install any software we need.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project
