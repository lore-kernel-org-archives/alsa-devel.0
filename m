From: Chris Raphael <raphael@math.umass.edu>
Subject: Re: playing underruns
Date: Thu, 13 Feb 2003 15:13:07 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302132013.h1DKD7n08538@fafner.math.umass.edu>
References: <200302131911.h1DJBBn08117@thales.math.umass.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200302131911.h1DJBBn08117@thales.math.umass.edu> (message from
	Paul Davis on Thu, 13 Feb 2003 14:10:54 -0500)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: paul@linuxaudiosystems.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Paul,  Okay I looked at the page you pointed me to with info about
hdparm.  before I changed any of the controller settings I 
got 21.12 MB/sec for "Timing buffered disk reads" which seems to be 
pretty good according to the
author of the web page.  After changing the settings (I/O support
32 bit, unmaskirq = on, transfer mode to UltraDMA) no change.
I think my program is not adversely affected by any disk access
since I always check to see  when my program's callbacks are
actually delivered.  They seem to be accurate enough and almost
never more that .02 secs later than requested.  My sense is that
I am writing my samples on time (as far as I can measure) and the
problem happens somewhere in the chain of events *after*
my program writes audio samples.  Do you think the lowlatency patch
might help there?  Or any other ideas?

Chris



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
