From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: configure doesn't accept --with-cards=powermac
Date: Tue, 14 Sep 2004 19:40:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040914194040.1f406191.pochini@shiny.it>
References: <20040912113743.283b28be.pochini@shiny.it>
	<Pine.LNX.4.58.0409121328010.10059@pnote.perex-int.cz>
	<20040913212445.401b5917.pochini@shiny.it>
	<s5hy8jdrzdp.wl@alsa2.suse.de>
	<Pine.LNX.4.58.0409141112410.17743@denise.shiny.it>
	<s5hpt4prve7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpt4prve7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: pochini@denise.shiny.it, perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 14 Sep 2004 12:34:56 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> > > > Yes, they're both enabled, but config.log shows that CONFIG_INPUT is an
> > > > empty string  ,8-/  ?? It's "y" in the kernel .config file.
> > >
> > > What about linux/autoconf.h?
> > > configure checks only this header file instead of .config.
> >
> > It was "1" IIRC. I can't verify right now because I'm not at home, but I'm
> > pretty sure it was 1.
>
> It looks like configure doesn't check CONFIG_INPUT indeed.
> Could you try the attached patch?

Yes, it works. Tnx.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
