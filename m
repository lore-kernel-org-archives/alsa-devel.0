From: Paul Davis <pbd@op.net>
Subject: Re: another control API issue
Date: Wed, 08 May 2002 10:06:26 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205081405.QAA07521@alsa.alsa-project.org>
References: <3CD92F89.4D5711B9@alsa-project.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA07521
	for <alsa-devel@alsa-project.org>; Wed, 8 May 2002 16:05:50 +0200
In-Reply-To: Your message of "Wed, 08 May 2002 16:00:41 +0200."
             <3CD92F89.4D5711B9@alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

>> Sound right?
>
>Not fully. You can use FPU in kernel space with some attention (disable
>preemption and save/restore FPU state for critical area).

Sure, you can do this, but if anyone from lkml gets a look at it, it
won't last very long :)

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
