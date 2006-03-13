From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Buffer management questions
Date: Mon, 13 Mar 2006 20:07:10 +0000
Message-ID: <1142280430.9235.27.camel@localhost.localdomain>
References: <4415C6FE.2080202@kenati.com>
	 <1142277952.9235.14.camel@localhost.localdomain>
	 <4415D011.80001@kenati.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4415D011.80001@kenati.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlos Munoz <carlos@kenati.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-03-13 at 12:03 -0800, Carlos Munoz wrote:
> Adrian McMenamin wrote:
> 

> 
> Hi Adrian,
> 
> The driver is for the Sound Interface Unit (SIU) peripheral on the 
> Renesas SH7343 processor. 

Ah, mine was for the Dreamcast :)


> This chip has several peripherals including 
> the SIU and a DMA controller. The end product is a cell phone that will 
> play music as well. The DMA controller can be optimized for transfers 
> to/from internal peripherals. I was  planning to use the DMA controller 
> to write the sound data from the memory to the SIU fifo. The DMA 
> transfer will be 1024 bytes (period) and I will call 
> snd_pcm_period_elapsed() after each transfer completes. However, I don't 
> know what to do when I get to the end of the buffer. How do I know there 
> is new data in the buffer. Should I just wrap around ? Also, I need to 
> know if caching is disabled for the buffer, since the DMA controller is 
> not cache coherent and will not read the data from the cache but 
> directly from the memory.


The DMA stuff is beyond me - but you can wrap around: have a look at my
sources - still under development and the stereo separation stuff I
added last night is broken, but it sounds similar to your box and you
may even be using the same DMA API


> 
> Please let me know if you have any questions.
> 
> Thanks,
> 
> 
> Carlos



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
