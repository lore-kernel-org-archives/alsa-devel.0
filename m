From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Scatter Gather
Date: Fri, 27 Feb 2004 14:17:43 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1077905854.6881.28.camel@localhost>
Reply-To: manuel.jander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

AFAIK, it seems that when using a scatter gather buffer, not every
period is located inside of a page. If for example i use a period size
of 3000 bytes and a Scatter Gather buffer, i would have this:

pages : page0, page1, page2 ...
periods: p0, p1, p2, p3, p4 ...

|...page0...||...page1...||...page3...|
|...p0...||...p1...||...p2...||...p3...|

The problem is that a DMA transfer can not go accross 2 different pages.
On Aureal hardware, even on contiguous buffers this causes all sort of
odd problems. Each DMA chunk must be on the same page.

So i would have to do this:

d0, d1, d2, d3 : DMA chunks programmed in hardware. There are 4 for each
DMA channel.

|...page0...||...page1...||...page3...|
|...p0...||..|.p1...||...p2...||...p3...|
|...d0...||d1||.d2..||d3||.d0.||..d1..|

That means that i would have to split each period that crosses a page
boundary into 2 DMA chunks, with all the complications involved because
of irregular sizes, offsets... ARghhh!

I could just leave the period size as a power of 2, on that way, a
period would never cross any page boundary, but most ALSA programs are
too picky to accept that kind of restrictions in most cases.


----------------------------------------------
Regarding the "Writing a ALSA driver" Docbook:

Regarding the Non contiguous buffers, that the sgbuf struct can be
derived as:

snd_pcm_sgbuf_t *sgbuf = (snd_pcm_sgbuf_t*)substream->dma_private;

But there is a problem: The substream->dma_private is only valid after 
snd_pcm_lib_malloc_pages() has been called. Maybe it would be nice to
hint about this small detail in the document.


Best Regards

Manuel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
