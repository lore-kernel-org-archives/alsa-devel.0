From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: static
	snd_pcm_uframes_t	snd_aicapcm_pcm_pointer(snd_pcm_substream_t *substream)
Date: Mon, 27 Feb 2006 23:35:26 +0000
Message-ID: <1141083326.9257.5.camel@localhost.localdomain>
References: <1140813688.9827.1.camel@localhost.localdomain>
	 <1140918491.24141.80.camel@mindpipe>
	 <1140951305.9540.3.camel@localhost.localdomain>
	 <s5hirr1t4pc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hirr1t4pc.wl%tiwai@suse.de>
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
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-02-27 at 12:35 +0100, Takashi Iwai wrote:

> 
> The pointer callback can be at any time to query the current DMA
> position, not only from the interrupt handler, e.g. from ioctl.
> 
> 
What has DMA got to do with it? I am again confused.. I thought it was
meant to return the current playback position, not the DMA position.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
