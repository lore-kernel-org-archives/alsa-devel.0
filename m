From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: SND_PCM_OPEN_PLAYBACK & SND_PCM_OPEN_CAPTURE
Date: Wed, 13 Aug 2003 09:58:45 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308131359.h7DDwjGM000761@localhost.localdomain>
References: <1060775410.23597.5.camel@linuxzone>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "13 Aug 2003 13:50:11 +0200."
             <1060775410.23597.5.camel@linuxzone>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Damien Sandras <dsandras@seconix.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I just noticed I was looking at the old API :)
>
>With the new API, I think it always work to open the same device twice
>(once for PLAYBACK STREAM and once for CAPTURE STREAM) at least for
>full-duplex soundcards. If I'm wrong, can somebody correct me?

yes, if the h/w can do full-duplex, then this will always work (and as
you noticed, there is no "DUPLEX" mode anymore - you always get one
handle for playback and a different one for capture).

note that some cards (the early SB series come to mind) will not
support the same parameters for playback and capture when opened for
duplex usage, so it can a bit more complex than you'd really like.

--p



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
