From: Paul Davis <pbd@Op.Net>
Subject: Re: latency timer
Date: Wed, 27 Feb 2002 10:13:49 -0500
Message-ID: <200202271514.KAA11954@renoir.op.net>
In-reply-to: Your message of "Wed, 27 Feb 2002 08:45:39 +0100."
             <000f01c1bf62$c598a4e0$0300a8c0@wgilmenau>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Robert Br ckmann <robert.brueckmann@stud.tu-ilmenau.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>So what do think I should use instead? I need all 48 channels in perfect
>sync (sample-accurate). Do you think that's impossible? The CPU-load of my

I think it might be very difficult if it involves two separate
cards. It would be easy on one card, for sure.

>application is (with signal processing) less than 30%, but still there are
>xruns sometimes. It might be that the pci bus can't handle my data.

unlikely. its less than 18MB/sec. the PCI bus can easily handle that.

>I wonder if I'm the first one who wants to use two hammerfalls in linux for
>recording and playback at the same time.

under linux: almost certainly.
under any OS: quite possibly.

one other question: what kind of video interface are you using and
which version of XFree86?

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
