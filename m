From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Scatter-Gather buffer allocation before running on
 HDSP-MADI ?
Date: Fri, 10 Oct 2003 13:57:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310101356201.18818@pnote.perex-int.cz>
References: <16254.61960.840856.972245@seneca.iemnet>
 <Pine.LNX.4.53.0310052055350.13267@pnote.perex-int.cz> <s5had8eo4p1.wl@alsa2.suse.de>
 <1065460748.3f81a40c61063@iem.at> <s5hvfr2mflt.wl@alsa2.suse.de>
 <16258.59662.729091.684464@seneca.iemnet> <s5h65j1knhd.wl@alsa2.suse.de>
 <1065776616.3f8675e8b202e@iem.at> <s5hn0c97248.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0c97248.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ritsch@iem.at, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Oct 2003, Takashi Iwai wrote:

> At Fri, 10 Oct 2003 11:03:36 +0200 (CEST),
> ritsch@iem.at wrote:
> >
> > Hello,
> >
> >
> > the hdsp-madi card with the hdspm driver seems to work now.
> > so I want do a clean out of the code:
> >
> > I asking how should I do this:
> >
> > > > at least I have to allocate one page more = 4194304+4096, to get no
> > > > Segmentation fault, but that could be the hardware too, since hdsp
> > > > also needs one page more ?
> > >
> > > the SG-buffer allocation size is aligned (round up) to PAGE_SIZE.
> > > (note that PAGE_SIZE is not always 4K byte on other architectures.)
> > >
> >
> > Ok on my i386 architecture I have 4k pages and
> > the rme card needs  4k buffers.
> >
> > So how to code this that it works on all architectures getting
> > a SG Buf with 4k buffers.
> >
> > Do I have to do something by doing preallocation ?
>
> on linux, the least page size is 4K byte (so far, all architectures
> are so).  thus, simply do a loop like

Nope. Old alpha arch has 8K pages.

> 	offset = 0; /* bytes */
> 	while (offset < total_size) {
> 		dma_addr_t addr = snd_sgbuf_get_addr(sgbuf, offset);
> 		map_this_addr_to_my_hw_table(addr);
> 		offset += 4096; /* 4k */

I suggest to use PAGE_SIZE define here.

> 	}

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
