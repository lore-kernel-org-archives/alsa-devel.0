From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: playing underruns
Date: Thu, 13 Feb 2003 14:10:54 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18jOlQ-0004jy-00@sc8-sf-list1.sourceforge.net>
References: <200302131907.h1DJ78H07915@fafner.math.umass.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 13 Feb 2003 14:07:08 EST."
             <200302131907.h1DJ78H07915@fafner.math.umass.edu>
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

>/sbin/hdparm /dev/hda2
>
>I get:
>
>/dev/hda2:
> multcount	= 16 (on)
> I/O support	= 0 (default 16-bit)
> unmaskirq	= 0 (off)
> using_dma	= 1 (on)
> keepsettings	= 0 (off)
> nowerr		= 0 (off)
> readonly	= 0 (off)
> readahead	= 8 (on)
> geometry	= 4864/255/73, sectors = 36869175, start = 4225095
>
>with similar results for the other hda's.  I don't know if this
>is the question you were asking, though, since this doesn't seem
>to have much info.  

yep, this doesn't look too good, though its not a complete
disaster. please read this:

http://linux.oreillynet.com/pub/a/linux/2000/06/29/hdparm.html

keep in mind that some distributions (RH included, i think) have fixed
this issue somewhat, though they may not have gone far enough for low
latency audio.

>I don't have the low latency patch.  

you will probably need it. the standard kernel in RH7 is not up to the
task. 

--p


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
