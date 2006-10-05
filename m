From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Prolem with ALC260 soundcard
Date: Thu, 5 Oct 2006 11:32:27 +0930 (CST)
Message-ID: <200610050202.k9522Rtk022057@turbo.physics.adelaide.edu.au>
References: <mailman.51025.1159971494.16222.alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <mailman.51025.1159971494.16222.alsa-devel@lists.sourceforge.net>
	from "alsa-devel-request@lists.sourceforge.net" at Oct 04,
	2006 07:18:14 AM
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: rlrevell@joe-job.com, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

> I have experienced the same troubles since I bought my Packard Bell
> V7900 laptop.
> Not much developement is going for ALC260 ...

Well, that's not entirely accurate.  It is fair to say that development
occurs on an as-needs basis and as time allows.  No one's paying me to work
on ALSA so there's a day job and other issues to work around. :-)

> ... but they fixed this problem for other realtek
> chipsets and I'm confident they will do for this one too.

We'll get there.

Lee wrote: 

> Did you report what controls you needed to enable to get sound in test
> mode?

Initial details were posted to the list on 25 Sept 2006 by Andrea (subject
was "Re: : [Alsa-devel] ALC260 (Re:  ALSA 1.0.13rc2 release)"). 

Unfortunately I've been snowed under with work, family and other issues for
the past 3 or so weeks and have been able to get to this plus a number of
other things on my ALC260 "todo" list.  I'm hoping to get to them soon but
it depends on how a number of things pan out over the next couple of weeks.

For reference this is what was communicated.  When running with the test
mode:

  "The only way I could get sound to work (at a normal volume) was with
   headphones (connected to the line in plug) and setting "LINE1 pin mode"
   to "Line out".  Only that option is needed to be set, any other value in
   the fields doesn't change anything and neither do switches."

This tends to suggest that on this laptop the "Line in" plug on the laptop
is connected to the "LINE1" node on the ALC260.  As to what other plugs are
on this laptop and how they might be connected to ALC260 pin complexes, I
haven't had a chance to follow up yet.  It's odd that it was not possible to
get sound out of other plugs but that could be the result of the
interdependency of many of the controls in the test model - it's easy to
miss the particular combination which makes a plug start working.

Regards
  jonathan


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
