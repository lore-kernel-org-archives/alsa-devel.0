From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: configure doesn't accept --with-cards=powermac
Date: Mon, 13 Sep 2004 21:24:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040913212445.401b5917.pochini@shiny.it>
References: <20040912113743.283b28be.pochini@shiny.it>
	<Pine.LNX.4.58.0409121328010.10059@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0409121328010.10059@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 12 Sep 2004 13:30:17 +0200 (CEST)
Jaroslav Kysela <perex@suse.cz> wrote:

> > [Giu@Jay alsa-driver-1.0.7rc1]$ ./configure --with-cards=powermac
> > [...]
> > checking for which soundcards to compile driver for... configure: error: Unsupported soundcard powermac
> >
> > "powermac" is listed in the help.
>
> 1) Enable CONFIG_I2C in your kernel
> 2) Enable CONFIG_INPUT in your kernel

Yes, they're both enabled, but config.log shows that CONFIG_INPUT is an
empty string  ,8-/  ?? It's "y" in the kernel .config file.


> Or do you use a 2.4 kernel?

No, 2.6.8.1



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
