From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: Timer?
Date: Wed, 6 Mar 2002 17:39:55 -0000
Message-ID: <NGBBLNODKDFPBFMBBFAFCEBKCDAA.James@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net [194.217.242.91])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA20032
	for <alsa-devel@alsa-project.org>; Wed, 6 Mar 2002 18:39:18 +0100
In-Reply-To: <200203061730.MAA27701@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: Ulrich Zadow <ulrich.zadow@ARTCOM.DE>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Paul Davis [mailto:pbd@Op.Net]
> Sent: 06 March 2002 17:27
> To: James Courtier-Dutton
> Cc: Ulrich Zadow; alsa-devel@alsa-project.org
> Subject: Re: [Alsa-devel] Timer?
>
>
> >The delay value is calculated from getting the amount of samples still in
> >the sound buffer.
> >See the "ao_alsa_delay" function is
> >"xine-lib/src/audio_out/audio_alsa_out.c"
> >
> >So if the delay is 100 ms.
> >You have to place samples in the audio buffer 100ms before you
> wish to hear
> >them.
>
> Not quite right.
>
> You have to put the samples in the buffer when its time to put them
> there. The audio interface will tell you when its time to do that by
> sending you an interrupt, which in POSIX terms means your app will
> wake up from poll(2) if it was waiting on the relevant file
> descriptor(s). You can then deliver the data.

Our app does not use poll or anything like it. It does not get woken up by
the audio device.
Look at our source code.

Cheers
James


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
