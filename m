From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: Digital sound card conventions
Date: Fri, 03 Jan 2003 16:47:02 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301032139.WAA08066@alsa.alsa-project.org>
References: <Pine.LNX.4.33.0301032118550.500-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id WAA08066
	for <alsa-devel@alsa-project.org>; Fri, 3 Jan 2003 22:39:42 +0100
In-reply-to: Your message of "Fri, 03 Jan 2003 21:33:40 +0100."
             <Pine.LNX.4.33.0301032118550.500-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Anders Torger <torger@ludd.luth.se>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
>This part of PCM API has not been discussed. I think that we should follow
>the most easy way: It is - allow only sample rate given by application, if
>the master clock is using another sample rate - in trigger() callback -
>driver will fail. 

this seems wrong to me. what should fail is an attempt to set the
sample rate unless the hardware is its own clock Master. if no attempt
is made to set it, then the application gets whatever the hardware is
running at, whether that is externally controlled or some h/w specific
default. 

>		   Also it will fail, when sample rate is changed during
>operation. 

the hammerfall driver used to contain stubs for doing this. every
read/write operation would check that the (possibly externally
controlled) SR was the same as "last time". i never did any more on this.

>	    We probably need to add a new PCM state -
>SNDRV_PCM_STATE_STREAM_CHANGED (equal to DRAINING, but informative for
>applications). The notification of master clock / sample rate (or other
>parameter) changes should be implemented using the control API.

and already is for some cards (and some parameters).

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
