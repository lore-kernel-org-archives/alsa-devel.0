From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: PCM hw mixing with volume
Date: Mon, 08 Mar 2004 11:20:16 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403081620.i28GKH2M004996@dhin.linuxaudiosystems.com>
References: <1078671074.18057.17.camel@renegade>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Sun, 07 Mar 2004 15:51:14 +0100."
             <1078671074.18057.17.camel@renegade>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ove Kaaven <ovek@transgaming.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Are you planning to standardize such features or design a
>device-independent API for it? (And my manager wants to know which ALSA
>release this might get implemented in...)

Just a thought on your overall issues with ALSA over the last week.

The kinds of features you seem to expect from hardware didn't exist in
most devices 2 years ago. Its likely that features currently
considered "experimental" in hardware right now (matrix mixing springs
to mind) will become more common 2 years from now.

Does your manager think it wise to be writing software that is so tied
into a particular model of what audio interfaces can do that it will
be obsolete by the time processors run about 4 times as fast as they
do now?

People wrote game engines that did all this "multistream+backfill"
stuff years before any cards provided hardware mixing, and they did
most of it in software on CPU's that were 10-40 times slower than
todays leading edge game-friendly processors. You are going to burn a
lot of time trying to find common ways to access the slightly
different functionality provided by *some* audio interfaces that
pertains to multistreaming, and then find that you've still left a lot
of users in the dark. The number of cycles you will lose by doing this
in software rather than trying to abstract the h/w capability will
probably be available to your users for no extra cost by the end of
your work.

Just my $0.01 ...

--p



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
