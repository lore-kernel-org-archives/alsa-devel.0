From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ymfpci, big-endian, and spdif out
Date: Sun, 12 Jan 2003 10:46:59 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301121045290.611-100000@pnote.perex-int.cz>
References: <20030111201014.GI393@kalmia.hozed.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030111201014.GI393@kalmia.hozed.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Troy Benjegerdes <hozer@hozed.org>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 11 Jan 2003, Troy Benjegerdes wrote:

> On Fri, Jan 10, 2003 at 07:48:48PM -0600, Troy Benjegerdes wrote:
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
> Okay.... why does snd_ymfpci_playback_spdif_open use writel and every
> other write to YDSXGR_SPDIFOUTSTATUS register use writew? 

The register is 16-bit, but I think that 32-bit accesses are not invalid 
(high 16-bits are not used in the register space). Anyway, I replaced 
writel with writew, thanks.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
