From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: Error: firmware not found
Date: Fri, 28 Jan 2005 17:34:48 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0501281713050.30185@denise.shiny.it>
References: <s5hvf9lplgh.wl@alsa2.suse.de> <XFMail.20050126182942.pochini@shiny.it>
 <s5hpszrrxm7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpszrrxm7.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>, Thierry Vignaud <tvignaud@mandrakesoft.com>
List-Id: alsa-devel@alsa-project.org



On Thu, 27 Jan 2005, Takashi Iwai wrote:

> > *sigh* I'll do some tests in the weekend to see how much
> > is the impact of making all that stuff variable in terms
> > of binary size and mess in the sources. Maybe I can fix
> > it with some not very nice #define...
>
> [Looks like my last post didn't come out due to system problems, so I
>  rewriting again the same thing]
>
> You don't have to use variables (although it's better for a long
> term).

Ahem - it DID use variables some versions ago. I replaced them with
constants because it's quite pointless using variables for values that
never change. Shortly after Echoaudio released the 3G cards... Btw it's
not only a matter of variables, some functions are different, too.


> The problem is that you have two modules.  Combining them to a
> single module wouldn't be too hard.

Ok, but I don't want to keep all that duplicated code loaded when only
half of it is needed. I would prefer a tiny "loader" module that does the
same work of "modprobe snd-layla3g snd-gina3g". I'll also search for other
similar cases to see if someone has a better idea.


> > Btw, I don't see what is the problem of having two drivers
> > for the same ID. Does it break some rule ?
>
> We may have, but we can't load them at the same time.
> It's a tacit understanding that the drivers with the same id
> conflict.

..and I didn't check if it works at all if the drivers are not compiled
as modules.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
