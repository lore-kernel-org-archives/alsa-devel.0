From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Sudden ISA DMA problems
Date: Mon, 18 Feb 2002 23:13:37 +0000 (GMT)
Message-ID: <20020218231337.14166.qmail@web13105.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Received: from web13105.mail.yahoo.com (web13105.mail.yahoo.com [216.136.174.150])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id AAA13534
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2002 00:13:40 +0100
In-Reply-To: <Pine.LNX.4.31.0202181411530.505-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Chris Rankin <rankincj@yahoo.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

 --- Jaroslav Kysela <perex@suse.cz> wrote:
> I removed dma_flags from isa pages allocation
> routines. We use
> GFP_ATOMIC|GFP_DMA like pci_allocate_consistent().

Interesting ... my original and working code did the
following:

buf = snd_malloc_pages(size, GFP_KERNEL | GFP_DMA);

and then used virt_to_bus(). I do not know what
GFP_ATOMIC causes kmalloc() to do, but the net effect
seems to be to prevent ISA DMA.

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
