From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/core pcm_native.c,1.102,1.103
Date: Tue, 10 Aug 2004 23:48:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <411950A4.3070707@superbug.demon.co.uk>
References: <E1BuSw5-0008Ra-PX@sc8-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C8761232
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2004 00:48:05 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-32.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1BufPZ-000OGA-0W
	for alsa-devel@alsa-project.org; Tue, 10 Aug 2004 22:48:05 +0000
In-Reply-To: <E1BuSw5-0008Ra-PX@sc8-pr-cvs1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

There is a bug in this patch!

Jaroslav Kysela wrote:
> Update of /cvsroot/alsa/alsa-kernel/core
> In directory sc8-pr-cvs1.sourceforge.net:/tmp/cvs-serv32435
> 
> Modified Files:
> 	pcm_native.c 
> Log Message:
> Serialize runtime->status->state access
> 
> Index: pcm_native.c
> ===================================================================
> RCS file: /cvsroot/alsa/alsa-kernel/core/pcm_native.c,v
> retrieving revision 1.102
> retrieving revision 1.103
> diff -u -r1.102 -r1.103
> --- pcm_native.c	27 Jul 2004 12:28:36 -0000	1.102
> +++ pcm_native.c	10 Aug 2004 09:28:45 -0000	1.103
<snip>
> @@ -473,11 +479,16 @@
>  static int snd_pcm_sw_params(snd_pcm_substream_t * substream, snd_pcm_sw_params_t *params)
>  {
>  	snd_pcm_runtime_t *runtime;
> +
>  	snd_assert(substream != NULL, return -ENXIO);
>  	runtime = substream->runtime;
>  	snd_assert(runtime != NULL, return -ENXIO);
> -	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)

The following line should be "lock" and not "unlock"

> +	snd_pcm_stream_unlock_irq(substream);
> +	if (runtime->status->state == SNDRV_PCM_STATE_OPEN) {
> +		snd_pcm_stream_unlock_irq(substream);
>  		return -EBADFD;
> +	}
> +	snd_pcm_stream_unlock_irq(substream);
>  
>  	if (params->tstamp_mode > SNDRV_PCM_TSTAMP_LAST)
>  		return -EINVAL;
<snip>



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
