From: Ove Kaaven <ovek@transgaming.com>
Subject: Re: PCM hw mixing with volume
Date: Mon, 08 Mar 2004 22:29:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078781348.18057.85.camel@renegade>
References: <200403081620.i28GKH2M004996@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200403081620.i28GKH2M004996@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

man, 08.03.2004 kl. 17.20 skrev Paul Davis:
> The kinds of features you seem to expect from hardware didn't exist in
> most devices 2 years ago. Its likely that features currently
> considered "experimental" in hardware right now (matrix mixing springs
> to mind) will become more common 2 years from now.

Sounds interesting.

> Does your manager think it wise to be writing software that is so tied
> into a particular model of what audio interfaces can do that it will
> be obsolete by the time processors run about 4 times as fast as they
> do now?

To the extent your assumptions are true: Yes. It's even pretty nearly a
part of the job description.

> People wrote game engines that did all this "multistream+backfill"
> stuff years before any cards provided hardware mixing, and they did
> most of it in software on CPU's that were 10-40 times slower than
> todays leading edge game-friendly processors. You are going to burn a
> lot of time trying to find common ways to access the slightly
> different functionality provided by *some* audio interfaces that
> pertains to multistreaming, and then find that you've still left a lot
> of users in the dark. The number of cycles you will lose by doing this
> in software rather than trying to abstract the h/w capability will
> probably be available to your users for no extra cost by the end of
> your work.

And by that time, games will be even more demanding than before, and
still want to use those cycles for itself rather than software sound
processing, so just sitting idle waiting for the ultimate
infinite-megahertz cpu, that can do everything in no time, gains nobody
anything... at least our business won't.

Nobody is asking you to like that, we don't even ask people to like us
or our business (generally the most we ask is to dislike it for the
right reasons), but working on more or less suboptimal designs is part
of the job, and no amount of argumentation is going to change that. Yes,
we try to avoid bad designs whenever we can, but that's often not
possible.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
