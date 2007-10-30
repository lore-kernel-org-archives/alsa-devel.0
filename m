From: zhejiang <zhe.jiang@intel.com>
Subject: Re: patch for Dell 1210 which using stac9221 codec
Date: Tue, 30 Oct 2007 17:05:55 +0800
Message-ID: <1193735155.4414.7.camel@localhost.localdomain>
References: <1192675756.3701.30.camel@localhost.localdomain>
	<s5hve94zd3a.wl%tiwai@suse.de>
	<1192773763.4306.31.camel@localhost.localdomain>
	<s5hejfrekan.wl%tiwai@suse.de>
	<1192779729.4628.5.camel@localhost.localdomain>
	<s5hk5pjzefs.wl%tiwai@suse.de>
	<1193033299.26715.34.camel@localhost.localdomain>
	<s5hr6jmryaf.wl%tiwai@suse.de>
	<1193298282.3459.18.camel@localhost.localdomain>
	<s5hmyu7blzv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id F2ABD2449B
	for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2007 10:07:55 +0100 (CET)
In-Reply-To: <s5hmyu7blzv.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-10-25 at 11:07 +0200, Takashi Iwai wrote:
> At Thu, 25 Oct 2007 15:44:42 +0800,
> zhejiang wrote:
> > 
> > On Tue, 2007-10-23 at 11:11 +0200, Takashi Iwai wrote:
> > > At Mon, 22 Oct 2007 14:08:19 +0800,
> > > zhejiang wrote:
> > 
> > > > > Ah, then it's basically similar like 3-stack model but with two
> > > > > headphones instead of a pair of line-out and line-in.
> > > > > 
> > > > > Without your modification of pin config, how the driver detects?
> > > > > Do you have an output of kernel message with debug option about auto
> > > > > pin configs?
> > > > > 
> > > > I don't have the hardware.
> > > > I have asked the bug reporter to do the experiment,
> > > > I will post it here if i get any response.
> > > 
> > > Thanks.
> > > 
> > 
> > According to the response from the reporter,here is the pin config of
> > the original driver.
> > 
> > ALSA /tmp/alsa-driver-build/alsa-driver-1.0.15/pci/hda/hda_codec.c:2765:
> > autoconfig: line_outs=3 (0xd/0xc/0xf/0x0/0x0)
> > ALSA /tmp/alsa-driver-build/alsa-driver-1.0.15/pci/hda/hda_codec.c:2769:
> > speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> > ALSA /tmp/alsa-driver-build/alsa-driver-1.0.15/pci/hda/hda_codec.c:2773:
> > hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
> > ALSA /tmp/alsa-driver-build/alsa-driver-1.0.15/pci/hda/hda_codec.c:2781:
> > inputs: mic=0x0, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0
> > ALSA /tmp/alsa-driver-build/alsa-driver-1.0.15/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1652: stac92xx_add_dyn_out_pins: total dac count=4
> > ALSA /tmp/alsa-driver-build/alsa-driver-1.0.15/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:1775: dac_nids=3 (0x2/0x3/0x5/0x0/0x0)
> 
> Interesting.  Then the driver seems probing a fairly wrong pin
> mapping.  So obviously the PCI SSID table entry for this laptop isn't
> correct.


> OK, what about the patch below?
> It doesn't change the pincfg, so it wouldn't work as is, though.
> 
> 
> Takashi
> 
> diff -r 09088524dd7f pci/hda/hda_codec.c
> --- a/pci/hda/hda_codec.c	Thu Oct 25 11:46:24 2007 +0200
> +++ b/pci/hda/hda_codec.c	Thu Oct 25 12:42:00 2007 +0200
> @@ -2600,11 +2600,13 @@ int snd_hda_parse_pin_def_config(struct 
>  	short seq, assoc_line_out, assoc_speaker;
>  	short sequences_line_out[ARRAY_SIZE(cfg->line_out_pins)];
>  	short sequences_speaker[ARRAY_SIZE(cfg->speaker_pins)];
> +	short sequences_hp[ARRAY_SIZE(cfg->hp_pins)];
>  
>  	memset(cfg, 0, sizeof(*cfg));
>  
>  	memset(sequences_line_out, 0, sizeof(sequences_line_out));
>  	memset(sequences_speaker, 0, sizeof(sequences_speaker));
> +	memset(sequences_hp, 0, sizeof(sequences_hp));
>  	assoc_line_out = assoc_speaker = 0;
>  
>  	nodes = snd_hda_get_sub_nodes(codec, codec->afg, &nid_start);
> @@ -2659,9 +2661,12 @@ int snd_hda_parse_pin_def_config(struct 
>  			cfg->speaker_outs++;
>  			break;
>  		case AC_JACK_HP_OUT:
> +			seq = get_defcfg_sequence(def_conf);
> +			assoc = get_defcfg_association(def_conf);
>  			if (cfg->hp_outs >= ARRAY_SIZE(cfg->hp_pins))
>  				continue;
>  			cfg->hp_pins[cfg->hp_outs] = nid;
> +			sequences_hp[cfg->hp_outs] = (assoc << 4) | seq;
>  			cfg->hp_outs++;
>  			break;
>  		case AC_JACK_MIC_IN: {
> @@ -2705,7 +2710,24 @@ int snd_hda_parse_pin_def_config(struct 
>  			      cfg->line_outs);
>  	sort_pins_by_sequence(cfg->speaker_pins, sequences_speaker,
>  			      cfg->speaker_outs);
> +	sort_pins_by_sequence(cfg->hp_pins, sequences_hp,
> +			      cfg->hp_outs);
>  	
> +	/* if we have only one mic, make it AUTO_PIN_MIC */
> +	if (!cfg->input_pins[AUTO_PIN_MIC] &&
> +	    cfg->input_pins[AUTO_PIN_FRONT_MIC]) {
> +		cfg->input_pins[AUTO_PIN_MIC] =
> +			cfg->input_pins[AUTO_PIN_FRONT_MIC];
> +		cfg->input_pins[AUTO_PIN_FRONT_MIC] = 0;
> +	}
> +	/* ditto for line-in */
> +	if (!cfg->input_pins[AUTO_PIN_LINE] &&
> +	    cfg->input_pins[AUTO_PIN_FRONT_LINE]) {
> +		cfg->input_pins[AUTO_PIN_LINE] =
> +			cfg->input_pins[AUTO_PIN_FRONT_LINE];
> +		cfg->input_pins[AUTO_PIN_FRONT_LINE] = 0;
> +	}
> +
>  	/*
>  	 * FIX-UP: if no line-outs are detected, try to use speaker or HP pin
>  	 * as a primary output
> diff -r 09088524dd7f pci/hda/patch_sigmatel.c
> --- a/pci/hda/patch_sigmatel.c	Thu Oct 25 11:46:24 2007 +0200
> +++ b/pci/hda/patch_sigmatel.c	Thu Oct 25 12:42:00 2007 +0200
> @@ -1649,12 +1649,14 @@ static int stac92xx_add_control(struct s
>  }
>  
>  /* flag inputs as additional dynamic lineouts */
> -static int stac92xx_add_dyn_out_pins(struct hda_codec *codec, struct auto_pin_cfg *cfg)
> +static int stac92xx_add_dyn_out_pins(struct hda_codec *codec,
> +				     struct auto_pin_cfg *cfg,
> +				     int line_outs, hda_nid_t *line_out_pins)
>  {
>  	struct sigmatel_spec *spec = codec->spec;
>  	unsigned int wcaps, wtype;
>  	int i, num_dacs = 0;
> -	
> +
>  	/* use the wcaps cache to count all DACs available for line-outs */
>  	for (i = 0; i < codec->num_nodes; i++) {
>  		wcaps = codec->wcaps[i];
> @@ -1665,49 +1667,48 @@ static int stac92xx_add_dyn_out_pins(str
>  
>  	snd_printdd("%s: total dac count=%d\n", __func__, num_dacs);
>  	
> -	switch (cfg->line_outs) {
> +	switch (line_outs) {
>  	case 3:
>  		/* add line-in as side */
>  		if (cfg->input_pins[AUTO_PIN_LINE] && num_dacs > 3) {
> -			cfg->line_out_pins[cfg->line_outs] =
> +			line_out_pins[line_outs] =
>  				cfg->input_pins[AUTO_PIN_LINE];
>  			spec->line_switch = 1;
> -			cfg->line_outs++;
> +			line_outs++;
>  		}
>  		break;
>  	case 2:
>  		/* add line-in as clfe and mic as side */
>  		if (cfg->input_pins[AUTO_PIN_LINE] && num_dacs > 2) {
> -			cfg->line_out_pins[cfg->line_outs] =
> +			line_out_pins[line_outs] =
>  				cfg->input_pins[AUTO_PIN_LINE];
>  			spec->line_switch = 1;
> -			cfg->line_outs++;
> +			line_outs++;
>  		}
>  		if (cfg->input_pins[AUTO_PIN_MIC] && num_dacs > 3) {
> -			cfg->line_out_pins[cfg->line_outs] =
> +			line_out_pins[line_outs] =
>  				cfg->input_pins[AUTO_PIN_MIC];
>  			spec->mic_switch = 1;
> -			cfg->line_outs++;
> +			line_outs++;
>  		}
>  		break;
>  	case 1:
>  		/* add line-in as surr and mic as clfe */
>  		if (cfg->input_pins[AUTO_PIN_LINE] && num_dacs > 1) {
> -			cfg->line_out_pins[cfg->line_outs] =
> +			line_out_pins[line_outs] =
>  				cfg->input_pins[AUTO_PIN_LINE];
>  			spec->line_switch = 1;
> -			cfg->line_outs++;
> +			line_outs++;
>  		}
>  		if (cfg->input_pins[AUTO_PIN_MIC] && num_dacs > 2) {
> -			cfg->line_out_pins[cfg->line_outs] =
> +			line_out_pins[line_outs] =
>  				cfg->input_pins[AUTO_PIN_MIC];
>  			spec->mic_switch = 1;
> -			cfg->line_outs++;
> +			line_outs++;
>  		}
>  		break;
>  	}
> -
> -	return 0;
> +	return line_outs;
>  }
>  
> 
> @@ -1731,15 +1732,16 @@ static int is_in_dac_nids(struct sigmate
>   * and 9202/925x. For those, dac_nids[] must be hard-coded.
>   */
>  static int stac92xx_auto_fill_dac_nids(struct hda_codec *codec,
> -				       struct auto_pin_cfg *cfg)
> +				       struct auto_pin_cfg *cfg,
> +				       int line_outs, hda_nid_t *line_out_pins)
>  {
>  	struct sigmatel_spec *spec = codec->spec;
>  	int i, j, conn_len = 0; 
>  	hda_nid_t nid, conn[HDA_MAX_CONNECTIONS];
>  	unsigned int wcaps, wtype;
>  	
> -	for (i = 0; i < cfg->line_outs; i++) {
> -		nid = cfg->line_out_pins[i];
> +	for (i = 0; i < line_outs; i++) {
> +		nid = line_out_pins[i];
>  		conn_len = snd_hda_get_connections(codec, nid, conn,
>  						   HDA_MAX_CONNECTIONS);
>  		for (j = 0; j < conn_len; j++) {
> @@ -1760,7 +1762,7 @@ static int stac92xx_auto_fill_dac_nids(s
>  				/* we have already working output pins,
>  				 * so let's drop the broken ones again
>  				 */
> -				cfg->line_outs = spec->multiout.num_dacs;
> +				line_outs = spec->multiout.num_dacs;
>  				break;
>  			}
>  			/* error out, no available DAC found */
> @@ -1787,7 +1789,8 @@ static int stac92xx_auto_fill_dac_nids(s
>  		   spec->multiout.dac_nids[2],
>  		   spec->multiout.dac_nids[3],
>  		   spec->multiout.dac_nids[4]);
> -	return 0;
> +
> +	return line_outs;
>  }
>  
>  /* create volume control/switch for the given prefx type */
> @@ -2087,6 +2090,8 @@ static int stac92xx_parse_auto_config(st
>  static int stac92xx_parse_auto_config(struct hda_codec *codec, hda_nid_t dig_out, hda_nid_t dig_in)
>  {
>  	struct sigmatel_spec *spec = codec->spec;
> +	int line_outs, *line_out_p;
> +	hda_nid_t *line_out_pins;
>  	int err;
>  
>  	if ((err = snd_hda_parse_pin_def_config(codec,
> @@ -2096,11 +2101,32 @@ static int stac92xx_parse_auto_config(st
>  	if (! spec->autocfg.line_outs)
>  		return 0; /* can't find valid pin config */
>  
> -	if ((err = stac92xx_add_dyn_out_pins(codec, &spec->autocfg)) < 0)
> +	/* if we have multiple headphones and no line-outs,
> +	 * let's set up headphones as primary outputs and allow
> +	 * surround outputs
> +	 */
> +	if (spec->autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT &&
> +	    spec->autocfg.hp_outs > 1) {
> +		line_out_p = &spec->autocfg.hp_outs;
> +		line_out_pins = spec->autocfg.hp_pins;
> +	} else {
> +		line_out_p = &spec->autocfg.line_outs;
> +		line_out_pins = spec->autocfg.line_out_pins;
> +	}
> +	line_outs = *line_out_p;
> +	err = stac92xx_add_dyn_out_pins(codec, &spec->autocfg,
> +					line_outs, line_out_pins);
> +	if (err < 0)
>  		return err;
> -	if (spec->multiout.num_dacs == 0)
> -		if ((err = stac92xx_auto_fill_dac_nids(codec, &spec->autocfg)) < 0)
> +	line_outs = err;
> +	if (spec->multiout.num_dacs == 0) {
> +		err = stac92xx_auto_fill_dac_nids(codec, &spec->autocfg,
> +						  line_outs, line_out_pins);
> +		if (err < 0)
>  			return err;
> +		line_outs = err;
> +	}
> +	*line_out_p = line_outs; /* store back to autocfg */
>  
>  	err = stac92xx_auto_create_multi_out_ctls(codec, &spec->autocfg);
>  


The stac92xx_auto_create_multi_out_ctls() create controls according to
cfg->line_outs. This patch seems to leave the cfg->line_outs unchanged.
It will be 1 . So I think that we need to modify
stac92xx_auto_create_multi_out_ctls(),let it to use the right line_outs.

Thanks!
