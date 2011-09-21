From: Stephen Warren <swarren@nvidia.com>
Subject: Re: link between HDMI ELD and PCM devices
Date: Wed, 21 Sep 2011 11:29:52 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF1738180119@HQMAIL01.nvidia.com>
References: <1316560363.3872.14.camel@pbossart-Dell-N7010>
	<74CDBE0F657A3D45AFBB94109FB122FF04B73217D2@HQMAIL01.nvidia.com>
	<1316566711.3872.24.camel@pbossart-Dell-N7010>
	<4E7987BF.8000206@canonical.com>
	<000001cc7861$2d7895e0$8869c1a0$@bossart@linux.intel.com>
	<4E79ECBA.3060705@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF1738180031@HQMAIL01.nvidia.com>
	<1316626243.16197.7.camel@pbossart-Dell-N7010>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id E311B24473
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 20:30:02 +0200 (CEST)
In-Reply-To: <1316626243.16197.7.camel@pbossart-Dell-N7010>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, 'Wu Fengguang' <fengguang.wu@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote at Wednesday, September 21, 2011 11:31 AM:
...
> I simplified my initial patch based on David's suggestions, can you guys
> let me know how it behaves with multiple codecs/multiple PCMs?
> On my laptop, I get this result
> 
> $ amixer -c0 controls
> numid=22,iface=PCM,name='ELD',device=3
> $ amixer -c0 cget numid=22
> numid=22,iface=PCM,name='ELD',device=3
>   ; type=BYTES,access=rw------,values=84
>   : values=0x10,0x00,0x0d,0x00,0x68,0x82,0x00,0x0f,<snip>

GeForce 520 (1 codec, up to 4 pins per, but 2 pins disabled):

[swarren@swarren-lx2 alsa-driver-build]$ sudo amixer -c1 controls | grep ELD
numid=5,iface=PCM,name='ELD',device=3
numid=10,iface=PCM,name='ELD',device=7

GeForce 200 series (4 codecs, 1 pin per):

[swarren@swarren-lx2 alsa-driver-build]$ sudo amixer -c2 controls | grep ELD
numid=5,iface=PCM,name='ELD',device=3
numid=10,iface=PCM,name='ELD',device=7
numid=15,iface=PCM,name='ELD',device=8
numid=20,iface=PCM,name='ELD',device=9

That looks pretty sane to me.

A few comments on the patch:

It doesn't apply to ToT; it conflicts slightly with Takashi's recent
ELD bytes cleanup.

> diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
...
> @@ -335,21 +335,20 @@ int snd_hdmi_get_eld(struct hdmi_eld *eld,
>  		snd_printd(KERN_INFO "HDMI: ELD buf size is 0, force 128\n");
>  		size = 128;
>  	}
> -	if (size < ELD_FIXED_BYTES || size > PAGE_SIZE) {
> +	if (size < ELD_FIXED_BYTES || size > ELD_MAX_SIZE || size > PAGE_SIZE) {

Note that eld->eld_size are checked against ELD_MAX_SIZE here.

> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
...
> +static int hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_info *uinfo)
> +{
...
> +	pin_idx = kcontrol->private_value; 
...
> +	if (pin_idx < 0) {
> +		uinfo->count = 0;

I don't think you need that conditional. I'd just assume that pin_idx
was set correctly when the control was created, and not create the
control if that wasn't the case. At most, BUG_ON here?

Same comment in hdmi_eld_ctl_get below.

> +static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
> +			struct snd_ctl_elem_value *ucontrol)
...
> +	if (pin_idx < 0) {
> +		memset(ucontrol->value.bytes.data, 0, ELD_MAX_SIZE);
> +	} else {
> +		per_pin = &spec->pins[pin_idx];
> +		eld = &per_pin->sink_eld;
> +		memcpy(ucontrol->value.bytes.data, eld->eld_buffer,
> +			(eld->eld_size > ELD_MAX_SIZE) ?
> +			ELD_MAX_SIZE : eld->eld_size);

Given the check on eld->eld_size in snd_hdmi_get_eld, I don't think you
need the conditional here to calculate the number of bytes to copy.

One question: How do we know that ucontrol is large enough to accept
eld->eld_size; are all BYTES controls always big enough, or do we need
a check here on ucontrol->value.bytes.size or something like that?

> +static int hdmi_create_eld_ctl(struct hda_codec *codec, int pin_idx,
> +			int device)
> +{
> +	struct snd_kcontrol *kctl;
> +	struct hdmi_spec *spec = codec->spec;
> +	int err;
> +
> +	if (pin_idx < 0)
> +		return -EINVAL;

Oh, the pin_idx validity check is already here...

-- 
nvpublic
