From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: runtime->dma_addr
Date: Wed, 3 Mar 2004 19:29:19 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403031928440.2089@pnote.perex-int.cz>
References: <F509E6111989D311B63700805FA761DA09F2905D@DBDE01>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <F509E6111989D311B63700805FA761DA09F2905D@DBDE01>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Gupta, Kshitij" <kshitij@ti.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 3 Mar 2004, Gupta, Kshitij wrote:

> hi,
> 	Can someone please explain me what is  the difference between
> runtime->dma_addr and runtime->dma_area
> 
> where runtime = substream->runtime
> 
> I am getting a very strange problem where I am getting a rumtime->dma_addr
> value as 0 while runtime->dma_area is a proper value.  
> Any hints will be helpful

dma_area is virtual address (visible from the CPU view)
dma_addr is the physical bus address (visible from the hardware)

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
