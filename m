From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_wait()  More details required.
Date: Mon, 22 Mar 2004 10:56:31 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403221055520.1808@pnote.perex-int.cz>
References: <405DAB5C.5010106@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA31117
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2004 11:01:56 +0100
In-Reply-To: <405DAB5C.5010106@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

yOn Sun, 21 Mar 2004, James Courtier-Dutton wrote:

> I need more details on exactly what snd_pcm_wait() is supposed to do.
> The documentation on the www.alsa-project.org gives: -
> Wait for a PCM to become ready.
> 
> Parameters:
>      pcm  	PCM handle
>      timeout  	maximum time in milliseconds to wait
> 
> Returns:
>      a positive value on success otherwise a negative error code (-EPIPE 
> for the xrun and -ESTRPIPE for the suspended status, others for general 
> errors)
> 
> Return values:
>      0  	timeout occurred
>      1  	PCM stream is ready for I/O
> 
> 
> 
> So, when is a PCM ready?
> If a PCM is already in SND_PCM_STATE_RUNNING, when is snd_pcm_wait() 
> supposed to return ?

When avail >= avail_min.

> I have discovered a problem with xine when using it. I have done a work 
> around in xine so that dmix now works in xine. I think that my 
> assumptions regarding snd_pcm_wait() might have been wrong, so I want to 
>   get accurate details from yourselves.
> It also might be a good idea to update the documentation for 
> snd_pcm_wait() with more details.

We had a bug in the resample plugin which causes that snd_pcm_wait() 
function was broken. Try alsa-lib from CVS.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
