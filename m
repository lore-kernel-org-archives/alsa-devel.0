From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/5] ALSA: usb-audio: deallocate memory
 objects in error path
Date: Wed, 22 Feb 2017 22:20:04 +0900
Message-ID: <26741ba4-a60d-2c04-2542-9550cc661db1@sakamocchi.jp>
References: <20170220200921.824-1-o-takashi@sakamocchi.jp>
 <20170220200921.824-5-o-takashi@sakamocchi.jp> <s5hwpckpoz4.wl-tiwai@suse.de>
 <d7632df1-6524-d01c-cbcf-136902976953@sakamocchi.jp>
 <c4b1c062-2099-bd14-0bc2-5a2f9b1d30ab@sakamocchi.jp>
 <0f1bb4cb-daa3-7dd9-aa55-990b67c34a38@sakamocchi.jp>
 <070a40e4-f90e-7c29-5058-f3a247fd9104@sakamocchi.jp>
 <s5h4lzmoek2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 23CB6266BFF
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 14:20:09 +0100 (CET)
In-Reply-To: <s5h4lzmoek2.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: onkel@paraair.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Feb 22 2017 16:44, Takashi Iwai wrote:
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: usb-audio: Fix memory leak and corruption in
>  mixer_us16x08.c
>
> There are a few places leaking memory and doing double-free in
> mixer_us16x08.c.
>
> The driver allocates a usb_mixer_elem_info object at each
> add_new_ctl() call.  This has to be freed via kctl->private_free, but
> currently this is done properly only for some controls.
>
> Also, the driver allocates three external objects (comp_store,
> eq_store, meter_store), and these are referred in elem->private_data
> (it's not kctl->private_data).  And these have to be released, but
> there are none doing it.  Moreover, these extra objects have to be
> released only once.  Thus the release should be done only by the first
> kctl element that refers to it.
>
> For fixing these, we call either snd_usb_mixer_elem_free() (only for
> kctl->private_data) or elem_private_free() (for both
> kctl->private_data and elem->private_data) via kctl->private_free
> appropriately.
>
> Last but not least, snd_us16x08_controls_create() may return in the
> middle without releasing the allocated *_store objects.
> returns in the middle due to an error.  For fixing this, we shuffle
> the allocation code so that it's called just before its reference.
>
> Fixes: d2bb390a2081 ("ALSA: usb-audio: Tascam US-16x08 DSP mixer quirk")
> Reported-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/mixer_us16x08.c | 92 ++++++++++++++++++++---------------------------
>  sound/usb/mixer_us16x08.h |  1 -
>  2 files changed, 39 insertions(+), 54 deletions(-)

Looks good to me.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
> index 73a0b9afdd70..f7289541fbce 100644
> --- a/sound/usb/mixer_us16x08.c
> +++ b/sound/usb/mixer_us16x08.c
> @@ -1053,11 +1053,22 @@ static struct snd_us16x08_meter_store *snd_us16x08_create_meter_store(void)
>
>  }
>
> +/* release elem->private_free as well; called only once for each *_store */
> +static void elem_private_free(struct snd_kcontrol *kctl)
> +{
> +	struct usb_mixer_elem_info *elem = kctl->private_data;
> +
> +	if (elem)
> +		kfree(elem->private_data);
> +	kfree(elem);
> +	kctl->private_data = NULL;
> +}
> +
>  static int add_new_ctl(struct usb_mixer_interface *mixer,
>  	const struct snd_kcontrol_new *ncontrol,
>  	int index, int val_type, int channels,
>  	const char *name, const void *opt,
> -	void (*freeer)(struct snd_kcontrol *kctl),
> +	bool do_private_free,
>  	struct usb_mixer_elem_info **elem_ret)
>  {
>  	struct snd_kcontrol *kctl;
> @@ -1085,7 +1096,10 @@ static int add_new_ctl(struct usb_mixer_interface *mixer,
>  		return -ENOMEM;
>  	}
>
> -	kctl->private_free = freeer;
> +	if (do_private_free)
> +		kctl->private_free = elem_private_free;
> +	else
> +		kctl->private_free = snd_usb_mixer_elem_free;
>
>  	strlcpy(kctl->id.name, name, sizeof(kctl->id.name));
>
> @@ -1109,7 +1123,6 @@ static struct snd_us16x08_control_params eq_controls[] = {
>  		.type = USB_MIXER_BOOLEAN,
>  		.num_channels = 16,
>  		.name = "EQ Switch",
> -		.freeer = snd_usb_mixer_elem_free
>  	},
>  	{ /* EQ low gain */
>  		.kcontrol_new = &snd_us16x08_eq_gain_ctl,
> @@ -1117,7 +1130,6 @@ static struct snd_us16x08_control_params eq_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "EQ Low Volume",
> -		.freeer = snd_usb_mixer_elem_free
>  	},
>  	{ /* EQ low freq */
>  		.kcontrol_new = &snd_us16x08_eq_low_freq_ctl,
> @@ -1125,7 +1137,6 @@ static struct snd_us16x08_control_params eq_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "EQ Low Frequence",
> -		.freeer = NULL
>  	},
>  	{ /* EQ mid low gain */
>  		.kcontrol_new = &snd_us16x08_eq_gain_ctl,
> @@ -1133,7 +1144,6 @@ static struct snd_us16x08_control_params eq_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "EQ MidLow Volume",
> -		.freeer = snd_usb_mixer_elem_free
>  	},
>  	{ /* EQ mid low freq */
>  		.kcontrol_new = &snd_us16x08_eq_mid_freq_ctl,
> @@ -1141,7 +1151,6 @@ static struct snd_us16x08_control_params eq_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "EQ MidLow Frequence",
> -		.freeer = NULL
>  	},
>  	{ /* EQ mid low Q */
>  		.kcontrol_new = &snd_us16x08_eq_mid_width_ctl,
> @@ -1149,7 +1158,6 @@ static struct snd_us16x08_control_params eq_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "EQ MidQLow Q",
> -		.freeer = NULL
>  	},
>  	{ /* EQ mid high gain */
>  		.kcontrol_new = &snd_us16x08_eq_gain_ctl,
> @@ -1157,7 +1165,6 @@ static struct snd_us16x08_control_params eq_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "EQ MidHigh Volume",
> -		.freeer = snd_usb_mixer_elem_free
>  	},
>  	{ /* EQ mid high freq */
>  		.kcontrol_new = &snd_us16x08_eq_mid_freq_ctl,
> @@ -1165,7 +1172,6 @@ static struct snd_us16x08_control_params eq_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "EQ MidHigh Frequence",
> -		.freeer = NULL
>  	},
>  	{ /* EQ mid high Q */
>  		.kcontrol_new = &snd_us16x08_eq_mid_width_ctl,
> @@ -1173,7 +1179,6 @@ static struct snd_us16x08_control_params eq_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "EQ MidHigh Q",
> -		.freeer = NULL
>  	},
>  	{ /* EQ high gain */
>  		.kcontrol_new = &snd_us16x08_eq_gain_ctl,
> @@ -1181,7 +1186,6 @@ static struct snd_us16x08_control_params eq_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "EQ High Volume",
> -		.freeer = snd_usb_mixer_elem_free
>  	},
>  	{ /* EQ low freq */
>  		.kcontrol_new = &snd_us16x08_eq_high_freq_ctl,
> @@ -1189,7 +1193,6 @@ static struct snd_us16x08_control_params eq_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "EQ High Frequence",
> -		.freeer = NULL
>  	},
>  };
>
> @@ -1201,7 +1204,6 @@ static struct snd_us16x08_control_params comp_controls[] = {
>  		.type = USB_MIXER_BOOLEAN,
>  		.num_channels = 16,
>  		.name = "Compressor Switch",
> -		.freeer = snd_usb_mixer_elem_free
>  	},
>  	{ /* Comp threshold */
>  		.kcontrol_new = &snd_us16x08_comp_threshold_ctl,
> @@ -1209,7 +1211,6 @@ static struct snd_us16x08_control_params comp_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "Compressor Threshold Volume",
> -		.freeer = NULL
>  	},
>  	{ /* Comp ratio */
>  		.kcontrol_new = &snd_us16x08_comp_ratio_ctl,
> @@ -1217,7 +1218,6 @@ static struct snd_us16x08_control_params comp_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "Compressor Ratio",
> -		.freeer = NULL
>  	},
>  	{ /* Comp attack */
>  		.kcontrol_new = &snd_us16x08_comp_attack_ctl,
> @@ -1225,7 +1225,6 @@ static struct snd_us16x08_control_params comp_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "Compressor Attack",
> -		.freeer = NULL
>  	},
>  	{ /* Comp release */
>  		.kcontrol_new = &snd_us16x08_comp_release_ctl,
> @@ -1233,7 +1232,6 @@ static struct snd_us16x08_control_params comp_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "Compressor Release",
> -		.freeer = NULL
>  	},
>  	{ /* Comp gain */
>  		.kcontrol_new = &snd_us16x08_comp_gain_ctl,
> @@ -1241,7 +1239,6 @@ static struct snd_us16x08_control_params comp_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "Compressor Volume",
> -		.freeer = NULL
>  	},
>  };
>
> @@ -1253,7 +1250,6 @@ static struct snd_us16x08_control_params channel_controls[] = {
>  		.type = USB_MIXER_BOOLEAN,
>  		.num_channels = 16,
>  		.name = "Phase Switch",
> -		.freeer = snd_usb_mixer_elem_free,
>  		.default_val = 0
>  	},
>  	{ /* Fader */
> @@ -1262,7 +1258,6 @@ static struct snd_us16x08_control_params channel_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "Line Volume",
> -		.freeer = NULL,
>  		.default_val = 127
>  	},
>  	{ /* Mute */
> @@ -1271,7 +1266,6 @@ static struct snd_us16x08_control_params channel_controls[] = {
>  		.type = USB_MIXER_BOOLEAN,
>  		.num_channels = 16,
>  		.name = "Mute Switch",
> -		.freeer = NULL,
>  		.default_val = 0
>  	},
>  	{ /* Pan */
> @@ -1280,7 +1274,6 @@ static struct snd_us16x08_control_params channel_controls[] = {
>  		.type = USB_MIXER_U16,
>  		.num_channels = 16,
>  		.name = "Pan Left-Right Volume",
> -		.freeer = NULL,
>  		.default_val = 127
>  	},
>  };
> @@ -1293,7 +1286,6 @@ static struct snd_us16x08_control_params master_controls[] = {
>  		.type = USB_MIXER_U8,
>  		.num_channels = 16,
>  		.name = "Master Volume",
> -		.freeer = NULL,
>  		.default_val = 127
>  	},
>  	{ /* Bypass */
> @@ -1302,7 +1294,6 @@ static struct snd_us16x08_control_params master_controls[] = {
>  		.type = USB_MIXER_BOOLEAN,
>  		.num_channels = 16,
>  		.name = "DSP Bypass Switch",
> -		.freeer = NULL,
>  		.default_val = 0
>  	},
>  	{ /* Buss out */
> @@ -1311,7 +1302,6 @@ static struct snd_us16x08_control_params master_controls[] = {
>  		.type = USB_MIXER_BOOLEAN,
>  		.num_channels = 16,
>  		.name = "Buss Out Switch",
> -		.freeer = NULL,
>  		.default_val = 0
>  	},
>  	{ /* Master mute */
> @@ -1320,7 +1310,6 @@ static struct snd_us16x08_control_params master_controls[] = {
>  		.type = USB_MIXER_BOOLEAN,
>  		.num_channels = 16,
>  		.name = "Master Mute Switch",
> -		.freeer = NULL,
>  		.default_val = 0
>  	},
>
> @@ -1338,30 +1327,10 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
>  	/* just check for non-MIDI interface */
>  	if (mixer->hostif->desc.bInterfaceNumber == 3) {
>
> -		/* create compressor mixer elements */
> -		comp_store = snd_us16x08_create_comp_store();
> -		if (comp_store == NULL)
> -			return -ENOMEM;
> -
> -		/* create eq store */
> -		eq_store = snd_us16x08_create_eq_store();
> -		if (eq_store == NULL) {
> -			kfree(comp_store);
> -			return -ENOMEM;
> -		}
> -
> -		/* create meters store */
> -		meter_store = snd_us16x08_create_meter_store();
> -		if (meter_store == NULL) {
> -			kfree(comp_store);
> -			kfree(eq_store);
> -			return -ENOMEM;
> -		}
> -
>  		/* add routing control */
>  		err = add_new_ctl(mixer, &snd_us16x08_route_ctl,
>  			SND_US16X08_ID_ROUTE, USB_MIXER_U8, 8, "Line Out Route",
> -			NULL, NULL, &elem);
> +			NULL, false, &elem);
>  		if (err < 0) {
>  			usb_audio_dbg(mixer->chip,
>  				"Failed to create route control, err:%d\n",
> @@ -1372,6 +1341,11 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
>  			elem->cache_val[i] = i < 2 ? i : i + 2;
>  		elem->cached = 0xff;
>
> +		/* create compressor mixer elements */
> +		comp_store = snd_us16x08_create_comp_store();
> +		if (!comp_store)
> +			return -ENOMEM;
> +
>  		/* add master controls */
>  		for (i = 0;
>  			i < sizeof(master_controls)
> @@ -1385,7 +1359,8 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
>  				master_controls[i].num_channels,
>  				master_controls[i].name,
>  				comp_store,
> -				master_controls[i].freeer, &elem);
> +				i == 0, /* release comp_store only once */
> +				&elem);
>  			if (err < 0)
>  				return err;
>  			elem->cache_val[0] = master_controls[i].default_val;
> @@ -1405,7 +1380,7 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
>  				channel_controls[i].num_channels,
>  				channel_controls[i].name,
>  				comp_store,
> -				channel_controls[i].freeer, &elem);
> +				false, &elem);
>  			if (err < 0)
>  				return err;
>  			for (j = 0; j < SND_US16X08_MAX_CHANNELS; j++) {
> @@ -1415,6 +1390,11 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
>  			elem->cached = 0xffff;
>  		}
>
> +		/* create eq store */
> +		eq_store = snd_us16x08_create_eq_store();
> +		if (!eq_store)
> +			return -ENOMEM;
> +
>  		/* add EQ controls */
>  		for (i = 0; i < sizeof(eq_controls) /
>  			sizeof(control_params); i++) {
> @@ -1426,7 +1406,8 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
>  				eq_controls[i].num_channels,
>  				eq_controls[i].name,
>  				eq_store,
> -				eq_controls[i].freeer, NULL);
> +				i == 0, /* release eq_store only once */
> +				NULL);
>  			if (err < 0)
>  				return err;
>  		}
> @@ -1444,18 +1425,23 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
>  				comp_controls[i].num_channels,
>  				comp_controls[i].name,
>  				comp_store,
> -				comp_controls[i].freeer, NULL);
> +				false, NULL);
>  			if (err < 0)
>  				return err;
>  		}
>
> +		/* create meters store */
> +		meter_store = snd_us16x08_create_meter_store();
> +		if (!meter_store)
> +			return -ENOMEM;
> +
>  		/* meter function 'get' must access to compressor store
>  		 * so place a reference here
>  		 */
>  		meter_store->comp_store = comp_store;
>  		err = add_new_ctl(mixer, &snd_us16x08_meter_ctl,
>  			SND_US16X08_ID_METER, USB_MIXER_U16, 0, "Level Meter",
> -			(void *) meter_store, snd_usb_mixer_elem_free, NULL);
> +			meter_store, true, NULL);
>  		if (err < 0)
>  			return err;
>  	}
> diff --git a/sound/usb/mixer_us16x08.h b/sound/usb/mixer_us16x08.h
> index 64f89b5eca2d..a6312fb0f962 100644
> --- a/sound/usb/mixer_us16x08.h
> +++ b/sound/usb/mixer_us16x08.h
> @@ -112,7 +112,6 @@ struct snd_us16x08_control_params {
>  	int type;
>  	int num_channels;
>  	const char *name;
> -	void (*freeer)(struct snd_kcontrol *kctl);
>  	int default_val;
>  };

Regards

Takashi Sakamoto
