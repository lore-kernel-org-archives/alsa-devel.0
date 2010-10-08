From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: alsactl adds volume controls?
Date: Fri, 08 Oct 2010 14:21:54 +0100
Message-ID: <4CAF1AF2.3060907@colin.guthr.ie>
References: <s5hr5hczi06.wl%tiwai@suse.de>	<4C7F6D5D.7020101@canonical.com>	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>	<4C7FB2CF.5060505@ladisch.de>	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>	<4C7FC85B.4000009@ladisch.de>	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>	<i7viav$kjb$1@dough.gmane.org>	<4CA46E98.10402@ladisch.de>	<4CA4A844.7060403@colin.guthr.ie>	<20100930164753.GB9431@sirena.org.uk>	<s5hr5gb9k83.wl%tiwai@suse.de>	<4CA5834D.5030408@ladisch.de>	<4CA59976.2020306@colin.guthr.ie>	<4CA5A38A.7050006@ladisch.de>	<i8ce5u$fj3$1@dough.gmane.org>
	<4CAD7F3D.3090205@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id DC580243FF
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 15:22:14 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P4Ctm-000810-22
	for alsa-devel@alsa-project.org; Fri, 08 Oct 2010 15:22:10 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 08 Oct 2010 15:22:10 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 08 Oct 2010 15:22:10 +0200
In-Reply-To: <4CAD7F3D.3090205@ladisch.de>
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
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Clemens Ladisch at 07/10/10 09:05 did gyre and gimble:
> Please try this patch.
> 
> --- a/sound/pci/hda/patch_sigmatel.c
> +++ b/sound/pci/hda/patch_sigmatel.c
> @@ -606,6 +606,24 @@ static hda_nid_t stac9205_pin_nids[12] = {
>  	0x21, 0x22,
>  };
>  
> +static int stac92xx_minmute_volume_tlv(struct snd_kcontrol *control,
> +				       int op_flag, unsigned int size,
> +				       unsigned int __user *_tlv)
> +{
> +	int ret;
> +	unsigned int val;
> +
> +	ret = snd_hda_mixer_amp_tlv(control, op_flag, size, _tlv);
> +	if (ret >= 0) {
> +		if (get_user(val, _tlv + 3))
> +			return -EFAULT;
> +		val |= 0x10000; /* min is mute */
> +		if (put_user(val, _tlv + 3))
> +			return -EFAULT;
> +	}
> +	return ret;
> +}
> +
>  static int stac92xx_dmux_enum_info(struct snd_kcontrol *kcontrol,
>  				   struct snd_ctl_elem_info *uinfo)
>  {
> @@ -959,6 +977,21 @@ static struct hda_verb stac9205_core_init[] = {
>  	{}
>  };
>  
> +#define STAC_MINMUTE_VOLUME(xname, xnid) \
> +	{ \
> +		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
> +		.name = xname, \
> +		.subdevice = HDA_SUBDEV_AMP_FLAG, \
> +		.access = SNDRV_CTL_ELEM_ACCESS_READWRITE | \
> +			  SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
> +			  SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK, \
> +		.info = snd_hda_mixer_amp_volume_info, \
> +		.get = snd_hda_mixer_amp_volume_get, \
> +		.put = snd_hda_mixer_amp_volume_put, \
> +		.tlv = { .c = stac92xx_minmute_volume_tlv }, \
> +		.private_value = HDA_COMPOSE_AMP_VAL(xnid, 3, 0, HDA_OUTPUT), \
> +	}
> +
>  #define STAC_MONO_MUX \
>  	{ \
>  		.iface = SNDRV_CTL_ELEM_IFACE_MIXER, \
> @@ -992,7 +1025,7 @@ static struct hda_verb stac9205_core_init[] = {
>  	}
>  
>  static struct snd_kcontrol_new stac9200_mixer[] = {
> -	HDA_CODEC_VOLUME("Master Playback Volume", 0xb, 0, HDA_OUTPUT),
> +	STAC_MINMUTE_VOLUME("Master Playback Volume", 0xb),
>  	HDA_CODEC_MUTE("Master Playback Switch", 0xb, 0, HDA_OUTPUT),
>  	HDA_CODEC_VOLUME("Capture Volume", 0x0a, 0, HDA_OUTPUT),
>  	HDA_CODEC_MUTE("Capture Switch", 0x0a, 0, HDA_OUTPUT),


Seemed to do something. Now, rather than printing -46.5dB then the
Master slider is down at 0, it prints "mute".

Is this the extent of the fix? i.e. to correctly report that the bottom
value is muted?

If so, then is there a way to tell this via an API so that I can tell PA
to not control the slider down to it's 0 value in order to avoid the
auto mute?

Col


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
