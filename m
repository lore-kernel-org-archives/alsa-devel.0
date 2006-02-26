From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: static snd_pcm_uframes_t
	snd_aicapcm_pcm_pointer(snd_pcm_substream_t *substream)
Date: Sat, 25 Feb 2006 20:48:11 -0500
Message-ID: <1140918491.24141.80.camel@mindpipe>
References: <1140813688.9827.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1140813688.9827.1.camel@localhost.localdomain>
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

On Fri, 2006-02-24 at 20:41 +0000, Adrian McMenamin wrote:
> What should my pointer callback return - is it the number of frames
> still to come from the dma transfer or the number of frames still to
> play in the device's buffer, or something else?
> 

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x639.htm#PCM-INTERFACE-OPERATORS-POINTER-CALLBACK



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
