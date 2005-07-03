From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Subject: spdif setup
Date: Sun, 3 Jul 2005 14:32:54 +0000 (UTC)
Message-ID: <Pine.LNX.4.56.0507111229490.12873@www.ithos.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Date: Mon, 11 Jul 2005 12:45:40 +0200 (CEST)
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

Use case for the average user:
* have a cool new soundcard and the box says "HOT NEW SPDIF AC3!!11" [*]
* start Totem
* don't get AC-3 passthrough

How to fix this? I've just gone through the horror and joy that is free
software documentation. The best I can find is cool sample code in xine,
videolan and mplayer, who all set manual device entries with something
called AES0, AES1 and S16LE as audio format to get AC-3 passthrough to
work. Regardless of the fact that I cannot get any of this to work in the
first place (FC4 default install on x86-64; alsa 1.0.9 and latest cvs of
gstreamer), I'd like to make a more important point:

YOU GOTTA BE KIDDING ME!

I don't care much for the fact that the app needs some work to get this to
work, but I need to special case every possible format and add weird code
(what are those hex numbers anyway?) that assumes 16-bit integer to get
AC-3 working. Is that the new great ALSA? Please... Users have to set
weird-ass paranoia commandline options in each app out there (mplayer) or
edit through tons of xine config files to get this setup, with the end
result most likely being that it crashes. This just can't be it.

So, of course I'm just hoping that I'm completely wrong. I know that most
ALSA developers are really intelligent people and they, just like me, are
out there to make the Linux desktop experience happen. So I must've
misunderstood the whole thing. So, how *is* this supposed to work? What is
the theory and where are code examples to get AC-3 passthrough to work and
what is the suggested method for applications to make this transparent to
their user? I'd like to make any change needed to Totem and gstreamer for
this to be 100% transparent, but I'm just totally lost.

Cheers,
Ronald

[*] actually, the box mumbles some marketing stuff about dolby digital and
dts support, but same thing.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
