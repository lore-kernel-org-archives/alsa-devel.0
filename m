From: Sudarshan Bisht <sudarshan.bisht@nokia.com>
Subject: Re: [PATCH 1/1] alsa-lib: fixed coverity reported
 issues under "RESOURCE_LEAK" checker.
Date: Fri, 18 Mar 2011 10:23:59 +0200
Message-ID: <1300436639.2435.1164.camel@Sudarshan.research.nokia.com>
References: <1300354477-1088-1-git-send-email-sudarshan.bisht@nokia.com>
	<1300354477-1088-2-git-send-email-sudarshan.bisht@nokia.com>
	<4D81F653.5070906@ladisch.de>
Reply-To: sudarshan.bisht@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id B85DA24420
	for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2011 09:25:37 +0100 (CET)
In-Reply-To: <4D81F653.5070906@ladisch.de>
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

On Thu, 2011-03-17 at 12:53 +0100, ext Clemens Ladisch wrote:
> sudarshan.bisht@nokia.com wrote:
> > --- a/modules/mixer/simple/sbase.c
> > +++ b/modules/mixer/simple/sbase.c
> > @@ -377,6 +377,7 @@ static int simple_event_add1(snd_mixer_class_t *class,
> >  		if (ctype != SND_CTL_ELEM_TYPE_BOOLEAN) {
> >  		      __invalid_type:
> >  		      	snd_mixer_selem_id_free(id);
> > +			free(hsimple);
> >  			return -EINVAL;
> >  		}
> >  		break;
> 
> OK
> 
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
> OK
> 
> > --- a/src/conf.c
> > +++ b/src/conf.c
> > @@ -638,6 +638,7 @@ static int get_char_skip_comments(input_t *input)
> >  			fd = malloc(sizeof(*fd));
> >  			if (!fd) {
> >  				free(str);
> > +				snd_input_close(in);
> >  				return -ENOMEM;
> >  			}
> 
> OK
> 
> > @@ -4589,6 +4590,7 @@ static int parse_args(snd_config_t *subs, const char *str, snd_config_t *defs)
> >  		if (err < 0) {
> >  		_err:
> >  			free(val);
> > +			snd_config_delete(sub);
> >  			return err;
> >  		}
> 
> When this code is reached through the label _err, sub is not
> necessarily a valid pointer.
Ok, then a check for the validity of sub can be put here. 
> 
> > --- a/src/control/control_hw.c
> > +++ b/src/control/control_hw.c
> > @@ -230,8 +230,10 @@ static int snd_ctl_hw_elem_tlv(snd_ctl_t *handle, int op_flag,
> >  		return -errno;
> >  	}
> >  	if (op_flag == 0) {
> > -		if (xtlv->tlv[1] + 2 * sizeof(unsigned int) > tlv_size)
> > +		if (xtlv->tlv[1] + 2 * sizeof(unsigned int) > tlv_size) {
> > +			free(xtlv);
> >  			return -EFAULT;
> > +	}
> 
> OK, but the indent of the closing brace is wrong.
Ok, will correct it. 
> 
> > --- a/src/pcm/pcm_file.c
> > +++ b/src/pcm/pcm_file.c
> > @@ -218,7 +218,7 @@ static int snd_pcm_file_open_output_file(snd_pcm_file_t *file)
> >  
> >  	if (file->final_fname[0] == '|') {
> >  		/* pipe mode */
> > -		FILE *pipe;
> > +		FILE *pipe = NULL;
> >  		/* clearing */
> >  		pipe = popen(file->final_fname + 1, "w");
> >  		if (!pipe) {
> 
> This isn't necessary because the variable is set in the next line.
Ok.
> 
> > @@ -226,7 +226,8 @@ static int snd_pcm_file_open_output_file(snd_pcm_file_t *file)
> >  					file->final_fname);
> >  			return -errno;
> >  		}
> > -		fd = fileno(pipe);
> > +		fd = dup(fileno(pipe));
> > +		fclose(pipe);
> >  	} else {
> >  		if (file->trunc)
> >  			fd = open(file->final_fname, O_WRONLY|O_CREAT|O_TRUNC,
> 
> OK, but dup() might fail.
Yes, will take care of that. 
> 
> > --- a/src/pcm/pcm_ladspa.c
> > +++ b/src/pcm/pcm_ladspa.c
> > @@ -750,8 +750,10 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
> >                          if (instance->input.data == NULL ||
> >                              instance->input.m_data == NULL ||
> >                              instance->output.data == NULL ||
> > -                            instance->output.m_data == NULL)
> > +                            instance->output.m_data == NULL) {
> > +				free(pchannels);
> >                                  return -ENOMEM;
> > +			}
> 
> OK
> 
> > @@ -761,8 +763,10 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
> >  			        instance->input.data[idx] = pchannels[chn];
> >  			        if (instance->input.data[idx] == NULL) {
> >                                          instance->input.data[idx] = snd_pcm_ladspa_allocate_zero(ladspa, 0);
> > -                                        if (instance->input.data[idx] == NULL)
> > -                                                return -ENOMEM;
> > +                                        if (instance->input.data[idx] == NULL) {
> > +                                                free(pchannels);
> > +						return -ENOMEM;
> > +					}
> >                                  }
> >                          }
> 
> OK
> 
> > @@ -770,8 +774,10 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
> >                                  /* FIXME/OPTIMIZE: check if we can remove double alloc */
> >                                  /* if LADSPA plugin has no broken inplace */
> >                                  instance->output.data[idx] = malloc(sizeof(LADSPA_Data) * ladspa->allocated);
> > -                                if (instance->output.data[idx] == NULL)
> > -                                        return -ENOMEM;
> > +                                if (instance->output.data[idx] == NULL) {
> > +                                 	free(pchannels);
> > +					return -ENOMEM;
> > +				}
> >                                  pchannels[chn] = instance->output.m_data[idx] = instance->output.data[idx];
> >                          }
> >  		}
> 
> OK
> 
> > @@ -793,8 +799,10 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
> >                                                  instance->output.data[idx] = NULL;
> >                                          } else {
> >                                                  instance->output.data[idx] = snd_pcm_ladspa_allocate_zero(ladspa, 1);
> > -                                                if (instance->output.data[idx] == NULL)
> > +                                                if (instance->output.data[idx] == NULL) {
> > +							free(pchannels);	
> >                                                          return -ENOMEM;
> > +						}
> >                                          }
> >                                  }
> >                          }
> 
> OK
> 
> > --- a/src/pcm/pcm_plug.c
> > +++ b/src/pcm/pcm_plug.c
> > @@ -1298,6 +1298,7 @@ int _snd_pcm_plug_open(snd_pcm_t **pcmp, const char *name,
> >  		err = snd_pcm_route_load_ttable(tt, ttable, csize, ssize, &cused, &sused, -1);
> >  		if (err < 0) {
> >  			snd_config_delete(sconf);
> > +			free(ttable);
> >  			return err;
> >  		}
> 
> OK
> 
> 
> > @@ -1310,8 +1311,10 @@ int _snd_pcm_plug_open(snd_pcm_t **pcmp, const char *name,
> >  
> >  	err = snd_pcm_open_slave(&spcm, root, sconf, stream, mode, conf);
> >  	snd_config_delete(sconf);
> > -	if (err < 0)
> > +	if (err < 0) {
> > +		free(ttable);
> >  		return err;
> > +	}
> 
> OK, but the following snd_pcm_plug_open() does not guarantee that ttable
> is freed if an error happens.
Ok. will take care of that too. 
> 
> > diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
> > index 70e30e5..065c9da 100644
> > --- a/src/pcm/pcm_rate.c
> > +++ b/src/pcm/pcm_rate.c
> > @@ -1392,6 +1392,7 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
> >  	} else {
> >  		SNDERR("Invalid type for rate converter");
> >  		snd_pcm_close(pcm);
> > +		free(rate);
> >  		return -EINVAL;
> >  	}
> 
> OK, but the following three error cases don't free rate either.
Yes, these should be freed. 
> 
> > --- a/src/rawmidi/rawmidi.c
> > +++ b/src/rawmidi/rawmidi.c
> > @@ -255,8 +255,10 @@ static int snd_rawmidi_open_conf(snd_rawmidi_t **inputp, snd_rawmidi_t **outputp
> >  		snd_config_delete(type_conf);
> >  	if (err >= 0)
> >  		err = open_func(inputp, outputp, name, rawmidi_root, rawmidi_conf, mode);
> > -	if (err < 0)
> > +	if (err < 0) {
> > +		snd_dlclose(h);
> >  		return err;
> > +	}
> >  	if (inputp) {
> >  		(*inputp)->dl_handle = h; h = NULL;
> >  		snd_rawmidi_params_default(*inputp, &params);
> 
> OK
> 
> 
> Regards,
> Clemens
