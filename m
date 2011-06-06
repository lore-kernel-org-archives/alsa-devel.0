From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] wm8940: remove unecessary if statement
Date: Mon, 06 Jun 2011 10:31:23 +0100
Message-ID: <4DEC9E6B.8030505@cam.ac.uk>
References: <1307321274-21858-1-git-send-email-Gregory.Dietsche@cuw.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1307321274-21858-1-git-send-email-Gregory.Dietsche@cuw.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Dietsche <Gregory.Dietsche@cuw.edu>
Cc: perex@perex.cz, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, dp@opensource.wolfsonmicro.com, lrg@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/06/11 01:47, Greg Dietsche wrote:
> the code always returns ret regardless, so if(ret) check is unecessary.
Good point, though please spell check your commit messages.
unecessary -> unnecessary

Also if you want to do this sort of cleanup, please also fix the
equivalent in wm8940_resume and wm8940_add_widgets.  Ack is for
what is here, plus those if you do them.

Just as an aside, there is no earthly point in cc'ing lkml for a
simple cleanup like this. Just adds to already huge amount of noise!
> 
> Signed-off-by: Greg Dietsche <Gregory.Dietsche@cuw.edu>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  sound/soc/codecs/wm8940.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
> index 25580e3..1ada6d3 100644
> --- a/sound/soc/codecs/wm8940.c
> +++ b/sound/soc/codecs/wm8940.c
> @@ -730,9 +730,6 @@ static int wm8940_probe(struct snd_soc_codec *codec)
>  	if (ret)
>  		return ret;
>  	ret = wm8940_add_widgets(codec);
> -	if (ret)
> -		return ret;
> -
>  	return ret;
>  }
>  
