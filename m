From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: static snd_pcm_uframes_t
	snd_aicapcm_pcm_pointer(snd_pcm_substream_t *substream)
Date: Sun, 26 Feb 2006 10:55:05 +0000
Message-ID: <1140951305.9540.3.camel@localhost.localdomain>
References: <1140813688.9827.1.camel@localhost.localdomain>
	 <1140918491.24141.80.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1140918491.24141.80.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-02-25 at 20:48 -0500, Lee Revell wrote:
> On Fri, 2006-02-24 at 20:41 +0000, Adrian McMenamin wrote:
> > What should my pointer callback return - is it the number of frames
> > still to come from the dma transfer or the number of frames still to
> > play in the device's buffer, or something else?
> > 
> 
> http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x639.htm#PCM-INTERFACE-OPERATORS-POINTER-CALLBACK


The problem with that - which I have read many times and even host
locally - http://newgolddream.dyndns.info/alsa - so I have a copy that
is very easily accessible is that:

"This callback is called when the PCM middle layer inquires the current
hardware position on the buffer." 

Could mean any number of different things because there is more than one
buffer here.

As it is James Courtier-Dutton has clarified this for me.

But one more question: what is the different between this and the
interrupt handling? Are they both seeking to do the same thing?



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
