From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [alsa-cvslog] alsa-lib: SND_PCM_TSTAMP_MMAP ->
 SND_PCM_TSTAMP_ENABLE change
Date: Fri, 11 Jan 2008 09:21:32 +0100
Message-ID: <1200039692.19596.1230661259@webmail.messagingengine.com>
References: <ALOGGER1200038051.38@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id DF3C9243F1
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 09:21:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ALOGGER1200038051.38@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> description:
> SND_PCM_TSTAMP_MMAP -> SND_PCM_TSTAMP_ENABLE change
> 
> diff -r 3c87e22e70d8 -r 2519fcd54901 include/pcm.h
> --- a/include/pcm.h	Thu Jan 10 10:01:14 2008 +0100
> +++ b/include/pcm.h	Fri Jan 11 08:54:07 2008 +0100
> @@ -281,9 +281,9 @@
>  typedef enum _snd_pcm_tstamp {
>  	/** No timestamp */
>  	SND_PCM_TSTAMP_NONE = 0,
> -	/** Update mmap'ed timestamp */
> -	SND_PCM_TSTAMP_MMAP,
> -	SND_PCM_TSTAMP_LAST = SND_PCM_TSTAMP_MMAP
> +	/** Update timestamp at every hardware position update */
> +	SND_PCM_TSTAMP_ENABLE,
> +	SND_PCM_TSTAMP_LAST = SND_PCM_TSTAMP_ENABLE
>  } snd_pcm_tstamp_t;

This change breaks backward compatibility.
The v19-devel branch of PortAudio uses SND_PCM_TSTAMP_MMAP.


Regards,
Clemens
