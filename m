From: alfp <alfp@adsmr.co.za>
Subject: Re: [Fwd: Re: crash with rc8]
Date: 06 Mar 2003 09:27:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1046935644.3519.2.camel@didjeridu.adsmr.co.za>
References: <Pine.LNX.4.44.0303051554230.1014-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0303051554230.1014-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

It works now, thanks a million!
alf

On Wed, 2003-03-05 at 16:55, Jaroslav Kysela wrote:
> On 5 Mar 2003, alfp wrote:
> 
> > > Trace; f8b561a3 <[snd-pcm]snd_pcm_lib_malloc_pages+d3/e0>
> > > Code;  f8b410b7 <[snd-page-alloc]snd_dma_alloc_pages+17/e0>
> 
> Please, try this patch (already in CVS):
> 
> diff -u -r1.19 pcm_memory.c
> --- pcm_memory.c        28 Feb 2003 14:29:19 -0000      1.19
> +++ pcm_memory.c        5 Mar 2003 14:53:03 -0000
> @@ -348,7 +348,7 @@
>                 dmab = substream->dma_buffer;
>         } else {
>                 memset(&dmab, 0, sizeof(dmab));
> -               snd_dma_alloc_pages(&substream->dma_device, size, NULL);
> +               snd_dma_alloc_pages(&substream->dma_device, size, &dmab);
>         }
>         if (! dmab.area)
>                 return -ENOMEM;
> 
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
