From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Sudden ISA DMA problems
Date: Sun, 17 Feb 2002 10:29:20 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202171027531.513-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA14153
	for <alsa-devel@alsa-project.org>; Sun, 17 Feb 2002 10:29:28 +0100
In-Reply-To: <20020216153742.84853.qmail@web13106.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 16 Feb 2002, [iso-8859-1] Chris Rankin wrote:

> Hi,
>
> I saw from the CVS ChangeLog that ALSA is moving away
> from the deprecated virt_to_bus() to the new
> pci_allocate_consistent() system calls. Unfortunately,
> this is causing problems for my ISA DMA sound driver
> (CS4231 / MPU401 based). I have currently "fixed"
> things by #undef-ing the ISA_USE_PCI_ALLOC in
> core/pcm_memory.c. Once I do this, I get sound out of
> my speakers again.
>
> My soundcard also needs a DMA-able buffer so that it
> can upload its firmware. Previously, I used
> snd_malloc_pages(), and I tried changing this to
> snd_malloc_isa_pages(). However, you don't export this
> function, and even when I cut-and-pasted it into the
> source file, the firmware wouldn't upload until I used
> the virt_to_bus()-based compatibility version.
>
> It would probably be a good idea to export the
> following functions:
>
> snd_malloc_pci_pages()
> snd_malloc_isa_pages()
> snd_free_pci_pages()
> snd_free_isa_pages()
>
> Does anyone have any idea why
> pci_allocate_consistent() isn't working here, please?

Using pci_allocate_consistent() for ISA DMA allocation routines is
definitely a bad idea. I added snd_malloc_isa_pages() code as you
suggested to snd.o (it seems that it's good to abstract such bus specific
allocation routines).

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
