From: Sudarshan Bisht <sudarshan.bisht@nokia.com>
Subject: Re: [PATCH 1/1] alsa-lib: fixed coverity reported
 issues under "FORWARD_NULL" checker.
Date: Fri, 18 Mar 2011 11:14:28 +0200
Message-ID: <1300439668.2435.1211.camel@Sudarshan.research.nokia.com>
References: <1300354872-1443-1-git-send-email-sudarshan.bisht@nokia.com>
	<1300354872-1443-2-git-send-email-sudarshan.bisht@nokia.com>
	<4D81F9A7.4030007@ladisch.de>
Reply-To: sudarshan.bisht@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F6972445F
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 10:16:07 +0100 (CET)
In-Reply-To: <4D81F9A7.4030007@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-03-17 at 13:08 +0100, ext Clemens Ladisch wrote:
> sudarshan.bisht@nokia.com wrote:
> > --- a/modules/mixer/simple/sbasedl.c
> > +++ b/modules/mixer/simple/sbasedl.c
> > @@ -99,7 +99,7 @@ int mixer_simple_basic_dlopen(snd_mixer_class_t *class,
> >        __error:
> >        	if (initflag)
> >        		free(priv);
> > -	if (h == NULL)
> > +	if (h)
> >  		snd_dlclose(h);
> >  	free(xlib);
> >  	return -ENXIO;
> 
> We already had this one.
Ok.
> 
> > --- a/src/conf.c
> > +++ b/src/conf.c
> > @@ -3321,9 +3321,11 @@ static int snd_config_hooks_call(snd_config_t *root, snd_config_t *config, snd_c
> >  		snd_config_delete(func_conf);
> >  	if (err >= 0) {
> >  		snd_config_t *nroot;
> > -		err = func(root, config, &nroot, private_data);
> > -		if (err < 0)
> > -			SNDERR("function %s returned error: %s", func_name, snd_strerror(err));
> > +		if (func) {
> > +			err = func(root, config, &nroot, private_data);
> > +			if (err < 0)
> > +				SNDERR("function %s returned error: %s", func_name, snd_strerror(err));
> > +		}
> 
> The preceding "!func" and "err >= 0" checks already guarantee that
> func is valid.
But in case of "goto _err"  , "!func" and "err >= 0" are not going to be
checked. 
> 
> > --- a/src/hwdep/hwdep.c
> > +++ b/src/hwdep/hwdep.c
> > @@ -130,7 +130,7 @@ static int snd_hwdep_open_conf(snd_hwdep_t **hwdep,
> >         _err:
> >  	if (type_conf)
> >  		snd_config_delete(type_conf);
> > -	if (err >= 0) {
> > +	if (err >= 0 && open_func) {
> >  		err = open_func(hwdep, name, hwdep_root, hwdep_conf, mode);
> >  		if (err >= 0) {
> >  			(*hwdep)->dl_handle = h;
> 
> Same here.
Same explanation as above.
> 
> > --- a/src/pcm/pcm_hooks.c
> > +++ b/src/pcm/pcm_hooks.c
> > @@ -445,14 +445,15 @@ static int snd_pcm_hook_add_conf(snd_pcm_t *pcm, snd_config_t *root, snd_config_
> >  		else
> >  			err = install_func(pcm, args);
> >  		snd_config_delete(args);
> > -	} else
> > +	} else if (install_func)
> >  		err = install_func(pcm, args);
> >  
> >  	if (err >= 0)
> >  		err = hook_add_dlobj(pcm, h);
> >  
> >  	if (err < 0) {
> > -		snd_dlclose(h);
> > +		if (h)
> > +			snd_dlclose(h);
> >  		return err;
> >  	}
> >  	return 0;
> 
> Same here.
h will be NULL when encounters any preceding "goto _err".  
> 
> > --- a/src/pcm/pcm_simple.c
> > +++ b/src/pcm/pcm_simple.c
> > @@ -89,7 +89,7 @@ static int set_hw_params(snd_pcm_t *pcm,
> >  			return err;
> >  		if (periods == 1)
> >  			return -EINVAL;
> > -		if (*period_time == 0) {
> > +		if (period_time) {
> >  			err = INTERNAL(snd_pcm_hw_params_get_period_time)(hw_params, period_time, NULL);
> >  			if (err < 0)
> >  				return err;
> 
> OK, I think, but this change deserves an explanation.
If  "period_time == NULL" ( in preceding if condition) is true then "if
(*period_time == 0)" has no meaning,  and if  "*period_time == 0" ( in
preceding if condition) is true then obviously period_time will be a
valid pointer and satisfy the condition. Thats what original source
codes demands.      
> 
> > --- a/src/rawmidi/rawmidi.c
> > +++ b/src/rawmidi/rawmidi.c
> > @@ -253,7 +253,7 @@ static int snd_rawmidi_open_conf(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp
> >         _err:
> >  	if (type_conf)
> >  		snd_config_delete(type_conf);
> > -	if (err >= 0)
> > +	if (err >= 0 && open_func)
> >  		err = open_func(inputp, outputp, name, rawmidi_root, rawmidi_conf, mode);
> >  	if (err < 0)
> >  		return err;
> 
> Same as with the function pointers above.
Same reason what I gave for function pointers. 
> 
> > --- a/src/rawmidi/rawmidi_virt.c
> > +++ b/src/rawmidi/rawmidi_virt.c
> > @@ -383,9 +383,11 @@ int snd_rawmidi_virtual_open(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp,
> >   _err:
> >  	if (seq_handle)
> >  		snd_seq_close(seq_handle);
> > -	if (virt->midi_event)
> > -		snd_midi_event_free(virt->midi_event);
> > -	free(virt);
> > +	if (virt) {
> > +		if (virt->midi_event)
> > +			snd_midi_event_free(virt->midi_event);
> > +		free(virt);
> > +	}
> >  	if (inputp)
> >  		free(*inputp);
> >  	if (outputp)
> 
> OK, but not needed for the free().
Sorry, but I did not get this. 
> 
> 
> Regards,
> Clemens



Br,
Sudarshan Bisht. 
