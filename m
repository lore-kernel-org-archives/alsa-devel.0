From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: Timer?
Date: Wed, 6 Mar 2002 17:16:14 -0000
Message-ID: <NGBBLNODKDFPBFMBBFAFKEBICDAA.James@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net [194.217.242.91])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA19632
	for <alsa-devel@alsa-project.org>; Wed, 6 Mar 2002 18:15:33 +0100
In-Reply-To: <C1E3CFAE25BBCB45AAB06733BDC048DF13FA8F@tempo.INTERN.ARTCOM.DE>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ulrich Zadow <ulrich.zadow@ARTCOM.DE>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I help develop the xine media player in linux. http://xine.sf.net

For audio/video sync, we do not use any timer on the sound driver.
We use a concept of delay.
This delay value is a measure of time between "Sample being placed in the
audio buffer now" and "Sample being output to speakers".

The delay value is calculated from getting the amount of samples still in
the sound buffer.
See the "ao_alsa_delay" function is
"xine-lib/src/audio_out/audio_alsa_out.c"

So if the delay is 100 ms.
You have to place samples in the audio buffer 100ms before you wish to hear
them.

Cheers
James


> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Ulrich Zadow
> Sent: 06 March 2002 16:23
> To: alsa-devel@alsa-project.org
> Subject: [Alsa-devel] Timer?
>
>
> Hi,
>
> we've converted our app from OSS to ALSA in 3 days(!). It's
> working beautifully, we just need to get time support running again...
>
> Is there any documentation on the timer api that goes beyond
> what's on the alsa-project pages? We're trying to sync Video and
> Audio, and all we need is a way to query the current time
> relative to some arbitrary start point.
>
> Regards,
>
>   Uli
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
