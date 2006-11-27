From: enigma_0Z <enigma.0za@gmail.com>
Subject: Re: Alsa 1.0.14?
Date: Mon, 27 Nov 2006 12:35:34 -0500
Message-ID: <a6f0b350611270935q1df77ae1k8bdc7874dd88b9b7@mail.gmail.com>
References: <1164643487.413.99.camel@razman> <s5h7ixg6fcj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h7ixg6fcj.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 11/27/06, Takashi Iwai <tiwai@suse.de> wrote:
> At Mon, 27 Nov 2006 08:04:47 -0800,
> Tobin Davis wrote:
> >
> > With as much that has changed since alsa-1.0.13, can we expect to start
> > rolling out 1.0.14 soon?  The more users testing the changes, the
> > cleaner it gets.
>
> Yes, I'm for release 1.0.14, at least, for drivers.
>
> The question is still about device enumeration API in alsa-lib.
> We have no real implementations in the application side, except for
> aplay.  IMO, we'll need to create patches to major apps / system by
> ourselves to push this API, instead of just waiting for their
> implementations.  Otherwise no one will use such a new stuff at all
> and the API will get rotten, as usual.
>
>
> Takashi
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>

Can we wait until the conexant patches are finalized? There are still
some problems.

Mainly that the new patch (patch10) that has been integrated into hg
causes some opengl apps to slow down. I'm not sure how, and no
messages show up in the logs, but reinstalling a different version
(1.0.12, and i'm not sure how it's been patched) fixes the problem. It
seems like there's some polling going on in the new driver that eats
up cpu time from opengl apps.

Of course, sound with the older hacked version does not work with wine...

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
