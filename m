From: Peter Good <psgood@petesinternet.net>
Subject: [Fwd: Re: [PATCH] cs46xx DAC volume's mechanism
	rewrite, minor bugfixes]
Date: 11 Nov 2002 09:53:58 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1036972438.4956.0.camel@pete>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-2ckRwXbUca+MEa7cdTBg"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-2ckRwXbUca+MEa7cdTBg
Content-Type: multipart/mixed; boundary="=-8NcmFMmRAbm0wXYxH7we"


--=-8NcmFMmRAbm0wXYxH7we
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Dammit, forgot to cc to here heh.
--=20
"I am neither especially clever nor especially=20
gifted. I am only very, very curious." Einstein.

Peter Good
Pete's Internet Services
GnuPG Public Key: http://www.petesinternet.net/public.gpg

--=-8NcmFMmRAbm0wXYxH7we
Content-Disposition: inline
Content-Description: Forwarded message - Re: [Alsa-devel] [PATCH] cs46xx DAC
	volume's mechanism rewrite, minor bugfixes
Content-Type: message/rfc822

Subject: Re: [Alsa-devel] [PATCH] cs46xx DAC volume's mechanism rewrite,
	minor bugfixes
From: Peter Good <psgood@petesinternet.net>
To: Benny Sjostrand <gorm@cucumelo.org>
In-Reply-To: <3DCEB5A4.4090600@cucumelo.org>
References: <3DCEB5A4.4090600@cucumelo.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-e8wWEcY/KF8PcGED2oBm"
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Nov 2002 09:15:23 +1000
Message-Id: <1036970123.25555.3.camel@pete>
Mime-Version: 1.0


--=-e8wWEcY/KF8PcGED2oBm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Ok, that's fixed the bass problem I had here.
One thing though. Benny, do you have any idea what these values "should"
be?

iec958:AES0=3D0x6,AES1=3D0x82,AES2=3D0x0,AES3=3D0x2

Now that's what xine gives me, but, I know that can be reset via xine's
config file. mplayer on the other hand gives this.

alsa-init: testing and bugreports are welcome.
alsa-init: requested format: 48000 Hz, 2 channels, AC3
alsa-init: compiled for ALSA-0.9.0rc5
alsa-spdif-init: playing AC3, 2 channels
alsa-init: soundcard set to iec958:AES0=3D0x2,AES1=3D0x82,AES2=3D0x0,AES3=
=3D0x2
ALSA lib pcm.c:1719:(snd_pcm_open_conf) Invalid type for PCM
iec958:AES0=3D0x2,AES1=3D0x82,AES2=3D0x0,AES3=3D0x2 definition (id: iec958,
value: cards.pcm.iec958)
alsa-init: playback open error: Invalid argument
couldn't open/init audio device -> NOSOUND

hehe, any ideas on what the values should be would be appreciated.

Peter


On Mon, 2002-11-11 at 05:38, Benny Sjostrand wrote:
> Hi!
>=20
> This patch changes the way the DAC volume are set on DSP SCB tasks. I=20
> would like to know
> if maybe this fixes the "bass"  problem that some users have experienced=20
> with the cs46xx driver.
>=20
> Still some more attempts to have AC3 through IEC958, but no success yet .=
..
>=20
> Summary:
> - DAC volume mechanism  rewrite (added cs46xx_dsp_set_dac_volume (...)=20
> in dsp_spos.c)
> - IEC958 input volume mechanism rewrite (added=20
> cs46xx_dsp_set_iec958_volume (...) in dsp_spos.c)
> - Enable IEC958 hw if not done in cs46xx_iec958_pre_open (...)
> - Added "AC3 Mode Switch" in mixer, when enabled appropiate status
> bit's (non-audio, profesional) are set in IEC958 stream and PCM channel=20
> is locked to 48Khz
> - Typo fix in constant name DSP_SDPIF... -> DSP_SPDIF...
> - Some code cleanups
>=20
> /Benny
> ----
>=20

> diff --exclude=3DMakefile --exclude=3DCVS -Naur alsa-kernel/include/cs46x=
x_dsp_spos.h ../cvs/alsa-kernel/include/cs46xx_dsp_spos.h
> --- alsa-kernel/include/cs46xx_dsp_spos.h	Mon Nov  4 19:49:48 2002
> +++ ../cvs/alsa-kernel/include/cs46xx_dsp_spos.h	Sun Nov 10 14:35:17 2002
> @@ -60,9 +60,10 @@
>  #define DSP_PCM_LFE_CHANNEL     4
>  #define DSP_IEC958_CHANNEL      5
> =20
> -#define DSP_SDPIF_STATUS_OUTPUT_ENABLED 1
> -#define DSP_SDPIF_STATUS_PLAYBACK_OPEN  2
> -#define DSP_SDPIF_STATUS_HW_ENABLED     4
> +#define DSP_SPDIF_STATUS_OUTPUT_ENABLED 1
> +#define DSP_SPDIF_STATUS_PLAYBACK_OPEN  2
> +#define DSP_SPDIF_STATUS_HW_ENABLED     4
> +#define DSP_SPDIF_STATUS_AC3_MODE       8
> =20
>  struct _dsp_module_desc_t;
> =20
> @@ -155,6 +156,8 @@
> =20
>  	/* Main PCM playback mixer */
>  	dsp_scb_descriptor_t * master_mix_scb;
> +	u16 dac_volume_right;
> +	u16 dac_volume_left;
> =20
>  	/* Rear PCM playback mixer */
>  	dsp_scb_descriptor_t * rear_mix_scb;
> @@ -191,7 +194,8 @@
>  	/* SPDIF status */
>  	int spdif_status_out;
>  	int spdif_status_in;
> -	u32 spdif_input_volume;
> +	u16 spdif_input_volume_right;
> +	u16 spdif_input_volume_left;
> =20
>  	/* SPDIF input sample rate converter */
>  	dsp_scb_descriptor_t * spdif_in_src;
> @@ -221,4 +225,3 @@
>  } dsp_spos_instance_t;
> =20
>  #endif /* __DSP_SPOS_H__ */
> -
> diff --exclude=3DMakefile --exclude=3DCVS -Naur alsa-kernel/pci/cs46xx/cs=
46xx_lib.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c
> --- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Mon Nov  4 19:49:57 2002
> +++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Sun Nov 10 15:10:22 2002
> @@ -952,7 +952,9 @@
>  			snd_cs46xx_playback_transfer(substream, 0);
> =20
>  		/* raise playback volume */
> -		snd_cs46xx_poke(chip, (cpcm->pcm_channel->pcm_reader_scb->address + 0x=
E) << 2, 0x80008000);
> +		cs46xx_dsp_scb_set_volume (chip,cpcm->pcm_channel->pcm_reader_scb,
> +					   chip->dsp_spos_instance->dac_volume_right,
> +					   chip->dsp_spos_instance->dac_volume_left);
>  #else
>  		if (substream->runtime->periods !=3D CS46XX_FRAGS)
>  			snd_cs46xx_playback_transfer(substream, 0);
> @@ -966,8 +968,9 @@
>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  #ifdef CONFIG_SND_CS46XX_NEW_DSP
> -        /* mute channel */
> -		snd_cs46xx_poke(chip, (cpcm->pcm_channel->pcm_reader_scb->address + 0x=
E) << 2, 0xffffffff);
> +		/* mute channel */
> +		cs46xx_dsp_scb_set_volume (chip,cpcm->pcm_channel->pcm_reader_scb,0,0)=
;
> +
>  		if (!cpcm->pcm_channel->unlinked)
>  			cs46xx_dsp_pcm_unlink(chip,cpcm->pcm_channel);
>  #else
> @@ -1020,36 +1023,27 @@
>  	return result;
>  }
> =20
> -static int snd_cs46xx_playback_hw_params(snd_pcm_substream_t * substream=
,
> -					 snd_pcm_hw_params_t * hw_params)
> +static int _cs46xx_adjust_sample_rate (cs46xx_t *chip, cs46xx_pcm_t *cpc=
m,
> +				       int sample_rate)=20
>  {
> -	/*cs46xx_t *chip =3D snd_pcm_substream_chip(substream);*/
> -	snd_pcm_runtime_t *runtime =3D substream->runtime;
> -	cs46xx_pcm_t *cpcm;
> -	int err;
> -	cs46xx_t *chip =3D snd_pcm_substream_chip(substream);
> -	int sample_rate =3D params_rate(hw_params);
> -	int period_size =3D params_period_size(hw_params);
> -	cpcm =3D snd_magic_cast(cs46xx_pcm_t, runtime->private_data, return -EN=
XIO);
> -
> -#ifdef CONFIG_SND_CS46XX_NEW_DSP
> -	down (&chip->spos_mutex);
> -
> -	snd_assert (cpcm->pcm_channel !=3D NULL);
> -
> +	/* if this is the only PCMReaderSCB child under current
> +	   SrcTask then there no need to re-create pcm-channel */
>  	if ( cpcm->pcm_channel->src_scb->ref_count =3D=3D 1 &&
>  	     cpcm->pcm_channel->sample_rate !=3D sample_rate &&
>  	     /* never set a 0 khz sample rate */
>  	     sample_rate) {
>  		/* sample rate not set or we can reuse
>  		   the same SRC*/
> -
>  		cs46xx_dsp_set_src_sample_rate (chip,cpcm->pcm_channel->src_scb,sample=
_rate);
>  		cpcm->pcm_channel->sample_rate =3D sample_rate;
>  	}=20
> =20
> -	if (cpcm->pcm_channel->sample_rate !=3D runtime->rate &&
> -	    cpcm->pcm_channel->src_scb->ref_count !=3D 1) {
> +	/* if there is more then 1 PCMReaderSCB child's under current
> +	   SrcTask then we must recreate channel */
> +	if (cpcm->pcm_channel->sample_rate !=3D sample_rate &&
> +	    cpcm->pcm_channel->src_scb->ref_count !=3D 1 &&
> +	    /* never set a 0 khz sample rate */
> +	    sample_rate) {
>  		int unlinked =3D cpcm->pcm_channel->unlinked;
>  		cs46xx_dsp_destroy_pcm_channel (chip,cpcm->pcm_channel);
> =20
> @@ -1065,6 +1059,34 @@
>  		cpcm->pcm_channel->sample_rate =3D sample_rate;
>  	}
> =20
> +	return 0;
> +}
> +static int snd_cs46xx_playback_hw_params(snd_pcm_substream_t * substream=
,
> +					 snd_pcm_hw_params_t * hw_params)
> +{
> +	/*cs46xx_t *chip =3D snd_pcm_substream_chip(substream);*/
> +	snd_pcm_runtime_t *runtime =3D substream->runtime;
> +	cs46xx_pcm_t *cpcm;
> +	int err;
> +	cs46xx_t *chip =3D snd_pcm_substream_chip(substream);
> +	int sample_rate =3D params_rate(hw_params);
> +	int period_size =3D params_period_size(hw_params);
> +	cpcm =3D snd_magic_cast(cs46xx_pcm_t, runtime->private_data, return -EN=
XIO);
> +
> +#ifdef CONFIG_SND_CS46XX_NEW_DSP
> +	down (&chip->spos_mutex);
> +
> +	snd_assert (cpcm->pcm_channel !=3D NULL);
> +
> +	/* if IEC958 is opened in AC3 mode dont adjust SRCTask is not
> +	   used so dont adjust sample rate */
> +	if (cpcm->pcm_channel->pcm_channel_id !=3D DSP_IEC958_CHANNEL ||
> +	    !(chip->dsp_spos_instance->spdif_status_out & DSP_SPDIF_STATUS_AC3_=
MODE)) {
> +		if (_cs46xx_adjust_sample_rate (chip,cpcm,sample_rate)) {
> +			return -ENXIO;
> +		}
> +	}
> +
>  	if (cs46xx_dsp_pcm_channel_set_period (chip,cpcm->pcm_channel,period_si=
ze * 4)) {
>  		 up (&chip->spos_mutex);
>  		 return -EINVAL;
> @@ -1825,7 +1847,7 @@
>  	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_INTEGER;
>  	uinfo->count =3D 2;
>  	uinfo->value.integer.min =3D 0;
> -	uinfo->value.integer.max =3D 32767;
> +	uinfo->value.integer.max =3D 0x7fff;
>  	return 0;
>  }
> =20
> @@ -1847,26 +1869,9 @@
>  			    (0xffff - ucontrol->value.integer.value[1]));
>  	unsigned int old =3D snd_cs46xx_peek(chip, reg);
>  	int change =3D (old !=3D val);
> +
>  	if (change) {
>  		snd_cs46xx_poke(chip, reg, val);
> -#ifdef CONFIG_SND_CS46XX_NEW_DSP
> -		/* NOTE: this updates the current left and right volume
> -		   that should be automatically updated by the DSP and
> -		   not touched by the host. But for some strange reason
> -		   the DSP only updates the right channel volume, so with
> -		   this dirty hack we force updating the right and left
> -		   channel volume.=20
> -		*/
> -		snd_cs46xx_poke(chip, reg + 4, val);
> -
> -		/* shadow the SPDIF input volume */
> -		if (reg =3D=3D (ASYNCRX_SCB_ADDR + 0xE) << 2) {
> -			/* FIXME: I known this is uggly ...
> -			   any other suggestion ?=20
> -			*/
> -			chip->dsp_spos_instance->spdif_input_volume =3D val;
> -		}
> -#endif
>  	}
> =20
>  	return change;
> @@ -1874,6 +1879,57 @@
> =20
>  #ifdef CONFIG_SND_CS46XX_NEW_DSP
> =20
> +static int snd_cs46xx_vol_dac_get(snd_kcontrol_t * kcontrol, snd_ctl_ele=
m_value_t * ucontrol)
> +{
> +	cs46xx_t *chip =3D snd_kcontrol_chip(kcontrol);
> +
> +	ucontrol->value.integer.value[0] =3D chip->dsp_spos_instance->dac_volum=
e_right;
> +	ucontrol->value.integer.value[1] =3D chip->dsp_spos_instance->dac_volum=
e_left;
> +
> +	return 0;
> +}
> +
> +static int snd_cs46xx_vol_dac_put(snd_kcontrol_t * kcontrol, snd_ctl_ele=
m_value_t * ucontrol)
> +{
> +	cs46xx_t *chip =3D snd_kcontrol_chip(kcontrol);
> +	int change =3D 0;
> +
> +	if (chip->dsp_spos_instance->dac_volume_right !=3D ucontrol->value.inte=
ger.value[0] ||
> +	    chip->dsp_spos_instance->dac_volume_left !=3D ucontrol->value.integ=
er.value[1]) {
> +		cs46xx_dsp_set_dac_volume(chip,
> +					  ucontrol->value.integer.value[0],
> +					  ucontrol->value.integer.value[1]);
> +		change =3D 1;
> +	}
> +
> +	return change;
> +}
> +
> +static int snd_cs46xx_vol_iec958_get(snd_kcontrol_t * kcontrol, snd_ctl_=
elem_value_t * ucontrol)
> +{
> +	cs46xx_t *chip =3D snd_kcontrol_chip(kcontrol);
> +
> +	ucontrol->value.integer.value[0] =3D chip->dsp_spos_instance->spdif_inp=
ut_volume_right;
> +	ucontrol->value.integer.value[1] =3D chip->dsp_spos_instance->spdif_inp=
ut_volume_left;
> +	return 0;
> +}
> +
> +static int snd_cs46xx_vol_iec958_put(snd_kcontrol_t * kcontrol, snd_ctl_=
elem_value_t * ucontrol)
> +{
> +	cs46xx_t *chip =3D snd_kcontrol_chip(kcontrol);
> +	int change =3D 0;
> +
> +	if (chip->dsp_spos_instance->spdif_input_volume_right !=3D ucontrol->va=
lue.integer.value[0] ||
> +	    chip->dsp_spos_instance->spdif_input_volume_left !=3D ucontrol->val=
ue.integer.value[1]) {
> +		cs46xx_dsp_set_iec958_volume (chip,
> +					      ucontrol->value.integer.value[0],
> +					      ucontrol->value.integer.value[1]);
> +		change =3D 1;
> +	}
> +
> +	return change;
> +}
> +
>  static int snd_mixer_boolean_info(snd_kcontrol_t *kcontrol,=20
>  				  snd_ctl_elem_info_t *uinfo)
>  {
> @@ -1891,7 +1947,7 @@
>  	int reg =3D kcontrol->private_value;
> =20
>  	if (reg =3D=3D CS46XX_MIXER_SPDIF_OUTPUT_ELEMENT)
> -		ucontrol->value.integer.value[0] =3D (chip->dsp_spos_instance->spdif_s=
tatus_out & DSP_SDPIF_STATUS_OUTPUT_ENABLED);
> +		ucontrol->value.integer.value[0] =3D (chip->dsp_spos_instance->spdif_s=
tatus_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED);
>  	else
>  		ucontrol->value.integer.value[0] =3D chip->dsp_spos_instance->spdif_st=
atus_in;
> =20
> @@ -1907,13 +1963,13 @@
>  	switch (kcontrol->private_value) {
>  	case CS46XX_MIXER_SPDIF_OUTPUT_ELEMENT:
>  		down (&chip->spos_mutex);
> -		change =3D (chip->dsp_spos_instance->spdif_status_out & DSP_SDPIF_STAT=
US_OUTPUT_ENABLED);
> +		change =3D (chip->dsp_spos_instance->spdif_status_out & DSP_SPDIF_STAT=
US_OUTPUT_ENABLED);
>  		if (ucontrol->value.integer.value[0] && !change)=20
>  			cs46xx_dsp_enable_spdif_out(chip);
>  		else if (change && !ucontrol->value.integer.value[0])
>  			cs46xx_dsp_disable_spdif_out(chip);
> =20
> -		res =3D (change !=3D (chip->dsp_spos_instance->spdif_status_out & DSP_=
SDPIF_STATUS_OUTPUT_ENABLED));
> +		res =3D (change !=3D (chip->dsp_spos_instance->spdif_status_out & DSP_=
SPDIF_STATUS_OUTPUT_ENABLED));
>  		up (&chip->spos_mutex);
>  		break;
>  	case CS46XX_MIXER_SPDIF_INPUT_ELEMENT:
> @@ -1979,6 +2035,35 @@
>  	return 0;
>  }
> =20
> +static int snd_cs46xx_iec958_ac3_mode_get(snd_kcontrol_t *kcontrol,=20
> +					  snd_ctl_elem_value_t *ucontrol)=20
> +{
> +	cs46xx_t *chip =3D snd_kcontrol_chip(kcontrol);
> +	dsp_spos_instance_t * ins =3D chip->dsp_spos_instance;
> +
> +	if (!ins->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE)=20
> +		ucontrol->value.integer.value[0] =3D 1;
> +	else
> +		ucontrol->value.integer.value[0] =3D 0;
> +
> +	return 0;
> +}
> +
> +static int snd_cs46xx_iec958_ac3_mode_put(snd_kcontrol_t *kcontrol,=20
> +                                      snd_ctl_elem_value_t *ucontrol)=20
> +{
> +	cs46xx_t *chip =3D snd_kcontrol_chip(kcontrol);
> +	dsp_spos_instance_t * ins =3D chip->dsp_spos_instance;
> +	int old =3D ins->spdif_status_out;
> +
> +	if (ucontrol->value.integer.value[0])=20
> +		ins->spdif_status_out |=3D DSP_SPDIF_STATUS_AC3_MODE;
> +	else
> +		ins->spdif_status_out &=3D ~DSP_SPDIF_STATUS_AC3_MODE;
> +
> +	return (old !=3D ins->spdif_status_out);
> +}
> +
>  static int snd_cs46xx_pcm_capture_put(snd_kcontrol_t *kcontrol,=20
>                                        snd_ctl_elem_value_t *ucontrol)
>  {
> @@ -2013,7 +2098,7 @@
>  }
> =20
>  /*
> - *	Game Theatre XP card - EGPIO[0] is used to select SDPIF input optical=
 or coaxial.
> + *	Game Theatre XP card - EGPIO[0] is used to select SPDIF input optical=
 or coaxial.
>   */=20
>  static int snd_herc_spdif_select_put(snd_kcontrol_t *kcontrol,=20
>                                         snd_ctl_elem_value_t *ucontrol)
> @@ -2111,13 +2196,13 @@
>  	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
>  	.name =3D "DAC Volume",
>  	.info =3D snd_cs46xx_vol_info,
> +#ifndef CONFIG_SND_CS46XX_NEW_DSP
>  	.get =3D snd_cs46xx_vol_get,
>  	.put =3D snd_cs46xx_vol_put,
> -
> -#ifndef CONFIG_SND_CS46XX_NEW_DSP
>  	.private_value =3D BA1_PVOL,
>  #else
> -	.private_value =3D (MASTERMIX_SCB_ADDR + 0xE) << 2,
> +	.get =3D snd_cs46xx_vol_dac_get,
> +	.put =3D snd_cs46xx_vol_dac_put,
>  #endif
>  },
> =20
> @@ -2158,6 +2243,13 @@
>  },
>  {
>  	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name =3D "IEC 958 AC3 Mode Switch",
> +	.info =3D snd_mixer_boolean_info,
> +	.get =3D snd_cs46xx_iec958_ac3_mode_get,
> +	.put =3D snd_cs46xx_iec958_ac3_mode_put,
> +},
> +{
> +	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
>  	.name =3D "IEC 958 Input Switch",
>  	.info =3D snd_mixer_boolean_info,
>  	.get =3D snd_cs46xx_iec958_get,
> @@ -2168,8 +2260,8 @@
>  	.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
>  	.name =3D "IEC 958 Input Volume",
>  	.info =3D snd_cs46xx_vol_info,
> -	.get =3D snd_cs46xx_vol_get,
> -	.put =3D snd_cs46xx_vol_put,
> +	.get =3D snd_cs46xx_vol_iec958_get,
> +	.put =3D snd_cs46xx_vol_iec958_put,
>  	.private_value =3D (ASYNCRX_SCB_ADDR + 0xE) << 2,
>  },
>  #endif
> diff --exclude=3DMakefile --exclude=3DCVS -Naur alsa-kernel/pci/cs46xx/cs=
46xx_lib.h ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h
> --- alsa-kernel/pci/cs46xx/cs46xx_lib.h	Mon Nov  4 19:49:57 2002
> +++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h	Sun Nov 10 02:18:12 2002
> @@ -217,4 +217,6 @@
>  							       int period_size);
>  int                        cs46xx_dsp_pcm_ostream_set_period (cs46xx_t *=
 chip,
>  							      int period_size);
> +int                        cs46xx_dsp_set_dac_volume (cs46xx_t * chip,u1=
6 right,u16 left);
> +int                        cs46xx_dsp_set_iec958_volume (cs46xx_t * chip=
,u16 right,u16 left);
>  #endif /* __CS46XX_LIB_H__ */
> diff --exclude=3DMakefile --exclude=3DCVS -Naur alsa-kernel/pci/cs46xx/ds=
p_spos.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c
> --- alsa-kernel/pci/cs46xx/dsp_spos.c	Mon Nov  4 19:49:57 2002
> +++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c	Sun Nov 10 14:37:34 2002
> @@ -257,7 +257,10 @@
>  	ins->spdif_in_sample_rate =3D 48000;
> =20
>  	/* maximize volume */
> -	ins->spdif_input_volume =3D 0x80008000;
> +	ins->dac_volume_right =3D 0x8000;
> +	ins->dac_volume_left =3D 0x8000;
> +	ins->spdif_input_volume_right =3D 0x8000;
> +	ins->spdif_input_volume_left =3D 0x8000;
> =20
>  	return ins;
>  }
> @@ -1549,7 +1552,7 @@
>  	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 <=
< 12));
> =20
>  	/* monitor state */
> -	ins->spdif_status_out |=3D DSP_SDPIF_STATUS_HW_ENABLED;
> +	ins->spdif_status_out |=3D DSP_SPDIF_STATUS_HW_ENABLED;
> =20
>  	return 0;
>  }
> @@ -1585,8 +1588,10 @@
>  	cs46xx_src_link(chip,ins->spdif_in_src);
> =20
>  	/* restore SPDIF input volume */
> -	snd_cs46xx_poke(chip, (ASYNCRX_SCB_ADDR + 0xE) << 2, ins->spdif_input_v=
olume);
> -	snd_cs46xx_poke(chip, (ASYNCRX_SCB_ADDR + 0xF) << 2, ins->spdif_input_v=
olume);
> +	cs46xx_dsp_scb_set_volume (chip,ins->spdif_in_src,
> +				   ins->spdif_input_volume_right,
> +				   ins->spdif_input_volume_left);
> +
>  	spin_unlock_irq(&chip->reg_lock);
> =20
>  	/* set SPDIF input sample rate and unmute
> @@ -1716,6 +1721,44 @@
>  		snd_printk(KERN_ERR "dsp_spos: SPIOWriteTask not responding\n");
>  		return -EBUSY;
>  	}
> +
> +	return 0;
> +}
> +
> +int cs46xx_dsp_set_dac_volume (cs46xx_t * chip,u16 right,u16 left)
> +{
> +	int i;
> +	dsp_spos_instance_t * ins =3D chip->dsp_spos_instance;
> +
> +	down(&chip->spos_mutex);
> +
> +	ins->dac_volume_right =3D right;
> +	ins->dac_volume_left =3D left;
> +
> +	for (i =3D 0; i < DSP_MAX_PCM_CHANNELS; ++i) {
> +		if (ins->pcm_channels[i].active &&
> +		    !ins->pcm_channels[i].unlinked) {
> +			cs46xx_dsp_scb_set_volume (chip,ins->pcm_channels[i].pcm_reader_scb,
> +						   right,left);
> +		=09
> +		}
> +	}
> +
> +	up(&chip->spos_mutex);
> +
> +	return 0;
> +}
> +
> +int cs46xx_dsp_set_iec958_volume (cs46xx_t * chip,u16 right,u16 left) {
> +	dsp_spos_instance_t * ins =3D chip->dsp_spos_instance;
> +
> +	down(&chip->spos_mutex);
> +	cs46xx_dsp_scb_set_volume (chip,ins->spdif_in_src,
> +				   right,left);
> +
> +	ins->spdif_input_volume_right =3D right;
> +	ins->spdif_input_volume_left =3D left;
> +	up(&chip->spos_mutex);
> =20
>  	return 0;
>  }
> diff --exclude=3DMakefile --exclude=3DCVS -Naur alsa-kernel/pci/cs46xx/ds=
p_spos.h ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h
> --- alsa-kernel/pci/cs46xx/dsp_spos.h	Mon Nov  4 19:49:57 2002
> +++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h	Sun Nov 10 17:03:50 2002
> @@ -76,6 +76,7 @@
>  #define MIX_SAMPLE_BUF2          0x2D00
>  #define MIX_SAMPLE_BUF3          0x2E00
>  #define MIX_SAMPLE_BUF4          0x2F00
> +#define MIX_SAMPLE_BUF5          0x3000
> =20
>  /* Task stack address */
>  #define HFG_STACK                0x066A
> @@ -127,6 +128,7 @@
>  #define SCBfuncEntryPtr      0xA
>  #define SRCCorPerGof         0x2
>  #define SRCPhiIncr6Int26Frac 0xd
> +#define SCBVolumeCtrl        0xe
> =20
>  /* conf */
>  #define UseASER1Input 1
> @@ -190,6 +192,14 @@
>  			(scb->address + SCBsubListPtr) << 2,
>  			(scb->sub_list_ptr->address << 0x10) |
>  			(scb->next_scb_ptr->address));=09
> +}
> +
> +static inline void cs46xx_dsp_scb_set_volume (cs46xx_t * chip,dsp_scb_de=
scriptor_t * scb,
> +					      u16 right,u16 left) {
> +	unsigned int val =3D ((0xffff - right) << 16 | (0xffff - left));=09
> +
> +	snd_cs46xx_poke(chip, (scb->address + SCBVolumeCtrl) << 2, val);
> +	snd_cs46xx_poke(chip, (scb->address + SCBVolumeCtrl + 1) << 2, val);
>  }
> =20
>  #endif /* __DSP_SPOS_H__ */
> diff --exclude=3DMakefile --exclude=3DCVS -Naur alsa-kernel/pci/cs46xx/ds=
p_spos_scb_lib.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c
> --- alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Mon Nov  4 19:49:57 2002
> +++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Sun Nov 10 17:55:24 =
2002
> @@ -603,7 +603,7 @@
>  		src_buffer_addr << 0x10,
>  		0x04000000,
>  		{=20
> -			0xffff,0xffff,
> +			0x8000,0x8000,
>  			0xffff,0xffff
>  		}
>  	};
> @@ -658,7 +658,7 @@
>  		/* D */ 0,
>  		{
>  			/* E */ 0x8000,0x8000,
> -			/* F */ 0x8000,0x8000
> +			/* F */ 0xffff,0xffff
>  		}
>  	};
> =20
> @@ -825,7 +825,7 @@
>  		0x0058,0x0028,      /* Min Delta 7 dwords =3D=3D 28 bytes */
>  		/* : Max delta 25 dwords =3D=3D 100 bytes */
>  		0,hfg_scb_address,  /* Point to HFG task SCB */
> -		0,0,				/* Initialize current Delta and Consumer ptr adjustment count =
*/
> +		0,0,		    /* Initialize current Delta and Consumer ptr adjustment coun=
t */
>  		0,                  /* Initialize accumulated Phi to 0 */
>  		0,0x2aab,           /* Const 1/3 */
>     =20
> @@ -840,13 +840,13 @@
>     =20
>  		RSCONFIG_SAMPLE_16STEREO + RSCONFIG_MODULO_256, /* Stereo, 256 dword *=
/
>  		(asynch_buffer_address) << 0x10,  /* This should be automagically sync=
hronized
> -                                             to the producer pointer */
> +                                                     to the producer poi=
nter */
>     =20
>  		/* There is no correct initial value, it will depend upon the detected
>  		   rate etc  */
>  		0x18000000,                     /* Phi increment for approx 32k operat=
ion */
>  		0x8000,0x8000,                  /* Volume controls are unused at this =
time */
> -		0x8000,0x8000
> +		0xffff,0xffff
>  	};
>   =20
>  	scb =3D cs46xx_dsp_create_generic_scb(chip,scb_name,(u32 *)&asynch_fg_t=
x_scb,
> @@ -1114,7 +1114,13 @@
>  		snd_assert(0);
>  		break;
>  	case DSP_IEC958_CHANNEL:
> +		snd_assert (ins->asynch_tx_scb !=3D NULL, return NULL);
>  		mixer_scb =3D ins->asynch_tx_scb;
> +		if (ins->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE) {
> +			snd_printdd ("IEC958 opened in AC3 mode\n");
> +			/*src_scb =3D ins->asynch_tx_scb;
> +			  ins->asynch_tx_scb->ref_count ++;*/
> +		}
>  		break;
>  	default:
>  		snd_assert (0);
> @@ -1192,7 +1198,9 @@
>  			return NULL;
>  		}
> =20
> -		cs46xx_dsp_set_src_sample_rate(chip,src_scb,sample_rate);
> +		if (pcm_channel_id !=3D DSP_IEC958_CHANNEL ||
> +		    !(ins->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE))
> +			cs46xx_dsp_set_src_sample_rate(chip,src_scb,sample_rate);
> =20
>  		ins->nsrc_scb ++;
>  	}=20
> @@ -1454,14 +1462,16 @@
>  	spin_lock_irqsave(&chip->reg_lock, flags);
> =20
>  	/* mute SCB */
> -	snd_cs46xx_poke(chip, (src->address + 0xE) << 2, 0xffffffff);
> +	/* cs46xx_dsp_scb_set_volume (chip,src,0,0); */
> +
>  	snd_cs46xx_poke(chip, (src->address + SRCCorPerGof) << 2,
>  	  ((correctionPerSec << 16) & 0xFFFF0000) | (correctionPerGOF & 0xFFFF)=
);
> =20
>  	snd_cs46xx_poke(chip, (src->address + SRCPhiIncr6Int26Frac) << 2, phiIn=
cr);
> =20
>  	/* raise volume */
> -	snd_cs46xx_poke(chip, (src->address + 0xE) << 2, 0x80008000);
> +	/* cs46xx_dsp_scb_set_volume (chip,src,0x7fff,0x7fff); */
> +=09
>  	spin_unlock_irqrestore(&chip->reg_lock, flags);
>  }
> =20
> @@ -1495,7 +1505,7 @@
>  	snd_assert (src->parent_scb_ptr !=3D NULL,  return -EINVAL );
> =20
>  	/* mute SCB */
> -	snd_cs46xx_poke(chip, (src->address + 0xE) << 2, 0xffffffff);
> +	cs46xx_dsp_scb_set_volume (chip,src,0,0);
> =20
>  	_dsp_unlink_scb (chip,src);
> =20
> @@ -1530,16 +1540,16 @@
>  {
>  	dsp_spos_instance_t * ins =3D chip->dsp_spos_instance;
> =20
> -	if ( ! (ins->spdif_status_out & DSP_SDPIF_STATUS_PLAYBACK_OPEN) ) {
> +	if ( ! (ins->spdif_status_out & DSP_SPDIF_STATUS_HW_ENABLED) ) {
>  		cs46xx_dsp_enable_spdif_hw (chip);
>  	}
> =20
>  	/* dont touch anything if SPDIF is open */
> -	if ( ins->spdif_status_out & DSP_SDPIF_STATUS_PLAYBACK_OPEN) {
> +	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) {
>  		/* when cs46xx_iec958_post_close(...) is called it
>  		   will call this function if necesary depending on
>  		   this bit */
> -		ins->spdif_status_out |=3D DSP_SDPIF_STATUS_OUTPUT_ENABLED;
> +		ins->spdif_status_out |=3D DSP_SPDIF_STATUS_OUTPUT_ENABLED;
> =20
>  		return -EBUSY;
>  	}
> @@ -1569,7 +1579,7 @@
>  	if (!ins->spdif_pcm_input_scb) return -ENOMEM;
> =20
>  	/* monitor state */
> -	ins->spdif_status_out |=3D DSP_SDPIF_STATUS_OUTPUT_ENABLED;
> +	ins->spdif_status_out |=3D DSP_SPDIF_STATUS_OUTPUT_ENABLED;
> =20
>  	return 0;
>  }
> @@ -1579,8 +1589,8 @@
>  	dsp_spos_instance_t * ins =3D chip->dsp_spos_instance;
> =20
>  	/* dont touch anything if SPDIF is open */
> -	if ( ins->spdif_status_out & DSP_SDPIF_STATUS_PLAYBACK_OPEN) {
> -		ins->spdif_status_out &=3D ~DSP_SDPIF_STATUS_OUTPUT_ENABLED;
> +	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) {
> +		ins->spdif_status_out &=3D ~DSP_SPDIF_STATUS_OUTPUT_ENABLED;
>  		return -EBUSY;
>  	}
> =20
> @@ -1600,7 +1610,7 @@
>  	_dsp_clear_sample_buffer(chip,SPDIFO_IP_OUTPUT_BUFFER1,256);
> =20
>  	/* monitor state */
> -	ins->spdif_status_out  &=3D ~DSP_SDPIF_STATUS_OUTPUT_ENABLED;
> +	ins->spdif_status_out  &=3D ~DSP_SPDIF_STATUS_OUTPUT_ENABLED;
> =20
> =20
>  	return 0;
> @@ -1610,12 +1620,17 @@
>  {
>  	dsp_spos_instance_t * ins =3D chip->dsp_spos_instance;
> =20
> -	if ( ins->spdif_status_out & DSP_SDPIF_STATUS_OUTPUT_ENABLED ) {
> +	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED ) {
>  		/* remove AsynchFGTxSCB and and PCMSerialInput_II */
>  		cs46xx_dsp_disable_spdif_out (chip);
> =20
>  		/* save state */
> -		ins->spdif_status_out |=3D DSP_SDPIF_STATUS_OUTPUT_ENABLED;
> +		ins->spdif_status_out |=3D DSP_SPDIF_STATUS_OUTPUT_ENABLED;
> +	}
> +=09
> +	/* if not enabled already */
> +	if (ins->spdif_status_out & DSP_SPDIF_STATUS_HW_ENABLED) {
> +		cs46xx_dsp_enable_spdif_hw (chip);
>  	}
> =20
>  	/* Create the asynch. transfer task  for playback */
> @@ -1625,10 +1640,12 @@
>  								ins->master_mix_scb,
>  								SCB_ON_PARENT_NEXT_SCB);
> =20
> -	/* cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 15) |=20
> -	   (1 << 14) | (1 << 2) | (1 << 3)); */
> =20
> -	ins->spdif_status_out  |=3D DSP_SDPIF_STATUS_PLAYBACK_OPEN;
> +	if (ins->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE)=20
> +		/* set left (13), right validity bit (12) , and non-audio(1) and profs=
ional bit (0) */
> +		cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 =
<< 12) | (1 << 1) | 1);
> +
> +	ins->spdif_status_out  |=3D DSP_SPDIF_STATUS_PLAYBACK_OPEN;
> =20
>  	return 0;
>  }
> @@ -1639,16 +1656,17 @@
> =20
>  	snd_assert (ins->asynch_tx_scb !=3D NULL, return -EINVAL);
> =20
> -	ins->spdif_status_out  &=3D ~DSP_SDPIF_STATUS_PLAYBACK_OPEN;
> +	ins->spdif_status_out  &=3D ~DSP_SPDIF_STATUS_PLAYBACK_OPEN;
> =20
> -	/*cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1=
 << 12));*/
> +	/* restore settings */
> +	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 <=
< 12));
>  =09
>  	/* deallocate stuff */
>  	cs46xx_dsp_remove_scb (chip,ins->asynch_tx_scb);
>  	ins->asynch_tx_scb =3D NULL;
> =20
>  	/* restore state */
> -	if ( ins->spdif_status_out & DSP_SDPIF_STATUS_OUTPUT_ENABLED ) {
> +	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED ) {
>  		cs46xx_dsp_enable_spdif_out (chip);
>  	}
>  =09
--=20
"I am neither especially clever nor especially=20
gifted. I am only very, very curious." Einstein.

Peter Good
Pete's Internet Services
GnuPG Public Key: http://www.petesinternet.net/public.gpg

--=-e8wWEcY/KF8PcGED2oBm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA9zuiLxDSKIXbtT7gRAiZeAKCx8kmjkdD1jORsaYU/rxEcUr+YSgCgrGsu
MNaNkmg8tihbMnebJqaiNj0=3D
=3DyVGz
-----END PGP SIGNATURE-----

--=-e8wWEcY/KF8PcGED2oBm--


--=-8NcmFMmRAbm0wXYxH7we--

--=-2ckRwXbUca+MEa7cdTBg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA9zvGVxDSKIXbtT7gRAiZXAJ9H9nYKu+WEI5fgfBPODLQZd08w/gCcCl2i
ayeiwrNGCh0FvICk2Bm0+T8=
=MgkJ
-----END PGP SIGNATURE-----

--=-2ckRwXbUca+MEa7cdTBg--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
