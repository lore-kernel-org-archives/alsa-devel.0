From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Subject: [PATCH] latencytest for PPC (and maybe others)
Date: Tue, 14 Jun 2005 11:34:36 +0100
Message-ID: <20050614103436.GA24115@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi,

It was great talking to you again during LAC'05. As we discussed I'm
resending this mail regarding a patch against latencytest.0.5.5.
Patch is at:
    http://www.mph.eclipse.co.uk/pub/linux/patches/latencytest.patch

With USE_GENERIC_TIMER selected in the makefile, this should work on
any platform. For PPC I'd recommend setting USE_PPC_VEA_TIMEBASE in the
Makefile.

Would you be willing to include this patch? I've appended my original
mail which has more code & testing results.

Thanks,
	Martin Habets

----- Forwarded message from Martin Habets <errandir_news@mph.eclipse.co.uk> -----

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
To: alsa-devel@lists.sourceforge.net
User-Agent: Mutt/1.5.6+20040907i
Subject: [Alsa-devel] [PATCH] latencytest for PPC (and maybe others)
Date: Fri, 8 Apr 2005 16:49:58 +0100

I have been able to do some latency testing on my powerbook using
2.6.11 and a number of patches:

[1] A patch for the genrtc kernel driver
    http://www.mph.eclipse.co.uk/pub/linux/patches/2.6.11/genrtc.c.patch
The ioctls added can be tested using
    http://www.mph.eclipse.co.uk/pub/linux/patches/rtctest2.c
It is important to run to this to find out the accuracy of the clock on
your platform. On PPC 1024Hz is probably the highest accurate frequency.
Any machine using genrtc should be able to use these ioctls, not just PPC.

[2] A patch against latencytest.0.5.5
    http://www.mph.eclipse.co.uk/pub/linux/patches/latencytest.patch
With USE_GENERIC_TIMER selected in the makefile, this should work on
any platform. For PPC I'd recommend setting USE_PPC_VEA_TIMEBASE in the
Makefile.
Takashi, would you be willing to include this patch?

Results: Initial testing showed serious latency from the X11 tests, but
the rest looks okay.
[3] http://www.mph.eclipse.co.uk/pub/linux/latency/test3/index.html
With a (questionable) DRM patch for the Radeon driver the results become:
[4] http://www.mph.eclipse.co.uk/pub/linux/latency/test7/index.html
Jack shows 11.6msec latency with -r44100 -p128 -n4.

I hope this will be of use to other machines using genrtc.
-- 
Martin


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

----- End forwarded message -----


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
