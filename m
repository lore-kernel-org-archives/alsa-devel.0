From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: configure doesn't accept --with-cards=powermac
Date: Wed, 15 Sep 2004 09:34:43 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409150933060.1774@pnote.perex-int.cz>
References: <20040912113743.283b28be.pochini@shiny.it>
 <Pine.LNX.4.58.0409121328010.10059@pnote.perex-int.cz>
 <20040913212445.401b5917.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040913212445.401b5917.pochini@shiny.it>
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

On Mon, 13 Sep 2004, Giuliano Pochini wrote:

> On Sun, 12 Sep 2004 13:30:17 +0200 (CEST)
> Jaroslav Kysela <perex@suse.cz> wrote:
> 
> > > [Giu@Jay alsa-driver-1.0.7rc1]$ ./configure --with-cards=powermac
> > > [...]
> > > checking for which soundcards to compile driver for... configure: error: Unsupported soundcard powermac
> > >
> > > "powermac" is listed in the help.
> >
> > 1) Enable CONFIG_I2C in your kernel
> > 2) Enable CONFIG_INPUT in your kernel
> 
> Yes, they're both enabled, but config.log shows that CONFIG_INPUT is an
> empty string  ,8-/  ?? It's "y" in the kernel .config file.

Does this patch help?

Index: configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/configure.in,v
retrieving revision 1.264
diff -u -r1.264 configure.in
--- configure.in        8 Sep 2004 17:06:05 -0000       1.264
+++ configure.in        15 Sep 2004 07:38:37 -0000
@@ -587,6 +587,10 @@
 CHECK_KERNEL_TRISTATE_CONFIG(CONFIG_I2C, [I2C driver in kernel])
 AC_SUBST(CONFIG_I2C)
 
+dnl Check for input subsystem...
+CHECK_KERNEL_TRISTATE_CONFIG(CONFIG_INPUT, [input subsystem in kernel])
+AC_SUBST(CONFIG_INPUT)
+
 dnl Check for SGI/MIPS (HAL2) support...
 AC_MSG_CHECKING(for SGI/MIPS (HAL2) architecture)
 CONFIG_SGI=""

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
