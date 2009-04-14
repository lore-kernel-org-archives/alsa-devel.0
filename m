From: "Carlos R. Mafra" <crmafra2@gmail.com>
Subject: Re: General protection fault when unloading
	snd_hda_intel on	2.6.30-rc1+
Date: Tue, 14 Apr 2009 18:21:19 +0200
Message-ID: <20090414162119.GA4748__23200.9550476961$1239776847$gmane$org@Pilar.aei.mpg.de>
References: <20090411193630.GA16968@Pilar.aei.mpg.de>
	<s5h63h72tuf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <s5h63h72tuf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue 14.Apr'09 at 16:27:52 +0200, Takashi Iwai wrote:
> 
> This seems happening in the path exciting the codec again in the
> release due to restoration of the pin defcfg values.
> 
> Could you try the patch below, or merge for-next or master branch
> of sound git tree?
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git


I tested the patch below and now the module unloads correctly, so the
problem is fixed.

Tested-by: Carlos R. Mafra <crmafra2@gmail.com>

Thanks Takashi!


> 
> ---
> diff --git a/include/sound/jack.h b/include/sound/jack.h
> index 6b013c6..f236e42 100644
> --- a/include/sound/jack.h
> +++ b/include/sound/jack.h
> @@ -50,6 +50,8 @@ struct snd_jack {
>  	int type;
>  	const char *id;
>  	char name[100];
> +	void *private_data;
> +	void (*private_free)(struct snd_jack *);
>  };
>  
>  #ifdef CONFIG_SND_JACK
> diff --git a/sound/core/jack.c b/sound/core/jack.c
> index c8254c6..d54d1a0 100644
> --- a/sound/core/jack.c
> +++ b/sound/core/jack.c
> @@ -35,6 +35,9 @@ static int snd_jack_dev_free(struct snd_device *device)
>  {
>  	struct snd_jack *jack = device->device_data;
>  
> +	if (jack->private_free)
> +		jack->private_free(jack);
> +
>  	/* If the input device is registered with the input subsystem
>  	 * then we need to use a different deallocator. */
>  	if (jack->registered)
> diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> index 1f2ad76..56ce19e 100644
> --- a/sound/pci/hda/patch_conexant.c
> +++ b/sound/pci/hda/patch_conexant.c
> @@ -350,12 +350,20 @@ static int conexant_mux_enum_put(struct snd_kcontrol *kcontrol,
>  }
>  
>  #ifdef CONFIG_SND_JACK
> +static void conexant_free_jack_priv(struct snd_jack *jack)
> +{
> +	struct conexant_jack *jacks = jack->private_data;
> +	jacks->nid = 0;
> +	jacks->jack = NULL;
> +}
> +
>  static int conexant_add_jack(struct hda_codec *codec,
>  		hda_nid_t nid, int type)
>  {
>  	struct conexant_spec *spec;
>  	struct conexant_jack *jack;
>  	const char *name;
> +	int err;
>  
>  	spec = codec->spec;
>  	snd_array_init(&spec->jacks, sizeof(*jack), 32);
> @@ -368,7 +376,12 @@ static int conexant_add_jack(struct hda_codec *codec,
>  	jack->nid = nid;
>  	jack->type = type;
>  
> -	return snd_jack_new(codec->bus->card, name, type, &jack->jack);
> +	err = snd_jack_new(codec->bus->card, name, type, &jack->jack);
> +	if (err < 0)
> +		return err;
> +	jack->jack->private_data = jack;
> +	jack->jack->private_free = conexant_free_jack_priv;
> +	return 0;
>  }
>  
>  static void conexant_report_jack(struct hda_codec *codec, hda_nid_t nid)
> @@ -455,8 +468,10 @@ static void conexant_free(struct hda_codec *codec)
>  	if (spec->jacks.list) {
>  		struct conexant_jack *jacks = spec->jacks.list;
>  		int i;
> -		for (i = 0; i < spec->jacks.used; i++)
> -			snd_device_free(codec->bus->card, &jacks[i].jack);
> +		for (i = 0; i < spec->jacks.used; i++, jacks++) {
> +			if (jacks->jack)
> +				snd_device_free(codec->bus->card, jacks->jack);
> +		}
>  		snd_array_free(&spec->jacks);
>  	}
>  #endif
> diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
> index 61996a2..ce30b45 100644
> --- a/sound/pci/hda/patch_sigmatel.c
> +++ b/sound/pci/hda/patch_sigmatel.c
> @@ -3851,6 +3851,15 @@ static void stac_gpio_set(struct hda_codec *codec, unsigned int mask,
>  			   AC_VERB_SET_GPIO_DATA, gpiostate); /* sync */
>  }
>  
> +#ifdef CONFIG_SND_JACK
> +static void stac92xx_free_jack_priv(struct snd_jack *jack)
> +{
> +	struct sigmatel_jack *jacks = jack->private_data;
> +	jacks->nid = 0;
> +	jacks->jack = NULL;
> +}
> +#endif
> +
>  static int stac92xx_add_jack(struct hda_codec *codec,
>  		hda_nid_t nid, int type)
>  {
> @@ -3860,6 +3869,7 @@ static int stac92xx_add_jack(struct hda_codec *codec,
>  	int def_conf = snd_hda_codec_get_pincfg(codec, nid);
>  	int connectivity = get_defcfg_connect(def_conf);
>  	char name[32];
> +	int err;
>  
>  	if (connectivity && connectivity != AC_JACK_PORT_FIXED)
>  		return 0;
> @@ -3876,10 +3886,15 @@ static int stac92xx_add_jack(struct hda_codec *codec,
>  		snd_hda_get_jack_connectivity(def_conf),
>  		snd_hda_get_jack_location(def_conf));
>  
> -	return snd_jack_new(codec->bus->card, name, type, &jack->jack);
> -#else
> -	return 0;
> +	err = snd_jack_new(codec->bus->card, name, type, &jack->jack);
> +	if (err < 0) {
> +		jack->nid = 0;
> +		return err;
> +	}
> +	jack->jack->private_data = jack;
> +	jack->jack->private_free = stac92xx_free_jack_priv;
>  #endif
> +	return 0;
>  }
>  
>  static int stac_add_event(struct sigmatel_spec *spec, hda_nid_t nid,
> @@ -4138,8 +4153,10 @@ static void stac92xx_free_jacks(struct hda_codec *codec)
>  	if (!codec->bus->shutdown && spec->jacks.list) {
>  		struct sigmatel_jack *jacks = spec->jacks.list;
>  		int i;
> -		for (i = 0; i < spec->jacks.used; i++)
> -			snd_device_free(codec->bus->card, &jacks[i].jack);
> +		for (i = 0; i < spec->jacks.used; i++, jacks++) {
> +			if (jacks->jack)
> +				snd_device_free(codec->bus->card, jacks->jack);
> +		}
>  	}
>  	snd_array_free(&spec->jacks);
>  #endif
