From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Fwd: Re: crash with rc8]
Date: Wed, 5 Mar 2003 15:55:05 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303051554230.1014-100000@pnote.perex-int.cz>
References: <1046874281.14323.19.camel@didjeridu.adsmr.co.za>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1046874281.14323.19.camel@didjeridu.adsmr.co.za>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alfp <alfp@adsmr.co.za>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 5 Mar 2003, alfp wrote:

> > Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> > Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>

Please, try this patch (already in CVS):

diff -u -r1.19 pcm_memory.c
--- pcm_memory.c        28 Feb 2003 14:29:19 -0000      1.19
+++ pcm_memory.c        5 Mar 2003 14:53:03 -0000
@@ -348,7 +348,7 @@
                dmab = substream->dma_buffer;
        } else {
                memset(&dmab, 0, sizeof(dmab));
-               snd_dma_alloc_pages(&substream->dma_device, size, NULL);
+               snd_dma_alloc_pages(&substream->dma_device, size, &dmab);
        }
        if (! dmab.area)
                return -ENOMEM;


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
