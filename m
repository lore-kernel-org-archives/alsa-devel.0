From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] 1/3 Implement generic device DMA mapping
 support
Date: Mon, 1 Mar 2004 16:38:36 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403011637330.1870@pnote.perex-int.cz>
References: <20040229223820.C17862@flint.arm.linux.org.uk> <s5heksch8xf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5heksch8xf.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Russell King <rmk+alsa@arm.linux.org.uk>, Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Mar 2004, Takashi Iwai wrote:

> i also think that we can split pre-allocate stuffs and initialization
> stuffs to simplify.  that is, we provide the initializer
> 	snd_pcm_lib_set_dma_type(pcm, SND_DMA_PCI, ...);
> or somethine like that.  and call a single function,
> snd_pcm_lib_preallocate_buffers_for_all().
> having preallocate_*() stuffs for each DMA type is not necessary.

We can do this step later.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
