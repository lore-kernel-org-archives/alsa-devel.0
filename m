From: Vladimir Dergachev <volodya@mindspring.com>
Subject: Re: [GATOS]AVView recording sound error
Date: Sun, 29 Sep 2002 12:40:41 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209291233100.19600-100000@node2.localnet.net>
References: <m2heg9nhsl.fsf@p4.localdomain>
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m2heg9nhsl.fsf@p4.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Peter Osterlund <petero2@telia.com>
Cc: Sean Walker <lists@surfmy.net>, gatos-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



On 29 Sep 2002, Peter Osterlund wrote:

> Vladimir Dergachev <volodya@mindspring.com> writes:
>
> > On 7 Jul 2002, Sean Walker wrote:
> >
> > > If I try and record with an alsa device selected, I get the following
> > > error:
> > >
> > > Audio reader: overrun occurred, resetting pcm device
> > >
> > > repeated multiple times until I stop recording. The sound system is
> > > working just fine except for this.
> >
> > Try reducing the sample rate, maybe your card cannot handle it.
>
> I have the same problem with a 2.2GHz P4 as soon as I use the computer
> for anything else during recording. It turns out to be caused by the
> ALSA stop_threshold defaulting to 768, which corresponds to 16ms at a
> 48kHz sampling rate. 16ms is much smaller than the linux scheduler can
> handle, unless you use realtime priority and low-latency patches.
> Increasing this threshold to something bigger fixed the problem for
> me. 8192 was enough on my system but I don't think a big value will
> cause any harm, so I suggest using 32768.

Interestingly enough I don't have any problems and my card's default is
16384. I would say this is probably a bug in the alsa driver - it should
set a reasonable default without requiring adjustments by a program that
simply reads data.

Or, maybe, I did not read some paragraph in ALSA docs.

Could ALSA folks comment ?

>
> Here is a patch I used while experimenting with this. (It obviously
> needs cleaning up before being applied.)
>

Thanks ! - merged.

                    best

                      Vladimir Dergachev




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
