From: Tobias Hoffmann <smilingthax@googlemail.com>
Subject: Re: [WIP PATCH] Scarlett mixer interface for 6i6, 18i6,
 18i8 and 18i20.
Date: Thu, 09 Oct 2014 00:49:57 +0200
Message-ID: <5435BF95.2040909@googlemail.com>
References: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>
 <54358AA6.7040205@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f42.google.com (mail-la0-f42.google.com
 [209.85.215.42])
 by alsa0.perex.cz (Postfix) with ESMTP id C3E2E2604CF
 for <alsa-devel@alsa-project.org>; Thu,  9 Oct 2014 00:50:06 +0200 (CEST)
Received: by mail-la0-f42.google.com with SMTP id mk6so68776lab.29
 for <alsa-devel@alsa-project.org>; Wed, 08 Oct 2014 15:50:06 -0700 (PDT)
In-Reply-To: <54358AA6.7040205@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, robin@gareus.org, clemens@ladisch.de, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

And some more comments from me:

On 08/10/14 21:04, Daniel Mack wrote:
> +
> +/* #define WITH_METER */
> +/* #define WITH_LOGSCALEMETER */
> These should either be converted to module parameters, or removed
> alltogether. Why are they configurable, anyway?

As I've said in my earlier mail, code is current not working: Metering 
should be removed from this patch (or rewritten to use hwdep-API).

>> +#define LEVEL_BIAS 128  /* some gui mixers can't handle negative ctl values (alsamixergui, qasmixer, ...) */
>> +
>> +#ifndef LEVEL_BIAS
>> +	#define LEVEL_BIAS 0
>> +#endif
> Same here.
As LEVEL_BIAS = 0 definitely causes problems with some mixer GUIs, the 
#ifndef ... #endif should be removed completely.


>
>> +#if 0 /* rg debug XXX */
>> +	snd_printk(KERN_ERR "req ctl value: req = %#x, rtype = %#x, wValue = %#x, wIndex = %#x, size = %d\n",
>> +		   bRequest, (USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN), wValue, idx, size);
>> +#endif
> That can be moved to snd_printdd()

These are left overs from Robins code, even I didn't need them. It's 
probably safe to just remove all the
   #if 0 /* rg debug XXX */  ... #endif
from the patch.

>> +static int scarlett_ctl_enum_put(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct scarlett_mixer_elem_info *elem = kctl->private_data;
>> +	int changed = 0;
>> +	int err, oval, val;
>> +
>> +	err = get_ctl_value(elem, 0,&oval);
>> +	if (err<  0)
>> +		return err;
>> +
>> +	val = ucontrol->value.integer.value[0];
>> +#if 0 /* TODO? */
>> +	if (val == -1) {
>> +		val = elem->enum->len + 1; /* only true for master, not for mixer [also master must be used] */
>> +		/* ... or?>  0x20,  18i8: 0x22 */
>> +	} else
>> +#endif
> Could someone with access to such hardware sort that out, maybe? :)

The current code works as-is, so #if 0 ... #endif can be removed.

>
>> +static int scarlett_ctl_save_put(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct scarlett_mixer_elem_info *elem = kctl->private_data;
>> +	int err;
>> +
>> +	if (ucontrol->value.enumerated.item[0]>  0) {
>> +		char buf[1] = { 0xa5 };
>> +
>> +		err = set_ctl_urb2(elem->mixer->chip, UAC2_CS_MEM, 0x005a, 0x3c, buf, 1);
>> +		if (err<  0)
>> +			return err;
>> +
>> +		snd_printk(KERN_INFO "Scarlett: Saved settings to hardware.\n");
>> +	}
>> +
>> +	return 0; /* (?) */
> What's the confusion here? :)

The "Save to HW" enum uses a special kcontrol .get/.put combo:
.get always returns 0, and .put issues a special command to the hardware.

I not 100% sure what the "best" return value of the .put function would 
be in that case.
AFAIUI, .put functions have to return whether the value has changed... 
and here:
  - something happend (supporting return 1;)
  - but .get still returns 0 (supporting return 0;)

But I found this...:
> +static struct snd_kcontrol_new usb_scarlett_ctl_save = {
> +	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
> +	.name = "",
> +	.info = scarlett_ctl_enum_info,
> +	.get =  scarlett_ctl_save_get,
> +	.get =  scarlett_ctl_save_put,
> +};

BUG! .get is set twice instead of .get and .put...

Testing is definitely needed for that change.

>> +/*  untested...  */
>> +static const struct scarlett_device_info s6i6_info = {
> Would be nice to get some testers here.

I did heard of one person who used it (successfully) on s6i6.
That's not to say that we should not test the "final" patch on each device.

> +
> +/*  untested...  */
> +static const struct scarlett_device_info s8i6_info = {
I can't remember any users with s8i6 right now...

I have a s18i8.

s18i6 is what the original code did, but I have not heard of tests with 
the new code.

A few s18i20 users reported "no problems".

> +
> +static const char * const s18i8_texts[] = {
> +	txtOff, /* 'off' == 0xff  (original software: 0x22) */
> +	txtPcm1, txtPcm2, txtPcm3, txtPcm4,
> +	txtPcm5, txtPcm6, txtPcm7, txtPcm8,
> +	txtAnlg1, txtAnlg2, txtAnlg3, txtAnlg4,
> +	txtAnlg5, txtAnlg6, txtAnlg7, txtAnlg8,
> +	txtSpdif1, txtSpdif2,
> +	txtAdat1, txtAdat2, txtAdat3, txtAdat4,
> +	txtAdat5, txtAdat6, txtAdat7, txtAdat8,
> +	txtMix1, txtMix2, txtMix3, txtMix4,
> +	txtMix5, txtMix6, txtMix7, txtMix8
> +};
> +
> +static const struct scarlett_device_info s18i8_info = {
> +	.matrix_in = 18,
> +	.matrix_out = 8,
> +	.input_len = 18,
> +	.output_len = 8,
> +
> +	.pcm_start = 0,
> +	.analog_start = 8,
> +	.spdif_start = 16,
> +	.adat_start = 18,
> +	.mix_start = 26,
> +
> +	.opt_master = {
> +		.start = -1,
> +		.len = 35,
> +		.texts = s18i8_texts
> +	},
> Here, and in some other occasions, ARRAY_SIZE() should be used.
>
>> +	.opt_matrix = {
>> +		.start = -1,
>> +		.len = 27,
>> +		.texts = s18i8_texts
>> +	},
> Same here.

ARRAY_SIZE(s18i8_text) == 35, so  .len = (ARRAY_SIZE()-8) ?
I not sure that's helpful...
The better way to think about it is:
   .opt_matrix.len = .mix_start + 1,
   .opt_master.len = .opt_matrix.len + .matrix_out    // == ARRAY_SIZE()

> +/*
> +int scarlett_reset(struct usb_mixer_interface *mixer)
> +{
> +	 TODO? save first-time init flag into device?
> +
> +	 unmute [master +] mixes (switches are currently not initialized)
> +	 [set(get!) impedance: 0x01, 0x09, 1..2]
> +	 [set(get!) 0x01, 0x08, 3..4]
> +	 [set(get!) pad: 0x01, 0x0b, 1..4]
> +
> +	 matrix inputs (currently in scarlett_mixer_controls)
> +}
> +*/
> Should be removed, or get a real implementation.
Remove. Just some random ideas.

   Tobias
