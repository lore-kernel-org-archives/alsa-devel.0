From: Paul Davis <pbd@op.net>
Subject: Re: Async Transfer Method
Date: Fri, 26 Jul 2002 10:14:52 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207261411.QAA26684@alsa.alsa-project.org>
References: <3D4151DA.56765B56@t-online.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA26684
	for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2002 16:11:29 +0200
In-Reply-To: Your message of "Fri, 26 Jul 2002 15:42:51 +0200."
             <3D4151DA.56765B56@t-online.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: FAU <Frank.Uepping@t-online.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>I try to do IO with the async transfer method, but I don't get it work.
>As artwork I use the pcm example, but it doesn't work too (pcm -m async).
>Apparently the callback gets not called.
>Is there a bug concerning this?

i hope you have a good reason for using the async method, along with a
very rigorous design for doing so. if you search the archives for this
list, you will find a debate in which i point out that its
fundamentally unsafe to use because of POSIX "async" specifications.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
