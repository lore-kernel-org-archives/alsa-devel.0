From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Sudden ISA DMA problems
Date: Tue, 19 Feb 2002 08:08:21 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202190808050.535-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA21239
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2002 08:08:30 +0100
In-Reply-To: <20020218234711.30566.qmail@web13104.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 18 Feb 2002, [iso-8859-1] Chris Rankin wrote:

>  --- Jaroslav Kysela <perex@suse.cz> wrote:
> > We use
> > GFP_ATOMIC|GFP_DMA like pci_allocate_consistent().
>
> OK, I've hacked about a bit and it's not the presence
> of GFP_ATOMIC that causes trouble but the absence of
> GFP_DMA.
>
> Note that the current code in snd_malloc_isa_pages()
> is:
>
>   dma_area = snd_malloc_pages(size,
> GFP_ATOMIC|GFP_KERNEL);
>
> Without the GFP_DMA, ISA DMA transfers on my machine
> do not work. GFP_DMA|GFP_ATOMIC|GFP_KERNEL is OK.

Obvious typo. Thanks you for this report.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
