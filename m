From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: [Jackit-devel] alsa_driver_wait -> libasound?
Date: Tue, 14 Jan 2003 15:23:10 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301142022.h0EKMmCg025158@spider.tela.com>
References: <Pine.LNX.4.33.0301142029220.541-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 14 Jan 2003 20:35:45 +0100."
             <Pine.LNX.4.33.0301142029220.541-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Josh Haberman <joshua@haberman.com>, "jackit-devel@lists.sourceforge.net" <jackit-devel@lists.sourceforge.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>So resume:
>
>1) use snd_pcm_link to link all streams

we already have hardware that doesn't support linkage between
playback+capture. 

>2) start first linked stream (thus all in paralel or serial or combination 
>   sequence)
>3) poll the last stream handle for valid position
>
>And you don't need your complicate function.

i just can't agree with that. on return from JACK's alsa_driver_wait, the
caller knows:

       * how many frames are available (rounded to whole periods)
       * what delay was encountered in waiting for the data/space
       * whether an xrun occured
       * if some other error occured 

your proposed snd_pcm_wait_many() doesn't do any of that.

i think that josh's point was perhaps a little different than you are
thinking. i don't think he was suggesting a version of snd_pcm_wait()
that waited on multiple handles instead of just one. i think he was
suggesting a function that does something that most applications need:

to wait until a known-sized chunk of data/space (or multiple thereof)
is ready on *all* handles being used. since doing this involves much
more than just calling poll(), which is fundamentally all that
snd_pcm_wait() does, so would the multi-handle version.

--p


       


-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
