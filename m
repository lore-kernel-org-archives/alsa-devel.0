From: Paul Davis <pbd@op.net>
Subject: Re: Timer?
Date: Wed, 06 Mar 2002 12:51:11 -0500
Message-ID: <200203061754.MAA01756@renoir.op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA20246
	for <alsa-devel@alsa-project.org>; Wed, 6 Mar 2002 18:54:36 +0100
In-reply-to: Your message of "Wed, 06 Mar 2002 17:39:55 GMT."
             <NGBBLNODKDFPBFMBBFAFCEBKCDAA.James@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Ulrich Zadow <ulrich.zadow@ARTCOM.DE>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Our app does not use poll or anything like it. It does not get woken up by
>the audio device.

actually it does. but not woken up from poll, just from snd_pcm_write.

>Look at our source code.

i did. i downloaded xine a few weeks ago.

xine won't work the way a user expects if anyone tried to get it to
inter-operate *in sync* with another application.

computing an application-determined-sized chunk of data and delivering
it to the audio interface is a sure fire way to destroy sync as well
as responsiveness to user controls. not that your code is alone in
doing so, of course - its been the way Unix audio apps have been
written for years.

the audio interface is the only thing that knows how much data you
should be generating at any one time. the only case in which you can
get ahead of the interface (i.e. rely on the driver to buffer) without
any effects is when there are no real-time controls that might affect
the data (aplay would be an example of such a program).

xine has a volume control, at the very least. i haven't studied the
source code enough to see if there are other examples of things that
make this kind of "pre-generation" questionable.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
