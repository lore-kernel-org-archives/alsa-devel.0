From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: problem with driver
Date: Mon, 06 Sep 2004 16:28:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <413C822C.2090908@superbug.demon.co.uk>
References: <20040906122604.EAC9E4BDA8@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040906122604.EAC9E4BDA8@ws1-1.us4.outblaze.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ash Willis <ashwillis@programmer.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ash Willis wrote:
> Hi guys, i'm in need of a tiny bit of help...
> 
> I've been working on a driver. When playing sound, there are gaps and aplay complains of underuns.
> There is a problem that i need to correct, regarding calculating the correct dma position.
> This isn't the problem for me BUT when playing back the driver calls pcm_trigger (start) and pcm_trigger(stop) throughout the playback process...
> So when it triggers pcm start, the card resets it's counter and any query to the corresponding register is then deemed pointless because it will always return 0 (every time the interrupt routine is called, pcm_trigger (start) has just been called).
> 
> Any help?
> 
> Thanks a lot for you time and i hope i've been clear enough :s
> 
> Ash

Most sound cards have 2 registers that control DMA.
1) shows the hw_pointer
2) starts and stops the DMA actually happening.

snd_pcm_prepare() should set the hw_pointers to zero and and initialise 
any DMA registers.
snd_pcm_trigger() should just start/stop the DMA running.

It sounds like you are leaving the DMA running, and just setting the 
pointers to zero.

Another problem is that some sound cards call the interrupt routine 
immediately, and this first time call, when the pointer is at zero, 
should be acknowledged, but no snd_periods_elapsed() called.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
