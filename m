From: Alien <alien999999999@users.sourceforge.net>
Subject: Re: OSS/ALSA issue
Date: Wed, 7 Jun 2006 08:56:44 +0200
Message-ID: <200606070856.45040.alien999999999@users.sourceforge.net>
References: <200606062157.43489.alien999999999@users.sourceforge.net>
	<200606062332.55293.alien999999999@users.sourceforge.net>
	<1149630010.4072.81.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1149630010.4072.81.camel@mindpipe>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

BTW: i still have a spare au88x0 card... any devel want it?

I'd prefer it to be used to fix x86_64 issues with it.

mvg,

On Tuesday 06 June 2006 23:40, Lee Revell wrote:
> On Tue, 2006-06-06 at 23:32 +0200, Alien wrote:
> > Op dinsdag 6 juni 2006 22:37, schreef Lee Revell:
> > > On Tue, 2006-06-06 at 21:57 +0200, Alien wrote:
> > > > as a result, the sound was played, all sound looped (also flash), and
> > > > a few
> > > > hours later, my /var/log/kernel/warnings was > 600MB (kernel
> > > > warnings).
> > > >
> > > >
> > > > Now, we all know that:
> > > >
> > > > 1. ALSA has hardware mixing if the chipset/driver supports it (i know
> > > > mine does).
> > > >
> > > > 2. OSS does not do any multiple sounds
> > >
> > > It should work.  ALSA's OSS emulation supports mixing if the card has
> > > hardware mixing.  It is only in the case of software mixing that OSS
> > > emulation cannot support multiple open.
> > >
> > > Sounds like a driver bug.  What do the kernel warnings say?
> > >
> > > Lee
> >
> > forgot attachments
>
> It's a driver bug, please file a bug report if you can reproduce it with
> the latest ALSA sources from the Hg repository.
>
> Lee

-- 
Alien is my name and head-biting is my game
