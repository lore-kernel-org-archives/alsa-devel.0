From: Paul Davis <pbd@op.net>
Subject: Re: Timer?
Date: Wed, 06 Mar 2002 12:27:29 -0500
Message-ID: <200203061730.MAA27701@renoir.op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA19910
	for <alsa-devel@alsa-project.org>; Wed, 6 Mar 2002 18:30:47 +0100
In-reply-to: Your message of "Wed, 06 Mar 2002 17:16:14 GMT."
             <NGBBLNODKDFPBFMBBFAFKEBICDAA.James@superbug.demon.co.uk>
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

>The delay value is calculated from getting the amount of samples still in
>the sound buffer.
>See the "ao_alsa_delay" function is
>"xine-lib/src/audio_out/audio_alsa_out.c"
>
>So if the delay is 100 ms.
>You have to place samples in the audio buffer 100ms before you wish to hear
>them.

Not quite right.

You have to put the samples in the buffer when its time to put them
there. The audio interface will tell you when its time to do that by
sending you an interrupt, which in POSIX terms means your app will
wake up from poll(2) if it was waiting on the relevant file
descriptor(s). You can then deliver the data.

Typically (assuming you used sane parameters to configure the device
driver), this will be about 100ms ahead of the samples being
heard. But there is no need to try to do any other scheduling - just
give the audio interface the data when it tells you it needs it.

However, thats still not quite right either, at least not all the
time. If you have a digital audio interface that has further
downstream latency before the signal becomes an analog one, you have
to adjust for that as well. The audio interface and the driver can't
know about this delay, so your app has to take care of it.

How many more demonstrations of the importance of being driven by the
audio interface interrupt do we need? :)

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
