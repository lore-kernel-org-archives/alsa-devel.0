From: Paul Davis <pbd@op.net>
Subject: Re: duplex mode
Date: Sat, 27 Apr 2002 15:11:01 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204271910.g3RJAaf28591@post2.fast.net>
References: <3CCAF175.6080400@kamg.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Sat, 27 Apr 2002 20:44:05 +0200."
             <3CCAF175.6080400@kamg.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Karsten G nther <karsten.guenther@kamg.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I'm trying to get access to my soundcard in duplex mode. I simply try to 
>  open a pcm device twice, for capture and playback. But if I opened and 
>initialized the first device, I get an error message for the second, 
>that the sample format is not available. Is that, because my soundcard 
>does not support duplex? It's an AWE64, so I think, it should. I am 
>using this code.

i don't know anything specific here except that the awe64 is really
useless piece of junk for duplex work. you can't use both directions
at 16 bits, for example. save yourself the hassle and get a decent
soundcard. they're not expensive ...

--p
