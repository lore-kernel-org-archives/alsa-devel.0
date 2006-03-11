From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: pointer callback in pcm
Date: Sat, 11 Mar 2006 11:16:15 +0000
Message-ID: <4412B17F.7080200@superbug.co.uk>
References: <1141942882.10937.5.camel@localhost.localdomain>	 <1141952015.13319.90.camel@mindpipe> <1142020261.9246.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1142020261.9246.3.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Adrian,

Here is a quick summary of what I think you have been saying.
1) Your hardware has min and max periods set to 8.
2) Your hardware can do DMA, but not periodic DMA.   <- This is really 
the crux of the problem.
3) You wish to use DMA.
4) Unknown:  What triggers the audio interrupt? It should be triggered 
once each period is completed.

Now, here is what the ALSA model assumes:
1) hardware period sizes are exactly the same size as the memory mapped 
DMA pages.
2) snd_period_ellapsed() is called at periodic intervals dependent on 
where the ADC is playing samples.
3) If the copy callback is NULL, ALSA assumes the DMA has already completed.
4) If the copy callback is not NULL, ALSA calls it, but when the copy 
callback returns, the copy has been completed.
5) The pointer callback is then called that should return the position 
of the ADC in frames (not bytes) within the audio buffer.

So, if you wish to use DMA, you should be calling snd_period_ellapsed() 
only after the DMA has completed, alternatively, the copy() callback 
should only return after the DMA transaction has completed, but I don't 
know if delaying the copy() return is allowed.
Can you get it to interrupt on each DMA completion?

I would recommend you trying to do the following:
1) Discover when the ADC has played the entire period.
2) start the DMA transfer.
3) At the DMA transfer complete interrrupt, call period_ellapsed().

So, the problem might be how to discover that the ADC has played the 
entire period.
You might have to use some sort of timer based polling to discover this.

James


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
