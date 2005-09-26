From: Corvus Corax <corvus-ml@cybertrench.com>
Subject: Re: changing audio routing through mixer controls	with
 emu10k1/audigy
Date: Mon, 26 Sep 2005 22:36:42 +0000
Message-ID: <20050926223642.60df06fb@VikingPC.home>
References: <20050925234658.4d008c9e@VikingPC.home>
	<1127696645.26124.4.camel@mindpipe>
	<1127696983.26124.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1127696983.26124.6.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Sun, 25 Sep 2005 21:09:42 -0400
schrieb Lee Revell <rlrevell@joe-job.com>:

> On Sun, 2005-09-25 at 21:04 -0400, Lee Revell wrote:
> > On Sun, 2005-09-25 at 23:46 +0000, Corvus Corax wrote:
> > > So my question: is a similar functionality implemented in the alsa
> > > emu10k1
> > > driver? where are the tools to load those routes using the alsa
> > > drivers?
> > > who is working on them? can I help developing them somehow? 
> > 
> > Yes, it's called ld10k1, the GUI is qlo10k1.  It's part of alsa-utils.
> > It's currently in rough shape, we could certainly use some developers.
> 
> Sorry, I mean alsa-tools, not alsa-utils.
> 
> Lee
> 

Thanks.

I tested those from 1.0.10rc1 on my system (amd64 architecture)

The tools (unlike their OSS counterparts which are segfaulting on this arch) are
compiling and working on my system, however there is either no effect on the
DSP, or garbage out of the speaker - while the front end seems to be working
( additional mixer sliders and all appear and seem to be working, however
without any effect on sound output)

Now the question, what is the current development status? are they supposed to
work correctly on sb_live hardware? if so, the problem must be architecture
related - (seems so, since the OSS drivers dont work either)

My guess on the problem of the OSS driver was some type conversions in
the kernel module going wrong - causing a different (pointer) variable in
userspace to be overwritten during an unrelated ioctl which then causes a
segfault afterwards.

However since the alsa driver works and just the backend produces garbage I dont
know exactly where to search for. Could it be that the as10k1 assemmbler
produces incorrect DSP code on amd64?

The .bin files built by the OSS as10k1 on i386 differ in a few bytes from the
one build now under x86_64 (with a as10k1 compiled for x86_64) - but then that
could be version information, too.

As I said, I would like to help development with that - is there any background
documentation on how the emu10k1 DSP is to be programmed?

regards

Corvus Corax


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
