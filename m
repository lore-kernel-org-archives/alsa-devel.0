From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Re: [Jackit-devel] alsa_driver_wait -> libasound?
Date: Tue, 14 Jan 2003 20:35:45 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301142029220.541-100000@pnote.perex-int.cz>
References: <200301141642.h0EGgKCg018516@spider.tela.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301141642.h0EGgKCg018516@spider.tela.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Josh Haberman <joshua@haberman.com>, "jackit-devel@lists.sourceforge.net" <jackit-devel@lists.sourceforge.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 14 Jan 2003, Paul Davis wrote:

> >> that said, i think it would be great if this found its way into libasound.
> >
> >I wonder why to implement this function when one can link more pcm streams
> >with "snd_pcm_link()" together? Then polling one stream is sufficient when
> >streams are hardware synchronized.
> 
> why don't you go read the function in question and then consider
> whether that would actually accomplish anything like what it does? i
> say that because i don't think its even close. 

Why not? In the perfect world, when the hardware supports paralel start of 
multiple streams and application sets all equal parameters for all 
streams, the pointers to ring buffer are equal. Thus checking of only one 
stream is quite sufficient before r/w operation.

When hardware does not support paralel start, but the parts are running at 
same clock, then you can expect that last started stream in serialized 
start sequence (as ALSA driver does) has valid position and all other
streams, too.

And if clock are not synced, you cannot expect nothing and your code will 
fail later (when you don't do clock corrections), too.

So resume:

1) use snd_pcm_link to link all streams
2) start first linked stream (thus all in paralel or serial or combination 
   sequence)
3) poll the last stream handle for valid position

And you don't need your complicate function.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
