From: Julian Scheel <julian@jusst.de>
Subject: Re: [PATCH] ALSA: usb-audio: Fix parameter block size
 for UAC2 control requests
Date: Fri, 14 Aug 2015 15:45:58 +0200
Message-ID: <55CDF116.8070400@jusst.de>
References: <1439463886-5369-1-git-send-email-julian@jusst.de>
 <s5hpp2qt3ei.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender163-mail.zoho.com (sender163-mail.zoho.com
 [74.201.84.163])
 by alsa0.perex.cz (Postfix) with ESMTP id A6B412654B3
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2015 15:46:04 +0200 (CEST)
In-Reply-To: <s5hpp2qt3ei.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am 14.08.2015 um 15:17 schrieb Takashi Iwai:
> On Thu, 13 Aug 2015 13:04:46 +0200,
> Julian Scheel wrote:
>>
>> USB Audio Class version 2.0 supports three different parameter block sizes for
>> CUR requests, which are 1 byte (5.2.3.1 Layout 1 Parameter Block), 2 bytes
>> (5.2.3.2 Layout 2 Parameter Block) and 4 bytes (5.2.3.3 Layout 3 Parameter
>> Block). Use the correct size according to the specific control as it was
>> already done for UACv1. The allocated block size for control requests is
>> increased to support the 4 byte worst case.
>>
>> Signed-off-by: Julian Scheel <julian@jusst.de>
>> ---
>>   sound/usb/mixer.c | 83 +++++++++++++++++++++++++++++++++++++++++--------------
>>   sound/usb/mixer.h |  2 ++
>>   2 files changed, 65 insertions(+), 20 deletions(-)
>>
>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>> index 4a49944..675725b 100644
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -233,6 +233,14 @@ static int convert_signed_value(struct usb_mixer_elem_info *cval, int val)
>>   		if (val >= 0x8000)
>>   			val -= 0x10000;
>>   		break;
>> +	case USB_MIXER_U32:
>> +		val &= 0xffffffff;
>> +		break;
>> +	case USB_MIXER_S32:
>> +		val &= 0xffffffff;
>> +		if (val >= 0x80000000)
>> +			val -= 0x100000000;
>> +		break;
>
> All these are superfluous, as int on Linux is always 32bit.

Of course. Thanks.

>>   	}
>>   	return val;
>>   }
>> @@ -253,6 +261,9 @@ static int convert_bytes_value(struct usb_mixer_elem_info *cval, int val)
>>   	case USB_MIXER_S16:
>>   	case USB_MIXER_U16:
>>   		return val & 0xffff;
>> +	case USB_MIXER_S32:
>> +	case USB_MIXER_U32:
>> +		return val & 0xffffffff;
>
> Ditto.
>
>
>>   	}
>>   	return 0; /* not reached */
>>   }
>> @@ -328,14 +339,26 @@ static int get_ctl_value_v2(struct usb_mixer_elem_info *cval, int request,
>>   			    int validx, int *value_ret)
>>   {
>>   	struct snd_usb_audio *chip = cval->head.mixer->chip;
>> -	unsigned char buf[2 + 3 * sizeof(__u16)]; /* enough space for one range */
>> +	unsigned char buf[4 + 3 * sizeof(__u32)]; /* enough space for one range */
>>   	unsigned char *val;
>>   	int idx = 0, ret, size;
>>   	__u8 bRequest;
>>
>>   	if (request == UAC_GET_CUR) {
>>   		bRequest = UAC2_CS_CUR;
>> -		size = sizeof(__u16);
>> +		switch (cval->val_type) {
>> +			case USB_MIXER_S32:
>> +			case USB_MIXER_U32:
>> +				size = 4;
>> +				break;
>> +			case USB_MIXER_S16:
>> +			case USB_MIXER_U16:
>> +				size = 2;
>> +				break;
>> +			default:
>> +				size = 1;
>> +				break;
>
> Please split this into a small helper function,
> e.g. uac2_ctl_value_size().  The same stuff is used in below, too.

Ack.

>> +		}
>>   	} else {
>>   		bRequest = UAC2_CS_RANGE;
>>   		size = sizeof(buf);
>> @@ -446,7 +469,7 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
>>   				int request, int validx, int value_set)
>>   {
>>   	struct snd_usb_audio *chip = cval->head.mixer->chip;
>> -	unsigned char buf[2];
>> +	unsigned char buf[4];
>>   	int idx = 0, val_len, err, timeout = 10;
>>
>>   	validx += cval->idx_off;
>> @@ -454,8 +477,19 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
>>   	if (cval->head.mixer->protocol == UAC_VERSION_1) {
>>   		val_len = cval->val_type >= USB_MIXER_S16 ? 2 : 1;
>>   	} else { /* UAC_VERSION_2 */
>> -		/* audio class v2 controls are always 2 bytes in size */
>> -		val_len = sizeof(__u16);
>> +		switch (cval->val_type) {
>> +			case USB_MIXER_S32:
>> +			case USB_MIXER_U32:
>> +				val_len = 4;
>> +				break;
>> +			case USB_MIXER_S16:
>> +			case USB_MIXER_U16:
>> +				val_len = 2;
>> +				break;
>> +			default:
>> +				val_len = 1;
>> +				break;
>> +		}
>>
>>   		/* FIXME */
>>   		if (request != UAC_SET_CUR) {
>> @@ -469,6 +503,8 @@ int snd_usb_mixer_set_ctl_value(struct usb_mixer_elem_info *cval,
>>   	value_set = convert_bytes_value(cval, value_set);
>>   	buf[0] = value_set & 0xff;
>>   	buf[1] = (value_set >> 8) & 0xff;
>> +	buf[2] = (value_set >> 16) & 0xff;
>> +	buf[3] = (value_set >> 24) & 0xff;
>
> It's not smart but OK, just a subtle matter...

Hm, what would you like better?

>>   	err = snd_usb_autoresume(chip);
>>   	if (err < 0)
>>   		return -EIO;
>> @@ -799,24 +835,25 @@ static int check_input_term(struct mixer_build *state, int id,
>>   /* feature unit control information */
>>   struct usb_feature_control_info {
>>   	const char *name;
>> -	unsigned int type;	/* control type (mute, volume, etc.) */
>> +	int type;	/* data type for uac1 */
>> +	int type_uac2;	/* data type for uac2 if different from uac1, else -1 */
>>   };
>>
>>   static struct usb_feature_control_info audio_feature_info[] = {
>> -	{ "Mute",			USB_MIXER_INV_BOOLEAN },
>> -	{ "Volume",			USB_MIXER_S16 },
>> -	{ "Tone Control - Bass",	USB_MIXER_S8 },
>> -	{ "Tone Control - Mid",		USB_MIXER_S8 },
>> -	{ "Tone Control - Treble",	USB_MIXER_S8 },
>> -	{ "Graphic Equalizer",		USB_MIXER_S8 }, /* FIXME: not implemeted yet */
>> -	{ "Auto Gain Control",		USB_MIXER_BOOLEAN },
>> -	{ "Delay Control",		USB_MIXER_U16 }, /* FIXME: U32 in UAC2 */
>> -	{ "Bass Boost",			USB_MIXER_BOOLEAN },
>> -	{ "Loudness",			USB_MIXER_BOOLEAN },
>> +	{ "Mute",			USB_MIXER_INV_BOOLEAN, -1 },
>> +	{ "Volume",			USB_MIXER_S16, -1 },
>> +	{ "Tone Control - Bass",	USB_MIXER_S8, -1 },
>> +	{ "Tone Control - Mid",		USB_MIXER_S8, -1 },
>> +	{ "Tone Control - Treble",	USB_MIXER_S8, -1 },
>> +	{ "Graphic Equalizer",		USB_MIXER_S8, -1 }, /* FIXME: not implemeted yet */
>> +	{ "Auto Gain Control",		USB_MIXER_BOOLEAN, -1 },
>> +	{ "Delay Control",		USB_MIXER_U16, USB_MIXER_U32 },
>> +	{ "Bass Boost",			USB_MIXER_BOOLEAN, -1 },
>> +	{ "Loudness",			USB_MIXER_BOOLEAN, -1 },
>>   	/* UAC2 specific */
>> -	{ "Input Gain Control",		USB_MIXER_S16 },
>> -	{ "Input Gain Pad Control",	USB_MIXER_S16 },
>> -	{ "Phase Inverter Control",	USB_MIXER_BOOLEAN },
>> +	{ "Input Gain Control",		USB_MIXER_S16, -1 },
>> +	{ "Input Gain Pad Control",	USB_MIXER_S16, -1 },
>> +	{ "Phase Inverter Control",	USB_MIXER_BOOLEAN, -1 },
>>   };
>>
>>   /* private_free callback */
>> @@ -1241,7 +1278,13 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
>>   	snd_usb_mixer_elem_init_std(&cval->head, state->mixer, unitid);
>>   	cval->control = control;
>>   	cval->cmask = ctl_mask;
>> -	cval->val_type = audio_feature_info[control-1].type;
>> +	if (state->mixer->protocol == UAC_VERSION_1)
>> +		cval->val_type = audio_feature_info[control-1].type;
>> +	else /* UAC_VERSION_2 */
>> +		cval->val_type = audio_feature_info[control-1].type_uac2 > -1 ?
>
> Usually ">= 0" is used.

Ack.

>> +			audio_feature_info[control-1].type_uac2 :
>> +			audio_feature_info[control-1].type;
>
> Since audio_feature_info[control-1] is referred so many times, it's
> better to put in a temporary variable.

Ack.

Thanks for reviewing!
-Julian
