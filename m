From: Troy Benjegerdes <hozer@hozed.org>
Subject: Re: ymfpci, big-endian, and spdif out
Date: Fri, 10 Jan 2003 19:48:48 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030111014848.GD393@kalmia.hozed.org>
References: <20030108053721.GC10119@kalmia.hozed.org> <Pine.LNX.4.33.0301081229000.531-200000@pnote.perex-int.cz> <20030110065545.GC393@kalmia.hozed.org> <s5hvg0x6wvc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hvg0x6wvc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > results in alsa-kernel/core/pcm_memory.c:alloc_pcm_pages() getting
> > called with substream->dma_type= SNDRV_PCM_DMA_TYPE_UNKNOWN.
>  
> oh, you found a bug :)  it was introduced due to my last change to pcm
> pre-allocator.  now fixed on cvs.
> 
> thanks for your report!

Okay, now we're getting somewhere.. I'm not getting any errors anymore.
The reciever (hardware AC3 decoder) is recognizing I'm sending it
something other than PCM, but no sound comes out and none of the dolby
digital or other indicators light up. Any ideas?

(Xine is still giving me a 'sample format not available' error, not that
it matters while ac3dec doesn't even work)


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
