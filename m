From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: ALSA is in 2.5!!!
Date: Wed, 13 Feb 2002 20:03:24 -0000
Message-ID: <NGBBLNODKDFPBFMBBFAFCEJMCAAA.James@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from finch-post-12.mail.demon.net (finch-post-12.mail.demon.net [194.217.242.41])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id VAA25338
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2002 21:03:41 +0100
Received: from superbug.demon.co.uk ([158.152.58.16] helo=jcd12345)
	by finch-post-12.mail.demon.net with smtp (Exim 3.34 #1)
	id 16b5ct-000IEt-0C
	for alsa-devel@alsa-project.org; Wed, 13 Feb 2002 20:03:35 +0000
In-Reply-To: <200202131938.OAA24975@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Excellent news.
I am an opensource developer. My main project at the moment is xine,
http://xine.sf.net and dvdnav http://dvd.sf.net.
The main requirement from xine is to get audio and video in perfect sync
with each other. Alsa provides for that requirement very well.
I would like to say that alsa 0.9.x is a great improvement over alsa 0.5.x,
and the fact that it is now in the kernel sources just goes to prove it.
I found it much easier to write applications for alsa 0.9.x than alsa 0.5.x.
For my part, I have only helped alsa is very minor ways. (bug fixes for SB
Live)
Over the coming months, I will hopefully be adding some low level audio
drivers to alsa.

The first on my list is dxr3 audio. This is a hardware dvd decoder with
integrated analogue and spdif out.
Currently, it is supported with an oss driver, but I hope to port it at some
point to alsa 0.9.x.
Now that alsa 0.9.x is in the kernel, there is even more reason to port over
all the remaining oss drivers to alsa 0.9.x.
I am finding it very difficult to find sound cards which are only supported
by oss. ;-)

I particularly like the way that alsa has a kernel driver module, and a
separate alsa-lib.
This makes the kernel image small, while at the same time presenting a very
nice API to application developers.
I would like to see this happen with other parts of the kernel. E.g. ISDN
support.

Congratulations to all the alsa developers. :-)

Cheers
James

> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Paul Davis
> Sent: 13 February 2002 19:34
> To: Jaroslav Kysela
> Cc: ALSA development
> Subject: Re: [Alsa-devel] ALSA is in 2.5!!!
>
>
> >	the big moment in ALSA existence is here. Linus integrated ALSA
> >into 2.5 kernel tree!! The first pre-patch with ALSA will be available
> >soon. For impatient hackers: Check http://openlogging.org, click on
> >'Sorted by number of lines' and choose 'Linux kernel tree' with domain
> >'transmeta.com' and contact 'Unknown'.
> >	I would like to send big thank you to all ALSA developers. I am
> >looking forward to the future.
>
> <sound of champagne bottles popping>
>
> jaroslav, abramo, frank, takashi - you all deserve huge
> congratulations for your dedication and work. the future will thank
> you in good time.
>
> --p
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
