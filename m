From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Sudden ISA DMA problems
Date: Sun, 17 Feb 2002 10:22:24 +0000 (GMT)
Message-ID: <20020217102224.73646.qmail@web13101.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Received: from web13101.mail.yahoo.com (web13101.mail.yahoo.com [216.136.174.146])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id LAA15041
	for <alsa-devel@alsa-project.org>; Sun, 17 Feb 2002 11:22:31 +0100
In-Reply-To: <Pine.LNX.4.31.0202171027531.513-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 --- Jaroslav Kysela <perex@suse.cz> wrote:
> Using pci_allocate_consistent() for ISA DMA
> allocation routines is
> definitely a bad idea. I added
> snd_malloc_isa_pages() code as you
> suggested to snd.o (it seems that it's good to
> abstract such bus specific
> allocation routines).

Thanks, my driver is now both compiling and working
again. (Just need to test "capture" mode now...) My
only concern is that I thought that virt_to_bus() was
going to disappear in 2.5, maybe even in future 2.4
kernels, leaving us with only
pci_allocate_consistent(). I wouldn't mind, except
that it doesn't seem to *work* for ISA DMA...!

Cheers,
Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
