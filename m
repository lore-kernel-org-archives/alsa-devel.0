From: "Yon Mercury" <swirlee@stickist.com>
Subject: RE: Re: Echo driver
Date: Wed, 10 Nov 2004 20:45:21 -0700
Message-ID: <20041111034521.M3689@stickist.com>
References: <20041109203858.M64061@stickist.com> <XFMail.20041110092710.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <XFMail.20041110092710.pochini@shiny.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Giuliano,

On Wed, 10 Nov 2004 09:27:10 +0100 (CET), Giuliano Pochini wrote
> I don't know, but nobody who tried an echoaudio card had success.

Really? Not even you?

> Look at this for example:
> http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg12364.html
> 
> but other people did try the same trick with no good results,
> so it's at least bridge-specific or, worse, computer-specific.

If you follow that thread, you get to another, where a second person solves
his cardbus problem:
http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg12641.html

>From the thread, it does seem that different cardbus bridges require special
tweaks-- but those people seem to be suggesting that it is an issue with the
Linux PCMCIA implementation and not ALSA. One of their fixes has already been
implemented into the PCMCIA tree.

What you could do is put out a call for anyone with a CardBus Echo card to
test your driver. What do you think?

-Mercury




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
