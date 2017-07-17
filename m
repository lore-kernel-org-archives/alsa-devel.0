From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ASoC: rsnd: remove unnecessary static in
 rsnd_ssiu_probe()
Date: Mon, 17 Jul 2017 09:31:36 -0700
Message-ID: <1500309096.25934.11.camel@perches.com>
References: <20170717153020.GA19704@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170717153020.GA19704@embeddedgus>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-07-17 at 10:30 -0500, Gustavo A. R. Silva wrote:
> Remove unnecessary static on local variable ops.
> Such variable is initialized before being used,
> on every execution path throughout the function.
> The static has no benefit and, removing it reduces
> the code size.
[]
> In the following log you can see the difference in the code size. Also,
> there is a significant difference in the bss segment. This log is the
> output of the size command, before and after the code change:
> 
> before:
>    text    data     bss     dec     hex filename
>    3211     680      64    3955     f73 sound/soc/sh/rcar/ssiu.o
> 
> after:
>    text    data     bss     dec     hex filename
>    3207     592       0    3799     ed7 sound/soc/sh/rcar/ssiu.o
[]
> diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
[]
> @@ -250,7 +250,7 @@ int rsnd_ssiu_probe(struct rsnd_priv *priv)
>  {
>  	struct device *dev = rsnd_priv_to_dev(priv);
>  	struct rsnd_ssiu *ssiu;
> -	static struct rsnd_mod_ops *ops;
> +	struct rsnd_mod_ops *ops;
>  	int i, nr, ret;
>  
>  	/* same number to SSI */

I'm not an sh user anymore, but it's curious to me why
the static removal has such a large impact on data size.

Is this for an allyesconfig with debug symbols?

btw: this does compile for x86 and those sizes seem
     more sensible.

$ size sound/soc/sh/rcar/ssiu.o*   text	   data	    bss	    dec	    hex	filename
   1950	    248	      0	   2198	    896	sound/soc/sh/rcar/ssiu.o.defconfig.new
   1950	    248	      8	   2206	    89e	sound/soc/sh/rcar/ssiu.o.defconfig.old
   2692	    248	      0	   2940	    b7c	sound/soc/sh/rcar/ssiu.o.allyesconfig.new
   2692	    248	      8	   2948	    b84	sound/soc/sh/rcar/ssiu.o.allyesconfig.old
