From: Troy Benjegerdes <hozer@hozed.org>
Subject: Re: ymfpci, big-endian, and spdif out
Date: Fri, 10 Jan 2003 00:55:45 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030110065545.GC393@kalmia.hozed.org>
References: <20030108053721.GC10119@kalmia.hozed.org> <Pine.LNX.4.33.0301081229000.531-200000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0301081229000.531-200000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> 
> > On Tue, Jan 07, 2003 at 05:02:53PM +0100, Takashi Iwai wrote:
> > > At Thu, 2 Jan 2003 22:22:34 -0600,
> > > Troy Benjegerdes wrote:
> > > > 
> > > > I have a mac G4 (running debian testing), a ymfpci card (MaxiSound
> > > > Fortissimo) with optical TOSlink out, and a yamaha HTR-5540 receiver with

> 
> There were a few bad assumtions in the spdif code. Could you try the 
> latest CVS code of ac3dec (or attached patch)?

Okay, I've dumped some printk's in core/pcm_memory.c, and found that the
following error:

hozer@narn ac3dec$ ./ac3dec -C ~/testac3/THX.ac3
Using PCM device 'iec958:AES0=0x2,AES1=0x82,AES2=0x0,AES3=0x2'
ALSA lib pcm_hw.c:297:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS
failed: Cannot allocate memory
PCM hw_params failed: Cannot allocate memory
Output open failed

results in alsa-kernel/core/pcm_memory.c:alloc_pcm_pages() getting
called with substream->dma_type= SNDRV_PCM_DMA_TYPE_UNKNOWN.

This definitely seems to be a driver problem.. Do you think this is
related to PowerPC, or a general ymfpci driver problem?

Thanks.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
