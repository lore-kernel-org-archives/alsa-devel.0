From: Andrew Gaydenko <a@etver.com>
Subject: Re: 1.0.4 snd-pcm.o dma_xxx errors
Date: Sun, 4 Apr 2004 01:02:49 +0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200404040102.49958@goldspace.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks, "rmmod snd-page-alloc" have helped.

Andrew

======= On Sunday 04 April 2004 0:01, Takashi Iwai wrote: =======
At Sat, 3 Apr 2004 21:54:03 +0200 (CEST),
Jaroslav wrote:
> 
> On Sat, 3 Apr 2004, Andrew Gaydenko wrote:
> 
> > Just have tried 1.0.4. "etc/init.d/alsasound restart" gives:
> > 
> > Starting sound driver: snd-ice1724 /lib/modules/2.4.25-lck1/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_dma_alloc_pages_Rsmp_2cbfa9e2
> > /lib/modules/2.4.25-lck1/kernel/sound/acore/snd-pcm.o: unresolved symbol snd_dma_set_reserved_Rsmp_77de065d
> > 
> > As you see. I have 2.4.25 kernrl with lck1 patch.
> 
> It looks that snd-page-alloc module is old or missing.

"alsasound stop" won't unload the snd-page-alloc module for keeping
the DMA buffers.  you have to rmmod it manually once when
snd-page-alloc is updated.


Takashi


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
