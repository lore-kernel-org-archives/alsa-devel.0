From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: PCM hw mixing with volume
Date: Wed, 10 Mar 2004 18:47:13 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <404F62B1.30206@superbug.demon.co.uk>
References: <XFMail.20040310104621.pochini@shiny.it> <1078928193.18054.247.camel@renegade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078928193.18054.247.camel@renegade>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ove Kaaven <ovek@transgaming.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ove Kaaven wrote:
> 
> 
> Well, the requirements that raised this thread should be fairly clear.
> For example,
> 
> ALTERNATIVE 1
> 
> snd_pcm_set_volume(snd_pcm_t* pcm, int volume)
> 
> and
> 
> snd_pcm_set_pan(snd_pcm_t* pcm, int pan)
> 
> using whatever value range makes the most sense, and perhaps some query
> on whether these controls are available from the pcm info. It's
> acceptable to have to explicitly ask for these controls using hw_params.
> The plug plugin could insert the route/volume plugin if these controls
> are asked for.
> 
> ALTERNATIVE 2
> 
> snd_pcm_set_volume(snd_pcm_t* pcm, int vol_left, int vol_right)
> 
> but I don't expect this to be useful, since there are probably some
> oddball devices out there that aren't able to control left and right
> volume independently like this.
> 
> ALTERNATIVE 3
> 
> Let each PCM channel have its own mixer control, like the EMU10K1
> currently do. That is, use snd_pcm_info_get_subdevice() to get the
> index, then look up a volume control with a well-known name and the
> given index using the snd_ctl API to control the volume of that PCM
> stream. The name and semantics of that mixer control would have to be
> standardized and be the same on all devices that are capable of this
> feature.
> 

What about 7.1 surround sound channels. All your suggestions only assume 
2 PCM channels.

Although it might seem nice to add this to alsa, it is not exactly a 
difficult task for the application to do itself.

I suggested exactly what you suggested some time ago (see alsa-devel 
archives), but recently I have realised that there is little or no point.
The application will contain a user interface control for the volume, so 
one might as well adjust the volume in software as well. It is not even 
very CPU intensive.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
