From: Martin Langer <martin-langer@gmx.de>
Subject: Re: 1.0.6rc1 packages
Date: Fri, 6 Aug 2004 22:50:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040806205050.GA511@tuba.home>
References: <Pine.LNX.4.58.0408042050320.15189@pnote.perex-int.cz> <Pine.LNX.4.58.0408052132460.23417@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (imap.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 8A83320F
	for <alsa-devel@alsa-project.org>; Fri,  6 Aug 2004 22:49:23 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408052132460.23417@denise.shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: Jaroslav Kysela <perex@suse.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 05, 2004 at 09:41:48PM +0200, Giuliano Pochini wrote:
> 
> cvscompile complains:
> 
> checking for which soundcards to compile driver for... configure: error:
> Unsupported soundcard powermac
> 
> Even though configure --help shows it in the list.
> 

just looking into alsa-kernel/ppc/Kconfig I found:

[...]
comment "ALSA PowerMac requires I2C"
        depends on SND && I2C=n
[...]

"requires I2C" and "I2C=n" are the same??? .... I'm still wondering here.


martin


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
