From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Advice on writing driver
Date: Sun, 26 Feb 2006 02:40:07 +0000
Message-ID: <44011507.7000808@superbug.co.uk>
References: <1140911587.9838.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net [194.217.242.88])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C029817C
	for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2006 03:40:04 +0100 (MET)
In-Reply-To: <1140911587.9838.19.camel@localhost.localdomain>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adrian McMenamin wrote:
> I have asked some the questions below in piecemeal form before and only
> occasionally got an answer, so i'll go through it all now and see if you
> can help.
>
> I am writing a driver for the Sega Dreamcast. Years ago I wrote an OSS
> driver but the sound dma had not been reversed then so it was slower and
> tended to lock the system.
>
> On the Dreamcast (DC) sound the main CPU is an SH4 but there is a
> separate low powered ARM7 to handle sound (PCM). The ARM7 has its own
> memory space which is directly accessible to the SH4 only through a FIFO
> like gateway (so slow) unless DMA is used.
>
> The ARM7 also has to have its own program to be told how to play the
> sound (this looks like firmware to the SH4).
>
> The driver currently allocates a buffer in the main SH4 memory (using
> the DMA buffer allocation APIs). This is then transferred to the ARM7
> space using DMA.
>
> The ARM7 code raises an interrupt to the SH4 whenever it plays 4096
> bytes of the sound - ie every period.
>
> What should my pointer callback return? the number of bytes/frames still
> to be transferred from the DMA buffer to the ARM memory or the number of
> bytes/frames still to play, or what?
>
> Adrian
>
>   
The pointer callback should return the current playback position in the 
sound  ring buffer.
So, NOT the following:

a) the number of bytes/frames still to be transferred from the DMA buffer to the ARM memory
b) the number of bytes/frames still to play

but instead it should return the position in the ring buffer of the 
frame currently being played by the ADC.


James



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
