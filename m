From: Laurent Canet <lc@tekila.org>
Subject: Non-coherent memory mapped devices
Date: Tue, 18 Mar 2003 20:48:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030318204808.66a39ed7.lc@tekila.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On the HPPA architecture, devices (including sound ones) are memory-mapped. 
On particular machines, memory access to devices are not consistent,
i.e. data wrote to memory could be cached by the CPU, thus inacessible
to the device. 
To avoid inconsistency in memory writes, there are arch-dep functions 
that flush write buffers. They are defined in <asm/io.h> as
dma_cache_inv(start,size), dma_cache_wback and dma_cache_wback_inv; and should be called after all DMA memory writes.

On architectures that don't have such cache issues (most ia32, ia64, alpha, mips, ppc, ...), they are just NOP.

I grepped out the whole alsa source tree and didn't find any occurences
of dma_cache_* functions. Who should implement these calls, low level drivers or PCM middle layer ? 

Thanks for your answer


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
