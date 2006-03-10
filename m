From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: pointer callback in pcm
Date: Fri, 10 Mar 2006 15:23:30 -0500
Message-ID: <1142022211.19759.27.camel@mindpipe>
References: <1141942882.10937.5.camel@localhost.localdomain>
	 <1141952015.13319.90.camel@mindpipe>
	 <1142020261.9246.3.camel@localhost.localdomain>
	 <s5hek1am4xb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hek1am4xb.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-03-10 at 21:16 +0100, Takashi Iwai wrote:
> Some hardwares have actually separate h/w buffer and the memory
> buffer (s/w buffer).  Even with such hardwares, mmap can be
> implemented.  Instead of DMA transfer by hardware, the driver copies
> data between h/w and s/w buffers on demand, namely, before starting
> the stream (in trigger callback) and when each period is consumed (via
> ack callback).
> 
> There are userful functions for such a case, found in pcm-indirect.h.
> They are used emu10k1 FX mode and cs46xx.
> 

Adrian has a weird case - his hardware *does* have DMA but it must be
reprogrammed every period.  So no copying is required in the driver.

The driver guide assumes that once the DMA is started, it will
repeatedly fill the buffer until we tell it to stop.

So, I thought that the DMA could be programmed in the copy callback each
period.  But maybe this should go in the ack callback.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
