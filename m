From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Non-coherent memory mapped devices
Date: Tue, 18 Mar 2003 20:33:55 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303182031160.1160-100000@pnote.perex-int.cz>
References: <20030318204808.66a39ed7.lc@tekila.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030318204808.66a39ed7.lc@tekila.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Laurent Canet <lc@tekila.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Mar 2003, Laurent Canet wrote:

> Hi,
> 
> On the HPPA architecture, devices (including sound ones) are memory-mapped. 
> On particular machines, memory access to devices are not consistent,
> i.e. data wrote to memory could be cached by the CPU, thus inacessible
> to the device. 
> To avoid inconsistency in memory writes, there are arch-dep functions 
> that flush write buffers. They are defined in <asm/io.h> as
> dma_cache_inv(start,size), dma_cache_wback and dma_cache_wback_inv; and should be called after all DMA memory writes.
> 
> On architectures that don't have such cache issues (most ia32, ia64, alpha, mips, ppc, ...), they are just NOP.
> 
> I grepped out the whole alsa source tree and didn't find any occurences
> of dma_cache_* functions. Who should implement these calls, low level drivers or PCM middle layer ? 

This code belongs to both midlevel and lowlevel drivers. See 
snd_pcm_lib_*_transfer() routines in pcm_lib.c.

Also, we'll probably need to define these functions in our library, 
because we can access directly to DMA ring buffers there, too.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
