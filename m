From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: [GATOS]AVView recording sound error
Date: Sun, 29 Sep 2002 19:09:43 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209291907360.591-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0209291233100.19600-100000@node2.localnet.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0209291233100.19600-100000@node2.localnet.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Vladimir Dergachev <volodya@mindspring.com>
Cc: Peter Osterlund <petero2@telia.com>, Sean Walker <lists@surfmy.net>, "gatos-devel@lists.sourceforge.net" <gatos-devel@lists.sourceforge.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 29 Sep 2002, Vladimir Dergachev wrote:

> 
> 
> On 29 Sep 2002, Peter Osterlund wrote:
> 
> > Vladimir Dergachev <volodya@mindspring.com> writes:
> >
> > > On 7 Jul 2002, Sean Walker wrote:
> > >
> > > > If I try and record with an alsa device selected, I get the following
> > > > error:
> > > >
> > > > Audio reader: overrun occurred, resetting pcm device
> > > >
> > > > repeated multiple times until I stop recording. The sound system is
> > > > working just fine except for this.
> > >
> > > Try reducing the sample rate, maybe your card cannot handle it.
> >
> > I have the same problem with a 2.2GHz P4 as soon as I use the computer
> > for anything else during recording. It turns out to be caused by the
> > ALSA stop_threshold defaulting to 768, which corresponds to 16ms at a
> > 48kHz sampling rate. 16ms is much smaller than the linux scheduler can
> > handle, unless you use realtime priority and low-latency patches.
> > Increasing this threshold to something bigger fixed the problem for
> > me. 8192 was enough on my system but I don't think a big value will
> > cause any harm, so I suggest using 32768.
> 
> Interestingly enough I don't have any problems and my card's default is
> 16384. I would say this is probably a bug in the alsa driver - it should
> set a reasonable default without requiring adjustments by a program that
> simply reads data.
> 
> Or, maybe, I did not read some paragraph in ALSA docs.
> 
> Could ALSA folks comment ?

The default stop_threshold should be equal to buffer size. It appears to
a bug. Hardware?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
