From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: possible problems with rc6 aplay
Date: Mon, 16 Dec 2002 09:51:34 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18NwXQ-0006X0-00@sc8-sf-list1.sourceforge.net>
References: <20021216143611.GN773@tuba.home>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 16 Dec 2002 15:36:11 +0100."
             <20021216143611.GN773@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: martin-langer@gmx.de
Cc: Mark Knecht <markknecht@attbi.com>, alsa-devel@lists.sourceforge.net, swpatrick@earthlink.net, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

>IMHO this is a design bug of all rme cards. The documents about rme32 and
>rme96 where identical in this point. They were talking about one master-mode
>and nothing about the frequency. I don't know anything about rme9652 or
>hdsp, but the sourcecode looks not very different to the older rme96.
>
>But if you read the datasheet from prodif24 (not supported by alsa) you have
>a switch with one slave position and three frequency positions. After

the problem here is not setting the card to master mode and not having
a defined frequency - this doesn't happen because there is a defined
default rate (just not well documented). the problem is setting the
rate and it appearing to succeed, even though in fact it has made no
difference to the operation of the card because its slaved to some
external clock.

>Alsa has copied here the documented rme way, but this seems to be wrong for
>me. I have just checked the behaviour of rme32, but I'm very sure that the
>bigger ones are working in the same style.

well, they have a more complex setup:

      * clock mode: AutoSync, Master or Word Clock
      * preferred source for autosync: ADAT1/2/3 or S/PDIF
      * S/PDIF sample rate
      * ADAT sample rate
      * system sample rate (the one the master clock runs at)

so its really not possible to define "the rate" in a straightforward
way. but i see your point.

--p



-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
