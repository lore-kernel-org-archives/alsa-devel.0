From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: 0.9.1 release
Date: Tue, 11 Mar 2003 17:33:20 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303112230.XAA24419@alsa.alsa-project.org>
References: <Pine.LNX.4.44.0303112255040.6200-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail09.voicenet.com (mail09.voicenet.com [207.103.0.43])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id XAA24419
	for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2003 23:30:06 +0100
In-reply-to: Your message of "Tue, 11 Mar 2003 23:03:37 +0100."
             <Pine.LNX.4.44.0303112255040.6200-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA Announce <alsa-announce@alsa-project.org>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>	What's left for 1.0: The sequencer instrument layer will be moved 
>completely to the user space. 

how about moving the entire sequencer into user-space? kernel 2.5
(with POSIX clock support) makes this entirely viable, i think. 

the only ugliness i can see is that inter-thread communication is
harder to make totally robust in the face of system/process shutdown
than user<->kernel communication (c.f. JACK).

there is other stuff that needs to be done for 1.0, not necessarily
development. we need GUI tools for many common user operations. we
need *much* better documentation than we have now. i also think that
the firmware-loading-from-file needs to be done too, and we might need
to make more use of tasklets.

--p




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
