From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [Jackit-devel] alsa_driver_wait -> libasound?
Date: Tue, 14 Jan 2003 09:38:51 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301141438.h0EEcWFH028649@spider.tela.com>
References: <1042530370.10960.111.camel@birdie>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "13 Jan 2003 23:46:10 PST."
             <1042530370.10960.111.camel@birdie>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Josh Haberman <joshua@haberman.com>
Cc: jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


 [ cc'ed to alsa-devel ]

>I think I've asked something to this effect before, but is there any
>reason why the polling portion of alsa_driver_wait should not be in
>libasound?  It's a very complicated piece of code that performs an
>operation that many programs are likely to want.  What if it was written
>as a companion function to snd_pcm_wait():
>
>   int snd_pcm_wait_many( snd_pcm_t **handles, int num_handles,
>                          int timeout);
>
>...not that JACK would have to give up its version with extra error
>reporting and timing, but for programs with simpler needs it would be a
>lot nicer than having to set and test all those poll conditions for all
>of the pfds on all the handles.
>
>I should probably ask this on the ALSA list, but I'm more familiar with
>the people here.  Any reason why this couldn't go into libasound?

seems like a good idea to me, although there is a small problem. the
current snd_pcm_wait function waits till the handles is
readable/writable, whereas the JACK code waits till the handles all
have a certain minimum amount of data/space. this is a subtle but
rather important difference.

that said, i think it would be great if this found its way into libasound.

--p


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
