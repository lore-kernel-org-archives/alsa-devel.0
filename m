From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Tue, 07 Sep 2004 09:23:58 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409071323.i87DNwnn004725@localhost.localdomain>
References: <20040907103408.GB4584@sunrise.pg.gda.pl>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from out007.verizon.net (out007pub.verizon.net [206.46.170.107])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2A98A1A1
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 15:24:01 +0200 (MEST)
In-reply-to: Your message of "Tue, 07 Sep 2004 12:34:08 +0200."
             <20040907103408.GB4584@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Talking about proper using mmaped mode in games, samplers and other apps
>which can generate sound at any time (not exactly - precision is about
>1 to several app frames) which of them could you show here?
>As I know xmms mmaped mode is broken and I just don't know an app
>which uses this mode with success.
>I just need a good example.

errr, JACK? i think there are other "pro-audio" apps with ALSA
backends that use a very similar approach. JACK is full duplex, which
makes its code significantly more complex than the playback-only
engine you seem to describing.

i note, though, that JACK still does not use the ALSA provided sample
step size for interleaved access.

--p


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
