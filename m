From: Paul Davis <pbd@op.net>
Subject: Re: Timer?
Date: Wed, 06 Mar 2002 11:28:21 -0500
Message-ID: <200203061631.LAA17147@renoir.op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA18839
	for <alsa-devel@alsa-project.org>; Wed, 6 Mar 2002 17:31:38 +0100
In-reply-to: Your message of "Wed, 06 Mar 2002 17:22:37 +0100."
             <C1E3CFAE25BBCB45AAB06733BDC048DF13FA8F@tempo.INTERN.ARTCOM.DE>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ulrich Zadow <ulrich.zadow@ARTCOM.DE>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Is there any documentation on the timer api that goes beyond what's on the als
>a-project pages? We're trying to sync Video and Audio, and all we need is a wa
>y to query the current time relative to some arbitrary start point.

i don't believe that the timer API has much to do with this. its more
a way of getting a trigger from a timer, not of reading time per se.

to sync audio + video you have to keep track of the number of frames
you've delivered to both streams. the audio stream is giving you
exactly the same timing info (albeit implicitly) as it would do if you
used as a timer.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
