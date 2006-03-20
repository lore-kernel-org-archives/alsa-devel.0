From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Detecting the sample format in the driver
Date: Sun, 19 Mar 2006 19:32:55 -0500
Message-ID: <1142814775.4532.48.camel@mindpipe>
References: <1142810413.9700.45.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 45EBE1D5
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2006 01:32:58 +0100 (MET)
In-Reply-To: <1142810413.9700.45.camel@localhost.localdomain>
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

On Sun, 2006-03-19 at 23:20 +0000, Adrian McMenamin wrote:
> for some reason this isn't working for me - and I need to set hardware
> channel parameters on the basis of the sample.
> 
> My hardware plays signed 8 bit, signed 16 bit little endian and 8 bit
> adaptive differential PCM and I have this set...
> 
> 
> 
> .formats =
> 	    (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE |
> 	     SNDRV_PCM_FMTBIT_IMA_ADPCM),
> 
> 
> 
> But when I try to detect the format...
> 
> 	if ((substream->runtime)->format == SNDRV_PCM_FMTBIT_S16_LE)
> 		channel->sfmt = SM_16BIT;
> 
> 
> It doesn't seem to work.
> 
> I am assuming the alsa subsystem ought to process the stream for me - ie
> any 16 bit stream will turn up as SNDRV_PCM_FMTBIT_S16_LE - is that
> right? And if it is, why isn't it working?
> 

What does snd_pcm_format_width(runtime->format) return (check emupcm.c
for examples)?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
