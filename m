From: Chris Raphael <raphael@math.umass.edu>
Subject: Re: playing underruns
Date: Thu, 13 Feb 2003 09:10:42 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302131410.h1DEAgW05232@fafner.math.umass.edu>
References: <200302122330.h1CNUMn05990@thales.math.umass.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200302122330.h1CNUMn05990@thales.math.umass.edu> (message from
	Paul Davis on Wed, 12 Feb 2003 18:34:46 -0500)
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


Thanks for responding Paul.

I'm using Red Hat 7.2 which is the 2.4 kernel and the 0.9.0rc7 ALSA driver.

I'm not sure why you want to know about the disk controller since there
is no disk access in the real-time part of my application.  But I am using
a Dell Inspiron 8200 and I looked on the web at the spec sheet which describes
the disk as "Ultra ATA."  They didn't have any info about controllers unless
ATA is some kind of controller.  

I think I have heard about the "low latency"
patch.  My understanding about that is that it is for more precise delivery
of signals.  That is, more precise than the .01 secs promised and usually
delivered by Linux.   With the current signal delivery my sound samples still
get written well before they should be played.  I am writing samples .05 secs
before they time they should actually move the speaker while my signals are
only rarely any later than .02 secs after the time requested.  
Of course, I have no idea what must happen
between the time I write the samples and when they actually are turned into sound.

Chris


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
