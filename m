From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_writei() return value
Date: Thu, 21 May 2009 20:08:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905212006040.4067@eeebox2.perex-int.cz>
References: <8235e6f40905211026x15a45c05p3061cfb323b329a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BDDD1037EE
	for <alsa-devel@alsa-project.org>;
	Thu, 21 May 2009 20:08:36 +0200 (CEST)
In-Reply-To: <8235e6f40905211026x15a45c05p3061cfb323b329a6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Cristian Morales Vega <cmorve69@yahoo.es>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 21 May 2009, Cristian Morales Vega wrote:

> while(buffer.length > 0) {
>  snd_pcm_sframes_t written = snd_pcm_writei(device.handle,
> buffer_ptr, buffer.length);
>  if(written < 0) {
>    snd_pcm_recover(device.handle, written, 1);
>  } else if(written <= buffer.length) {
>    buffer.length -= written;
>    buffer_ptr += written;
>  }
> }

This is correct.

> ? And still, in this case an interrupt would be handled by
> snd_pcm_recover() (written < 0) or by the "else" code?

-EINTR is just noop in recover() function:

         if (err == -EINTR)      /* nothing to do, continue */
                 return 0;

Also check returned value from recover() - if it's negative, other error 
occured.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
