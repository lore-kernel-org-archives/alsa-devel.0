From: Paul Davis <pbd@op.net>
Subject: Re: documentation
Date: Fri, 03 May 2002 12:22:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205031622.g43GLxD10522@post2.fast.net>
References: <20020503161133.96309.qmail@web11507.mail.yahoo.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA02046
	for <alsa-devel@alsa-project.org>; Fri, 3 May 2002 18:22:06 +0200
In-Reply-To: Your message of "Fri, 03 May 2002 09:11:33 PDT."
             <20020503161133.96309.qmail@web11507.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guilhem Tardy <guilhem_tardy@yahoo.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

>Hi,
>
>Now, I have this new driver which manages to open/close a pcm channel whenever
>one attempts to play a file with "play test.au", but complains (Sound protocol
>it not compatible) with "aplay test.au". Any idea what's wrong?
>Besides, I have no mixer defined (I would just to allow open/close a playback
>or capture channel, no more) and wonder if it is a problem?
>I am just loading the driver manually for now (insmod snd, snd-timer, snd-pcm,
>...), is there any special configuration I need? How to tell the driver to
>unmute?

sounds as if you have the wrong version of aplay installed (relative
to the version of alsa-lib and alsa-driver)

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
