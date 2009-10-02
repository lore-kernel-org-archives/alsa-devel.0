From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Soc: wm8940: Fix check on error code
	form	snd_soc_codec_set_cache_io
Date: Fri, 2 Oct 2009 16:12:00 +0100
Message-ID: <20091002151200.GE11133@sirena.org.uk>
References: <4AC617BD.4070706@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A571244F7
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 17:12:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4AC617BD.4070706@cam.ac.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 02, 2009 at 04:09:49PM +0100, Jonathan Cameron wrote:
> 
> Soc: wm8940: Fix check on error code form snd_soc_codec_set_cache_io

Applied, thanks.

Please don't duplicate the first line of the commit message into the
message body like this, it means the commit message needs to be manually
mangled after applying.

> 
> Fix for typo in commit 8d50e447d19fec64adebeef55f2b60d695435412
> ASoC: Factor out I/O for Wolfson 8 bit data 16 bit register CODECs
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> ---
> 
>  sound/soc/codecs/wm8940.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
> index da97aae..1ef2454 100644
> --- a/sound/soc/codecs/wm8940.c
> +++ b/sound/soc/codecs/wm8940.c
> @@ -790,7 +790,7 @@ static int wm8940_register(struct wm8940_priv *wm8940,
>  	codec->reg_cache = &wm8940->reg_cache;
>  
>  	ret = snd_soc_codec_set_cache_io(codec, 8, 16, control);
> -	if (ret == 0) {
> +	if (ret < 0) {
>  		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
>  		return ret;
>  	}
> -- 
> 1.6.3.3
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
