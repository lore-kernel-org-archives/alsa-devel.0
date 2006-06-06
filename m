From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: OSS/ALSA issue
Date: Tue, 06 Jun 2006 17:40:10 -0400
Message-ID: <1149630010.4072.81.camel@mindpipe>
References: <200606062157.43489.alien999999999@users.sourceforge.net>
	<1149626271.4072.60.camel@mindpipe>
	<200606062332.55293.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200606062332.55293.alien999999999@users.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alien <alien999999999@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-06-06 at 23:32 +0200, Alien wrote:
> Op dinsdag 6 juni 2006 22:37, schreef Lee Revell:
> > On Tue, 2006-06-06 at 21:57 +0200, Alien wrote:
> > > as a result, the sound was played, all sound looped (also flash), and
> > > a few
> > > hours later, my /var/log/kernel/warnings was > 600MB (kernel
> > > warnings).
> > >
> > >
> > > Now, we all know that:
> > >
> > > 1. ALSA has hardware mixing if the chipset/driver supports it (i know
> > > mine does).
> > >
> > > 2. OSS does not do any multiple sounds
> >
> > It should work.  ALSA's OSS emulation supports mixing if the card has
> > hardware mixing.  It is only in the case of software mixing that OSS
> > emulation cannot support multiple open.
> >
> > Sounds like a driver bug.  What do the kernel warnings say?
> >
> > Lee
> 
> forgot attachments

It's a driver bug, please file a bug report if you can reproduce it with
the latest ALSA sources from the Hg repository.

Lee
