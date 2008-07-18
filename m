From: Stewart Adam <maillist@diffingo.com>
Subject: Re: softvol and snd_pcm_rewind() is broken
Date: Fri, 18 Jul 2008 12:47:08 -0400
Message-ID: <1216399628.5975.1.camel@Diffingo.localdomain>
References: <20080716143004.GA21124@tango.0pointer.de>
	<s5hd4lc3kbw.wl%tiwai@suse.de>
Reply-To: s.adam@diffingo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from thelonius.ecohosting.com (thelonius.ecohosting.com [69.90.92.9])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B1B424523
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 18:47:16 +0200 (CEST)
In-Reply-To: <s5hd4lc3kbw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I tried applying it but the two hunks failed - Is there a more recent
patch available?

Thanks,
Stewart


On Thu, 2008-07-17 at 11:56 +0200, Takashi Iwai wrote:
> At Wed, 16 Jul 2008 16:30:04 +0200,
> Lennart Poettering wrote:
> > 
> > Heya!
> > 
> > With 1.0.17rc3 snd_pcm_rewind() is broken for softvol as it seems:
> > 
> > - Sometimes the sound becomes heavily distorted after such a seek:
> > 
> >   http://mailman.alsa-project.org/pipermail/alsa-devel/2008-June/008860.html
> > 
> > - And snd_pcm_rewind() might return a value that is higher than was
> >   passed in, which as far as I understood should never happen:
> > 
> >   http://mailman.alsa-project.org/pipermail/alsa-devel/2008-April/007308.html
> > 
> > These two issues might be caused by the same error.
> > 
> > Takashi, Jaroslav, how can I bribe you into fixing this? I'd love to
> > release my new PulseAudio version soon which heavily relies on
> > snd_pcm_rewind(), but unfortunately the most important driver (hda
> > with softvol) makes the most problems with it. :-(
> 
> As mentioned earlier, the softvol itself is a simple plain plugin and
> it has no code to do forward/rewind in itself.  Thus, if a bug is
> present in softvol, it must be in the generic plugin code -- or there
> can be a missing piece that the generic code doesn't cover.  I'm not
> sure yet, as I didn't write that code.
> 
> The second problem, the bigger return size, looks like a thinko in the
> code.  Try the patch below.
> 
> 
> Takashi
> 
> ---
> diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
> index c73a02b..b5e940b 100644
> --- a/src/pcm/pcm_plugin.c
> +++ b/src/pcm/pcm_plugin.c
> @@ -203,10 +203,10 @@ static snd_pcm_sframes_t snd_pcm_plugin_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t
>  	snd_pcm_sframes_t n = snd_pcm_mmap_hw_avail(pcm);
>  	snd_pcm_sframes_t sframes;
>  
> -	if ((snd_pcm_uframes_t)n > frames)
> -		frames = n;
> -	if (frames == 0)
> +	if (n <= 0 || frames == 0)
>  		return 0;
> +	if ((snd_pcm_uframes_t)n < frames)
> +		frames = n;
>  	
>  	if (plugin->slave_frames)
>  		sframes = plugin->slave_frames(pcm, (snd_pcm_sframes_t) frames);
> @@ -236,10 +236,10 @@ static snd_pcm_sframes_t snd_pcm_plugin_forward(snd_pcm_t *pcm, snd_pcm_uframes_
>  	snd_pcm_sframes_t n = snd_pcm_mmap_avail(pcm);
>  	snd_pcm_uframes_t sframes;
>  
> -	if ((snd_pcm_uframes_t)n > frames)
> -		frames = n;
> -	if (frames == 0)
> +	if (n <= 0 || frames == 0)
>  		return 0;
> +	if ((snd_pcm_uframes_t)n < frames)
> +		frames = n;
>  	
>  	if (plugin->slave_frames)
>  		sframes = plugin->slave_frames(pcm, (snd_pcm_sframes_t) frames);
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
