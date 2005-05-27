From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/core/oss pcm_oss.c,1.87,1.88
Date: Fri, 27 May 2005 10:40:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0505271038060.1757@pnote.perex-int.cz>
References: <E1DbLgK-0000QR-5z@sc8-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 184CF209
	for <alsa-devel@alsa-project.org>; Fri, 27 May 2005 10:40:16 +0200 (MEST)
In-Reply-To: <E1DbLgK-0000QR-5z@sc8-pr-cvs1.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <cladisch@users.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 26 May 2005, Clemens Ladisch wrote:

> Update of /cvsroot/alsa/alsa-kernel/core/oss
> In directory sc8-pr-cvs1.sourceforge.net:/tmp/cvs-serv1617
> 
> Modified Files:
> 	pcm_oss.c 
> Log Message:
> Summary: pcm_oss - fix SNDCTL_DSP_GETOPTR not working correctly
> 
> This patch changes snd_pcm_oss_bytes() by adding a local variable
> for the frames -> bytes conversion, which means that the frame count
> is no longer corrupted by this conversion.

It seems like a wrong patch to me. We cannot mix frames with bytes (see
last expression). I think that there is a overflow in the return
expression.

					Jaroslav

> 
> Signed-off-by: Roger Mach <bigmach@us.ibm.com>
> 
> Index: pcm_oss.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-kernel/core/oss/pcm_oss.c,v
> retrieving revision 1.87
> retrieving revision 1.88
> diff -u -r1.87 -r1.88
> --- pcm_oss.c	12 Apr 2005 16:33:59 -0000	1.87
> +++ pcm_oss.c	26 May 2005 16:58:01 -0000	1.88
> @@ -124,11 +124,12 @@
>  
>  static long snd_pcm_oss_bytes(snd_pcm_substream_t *substream, long frames)
>  {
> +	long bytes = 0;
>  	snd_pcm_runtime_t *runtime = substream->runtime;
>  	snd_pcm_uframes_t buffer_size = snd_pcm_lib_buffer_bytes(substream);
> -	frames = frames_to_bytes(runtime, frames);
> +	bytes = frames_to_bytes(runtime, frames);
>  	if (buffer_size == runtime->oss.buffer_bytes)
> -		return frames;
> +		return bytes;
>  	return (runtime->oss.buffer_bytes * frames) / buffer_size;
>  }

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
