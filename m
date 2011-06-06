From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Suppress restore of default register
	values for	rbtree cache sync
Date: Mon, 6 Jun 2011 10:18:07 +0100
Message-ID: <20110606091807.GA18786@opensource.wolfsonmicro.com>
References: <1307115435-18213-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EAD4E1037E3
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 11:18:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307115435-18213-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 03, 2011 at 04:37:15PM +0100, Mark Brown wrote:
> Currently the rbtree code will write out the entire register map when
> doing a cache sync which is wasteful and will slow things down. Check
> to see if the value we're about to write is the default and don't bother
> restoring it if it is, either the value will have been retained or the
> device will have been reset and holds the value already.
> 
> We should really store the defaults in the nodes but this resolves the
> immediate issue.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-cache.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
> index d8ce34c..d82ab42 100644
> --- a/sound/soc/soc-cache.c
> +++ b/sound/soc/soc-cache.c
> @@ -607,7 +607,7 @@ static int snd_soc_rbtree_cache_sync(struct snd_soc_codec *codec)
>  	struct rb_node *node;
>  	struct snd_soc_rbtree_node *rbnode;
>  	unsigned int regtmp;
> -	unsigned int val;
> +	unsigned int val, def;
>  	int ret;
>  	int i;
>  
> @@ -619,6 +619,11 @@ static int snd_soc_rbtree_cache_sync(struct snd_soc_codec *codec)
>  			WARN_ON(codec->writable_register &&
>  				codec->writable_register(codec, regtmp));
>  			val = snd_soc_rbtree_get_register(rbnode, i);
> +			def = snd_soc_get_cache_val(codec->reg_def_copy, i,
> +						    rbnode->word_size);
> +			if (val == def)
> +				continue;
> +
>  			codec->cache_bypass = 1;
>  			ret = snd_soc_write(codec, regtmp, val);
>  			codec->cache_bypass = 0;
> -- 
> 1.7.5.3
> 

There should be a check for reg_def_copy being NULL, the soc-cache code
is also built around the idea that the driver might not provide a
register defaults cache at all so this change needs to cope with that.

Also I'd expect the reg_def_copy cache to be freed sooner rather than
while unregistering the codec, this is not happening at the moment,
which is wasting significant space.  This is the case because it is only
used during initialization.

Note that the only reason we allocate reg_def_copy is to avoid to fiddle
with a cache that might be marked as __devinitconst which is also not
happening for any of the users at the moment.

Thanks,
Dimitris
