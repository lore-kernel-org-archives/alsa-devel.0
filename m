From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: playing underruns
Date: Thu, 13 Feb 2003 09:35:12 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18jKSn-0003CY-00@sc8-sf-list1.sourceforge.net>
References: <200302131410.h1DEAgW05232@fafner.math.umass.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 13 Feb 2003 09:10:42 EST."
             <200302131410.h1DEAgW05232@fafner.math.umass.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Raphael <raphael@math.umass.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

trying to summarize 3-4 years of experience with this is hard. but
lets start by pointing out that its possible that your disk controller
causes the kernel to delay scheduling for up to 100msecs. i'm not sure
if RH7 fixed this by setting the driver parameters correctly - i have
heard that newer versions of RH do this. IDE/ATA drives have been
notorious under linux for ruining any soft-real-time performance. and
yes, your program may do no disk i/o, but that doesn't mean none is
going on.

you need to run hdparm to get the driver parameters, and also check if
you have a file /proc/sys/kernel/lowlatency.

--p

ps. and BTW, in my regularly scheduled plug, please, please take a
    look at jackit.sf.net for a much easier and more useful
    way to write audio apps for linux. and now, back to our
    program!
	


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
