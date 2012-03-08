From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] Initialize volumes of HD-audio slave ctls
Date: Fri, 09 Mar 2012 00:55:53 +0100
Message-ID: <4F594709.6090303@canonical.com>
References: <s5haa3ryuxb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 8793710BB40
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 00:55:56 +0100 (CET)
In-Reply-To: <s5haa3ryuxb.wl%tiwai@suse.de>
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

On 03/08/2012 04:27 PM, Takashi Iwai wrote:
> Hi,
>
> the patch below is an attempt to initialize the volume / mutes of
> slave controls (such as "Headphone", "Speaker") with vmaster in
> HD-audio, so that the sound can come out only by changing the master
> volume/mute.
>
> We have thought that such initializations could be done well in
> alsactl init, but it seems that not everyone installs the latest and
> greatest alsactl, and there is always a risk that any new controls may
> be added before alsactl is updated and released.  Since the master
> volume is set muted, the risk by this change should be low.
>
> patch_cirrus.c still doesn't support this because it's handling
> vmaster by itself, but it can be fixed later, too.
>
> If anyone has a concern by this, please let me know.

I think it is good to initialise the volume controls to a sane value in 
general. I guess the risk of causing unnecessary pops is possible, but 
not common.

I'm a little surprised by the implementation though; partly because the 
functions added to hda_codec.c does not seem to be HDA specific, partly 
by the need to mess around with set_fs. I trust you to know what you're 
doing w r t to the set_fs stuff, but maybe it would be more elegant if 
these functions could be in the core and either using, or together with, 
other functions that need to do set_fs to read/write TLV information?

Another thought is whether you need to do snd_ctl_notify or if that is 
handled automatically inside kctl->put. Or if you're just counting on 
nobody to listen at that point.

>
>
> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> index 0527ae1..d4736b9 100644
> --- a/sound/pci/hda/hda_codec.c
> +++ b/sound/pci/hda/hda_codec.c
> @@ -19,6 +19,7 @@
>    *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
>    */
>
> +#include<linux/mm.h>
>   #include<linux/init.h>
>   #include<linux/delay.h>
>   #include<linux/slab.h>
> @@ -2340,6 +2341,52 @@ static int check_slave_present(void *data, struct snd_kcontrol *sctl)
>   	return 1;
>   }
>
> +static int get_kctl_0dB_offset(struct snd_kcontrol *kctl)
> +{
> +	mm_segment_t fs;
> +	int _tlv[4];
> +	const int *tlv = NULL;
> +	int val = -1;
> +
> +	fs = get_fs();
> +	set_fs(get_ds());
> +	if (kctl->vd[0].access&  SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
> +		if (!kctl->tlv.c(kctl, 0, sizeof(_tlv), _tlv))
> +			tlv = _tlv;
> +	} else if (kctl->vd[0].access&  SNDRV_CTL_ELEM_ACCESS_TLV_READ)
> +		tlv = kctl->tlv.p;
> +	if (tlv&&  tlv[0] == SNDRV_CTL_TLVT_DB_SCALE)
> +		val = -tlv[2] / tlv[3];
> +	set_fs(fs);
> +	return val;
> +}
> +
> +static int put_kctl_with_value(struct snd_kcontrol *kctl, int val)
> +{
> +	struct snd_ctl_elem_value *ucontrol;
> +	ucontrol = kzalloc(sizeof(*ucontrol), GFP_KERNEL);
> +	if (!ucontrol)
> +		return -ENOMEM;
> +	ucontrol->value.integer.value[0] = val;
> +	ucontrol->value.integer.value[1] = val;
> +	kctl->put(kctl, ucontrol);
> +	kfree(ucontrol);
> +	return 0;
> +}
> +
> +static int init_slave_0dB(void *data, struct snd_kcontrol *slave)
> +{
> +	int offset = get_kctl_0dB_offset(slave);
> +	if (offset>  0)
> +		put_kctl_with_value(slave, offset);
> +	return 0;
> +}
> +
> +static int init_slave_unmute(void *data, struct snd_kcontrol *slave)
> +{
> +	return put_kctl_with_value(slave, 1);
> +}
> +
>   /**
>    * snd_hda_add_vmaster - create a virtual master control and add slaves
>    * @codec: HD-audio codec
> @@ -2347,6 +2394,7 @@ static int check_slave_present(void *data, struct snd_kcontrol *sctl)
>    * @tlv: TLV data (optional)
>    * @slaves: slave control names (optional)
>    * @suffix: suffix string to each slave name (optional)
> + * @init_slave_vol: initialize slaves to unmute/0dB
>    *
>    * Create a virtual master control with the given name.  The TLV data
>    * must be either NULL or a valid data.
> @@ -2357,9 +2405,9 @@ static int check_slave_present(void *data, struct snd_kcontrol *sctl)
>    *
>    * This function returns zero if successful or a negative error code.
>    */
> -int snd_hda_add_vmaster(struct hda_codec *codec, char *name,
> +int __snd_hda_add_vmaster(struct hda_codec *codec, char *name,
>   			unsigned int *tlv, const char * const *slaves,
> -			const char *suffix)
> +			const char *suffix, bool init_slave_vol)
>   {
>   	struct snd_kcontrol *kctl;
>   	int err;
> @@ -2380,9 +2428,16 @@ int snd_hda_add_vmaster(struct hda_codec *codec, char *name,
>   			 (map_slave_func_t)snd_ctl_add_slave, kctl);
>   	if (err<  0)
>   		return err;
> +
> +	/* init with master mute&  zero volume */
> +	put_kctl_with_value(kctl, 0);
> +	if (init_slave_vol)
> +		map_slaves(codec, slaves, suffix,
> +			   tlv ? init_slave_0dB : init_slave_unmute, kctl);
> +
>   	return 0;
>   }
> -EXPORT_SYMBOL_HDA(snd_hda_add_vmaster);
> +EXPORT_SYMBOL_HDA(__snd_hda_add_vmaster);
>
>   /**
>    * snd_hda_mixer_amp_switch_info - Info callback for a standard AMP mixer switch
> diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
> index 6094dea8..caa6468 100644
> --- a/sound/pci/hda/hda_local.h
> +++ b/sound/pci/hda/hda_local.h
> @@ -139,9 +139,11 @@ void snd_hda_set_vmaster_tlv(struct hda_codec *codec, hda_nid_t nid, int dir,
>   			     unsigned int *tlv);
>   struct snd_kcontrol *snd_hda_find_mixer_ctl(struct hda_codec *codec,
>   					    const char *name);
> -int snd_hda_add_vmaster(struct hda_codec *codec, char *name,
> +int __snd_hda_add_vmaster(struct hda_codec *codec, char *name,
>   			unsigned int *tlv, const char * const *slaves,
> -			const char *suffix);
> +			const char *suffix, bool init_slave_vol);
> +#define snd_hda_add_vmaster(codec, name, tlv, slaves, suffix) \
> +	__snd_hda_add_vmaster(codec, name, tlv, slaves, suffix, true)
>   int snd_hda_codec_reset(struct hda_codec *codec);
>
>   /* amp value bits */
> diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
> index 9771b07..f450f2a 100644
> --- a/sound/pci/hda/patch_analog.c
> +++ b/sound/pci/hda/patch_analog.c
> @@ -82,6 +82,7 @@ struct ad198x_spec {
>   	unsigned int inv_jack_detect: 1;/* inverted jack-detection */
>   	unsigned int inv_eapd: 1;	/* inverted EAPD implementation */
>   	unsigned int analog_beep: 1;	/* analog beep input present */
> +	unsigned int avoid_init_slave_vol:1;
>
>   #ifdef CONFIG_SND_HDA_POWER_SAVE
>   	struct hda_loopback_check loopback;
> @@ -223,11 +224,12 @@ static int ad198x_build_controls(struct hda_codec *codec)
>   		unsigned int vmaster_tlv[4];
>   		snd_hda_set_vmaster_tlv(codec, spec->vmaster_nid,
>   					HDA_OUTPUT, vmaster_tlv);
> -		err = snd_hda_add_vmaster(codec, "Master Playback Volume",
> +		err = __snd_hda_add_vmaster(codec, "Master Playback Volume",
>   					  vmaster_tlv,
>   					  (spec->slave_vols ?
>   					   spec->slave_vols : ad_slave_pfxs),
> -					  "Playback Volume");
> +					  "Playback Volume",
> +					  !spec->avoid_init_slave_vol);
>   		if (err<  0)
>   			return err;
>   	}
> @@ -3604,6 +3606,7 @@ static int patch_ad1884(struct hda_codec *codec)
>   	spec->vmaster_nid = 0x04;
>   	/* we need to cover all playback volumes */
>   	spec->slave_vols = ad1884_slave_vols;
> +	spec->avoid_init_slave_vol = 1;
>
>   	codec->patch_ops = ad198x_patch_ops;
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
