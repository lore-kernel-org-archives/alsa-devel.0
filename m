From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: 1.0.4 snd-pcm.o dma_xxx errors
Date: Sat, 3 Apr 2004 21:54:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0404032152390.2140@pnote.perex-int.cz>
References: <200404032230.22915@goldspace.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200404032230.22915@goldspace.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Gaydenko <a@etver.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 3 Apr 2004, Andrew Gaydenko wrote:

> Just have tried 1.0.4. "etc/init.d/alsasound restart" gives:
> 
> Starting sound driver: snd-ice1724 /lib/modules/2.4.25-lck1/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_dma_alloc_pages_Rsmp_2cbfa9e2
> /lib/modules/2.4.25-lck1/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_dma_set_reserved_Rsmp_77de065d
> 
> As you see. I have 2.4.25 kernrl with lck1 patch.

It looks that snd-page-alloc module is old or missing.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
