From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Sudden ISA DMA problems
Date: Mon, 18 Feb 2002 23:47:11 +0000 (GMT)
Message-ID: <20020218234711.30566.qmail@web13104.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Received: from web13104.mail.yahoo.com (web13104.mail.yahoo.com [216.136.174.149])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id AAA14160
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2002 00:47:14 +0100
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
> We use
> GFP_ATOMIC|GFP_DMA like pci_allocate_consistent().

OK, I've hacked about a bit and it's not the presence
of GFP_ATOMIC that causes trouble but the absence of
GFP_DMA.

Note that the current code in snd_malloc_isa_pages()
is:

  dma_area = snd_malloc_pages(size,
GFP_ATOMIC|GFP_KERNEL);

Without the GFP_DMA, ISA DMA transfers on my machine
do not work. GFP_DMA|GFP_ATOMIC|GFP_KERNEL is OK.

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
