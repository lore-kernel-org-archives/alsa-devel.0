From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: [Jackit-devel] alsa_driver_wait -> libasound?
Date: Tue, 14 Jan 2003 11:42:40 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301141642.h0EGgKCg018516@spider.tela.com>
References: <Pine.LNX.4.33.0301141728510.504-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 14 Jan 2003 17:31:22 +0100."
             <Pine.LNX.4.33.0301141728510.504-100000@pnote.perex-int.cz>
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

>> that said, i think it would be great if this found its way into libasound.
>
>I wonder why to implement this function when one can link more pcm streams
>with "snd_pcm_link()" together? Then polling one stream is sufficient when
>streams are hardware synchronized.

why don't you go read the function in question and then consider
whether that would actually accomplish anything like what it does? i
say that because i don't think its even close. 

--p


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
