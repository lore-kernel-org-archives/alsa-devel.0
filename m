From: Jean-Marc Desprez <jean-marc.desprez@wanadoo.fr>
Subject: Re: ASYNC mode...
Date: Sat, 29 Nov 2003 16:50:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FC8C02E.1030003@wanadoo.fr>
References: <m3brqw6aey.wl@ml1.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m3brqw6aey.wl@ml1.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Peter Bessman wrote:

>...what's up with it?  If you pass SND_PCM_ASYNC to snd_pcm_open(), it
>doesn't work, which strikes me as counter-intuitive.  Actually, it
>seems to be really finicky, and after playing around with pcm.c for
>something on the order of 8 hours, I still don't "get it" well enough
>to confidently make use of it.  Are there better examples out there,
>or is this mode dysfunctional?  FWIW, I'm running the latest
>PlanetCCRMA, which puts my alsa-lib at 0.9.6 (and a cvs checkout, at
>that).
>
>[pb]
>  
>
hi

I did not checked recently, but on an alsa 0.9.7 lib:
- using snd_pcm_open with SND_PCM_ASYNC opens the pcm fd with the 
O_ASYNC flag (that seems correct), and then
- setting up the callback with snd_async_add_pcm_handler performs a 
fcntl to set O_ASYNC flag in the fd (kernel) context, and supply the pid 
ot the calling process that will receive the SIGIO

the problem (bug/feature ?) within the linux kernel (at least until 
2.4.20), is that when O_ASYNC is already set in the fd kernel context, 
subsequent fcntl dealing with O_ASYNC are silently ignored, whereas 
fcntl is supposed to perform more init than open (read linux/fs/open.c 
and fcntl.c for more)

so as you say, it is conter-intuitive, but asserting the SND_PCM_ASYNC 
flag in snd_pcm_open forbids snd_async_add_pcm_handler to work!

I already suggested on this list that SND_PCM_ASYNC be only kept to 
authorise the use of snd_async_add_pcm_handler, but as far as quite few 
people are interested in async mode, I believe that priorities are 
elsewhere and it had no effect. Beside, the async mode works fine once 
this init problem is solved.

Regards


>
>-------------------------------------------------------
>This SF.net email is sponsored by: SF.net Giveback Program.
>Does SourceForge.net help you be more productive?  Does it
>help you create better code?  SHARE THE LOVE, and help us help
>YOU!  Click Here: http://sourceforge.net/donate/
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>  
>




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
