From: Ove Kaaven <ovek@transgaming.com>
Subject: Re: the emu10k1 midi bug
Date: Mon, 15 Mar 2004 16:45:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1079365534.18057.748.camel@renegade>
References: <Pine.HPX.4.33n.0403151012380.20241-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0403151012380.20241-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

man, 15.03.2004 kl. 10.14 skrev Clemens Ladisch:
> Ove Kaaven wrote:
> > - wavetable drops notes sometimes. (a good test example wanted.)
> >
> > I've encountered this randomly sometimes, but I think I also have an
> > example of the opposite - a note that is never turned off - that
> > manifests every single time for me. So I'm wondering if anyone else can
> > reproduce.
> >
> > 1. Install MusE 0.6.3. (pmidi or aplaymidi does not exhibit the problem,
> > but MusE does;
> 
> If it doesn't happen with aplaymidi, it's probably not an emu10k1 bug.

I thought perhaps if MusE queued the events differently than aplaymidi
did, and that different method made a difference... but OK. I could file
a bug on MusE instead.

> Did you try playmidi?

playmidi stops playing too soon to really hear if there's any note
incorrectly left on.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
