From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Stereo or mono - how to tell, what to do?
Date: Sun, 12 Mar 2006 21:56:33 +0000
Message-ID: <44149911.1030309@superbug.co.uk>
References: <1142194467.19034.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A416B177
	for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2006 22:56:15 +0100 (MET)
In-Reply-To: <1142194467.19034.6.camel@localhost.localdomain>
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
> I want to add the capacity to play stereo samples to my Dreamcast sound
> driver.
>
> The hardware does not support interleaved samples and in the OSS driver
> I simply separated out the input stream into two different buffers and
> transferred them separately into the hardware's memory. Can I do the
> same with ALSA or is there some middle layer magic I should be aware of?
>   
You can get alsa-lib to send either interleaved or non-interleaved 
samples to your driver.
You just tell alsa-lib which format you like, and set the 
snd_pcm_hardware .info parameter.
I have not looked into how alsa-lib informs the driver of the 
non-interleaved nature of the samples. You might have to look into that 
yourself.
Probably something in the snd_pcm_runtime structure.
> And how can my driver tell if the incoming samples are stereo or not. In
> OSS this was all done through the SNDCTL_DSP_STEREO and
> SNDCTL_DSP_CHANNELS ioctls, how do I do it in ALSA (I need to inform the
> hardware to expect two channels and not one).
>
> Adrian
>
>   
You get all that information from the prepare() callback.
The parameter passed is struct snd_pcm_substream *substream.
substream->runtime->rate
substream->runtime->format
substream->runtime->channels
substream->runtime->buffer_size
substream->runtime->period_size
substream->runtime->periods





-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
