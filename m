From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: hint needed
Date: Sat, 6 Dec 2003 16:59:28 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312061658300.20863@pnote.perex-int.cz>
References: <20031206163939.228ea11f.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031206163939.228ea11f.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 6 Dec 2003, Giuliano Pochini wrote:

> 
> Echoaudio cards are grouped into two families: EchoGals (the old
> discontinued serie) and the Echo24. The driver is almost identical for both
> families, but some constants define at compile time. I currently select the
> family by a hack in the makefile:
> 
> ifneq ($(CONFIG_SND_GINA24),)
> EXTRA_CFLAGS += -DECHO24_FAMILY
> endif
> 
> ifneq ($(CONFIG_SND_GINA20),)
> EXTRA_CFLAGS += -DECHOGALS_FAMILY
> endif
> 
> This works fine only if you run configure --with-cards that belong to the
> same family. How can I solve this issue ?  I can replace the constants with
> something choosen at runtime, but I don't like to put translation tables for
> dsp commands and such. Very ugly. Alternatively, I can duplicate all common
> parts of the driver. The files would be identical except a #define at the
> beginning :-6

See alsa-kernel/pci/ens1370.c and alsa-kernel/pci/ens1371.c for an elegant 
solution.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
