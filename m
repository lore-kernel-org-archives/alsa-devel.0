From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/1] alsa-lib: fixed coverity reported
 issues under "FORWARD_NULL" checker.
Date: Thu, 17 Mar 2011 13:08:07 +0100
Message-ID: <4D81F9A7.4030007@ladisch.de>
References: <1300354872-1443-1-git-send-email-sudarshan.bisht@nokia.com>
	<1300354872-1443-2-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id E9D07103806
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2011 13:06:31 +0100 (CET)
In-Reply-To: <1300354872-1443-2-git-send-email-sudarshan.bisht@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sudarshan.bisht@nokia.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sudarshan.bisht@nokia.com wrote:
> --- a/modules/mixer/simple/sbasedl.c
> +++ b/modules/mixer/simple/sbasedl.c
> @@ -99,7 +99,7 @@ int mixer_simple_basic_dlopen(snd_mixer_class_t *class,
>        __error:
>        	if (initflag)
>        		free(priv);
> -	if (h == NULL)
> +	if (h)
>  		snd_dlclose(h);
>  	free(xlib);
>  	return -ENXIO;

We already had this one.

> --- a/src/conf.c
> +++ b/src/conf.c
> @@ -3321,9 +3321,11 @@ static int snd_config_hooks_call(snd_config_t *root, snd_config_t *config, snd_c
>  		snd_config_delete(func_conf);
>  	if (err >= 0) {
>  		snd_config_t *nroot;
> -		err = func(root, config, &nroot, private_data);
> -		if (err < 0)
> -			SNDERR("function %s returned error: %s", func_name, snd_strerror(err));
> +		if (func) {
> +			err = func(root, config, &nroot, private_data);
> +			if (err < 0)
> +				SNDERR("function %s returned error: %s", func_name, snd_strerror(err));
> +		}

The preceding "!func" and "err >= 0" checks already guarantee that
func is valid.

> --- a/src/hwdep/hwdep.c
> +++ b/src/hwdep/hwdep.c
> @@ -130,7 +130,7 @@ static int snd_hwdep_open_conf(snd_hwdep_t **hwdep,
>         _err:
>  	if (type_conf)
>  		snd_config_delete(type_conf);
> -	if (err >= 0) {
> +	if (err >= 0 && open_func) {
>  		err = open_func(hwdep, name, hwdep_root, hwdep_conf, mode);
>  		if (err >= 0) {
>  			(*hwdep)->dl_handle = h;

Same here.

> --- a/src/pcm/pcm_hooks.c
> +++ b/src/pcm/pcm_hooks.c
> @@ -445,14 +445,15 @@ static int snd_pcm_hook_add_conf(snd_pcm_t *pcm, snd_config_t *root, snd_config_
>  		else
>  			err = install_func(pcm, args);
>  		snd_config_delete(args);
> -	} else
> +	} else if (install_func)
>  		err = install_func(pcm, args);
>  
>  	if (err >= 0)
>  		err = hook_add_dlobj(pcm, h);
>  
>  	if (err < 0) {
> -		snd_dlclose(h);
> +		if (h)
> +			snd_dlclose(h);
>  		return err;
>  	}
>  	return 0;

Same here.

> --- a/src/pcm/pcm_simple.c
> +++ b/src/pcm/pcm_simple.c
> @@ -89,7 +89,7 @@ static int set_hw_params(snd_pcm_t *pcm,
>  			return err;
>  		if (periods == 1)
>  			return -EINVAL;
> -		if (*period_time == 0) {
> +		if (period_time) {
>  			err = INTERNAL(snd_pcm_hw_params_get_period_time)(hw_params, period_time, NULL);
>  			if (err < 0)
>  				return err;

OK, I think, but this change deserves an explanation.

> --- a/src/rawmidi/rawmidi.c
> +++ b/src/rawmidi/rawmidi.c
> @@ -253,7 +253,7 @@ static int snd_rawmidi_open_conf(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp
>         _err:
>  	if (type_conf)
>  		snd_config_delete(type_conf);
> -	if (err >= 0)
> +	if (err >= 0 && open_func)
>  		err = open_func(inputp, outputp, name, rawmidi_root, rawmidi_conf, mode);
>  	if (err < 0)
>  		return err;

Same as with the function pointers above.

> --- a/src/rawmidi/rawmidi_virt.c
> +++ b/src/rawmidi/rawmidi_virt.c
> @@ -383,9 +383,11 @@ int snd_rawmidi_virtual_open(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp,
>   _err:
>  	if (seq_handle)
>  		snd_seq_close(seq_handle);
> -	if (virt->midi_event)
> -		snd_midi_event_free(virt->midi_event);
> -	free(virt);
> +	if (virt) {
> +		if (virt->midi_event)
> +			snd_midi_event_free(virt->midi_event);
> +		free(virt);
> +	}
>  	if (inputp)
>  		free(*inputp);
>  	if (outputp)

OK, but not needed for the free().


Regards,
Clemens
