From: Paul Davis <pbd@Op.Net>
Subject: Re: alsa ready for 24bit/192khz cards?
Date: Wed, 13 Mar 2002 23:11:44 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203140410.XAA25114@renoir.op.net>
References: <Pine.LNX.4.44.0203131911030.9435-100000@sasami.anime.net>
In-Reply-To: Your message of "Wed, 13 Mar 2002 19:13:04 PST."
             <Pine.LNX.4.44.0203131911030.9435-100000@sasami.anime.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Dan Hollis <goemon@anime.net>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Is ALSA architecture ready for 24bit/192khz cards?

I believe it is. I can't think of anywhere in ALSA that sample rate
plays a major role in limiting resources or capabilities.

OTOH, I don't know if the kernel can handle this with the smallest
periods.  64 frames/interrupt translates to an interrupt every
0.3msec. Running with HZ=1000 is reported to cause a 6% increase in
CPU load spent on the system clock interrupt. This is more than 3
times that level, with an arguably more expensive IRQ handler.

Still, for large frames/interrupt setting, it should be pretty good,
and besides, you can still choose a period setting thats the same as
current 48 or 96kHz cards can get.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
