From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: Timer?
Date: Wed, 6 Mar 2002 18:00:27 -0000
Message-ID: <NGBBLNODKDFPBFMBBFAFMEBKCDAA.James@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net [194.217.242.91])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA20333
	for <alsa-devel@alsa-project.org>; Wed, 6 Mar 2002 18:59:46 +0100
In-Reply-To: <200203061754.MAA01756@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Paul Davis [mailto:pbd@Op.Net]
> Sent: 06 March 2002 17:51
> To: James Courtier-Dutton
> Cc: Ulrich Zadow; alsa-devel@alsa-project.org
> Subject: Re: [Alsa-devel] Timer?
>
>
> >Our app does not use poll or anything like it. It does not get
> woken up by
> >the audio device.
>
> actually it does. but not woken up from poll, just from snd_pcm_write.
>
> >Look at our source code.
>
> i did. i downloaded xine a few weeks ago.
>
> xine won't work the way a user expects if anyone tried to get it to
> inter-operate *in sync* with another application.
>
There has never been a requirement of a audio/video app like xine to be in
sync with any other application.
It just needs to sync it's own audio with it's own video streams.

Cheers
James


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
