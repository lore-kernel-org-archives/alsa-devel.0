From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa-lib: pcm_plug: fix float conversion for user
 specified ttable
Date: Tue, 17 Jun 2014 15:06:46 +0200
Message-ID: <53A03D66.1090302@perex.cz>
References: <1402933971.835286264@f359.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 64C9F2655C4
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 15:06:48 +0200 (CEST)
In-Reply-To: <1402933971.835286264@f359.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergey <sergemp@mail.ru>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Date 16.6.2014 17:52, Sergey wrote:
> Move custom ttable with equal channels case from a separate ttable_last
> exception into a common plugins insertion loop.
> Fixes plug with ttable for float pcms (jack, ladspa).
> Example: aplay -fFLOAT_LE /dev/zero
> pcm.!default {
>     type plug
>     slave.pcm { type null }
>     ttable.0.0 1
> }
> ---
>  src/pcm/pcm_plug.c |   36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
> 
> diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
> index ede9c15..6d0454f 100644
> --- a/src/pcm/pcm_plug.c
> +++ b/src/pcm/pcm_plug.c
> @@ -53,7 +53,7 @@ typedef struct {
>  	const snd_config_t *rate_converter;
>  	enum snd_pcm_plug_route_policy route_policy;
>  	snd_pcm_route_ttable_entry_t *ttable;
> -	int ttable_ok, ttable_last;
> +	int ttable_ok;
>  	unsigned int tt_ssize, tt_cused, tt_sused;
>  } snd_pcm_plug_t;
>  
> @@ -380,7 +380,7 @@ static int snd_pcm_plug_change_channels(snd_pcm_t *pcm, snd_pcm_t **new, snd_pcm
>  	snd_pcm_route_ttable_entry_t *ttable;
>  	int err;
>  	if (clt->channels == slv->channels &&
> -	    (!plug->ttable || !plug->ttable_last))
> +	    (!plug->ttable || plug->ttable_ok))
>  		return 0;
>  	if (clt->rate != slv->rate &&
>  	    clt->channels > slv->channels)
> @@ -485,13 +485,15 @@ static int snd_pcm_plug_change_format(snd_pcm_t *pcm, snd_pcm_t **new, snd_pcm_p
>  	/* No conversion is needed */
>  	if (clt->format == slv->format &&
>  	    clt->rate == slv->rate &&
> -	    clt->channels == slv->channels)
> +	    clt->channels == slv->channels &&
> +	    (!plug->ttable || plug->ttable_ok))
>  		return 0;
>  
>  	if (snd_pcm_format_linear(slv->format)) {
>  		/* Conversion is done in another plugin */
>  		if (clt->rate != slv->rate ||
> -		    clt->channels != slv->channels)
> +		    clt->channels != slv->channels ||
> +		    (plug->ttable && !plug->ttable_ok))
>  			return 0;
>  		cfmt = clt->format;
>  		switch (clt->format) {
> @@ -525,7 +527,8 @@ static int snd_pcm_plug_change_format(snd_pcm_t *pcm, snd_pcm_t **new, snd_pcm_p
>  		if (snd_pcm_format_linear(clt->format)) {
>  			cfmt = clt->format;
>  			f = snd_pcm_lfloat_open;
> -		} else if (clt->rate != slv->rate || clt->channels != slv->channels) {
> +		} else if (clt->rate != slv->rate || clt->channels != slv->channels ||
> +		           (plug->ttable && !plug->ttable_ok)) {
>  			cfmt = SND_PCM_FORMAT_S16;
>  			f = snd_pcm_lfloat_open;
>  		} else
> @@ -641,11 +644,12 @@ static int snd_pcm_plug_insert_plugins(snd_pcm_t *pcm,
>  	};
>  	snd_pcm_plug_params_t p = *slave;
>  	unsigned int k = 0;
> -	plug->ttable_ok = plug->ttable_last = 0;
> +	plug->ttable_ok = 0;
>  	while (client->format != p.format ||
>  	       client->channels != p.channels ||
>  	       client->rate != p.rate ||
> -	       client->access != p.access) {
> +	       client->access != p.access ||
> +	       (plug->ttable && !plug->ttable_ok)) {
>  		snd_pcm_t *new;
>  		int err;
>  		if (k >= sizeof(funcs)/sizeof(*funcs))
> @@ -660,24 +664,6 @@ static int snd_pcm_plug_insert_plugins(snd_pcm_t *pcm,
>  		}
>  		k++;
>  	}
> -#ifdef BUILD_PCM_PLUGIN_ROUTE
> -	/* it's exception, user specified ttable, but no reduction/expand */
> -	if (plug->ttable && !plug->ttable_ok) {
> -		snd_pcm_t *new;
> -		int err;
> -		plug->ttable_last = 1;
> -		err = snd_pcm_plug_change_channels(pcm, &new, client, &p);
> -		if (err < 0) {
> -			snd_pcm_plug_clear(pcm);
> -			return err;
> -		}
> -		assert(err);
> -		assert(plug->ttable_ok);
> -		plug->gen.slave = new;
> -		pcm->fast_ops = new->fast_ops;
> -		pcm->fast_op_arg = new->fast_op_arg;
> -	}
> -#endif
>  	return 0;
>  }
>  
> 

Thanks. Looks good. Applied.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
