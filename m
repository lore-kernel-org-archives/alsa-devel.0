From: Chris J Arges <chris.j.arges@canonical.com>
Subject: Re: [PATCH v3 4/4] ALSA: usb-audio: Scarlett mixer
 interface for 6i6, 18i6, 18i8 and 18i20
Date: Mon, 03 Nov 2014 11:11:45 -0600
Message-ID: <5457B751.20605@canonical.com>
References: <s5h1tq0egzi.wl-tiwai@suse.de>	<1414616163-14146-1-git-send-email-chris.j.arges@canonical.com>	<1414616163-14146-5-git-send-email-chris.j.arges@canonical.com>
 <s5h8ujyc88y.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 80F75260526
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 18:11:50 +0100 (CET)
In-Reply-To: <s5h8ujyc88y.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, robin@gareus.org, clemens@ladisch.de, th55@gmx.de, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org



On 10/30/2014 02:43 AM, Takashi Iwai wrote:
> At Wed, 29 Oct 2014 15:56:03 -0500,
> Chris J Arges wrote:
>>
>> +/********************** Enum Strings *************************/
>> +static const char txtOff[] = "Off",
>> +	     txtPcm1[] = "PCM 1", txtPcm2[] = "PCM 2",
>> +	     txtPcm3[] = "PCM 3", txtPcm4[] = "PCM 4",
>> +	     txtPcm5[] = "PCM 5", txtPcm6[] = "PCM 6",
>> +	     txtPcm7[] = "PCM 7", txtPcm8[] = "PCM 8",
>> +	     txtPcm9[] = "PCM 9", txtPcm10[] = "PCM 10",
>> +	     txtPcm11[] = "PCM 11", txtPcm12[] = "PCM 12",
>> +	     txtPcm13[] = "PCM 13", txtPcm14[] = "PCM 14",
>> +	     txtPcm15[] = "PCM 15", txtPcm16[] = "PCM 16",
>> +	     txtPcm17[] = "PCM 17", txtPcm18[] = "PCM 18",
>> +	     txtPcm19[] = "PCM 19", txtPcm20[] = "PCM 20",
>> +	     txtAnlg1[] = "Analog 1", txtAnlg2[] = "Analog 2",
>> +	     txtAnlg3[] = "Analog 3", txtAnlg4[] = "Analog 4",
>> +	     txtAnlg5[] = "Analog 5", txtAnlg6[] = "Analog 6",
>> +	     txtAnlg7[] = "Analog 7", txtAnlg8[] = "Analog 8",
>> +	     txtSpdif1[] = "SPDIF 1", txtSpdif2[] = "SPDIF 2",
>> +	     txtAdat1[] = "ADAT 1", txtAdat2[] = "ADAT 2",
>> +	     txtAdat3[] = "ADAT 3", txtAdat4[] = "ADAT 4",
>> +	     txtAdat5[] = "ADAT 5", txtAdat6[] = "ADAT 6",
>> +	     txtAdat7[] = "ADAT 7", txtAdat8[] = "ADAT 8",
>> +	     txtMix1[] = "Mix A", txtMix2[] = "Mix B",
>> +	     txtMix3[] = "Mix C", txtMix4[] = "Mix D",
>> +	     txtMix5[] = "Mix E", txtMix6[] = "Mix F",
>> +	     txtMix7[] = "Mix G", txtMix8[] = "Mix H";
> 
> This is too ugly.  Can we generate strings systematically?
> 

Hi, at some point we need an array of static strings to pass into
snd_ctl_enum_info, so in v3 I've created a macro to define the strings
and created per device array of strings. I can do this using a function
as well and dynamically allocate memory if that is a better approach.

>> +static const struct usb_mixer_elem_enum_info opt_pad = {
>> +	.start = 0,
>> +	.len = 2,
>> +	.names = (const char *[]){
> 
> Better to be "const char * const []"?
> 
>> +		txtOff, "-10dB"
>> +	}
>> +};
>> +
>> +static const struct usb_mixer_elem_enum_info opt_impedance = {
>> +	.start = 0,
>> +	.len = 2,
>> +	.names = (const char *[]){
>> +		"Line", "Hi-Z"
>> +	}
>> +};
>> +
>> +static const struct usb_mixer_elem_enum_info opt_clock = {
>> +	.start = 1,
>> +	.len = 3,
>> +	.names = (const char *[]){
>> +		"Internal", "SPDIF", "ADAT"
>> +	}
>> +};
>> +
>> +static const struct usb_mixer_elem_enum_info opt_sync = {
>> +	.start = 0,
>> +	.len = 2,
>> +	.names = (const char *[]){
>> +		"No Lock", "Locked"
>> +	}
>> +};
>> +
>> +static const struct usb_mixer_elem_enum_info opt_save = {
>> +	.start = 0,
>> +	.len = 2,
>> +	.names = (const char *[]){
>> +		"---", "Save"
>> +	}
>> +};
> 
> This enum item look strange.
> 

This control is activated much like a push button, so normally its in
the "---" state and if you active it then it triggers the "Save to HW"
function. Is there a better way to express this control?

>> +static int scarlett_ctl_switch_info(struct snd_kcontrol *kctl,
>> +		struct snd_ctl_elem_info *uinfo)
>> +{
>> +	struct usb_mixer_elem_info *elem = kctl->private_data;
>> +
>> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
>> +	uinfo->count = elem->channels;
>> +	uinfo->value.integer.min = 0;
>> +	uinfo->value.integer.max = 1;
>> +	return 0;
>> +}
> 
> Use snd_ctl_boolean_mono_info().
> 

I've tried this but unfortunately some of the switch controls are stereo
and some are mono. I could create two separate controls for mono/stereo,
or perhaps I make this function more generate and add as
'snd_ctl_boolean_info' and allow it to check 'channels'?

>> +static int scarlett_ctl_switch_get(struct snd_kcontrol *kctl,
>> +		struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct usb_mixer_elem_info *elem = kctl->private_data;
>> +	int i, err, val;
>> +
>> +	for (i = 0; i < elem->channels; i++) {
>> +		err = snd_usb_get_cur_mix_value(elem, i, i, &val);
>> +		if (err < 0)
>> +			return err;
>> +
>> +		val = !val; /* alsa uses 0: on, 1: off */
> 
> Hm?  ALSA uses 0:off 1:on in general.  The meaning of "mute" is
> inverted -- it turns off when it's 1.  So, in mixer.c, the mute
> control is assigned as USB_MIXER_INV_BOOLEAN.
> 
>> +		ucontrol->value.integer.value[i] = val;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int scarlett_ctl_switch_put(struct snd_kcontrol *kctl,
>> +		struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct usb_mixer_elem_info *elem = kctl->private_data;
>> +	int i, changed = 0;
>> +	int err, oval, val;
>> +
>> +	for (i = 0; i < elem->channels; i++) {
>> +		err = snd_usb_get_cur_mix_value(elem, i, i, &oval);
>> +		if (err < 0)
>> +			return err;
>> +
>> +		val = ucontrol->value.integer.value[i];
>> +		val = !val;
>> +		if (oval != val) {
>> +			err = snd_usb_set_cur_mix_value(elem, i, i, val);
>> +			if (err < 0)
>> +				return err;
>> +
>> +			changed = 1;
>> +		}
>> +	}
>> +
>> +	return changed;
>> +}
>> +
>> +static int scarlett_ctl_info(struct snd_kcontrol *kctl,
>> +			     struct snd_ctl_elem_info *uinfo)
>> +{
>> +	struct usb_mixer_elem_info *elem = kctl->private_data;
>> +
>> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
>> +	uinfo->count = elem->channels;
>> +	uinfo->value.integer.min = -128 + SND_SCARLETT_LEVEL_BIAS;
> 
> This is 0, right?  IOW, SND_SCARLETT_LEVEL_BIAS was defined so that
> this becomes zero.
> 
>> +	uinfo->value.integer.max = (int)kctl->private_value +
>> +		SND_SCARLETT_LEVEL_BIAS;
>> +	uinfo->value.integer.step = 1;
>> +	return 0;
>> +}
>> +
>> +static int scarlett_ctl_get(struct snd_kcontrol *kctl,
>> +			    struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct usb_mixer_elem_info *elem = kctl->private_data;
>> +	int i, err, val;
>> +
>> +	for (i = 0; i < elem->channels; i++) {
>> +		err = snd_usb_get_cur_mix_value(elem, i, i, &val);
>> +		if (err < 0)
>> +			return err;
>> +
>> +		val = clamp(val / 256, -128, (int)kctl->private_value) +
>> +				    SND_SCARLETT_LEVEL_BIAS;
>> +		ucontrol->value.integer.value[i] = val;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int scarlett_ctl_put(struct snd_kcontrol *kctl,
>> +			    struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct usb_mixer_elem_info *elem = kctl->private_data;
>> +	int i, changed = 0;
>> +	int err, oval, val;
>> +
>> +	for (i = 0; i < elem->channels; i++) {
>> +		err = snd_usb_get_cur_mix_value(elem, i, i, &oval);
>> +		if (err < 0)
>> +			return err;
>> +
>> +		val = ucontrol->value.integer.value[i] -
>> +			SND_SCARLETT_LEVEL_BIAS;
>> +		val = val * 256;
>> +		if (oval != val) {
>> +			err = snd_usb_set_cur_mix_value(elem, i, i, val);
>> +			if (err < 0)
>> +				return err;
>> +
>> +			changed = 1;
>> +		}
>> +	}
>> +
>> +	return changed;
>> +}
>> +
>> +static int scarlett_ctl_enum_info(struct snd_kcontrol *kctl,
>> +				  struct snd_ctl_elem_info *uinfo)
>> +{
>> +	struct usb_mixer_elem_info *elem = kctl->private_data;
>> +
>> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
>> +	uinfo->count = elem->channels;
>> +	uinfo->value.enumerated.items = elem->opt->len;
>> +	if (uinfo->value.enumerated.item > uinfo->value.enumerated.items - 1)
>> +		uinfo->value.enumerated.item =
>> +			uinfo->value.enumerated.items - 1;
>> +	strcpy(uinfo->value.enumerated.name,
>> +	       elem->opt->names[uinfo->value.enumerated.item]);
>> +	return 0;
>> +}
> 
> Use snd_ctl_enum_info().
> 
>> +
>> +static int scarlett_ctl_enum_get(struct snd_kcontrol *kctl,
>> +				 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct usb_mixer_elem_info *elem = kctl->private_data;
>> +	int err, val;
>> +
>> +	err = snd_usb_get_cur_mix_value(elem, 0, 0, &val);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	if ((elem->opt->start == -1) && (val > elem->opt->len)) /* >= 0x20 */
>> +		val = 0;
>> +	else
>> +		val = clamp(val - elem->opt->start, 0, elem->opt->len-1);
>> +
>> +	ucontrol->value.enumerated.item[0] = val;
>> +
>> +	return 0;
>> +}
>> +
>> +static int scarlett_ctl_enum_put(struct snd_kcontrol *kctl,
>> +				 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct usb_mixer_elem_info *elem = kctl->private_data;
>> +	int changed = 0;
>> +	int err, oval, val;
>> +
>> +	err = snd_usb_get_cur_mix_value(elem, 0, 0, &oval);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	val = ucontrol->value.integer.value[0];
>> +	val = val + elem->opt->start;
>> +	if (oval != val) {
>> +		err = snd_usb_set_cur_mix_value(elem, 0, 0, val);
>> +		if (err < 0)
>> +			return err;
>> +
>> +		changed = 1;
>> +	}
>> +
>> +	return changed;
>> +}
>> +
>> +static int scarlett_ctl_save_get(struct snd_kcontrol *kctl,
>> +				 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	ucontrol->value.enumerated.item[0] = 0;
>> +	return 0;
>> +}
>> +
>> +static int scarlett_ctl_save_put(struct snd_kcontrol *kctl,
>> +				 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct usb_mixer_elem_info *elem = kctl->private_data;
>> +	struct snd_usb_audio *chip = elem->mixer->chip;
>> +	char buf[] = { 0x00, 0xa5 };
>> +	int err;
>> +
>> +	if (ucontrol->value.enumerated.item[0] > 0) {
>> +		err = snd_usb_ctl_msg(chip->dev,
>> +			usb_sndctrlpipe(chip->dev, 0), UAC2_CS_MEM,
>> +			USB_RECIP_INTERFACE | USB_TYPE_CLASS |
>> +			USB_DIR_OUT, 0x005a, snd_usb_ctrl_intf(chip) |
>> +			(0x3c << 8), buf, 2);
>> +		if (err < 0)
>> +			return err;
>> +
>> +		dev_info(&(elem->mixer->chip->dev->dev),
>> +			 "scarlett: saved settings to hardware.\n");
> 
> This can be usb_audio_info(chip, ...)
> 
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int scarlett_ctl_meter_get(struct snd_kcontrol *kctl,
>> +				  struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct usb_mixer_elem_info *elem = kctl->private_data;
>> +	struct snd_usb_audio *chip = elem->mixer->chip;
>> +	unsigned char buf[2 * MAX_CHANNELS] = {0, };
>> +	int wValue = (elem->control << 8) | elem->idx_off;
>> +	int idx = snd_usb_ctrl_intf(chip) | (elem->id << 8);
>> +	int err;
>> +
>> +	err = snd_usb_ctl_msg(chip->dev,
>> +				usb_rcvctrlpipe(chip->dev, 0),
>> +				UAC2_CS_MEM,
>> +				USB_RECIP_INTERFACE | USB_TYPE_CLASS |
>> +				USB_DIR_IN, wValue, idx, buf, elem->channels);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	ucontrol->value.enumerated.item[0] = clamp((int)buf[0], 0, 1);
>> +	return 0;
>> +}
>> +
>> +static struct snd_kcontrol_new usb_scarlett_ctl_switch = {
>> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>> +	.name = "",
>> +	.info = scarlett_ctl_switch_info,
>> +	.get =  scarlett_ctl_switch_get,
>> +	.put =  scarlett_ctl_switch_put,
>> +};
>> +
>> +static const DECLARE_TLV_DB_SCALE(db_scale_scarlett_gain, -12800, 100, 0);
>> +
>> +static struct snd_kcontrol_new usb_scarlett_ctl = {
>> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>> +	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
>> +		  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
>> +	.name = "",
>> +	.info = scarlett_ctl_info,
>> +	.get =  scarlett_ctl_get,
>> +	.put =  scarlett_ctl_put,
>> +	.private_value = 6,  /* max value */
>> +	.tlv = { .p = db_scale_scarlett_gain }
>> +};
>> +
>> +static struct snd_kcontrol_new usb_scarlett_ctl_master = {
>> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>> +	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
>> +		  SNDRV_CTL_ELEM_ACCESS_TLV_READ,
>> +	.name = "",
>> +	.info = scarlett_ctl_info,
>> +	.get =  scarlett_ctl_get,
>> +	.put =  scarlett_ctl_put,
>> +	.private_value = 6,  /* max value */
>> +	.tlv = { .p = db_scale_scarlett_gain }
>> +};
>> +
>> +static struct snd_kcontrol_new usb_scarlett_ctl_enum = {
>> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>> +	.name = "",
>> +	.info = scarlett_ctl_enum_info,
>> +	.get =  scarlett_ctl_enum_get,
>> +	.put =  scarlett_ctl_enum_put,
>> +};
>> +
>> +static struct snd_kcontrol_new usb_scarlett_ctl_sync = {
>> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>> +	.access = SNDRV_CTL_ELEM_ACCESS_READ | SNDRV_CTL_ELEM_ACCESS_VOLATILE,
>> +	.name = "",
>> +	.info = scarlett_ctl_enum_info,
>> +	.get =  scarlett_ctl_meter_get,
>> +};
>> +
>> +static struct snd_kcontrol_new usb_scarlett_ctl_save = {
>> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
>> +	.name = "",
>> +	.info = scarlett_ctl_enum_info,
>> +	.get =  scarlett_ctl_save_get,
>> +	.put =  scarlett_ctl_save_put,
>> +};
>> +
>> +static int add_new_ctl(struct usb_mixer_interface *mixer,
>> +		       const struct snd_kcontrol_new *ncontrol,
>> +		       int index, int offset, int num,
>> +		       int val_type, int channels, const char *name,
>> +		       const struct usb_mixer_elem_enum_info *opt,
>> +		       struct usb_mixer_elem_info **elem_ret
>> +)
>> +{
>> +	struct snd_kcontrol *kctl;
>> +	struct usb_mixer_elem_info *elem;
>> +	int err;
>> +
>> +	elem = kzalloc(sizeof(*elem), GFP_KERNEL);
>> +	if (!elem)
>> +		return -ENOMEM;
>> +
>> +	elem->mixer = mixer;
>> +	elem->control = offset;
>> +	elem->idx_off = num;
>> +	elem->id = index;
>> +	elem->val_type = val_type;
>> +
>> +	elem->channels = channels;
>> +	elem->opt = opt;
>> +
>> +	kctl = snd_ctl_new1(ncontrol, elem);
>> +	if (!kctl) {
>> +		dev_err(&(mixer->chip->dev->dev), "cannot malloc kcontrol\n");
>> +		kfree(elem);
>> +		return -ENOMEM;
>> +	}
>> +	kctl->private_free = snd_usb_mixer_elem_free;
>> +
>> +	snprintf(kctl->id.name, sizeof(kctl->id.name), "%s", name);
>> +
>> +	err = snd_ctl_add(mixer->chip->card, kctl);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	if (elem_ret)
>> +		*elem_ret = elem;
>> +
>> +	return 0;
>> +}
>> +
>> +static int init_ctl(struct usb_mixer_elem_info *elem, int value)
>> +{
>> +	int err, channel;
>> +
>> +	for (channel = 0; channel < elem->channels; channel++) {
>> +		err = snd_usb_set_cur_mix_value(elem, channel, channel, value);
>> +		if (err < 0)
>> +			return err;
>> +	}
>> +	return 0;
>> +}
>> +
>> +#define INIT(value) \
>> +	do { \
>> +		err = init_ctl(elem, value); \
>> +		if (err < 0) \
>> +			return err; \
>> +	} while (0)
>> +
>> +#define CTL_SWITCH(cmd, off, no, count, name) \
>> +	do { \
>> +		err = add_new_ctl(mixer, &usb_scarlett_ctl_switch, cmd, off, \
>> +			no, USB_MIXER_S16, count, name, NULL, &elem); \
>> +		if (err < 0) \
>> +			return err; \
>> +	} while (0)
>> +
>> +/* no multichannel enum, always count == 1  (at least for now) */
>> +#define CTL_ENUM(cmd, off, no, name, opt) \
>> +	do { \
>> +		err = add_new_ctl(mixer, &usb_scarlett_ctl_enum, cmd, off, \
>> +			no, USB_MIXER_S16, 1, name, opt, &elem); \
>> +		if (err < 0) \
>> +			return err; \
>> +	} while (0)
>> +
>> +#define CTL_MIXER(cmd, off, no, count, name) \
>> +	do { \
>> +		err = add_new_ctl(mixer, &usb_scarlett_ctl, cmd, off, \
>> +			no, USB_MIXER_S16, count, name, NULL, &elem); \
>> +		if (err < 0) \
>> +			return err; \
>> +		INIT(-32768); /* -128*256 */  \
>> +	} while (0)
>> +
>> +#define CTL_MASTER(cmd, off, no, count, name) \
>> +	do { \
>> +		err = add_new_ctl(mixer, &usb_scarlett_ctl_master, cmd, off, \
>> +			no, USB_MIXER_S16, count, name, NULL, &elem); \
>> +		if (err < 0) \
>> +			return err; \
>> +		INIT(0); \
>> +	} while (0)
>> +
>> +static int add_output_ctls(struct usb_mixer_interface *mixer,
>> +			   int index, const char *name,
>> +			   const struct scarlett_device_info *info)
>> +{
>> +	int err;
>> +	char mx[48];
>> +	struct usb_mixer_elem_info *elem;
>> +
>> +	/* Add mute switch */
>> +	snprintf(mx, sizeof(mx), "Master %d (%s) Playback Switch",
>> +		index + 1, name);
>> +	CTL_SWITCH(0x0a, 0x01, 2*index+1, 2, mx);
>> +
>> +	/* Add volume control */
>> +	snprintf(mx, sizeof(mx), "Master %d (%s) Playback Volume",
>> +		index + 1, name);
>> +	CTL_MASTER(0x0a, 0x02, 2*index+1, 2, mx);
>> +
>> +	/* Add L channel source playback enumeration */
>> +	snprintf(mx, sizeof(mx), "Master %dL (%s) Source Playback Enum",
>> +		index + 1, name);
>> +	CTL_ENUM(0x33, 0x00, 2*index, mx, &info->opt_master);
>> +	INIT(info->mix_start);
>> +
>> +	/* Add R channel source playback enumeration */
>> +	snprintf(mx, sizeof(mx), "Master %dR (%s) Source Playback Enum",
>> +		index + 1, name);
>> +	CTL_ENUM(0x33, 0x00, 2*index+1, mx, &info->opt_master);
>> +	INIT(info->mix_start + 1);
>> +
>> +	return 0;
>> +}
>> +
>> +#define CTLS_OUTPUT(index, name) \
>> +	do { \
>> +		err = add_output_ctls(mixer, index, name, info); \
>> +		if (err < 0) \
>> +			return err;\
>> +	} while (0)
> 
> Hmm, these macros...  Can we build from a table instead of calling
> each function?  This would reduce the code size significantly, too,
> and the code flow would be more obvious.  The biggest disadvantage of
> this kind of macro is that the code flow is hidden.  It doesn't show
> that it can return secretly at error.
> 
> 

I've got this mostly working, and will remove these macros in v3. The
rest of the suggestions are implemented, and I've responded with some
questions before I submit v3.

Thanks,
--chris


> Takashi
> 
>> +/********************** device-specific config *************************/
>> +static int scarlet_s6i6_controls(struct usb_mixer_interface *mixer,
>> +				 const struct scarlett_device_info *info)
>> +{
>> +	struct usb_mixer_elem_info *elem;
>> +	int err;
>> +
>> +	CTLS_OUTPUT(0, "Monitor");
>> +	CTLS_OUTPUT(1, "Headphone 2");
>> +	CTLS_OUTPUT(2, "SPDIF");
>> +
>> +	CTL_ENUM(0x01, 0x09, 1, "Input 1 Impedance Switch", &opt_impedance);
>> +	CTL_ENUM(0x01, 0x0b, 1, "Input 1 Pad Switch", &opt_pad);
>> +
>> +	CTL_ENUM(0x01, 0x09, 2, "Input 2 Impedance Switch", &opt_impedance);
>> +	CTL_ENUM(0x01, 0x0b, 2, "Input 2 Pad Switch", &opt_pad);
>> +
>> +	CTL_ENUM(0x01, 0x0b, 3, "Input 3 Pad Switch", &opt_pad);
>> +	CTL_ENUM(0x01, 0x0b, 4, "Input 4 Pad Switch", &opt_pad);
>> +
>> +	return 0;
>> +}
>> +
>> +static int scarlet_s8i6_controls(struct usb_mixer_interface *mixer,
>> +				 const struct scarlett_device_info *info)
>> +{
>> +	struct usb_mixer_elem_info *elem;
>> +	int err;
>> +
>> +	CTLS_OUTPUT(0, "Monitor");
>> +	CTLS_OUTPUT(1, "Headphone");
>> +	CTLS_OUTPUT(2, "SPDIF");
>> +
>> +	CTL_ENUM(0x01, 0x09, 1, "Input 1 Impedance Switch", &opt_impedance);
>> +	CTL_ENUM(0x01, 0x09, 2, "Input 2 Impedance Switch", &opt_impedance);
>> +
>> +	CTL_ENUM(0x01, 0x0b, 3, "Input 3 Pad Switch", &opt_pad);
>> +	CTL_ENUM(0x01, 0x0b, 4, "Input 4 Pad Switch", &opt_pad);
>> +
>> +	return 0;
>> +}
>> +
>> +static int scarlet_s18i6_controls(struct usb_mixer_interface *mixer,
>> +				  const struct scarlett_device_info *info)
>> +{
>> +	struct usb_mixer_elem_info *elem;
>> +	int err;
>> +
>> +	CTLS_OUTPUT(0, "Monitor");
>> +	CTLS_OUTPUT(1, "Headphone");
>> +	CTLS_OUTPUT(2, "SPDIF");
>> +
>> +	CTL_ENUM(0x01, 0x09, 1, "Input 1 Impedance Switch", &opt_impedance);
>> +	CTL_ENUM(0x01, 0x09, 2, "Input 2 Impedance Switch", &opt_impedance);
>> +
>> +	return 0;
>> +}
>> +
>> +static int scarlet_s18i8_controls(struct usb_mixer_interface *mixer,
>> +				  const struct scarlett_device_info *info)
>> +{
>> +	struct usb_mixer_elem_info *elem;
>> +	int err;
>> +
>> +	CTLS_OUTPUT(0, "Monitor");
>> +	CTLS_OUTPUT(1, "Headphone 1");
>> +	CTLS_OUTPUT(2, "Headphone 2");
>> +	CTLS_OUTPUT(3, "SPDIF");
>> +
>> +	CTL_ENUM(0x01, 0x09, 1, "Input 1 Impedance Switch", &opt_impedance);
>> +	CTL_ENUM(0x01, 0x0b, 1, "Input 1 Pad Switch", &opt_pad);
>> +
>> +	CTL_ENUM(0x01, 0x09, 2, "Input 2 Impedance Switch", &opt_impedance);
>> +	CTL_ENUM(0x01, 0x0b, 2, "Input 2 Pad Switch", &opt_pad);
>> +
>> +	CTL_ENUM(0x01, 0x0b, 3, "Input 3 Pad Switch", &opt_pad);
>> +	CTL_ENUM(0x01, 0x0b, 4, "Input 4 Pad Switch", &opt_pad);
>> +
>> +	return 0;
>> +}
>> +
>> +static int scarlet_s18i20_controls(struct usb_mixer_interface *mixer,
>> +				   const struct scarlett_device_info *info)
>> +{
>> +	int err;
>> +
>> +	CTLS_OUTPUT(0, "Monitor");   /* 1/2 */
>> +	CTLS_OUTPUT(1, "Line 3/4");
>> +	CTLS_OUTPUT(2, "Line 5/6");
>> +	CTLS_OUTPUT(3, "Line 7/8");  /* = Headphone 1 */
>> +	CTLS_OUTPUT(4, "Line 9/10"); /* = Headphone 2 */
>> +	CTLS_OUTPUT(5, "SPDIF");
>> +	CTLS_OUTPUT(6, "ADAT 1/2");
>> +	CTLS_OUTPUT(7, "ADAT 3/4");
>> +	CTLS_OUTPUT(8, "ADAT 5/6");
>> +	CTLS_OUTPUT(9, "ADAT 7/8");
>> +
>> +/* ? real hardware switches
>> +	CTL_ENUM  (0x01, 0x09, 1, "Input 1 Impedance Switch", &opt_impedance);
>> +	CTL_ENUM  (0x01, 0x0b, 1, "Input 1 Pad Switch", &opt_pad);
>> +
>> +	CTL_ENUM  (0x01, 0x09, 2, "Input 2 Impedance Switch", &opt_impedance);
>> +	CTL_ENUM  (0x01, 0x0b, 2, "Input 2 Pad Switch", &opt_pad);
>> +
>> +	CTL_ENUM  (0x01, 0x0b, 3, "Input 3 Pad Switch", &opt_pad);
>> +	CTL_ENUM  (0x01, 0x0b, 4, "Input 4 Pad Switch", &opt_pad);
>> +*/
>> +
>> +	return 0;
>> +}
>> +
>> +static const char * const s6i6_names[] = {
>> +	txtOff, /* 'off' == 0xff */
>> +	txtPcm1, txtPcm2, txtPcm3, txtPcm4,
>> +	txtPcm5, txtPcm6, txtPcm7, txtPcm8,
>> +	txtPcm9, txtPcm10, txtPcm11, txtPcm12,
>> +	txtAnlg1, txtAnlg2, txtAnlg3, txtAnlg4,
>> +	txtSpdif1, txtSpdif2,
>> +	txtMix1, txtMix2, txtMix3, txtMix4,
>> +	txtMix5, txtMix6, txtMix7, txtMix8
>> +};
>> +
>> +/*  untested...  */
>> +static const struct scarlett_device_info s6i6_info = {
>> +	.matrix_in = 18,
>> +	.matrix_out = 8,
>> +	.input_len = 6,
>> +	.output_len = 6,
>> +
>> +	.pcm_start = 0,
>> +	.analog_start = 12,
>> +	.spdif_start = 16,
>> +	.adat_start = 18,
>> +	.mix_start = 18,
>> +
>> +	.opt_master = {
>> +		.start = -1,
>> +		.len = 27,
>> +		.names = s6i6_names
>> +	},
>> +
>> +	.opt_matrix = {
>> +		.start = -1,
>> +		.len = 19,
>> +		.names = s6i6_names
>> +	},
>> +
>> +	.controls_fn = scarlet_s6i6_controls,
>> +	.matrix_mux_init = {
>> +		12, 13, 14, 15,                 /* Analog -> 1..4 */
>> +		16, 17,                          /* SPDIF -> 5,6 */
>> +		0, 1, 2, 3, 4, 5, 6, 7,     /* PCM[1..12] -> 7..18 */
>> +		8, 9, 10, 11
>> +	}
>> +};
>> +
>> +/* and 2 loop channels: Mix1, Mix2 */
>> +static const char * const s8i6_names[] = {
>> +	txtOff, /* 'off' == 0xff */
>> +	txtPcm1, txtPcm2, txtPcm3, txtPcm4,
>> +	txtPcm5, txtPcm6, txtPcm7, txtPcm8,
>> +	txtPcm9, txtPcm10, txtPcm11, txtPcm12,
>> +	txtAnlg1, txtAnlg2, txtAnlg3, txtAnlg4,
>> +	txtSpdif1, txtSpdif2,
>> +	txtMix1, txtMix2, txtMix3, txtMix4,
>> +	txtMix5, txtMix6
>> +};
>> +
>> +/*  untested...  */
>> +static const struct scarlett_device_info s8i6_info = {
>> +	.matrix_in = 18,
>> +	.matrix_out = 6,
>> +	.input_len = 8,
>> +	.output_len = 6,
>> +
>> +	.pcm_start = 0,
>> +	.analog_start = 12,
>> +	.spdif_start = 16,
>> +	.adat_start = 18,
>> +	.mix_start = 18,
>> +
>> +	.opt_master = {
>> +		.start = -1,
>> +		.len = 25,
>> +		.names = s8i6_names
>> +	},
>> +
>> +	.opt_matrix = {
>> +		.start = -1,
>> +		.len = 19,
>> +		.names = s8i6_names
>> +	},
>> +
>> +	.controls_fn = scarlet_s8i6_controls,
>> +	.matrix_mux_init = {
>> +		12, 13, 14, 15,                 /* Analog -> 1..4 */
>> +		16, 17,                          /* SPDIF -> 5,6 */
>> +		0, 1, 2, 3, 4, 5, 6, 7,     /* PCM[1..12] -> 7..18 */
>> +		8, 9, 10, 11
>> +	}
>> +};
>> +
>> +static const char * const s18i6_names[] = {
>> +	txtOff, /* 'off' == 0xff */
>> +	txtPcm1, txtPcm2, txtPcm3, txtPcm4,
>> +	txtPcm5, txtPcm6,
>> +	txtAnlg1, txtAnlg2, txtAnlg3, txtAnlg4,
>> +	txtAnlg5, txtAnlg6, txtAnlg7, txtAnlg8,
>> +	txtSpdif1, txtSpdif2,
>> +	txtAdat1, txtAdat2, txtAdat3, txtAdat4,
>> +	txtAdat5, txtAdat6, txtAdat7, txtAdat8,
>> +	txtMix1, txtMix2, txtMix3, txtMix4,
>> +	txtMix5, txtMix6
>> +};
>> +
>> +static const struct scarlett_device_info s18i6_info = {
>> +	.matrix_in = 18,
>> +	.matrix_out = 6,
>> +	.input_len = 18,
>> +	.output_len = 6,
>> +
>> +	.pcm_start = 0,
>> +	.analog_start = 6,
>> +	.spdif_start = 14,
>> +	.adat_start = 16,
>> +	.mix_start = 24,
>> +
>> +	.opt_master = {
>> +		.start = -1,
>> +		.len = 31,
>> +		.names = s18i6_names
>> +	},
>> +
>> +	.opt_matrix = {
>> +		.start = -1,
>> +		.len = 25,
>> +		.names = s18i6_names
>> +	},
>> +
>> +	.controls_fn = scarlet_s18i6_controls,
>> +	.matrix_mux_init = {
>> +		 6,  7,  8,  9, 10, 11, 12, 13, /* Analog -> 1..8 */
>> +		16, 17, 18, 19, 20, 21,     /* ADAT[1..6] -> 9..14 */
>> +		14, 15,                          /* SPDIF -> 15,16 */
>> +		0, 1                          /* PCM[1,2] -> 17,18 */
>> +	}
>> +};
>> +
>> +static const char * const s18i8_names[] = {
>> +	txtOff, /* 'off' == 0xff  (original software: 0x22) */
>> +	txtPcm1, txtPcm2, txtPcm3, txtPcm4,
>> +	txtPcm5, txtPcm6, txtPcm7, txtPcm8,
>> +	txtAnlg1, txtAnlg2, txtAnlg3, txtAnlg4,
>> +	txtAnlg5, txtAnlg6, txtAnlg7, txtAnlg8,
>> +	txtSpdif1, txtSpdif2,
>> +	txtAdat1, txtAdat2, txtAdat3, txtAdat4,
>> +	txtAdat5, txtAdat6, txtAdat7, txtAdat8,
>> +	txtMix1, txtMix2, txtMix3, txtMix4,
>> +	txtMix5, txtMix6, txtMix7, txtMix8
>> +};
>> +
>> +static const struct scarlett_device_info s18i8_info = {
>> +	.matrix_in = 18,
>> +	.matrix_out = 8,
>> +	.input_len = 18,
>> +	.output_len = 8,
>> +
>> +	.pcm_start = 0,
>> +	.analog_start = 8,
>> +	.spdif_start = 16,
>> +	.adat_start = 18,
>> +	.mix_start = 26,
>> +
>> +	.opt_master = {
>> +		.start = -1,
>> +		.len = 35,
>> +		.names = s18i8_names
>> +	},
>> +
>> +	.opt_matrix = {
>> +		.start = -1,
>> +		.len = 27,
>> +		.names = s18i8_names
>> +	},
>> +
>> +	.controls_fn = scarlet_s18i8_controls,
>> +	.matrix_mux_init = {
>> +		 8,  9, 10, 11, 12, 13, 14, 15, /* Analog -> 1..8 */
>> +		18, 19, 20, 21, 22, 23,     /* ADAT[1..6] -> 9..14 */
>> +		16, 17,                          /* SPDIF -> 15,16 */
>> +		0, 1                          /* PCM[1,2] -> 17,18 */
>> +	}
>> +};
>> +
>> +static const char * const s18i20_names[] = {
>> +	txtOff, /* 'off' == 0xff  (original software: 0x22) */
>> +	txtPcm1, txtPcm2, txtPcm3, txtPcm4,
>> +	txtPcm5, txtPcm6, txtPcm7, txtPcm8,
>> +	txtPcm9, txtPcm10, txtPcm11, txtPcm12,
>> +	txtPcm13, txtPcm14, txtPcm15, txtPcm16,
>> +	txtPcm17, txtPcm18, txtPcm19, txtPcm20,
>> +	txtAnlg1, txtAnlg2, txtAnlg3, txtAnlg4,
>> +	txtAnlg5, txtAnlg6, txtAnlg7, txtAnlg8,
>> +	txtSpdif1, txtSpdif2,
>> +	txtAdat1, txtAdat2, txtAdat3, txtAdat4,
>> +	txtAdat5, txtAdat6, txtAdat7, txtAdat8,
>> +	txtMix1, txtMix2, txtMix3, txtMix4,
>> +	txtMix5, txtMix6, txtMix7, txtMix8
>> +};
>> +
>> +static const struct scarlett_device_info s18i20_info = {
>> +	.matrix_in = 18,
>> +	.matrix_out = 8,
>> +	.input_len = 18,
>> +	.output_len = 20,
>> +
>> +	.pcm_start = 0,
>> +	.analog_start = 20,
>> +	.spdif_start = 28,
>> +	.adat_start = 30,
>> +	.mix_start = 38,
>> +
>> +	.opt_master = {
>> +		.start = -1,
>> +		.len = 47,
>> +		.names = s18i20_names
>> +	},
>> +
>> +	.opt_matrix = {
>> +		.start = -1,
>> +		.len = 39,
>> +		.names = s18i20_names
>> +	},
>> +
>> +	.controls_fn = scarlet_s18i20_controls,
>> +	.matrix_mux_init = {
>> +		20, 21, 22, 23, 24, 25, 26, 27, /* Analog -> 1..8 */
>> +		30, 31, 32, 33, 34, 35,     /* ADAT[1..6] -> 9..14 */
>> +		28, 29,                          /* SPDIF -> 15,16 */
>> +		0, 1                          /* PCM[1,2] -> 17,18 */
>> +	}
>> +};
>> +
>> +/*
>> + * Create and initialize a mixer for the Focusrite(R) Scarlett
>> + */
>> +int snd_scarlett_controls_create(struct usb_mixer_interface *mixer)
>> +{
>> +	int err, i, o;
>> +	char mx[32];
>> +	const struct scarlett_device_info *info;
>> +	struct usb_mixer_elem_info *elem;
>> +	static char sample_rate_buffer[4] = { '\x80', '\xbb', '\x00', '\x00' };
>> +
>> +	CTL_SWITCH(0x0a, 0x01, 0, 1, "Master Playback Switch");
>> +	CTL_MASTER(0x0a, 0x02, 0, 1, "Master Playback Volume");
>> +
>> +	switch (mixer->chip->usb_id) {
>> +	case USB_ID(0x1235, 0x8012):
>> +		info = &s6i6_info;
>> +		break;
>> +	case USB_ID(0x1235, 0x8002):
>> +		info = &s8i6_info;
>> +		break;
>> +	case USB_ID(0x1235, 0x8004):
>> +		info = &s18i6_info;
>> +		break;
>> +	case USB_ID(0x1235, 0x8014):
>> +		info = &s18i8_info;
>> +		break;
>> +	case USB_ID(0x1235, 0x800c):
>> +		info = &s18i20_info;
>> +		break;
>> +	default: /* device not (yet) supported */
>> +		return -EINVAL;
>> +	}
>> +
>> +	err = (*info->controls_fn)(mixer, info);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	for (i = 0; i < info->matrix_in; i++) {
>> +		snprintf(mx, 32, "Matrix %02d Input Playback Route", i+1);
>> +		CTL_ENUM(0x32, 0x06, i, mx, &info->opt_matrix);
>> +		INIT(info->matrix_mux_init[i]);
>> +
>> +		for (o = 0; o < info->matrix_out; o++) {
>> +			sprintf(mx, "Matrix %02d Mix %c Playback Volume", i+1,
>> +				o+'A');
>> +			CTL_MIXER(0x3c, 0x00, (i << 3) + (o & 0x07), 1, mx);
>> +			if (((o == 0) &&
>> +			     (info->matrix_mux_init[i] == info->pcm_start)) ||
>> +			    ((o == 1) &&
>> +			     (info->matrix_mux_init[i] == info->pcm_start + 1))
>> +			   ) {
>> +				INIT(0); /* hack: enable PCM 1/2 on Mix A/B */
>> +			}
>> +		}
>> +	}
>> +
>> +	for (i = 0; i < info->input_len; i++) {
>> +		snprintf(mx, 32, "Input Source %02d Capture Route", i+1);
>> +		CTL_ENUM(0x34, 0x00, i, mx, &info->opt_master);
>> +		INIT(info->analog_start + i);
>> +	}
>> +
>> +	/* val_len == 1 needed here */
>> +	err = add_new_ctl(mixer, &usb_scarlett_ctl_enum, 0x28, 0x01, 0,
>> +			  USB_MIXER_U8, 1, "Sample Clock Source",
>> +			  &opt_clock, &elem);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	/* val_len == 1 and UAC2_CS_MEM */
>> +	err = add_new_ctl(mixer, &usb_scarlett_ctl_sync, 0x3c, 0x00, 2,
>> +			  USB_MIXER_U8, 1, "Sample Clock Sync Status",
>> +			  &opt_sync, &elem);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	/* val_len == 1 and UAC2_CS_MEM */
>> +	err = add_new_ctl(mixer, &usb_scarlett_ctl_save, 0x3c, 0x00, 0x5a,
>> +			  USB_MIXER_U8, 1, "Save To HW", &opt_save, &elem);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	/* initialize sampling rate to 48000 */
>> +	err = snd_usb_ctl_msg(mixer->chip->dev,
>> +		usb_sndctrlpipe(mixer->chip->dev, 0), UAC2_CS_CUR,
>> +		USB_RECIP_INTERFACE | USB_TYPE_CLASS |
>> +		USB_DIR_OUT, 0x0100, snd_usb_ctrl_intf(mixer->chip) |
>> +		(0x29 << 8), sample_rate_buffer, 4);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	return 0;
>> +}
>> diff --git a/sound/usb/mixer_scarlett.h b/sound/usb/mixer_scarlett.h
>> new file mode 100644
>> index 0000000..19c592a
>> --- /dev/null
>> +++ b/sound/usb/mixer_scarlett.h
>> @@ -0,0 +1,6 @@
>> +#ifndef __USB_MIXER_SCARLETT_H
>> +#define __USB_MIXER_SCARLETT_H
>> +
>> +int snd_scarlett_controls_create(struct usb_mixer_interface *mixer);
>> +
>> +#endif /* __USB_MIXER_SCARLETT_H */
>> -- 
>> 2.1.0
>>
> 
