From: Paul Davis <pbd@op.net>
Subject: Re: patches for rme9652
Date: Thu, 09 May 2002 09:12:59 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205091311.g49DBw928844@post2.fast.net>
References: <Pine.LNX.4.33.0205090849560.544-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA26485
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 15:12:07 +0200
In-Reply-To: Your message of "Thu, 09 May 2002 08:54:33 +0200."
             <Pine.LNX.4.33.0205090849560.544-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

[ changing between single and double speed modes on a hammerfall ]

>Note: We have hw_free callback for PCM resources which should clear all 
>used resources. After this point, driver should allow to change ANY
>parameters.

that doesn't solve the problem - there aren't any resources allocated
that are channel count/location dependent. the reason for the
restriction was that user space may have cached channel counts and
worse still channel addresses. it may attempt to use these again after
changing the rate to a value that invalidates these cached values.

however, after some reflection it seems to me that user space probably
can't do any damage by using these cached values. they don't actually
give user space access to any invalid memory or data structures, its
just that the data they access may not refer to what the application
thinks is actually there. 

i think that its ok to simply remove this restriction, after another
careful reading of the code. at the same time, we need to somehow
document that changing the rate in this way has serious implications
for the application.

takashi: when do you think we might see progress on a card info database?

>> please let me know when this is applied to CVS.
>
>Applied (the later one).

thanks.

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
