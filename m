From: Troy Benjegerdes <hozer@hozed.org>
Subject: Re: ymfpci, big-endian, and spdif out
Date: Sat, 11 Jan 2003 12:48:38 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030111184837.GG393@kalmia.hozed.org>
References: <20030111014848.GD393@kalmia.hozed.org> <Pine.LNX.4.33.0301111052260.613-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0301111052260.613-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

No dice. :-/

I played around with some of my own changes that did the same thing, as
well as your patch, and I always get nothing on the receiver.

What next? try an x86 box and make sure it works with that? Is there
something In the ymfpci driver I should look at? (also, are there any
IRC channels you or someone else that knows about iec958 would be on?)

Thanks!

On Sat, Jan 11, 2003 at 10:53:51AM +0100, Jaroslav Kysela wrote:
> On Fri, 10 Jan 2003, Troy Benjegerdes wrote:
> 
> > > > results in alsa-kernel/core/pcm_memory.c:alloc_pcm_pages() getting
> > > > called with substream->dma_type= SNDRV_PCM_DMA_TYPE_UNKNOWN.
> > >  
> > > oh, you found a bug :)  it was introduced due to my last change to pcm
> > > pre-allocator.  now fixed on cvs.
> > > 
> > > thanks for your report!
> > 
> > Okay, now we're getting somewhere.. I'm not getting any errors anymore.
> > The reciever (hardware AC3 decoder) is recognizing I'm sending it
> > something other than PCM, but no sound comes out and none of the dolby
> > digital or other indicators light up. Any ideas?
> 
> Please, use this patch and try to change '#if 0' to '#if 1' until it 
> works (any combination):
> 
> Index: ac3spdif.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-tools/ac3dec/ac3spdif.c,v
> retrieving revision 1.4
> diff -u -r1.4 ac3spdif.c
> --- ac3spdif.c	8 Jan 2003 11:30:04 -0000	1.4
> +++ ac3spdif.c	11 Jan 2003 09:52:32 -0000
> @@ -154,10 +154,15 @@
>          done_banner = 1;
>        }
>        
> -#ifndef _a_b_c_d_e_f /* WORDS_BIGENDIAN */
> +#if 0
>        // extract_ac3 seems to write swabbed data
>        swab(&buf[10], &buf[10], syncinfo.frame_size * 2 - 2);
>  #endif
> +
> +#if 0
> +      swab(buf, buf, (syncinfo.frame_size * 2 - 2) + 10);
> +#endif
> +
>        res = output_play((short *)buf, BLOCK_SIZE / 2 / 2);	/* 2 channels, 16-bit samples */
>        ret = ret < 0 ? ret : res;
>        bzero(buf,BLOCK_SIZE);
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 

-- 
--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@drgw.net   

Somone asked my why I work on this free (http://www.fsf.org/philosophy/)
software stuff and not get a real job. Charles Shultz had the best answer:

"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's why
I draw cartoons. It's my life." -- Charles Shultz


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
