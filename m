From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: pointer callback in pcm
Date: Thu, 09 Mar 2006 19:53:34 -0500
Message-ID: <1141952015.13319.90.camel@mindpipe>
References: <1141942882.10937.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1141942882.10937.5.camel@localhost.localdomain>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-03-09 at 22:21 +0000, Adrian McMenamin wrote:
> The documentation states:
> 
> "This callback is called when the PCM middle layer inquires the current
> hardware position on the buffer."
> 
> 
> Does that mean the position the hardware is at (in its ring buffer in my
> case) or does it mean the position we are at in the dma buffer.
> 
> ie I have a 128k DMA buffer which transfers samples into the 32k
> hardware memory buffer. Which position am I meant to be reporting?
> 

The DMA buffer should be the same size as the hardware buffer, so the
positions should be the same.

The pointer callback should return the position of sample that the
hardware is currently playing.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
