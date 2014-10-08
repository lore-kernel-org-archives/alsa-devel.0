From: Daniel Mack <daniel@zonque.org>
Subject: Re: [WIP PATCH] Scarlett mixer interface for 6i6, 18i6,
 18i8 and 18i20.
Date: Wed, 08 Oct 2014 21:04:06 +0200
Message-ID: <54358AA6.7040205@zonque.org>
References: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 27FAA2604C5
 for <alsa-devel@alsa-project.org>; Wed,  8 Oct 2014 21:04:10 +0200 (CEST)
In-Reply-To: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, robin@gareus.org, clemens@ladisch.de, smilingthax@googlemail.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 10/07/2014 05:16 PM, David Henningsson wrote:
> Author: Tobias Hoffman <th55@gmx.de>
> Author: Robin Gareus <robin@gareus.org>
> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
> ---
> 
> So, this is how Tobias' and Robin's patch look now. I've merged it all to one
> big patch, both for my own simplicity and because I thought that made the most
> sense. I've also fixed most checkpatch stuff (apart from long lines warnings).
> 
> It's not ready for merging yet, I assume. But it would be good with a hint w r t
> what the big issues are with this patch as you see it. And then we could see if I
> have some spare cycles to fix that up, or not.
> 

Thanks for doing that!

I've done a first round of superficial review. In general, the #ifdefs
have to be cleaned up, and dead code (such that is inside of comments)
has to be removed or turned into something useful.

Also, some comments imply that not all code paths have been tested
really. It would be nice if that could be done. AFAIR there were some
volunteers that wanted to help with testing.

Some more comments inline.


Best regards,
Daniel


> diff --git a/sound/usb/scarlettmixer.c b/sound/usb/scarlettmixer.c
> new file mode 100644
> index 0000000..873d5d6
> --- /dev/null
> +++ b/sound/usb/scarlettmixer.c

...

> +#include <linux/slab.h>
> +#include <linux/usb.h>
> +#include <linux/usb/audio-v2.h>
> +
> +#include <sound/core.h>
> +#include <sound/control.h>
> +#include <sound/tlv.h>
> +
> +#include "usbaudio.h"
> +#include "mixer.h"
> +#include "helper.h"
> +#include "power.h"
> +
> +#include "scarlettmixer.h"
> +
> +/* #define WITH_METER */
> +/* #define WITH_LOGSCALEMETER */

These should either be converted to module parameters, or removed
alltogether. Why are they configurable, anyway?

> +#define LEVEL_BIAS 128  /* some gui mixers can't handle negative ctl values (alsamixergui, qasmixer, ...) */
> +
> +#ifndef LEVEL_BIAS
> +	#define LEVEL_BIAS 0
> +#endif

Same here.

> +static void scarlett_mixer_elem_free(struct snd_kcontrol *kctl)
> +{
> +	kfree(kctl->private_data);
> +	kctl->private_data = NULL;
> +}
> +
> +/***************************** Low Level USB I/O *****************************/
> +
> +/* stripped down/adapted from get_ctl_value_v2 */
> +static int get_ctl_urb2(struct snd_usb_audio *chip,
> +		int bRequest, int wValue, int index,
> +		unsigned char *buf, int size)
> +{
> +	int ret, idx = 0;
> +
> +	ret = snd_usb_autoresume(chip);
> +	if (ret < 0 && ret != -ENODEV) {
> +		ret = -EIO;
> +		goto error;
> +	}
> +
> +	down_read(&chip->shutdown_rwsem);
> +	if (chip->shutdown) {
> +		ret = -ENODEV;
> +	} else {
> +		idx = snd_usb_ctrl_intf(chip) | (index << 8);
> +		ret = snd_usb_ctl_msg(chip->dev,
> +				      usb_rcvctrlpipe(chip->dev, 0),
> +				      bRequest,
> +				      USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN,
> +				      wValue, idx, buf, size);
> +	}
> +	up_read(&chip->shutdown_rwsem);
> +	snd_usb_autosuspend(chip);
> +
> +	if (ret < 0) {
> +error:
> +		snd_printk(KERN_ERR "cannot get ctl value: req = %#x, wValue = %#x, wIndex = %#x, size = %d\n",
> +			   bRequest, wValue, idx, size);
> +		return ret;
> +	}
> +#if 0 /* rg debug XXX */
> +	snd_printk(KERN_ERR "req ctl value: req = %#x, rtype = %#x, wValue = %#x, wIndex = %#x, size = %d\n",
> +		   bRequest, (USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_IN), wValue, idx, size);
> +#endif

That can be moved to snd_printdd()

> +	return 0;
> +}
> +
> +/* adopted from snd_usb_mixer_set_ctl_value */
> +static int set_ctl_urb2(struct snd_usb_audio *chip,
> +		int request, int wValue, int index,
> +		unsigned char *buf, int val_len)
> +{
> +	int idx = 0, err, timeout = 10;
> +
> +	err = snd_usb_autoresume(chip);
> +	if (err < 0 && err != -ENODEV)
> +		return -EIO;
> +	down_read(&chip->shutdown_rwsem);
> +	while (timeout-- > 0) {
> +		if (chip->shutdown)
> +			break;
> +		idx = snd_usb_ctrl_intf(chip) | (index << 8);
> +		if (snd_usb_ctl_msg(chip->dev,
> +				    usb_sndctrlpipe(chip->dev, 0), request,
> +				    USB_RECIP_INTERFACE | USB_TYPE_CLASS | USB_DIR_OUT,
> +				    wValue, idx, buf, val_len) >= 0) {
> +			err = 0;
> +			goto out;
> +		}
> +	}
> +	snd_printdd(KERN_ERR "cannot set ctl value: req = %#x, wValue = %#x, wIndex = %#x, len = %d, data = %#x/%#x\n",
> +		    request, wValue, idx, val_len, buf[0], buf[1]);
> +	err = -EINVAL;
> +
> + out:
> +	up_read(&chip->shutdown_rwsem);
> +	snd_usb_autosuspend(chip);
> +#if 0 /* rg debug XXX */
> +	snd_printk(KERN_ERR "set ctl value: req = %#x, wValue = %#x, wIndex = %#x, len = %d, data = %#x/%#x\n",
> +		    request, wValue, idx, val_len, buf[0], buf[1]);
> +#endif

Same here.

...

> +static int sig_to_db(const int sig16bit)
> +{
> +	int i;
> +	const int dbtbl[148] = {
> +		13, 14, 15, 16, 16, 17, 18, 20, 21, 22, 23, 25, 26, 28, 29, 31, 33, 35,
> +		37, 39, 41, 44, 46, 49, 52, 55, 58, 62, 66, 69, 74, 78, 83, 87, 93, 98,
> +		104, 110, 117, 123, 131, 139, 147, 155, 165, 174, 185, 196, 207, 220,
> +		233, 246, 261, 276, 293, 310, 328, 348, 369, 390, 414, 438, 464, 491,
> +		521, 551, 584, 619, 655, 694, 735, 779, 825, 874, 926, 981, 1039, 1100,
> +		1165, 1234, 1308, 1385, 1467, 1554, 1646, 1744, 1847, 1957, 2072, 2195,
> +		2325, 2463, 2609, 2764, 2927, 3101, 3285, 3479, 3685, 3904, 4135, 4380,
> +		4640, 4915, 5206, 5514, 5841, 6187, 6554, 6942, 7353, 7789, 8250, 8739,
> +		9257, 9806, 10387, 11002, 11654, 12345, 13076, 13851, 14672, 15541,
> +		16462, 17437, 18471, 19565, 20724, 21952, 23253, 24631, 26090, 27636,
> +		29274, 31008, 32846, 34792, 36854, 39037, 41350, 43801, 46396, 49145,
> +		52057, 55142, 58409, 61870
> +	};
> +
> +	if (sig16bit < 13) {
> +		switch (sig16bit) {
> +		case  0: return 0;
> +		case  1: return 1;  /* -96.0dB */
> +		case  2: return 13; /* -90.5dB */
> +		case  3: return 20; /* -87.0dB */
> +		case  4: return 26; /* -84.0dB */
> +		case  5: return 29; /* -82.5dB */
> +		case  6: return 32; /* -81.0dB */
> +		case  7: return 35; /* -79.5dB */
> +		case  8: return 37; /* -78.5dB */
> +		case  9: return 39; /* -77.5dB */
> +		case 10: return 41; /* -76.5dB */
> +		case 11: return 43; /* -75.5dB */
> +		case 12: return 45; /* -74.5dB */
> +		}
> +	}

I'd say a lookup table is nicer here, but that's a nit.

> +static int scarlett_ctl_enum_get(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct scarlett_mixer_elem_info *elem = kctl->private_data;
> +	int err, val;
> +
> +	err = get_ctl_value(elem, 0, &val);
> +	if (err < 0)
> +		return err;
> +
> +	/* snd_printk(KERN_WARNING "enum %s: %x %x\n", ucontrol->id.name, val, elem->opt->len); */

No dead code in general. Either remove it or use snd_printd[d].

> +static int scarlett_ctl_enum_put(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct scarlett_mixer_elem_info *elem = kctl->private_data;
> +	int changed = 0;
> +	int err, oval, val;
> +
> +	err = get_ctl_value(elem, 0, &oval);
> +	if (err < 0)
> +		return err;
> +
> +	val = ucontrol->value.integer.value[0];
> +#if 0 /* TODO? */
> +	if (val == -1) {
> +		val = elem->enum->len + 1; /* only true for master, not for mixer [also master must be used] */
> +		/* ... or? > 0x20,  18i8: 0x22 */
> +	} else
> +#endif

Could someone with access to such hardware sort that out, maybe? :)


> +static int scarlett_ctl_save_put(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct scarlett_mixer_elem_info *elem = kctl->private_data;
> +	int err;
> +
> +	if (ucontrol->value.enumerated.item[0] > 0) {
> +		char buf[1] = { 0xa5 };
> +
> +		err = set_ctl_urb2(elem->mixer->chip, UAC2_CS_MEM, 0x005a, 0x3c, buf, 1);
> +		if (err < 0)
> +			return err;
> +
> +		snd_printk(KERN_INFO "Scarlett: Saved settings to hardware.\n");
> +	}
> +
> +	return 0; /* (?) */

What's the confusion here? :)

...

> +#define INIT(value) \
> +	do { \
> +		err = init_ctl(elem, value); \
> +		if (err < 0) \
> +			return err; \
> +	} while (0)
> +
> +#define CTL_SWITCH(cmd, off, no, count, name) \
> +	do { \
> +		err = add_new_ctl(mixer, &usb_scarlett_ctl_switch, cmd, off, no, 2, count, name, NULL, &elem); \
> +		if (err < 0) \
> +			return err; \
> +	} while (0)
> +
> +/* no multichannel enum, always count == 1  (at least for now) */
> +#define CTL_ENUM(cmd, off, no, name, opt) \
> +	do { \
> +		err = add_new_ctl(mixer, &usb_scarlett_ctl_enum, cmd, off, no, 2, 1, name, opt, &elem); \
> +		if (err < 0) \
> +			return err; \
> +	} while (0)
> +
> +#define CTL_MIXER(cmd, off, no, count, name) \
> +	do { \
> +		err = add_new_ctl(mixer, &usb_scarlett_ctl, cmd, off, no, 2, count, name, NULL, &elem); \
> +		if (err < 0) \
> +			return err; \
> +		INIT(-32768); /* -128*256 */  \
> +	} while (0)
> +
> +#define CTL_MASTER(cmd, off, no, count, name) \
> +	do { \
> +		err = add_new_ctl(mixer, &usb_scarlett_ctl_master, cmd, off, no, 2, count, name, NULL, &elem); \
> +		if (err < 0) \
> +			return err; \
> +		INIT(0); \
> +	} while (0)
> +
> +#define CTL_PEAK(cmd, off, no, count, name)  /* but UAC2_CS_MEM */ \
> +	do { \
> +		err = add_new_ctl(mixer, &usb_scarlett_ctl_meter, cmd, off, no, 2, count, name, NULL, NULL); \
> +		if (err < 0) \
> +			return err; \
> +	} while (0)
> +
> +static int add_output_ctls(struct usb_mixer_interface *mixer,
> +			   int index, const char *name,
> +			   const struct scarlett_device_info *info)
> +{
> +	int err;
> +	char mx[45];
> +	struct scarlett_mixer_elem_info *elem;
> +
> +	snprintf(mx, 45, "Master %d (%s) Playback Switch", index+1, name); /* mute */
> +	CTL_SWITCH(0x0a, 0x01, 2*index+1, 2, mx);
> +
> +	snprintf(mx, 45, "Master %d (%s) Playback Volume", index+1, name);
> +	CTL_MASTER(0x0a, 0x02, 2*index+1, 2, mx);
> +
> +	snprintf(mx, 45, "Master %dL (%s) Source Playback Enum", index+1, name);
> +	CTL_ENUM(0x33, 0x00, 2*index, mx, &info->opt_master);
> +	INIT(info->mix_start);
> +
> +	snprintf(mx, 45, "Master %dR (%s) Source Playback Enum", index+1, name);
> +	CTL_ENUM(0x33, 0x00, 2*index+1, mx, &info->opt_master);
> +	INIT(info->mix_start + 1);

Hmm, I don't really like the style of magically returning from macros.
That makes the control flow uneasy to read IMO. Couldn't something with
statically initialized structs be done here, and then keep the code that
does the work generic? I haven't tried to implement that, just an idea.

...

> +/*  untested...  */
> +static const struct scarlett_device_info s6i6_info = {

Would be nice to get some testers here.

> +	.matrix_in = 18,
> +	.matrix_out = 8,
> +	.input_len = 6,
> +	.output_len = 6,
> +
> +	.pcm_start = 0,
> +	.analog_start = 12,
> +	.spdif_start = 16,
> +	.adat_start = 18,
> +	.mix_start = 18,
> +
> +	.opt_master = {
> +		.start = -1,
> +		.len = 27,
> +		.texts = s6i6_texts
> +	},
> +
> +	.opt_matrix = {
> +		.start = -1,
> +		.len = 19,
> +		.texts = s6i6_texts
> +	},
> +
> +	.controls_fn = scarlet_s6i6_controls,
> +	.matrix_mux_init = {
> +		12, 13, 14, 15,                 /* Analog -> 1..4 */
> +		16, 17,                          /* SPDIF -> 5,6 */
> +		0, 1, 2, 3, 4, 5, 6, 7,     /* PCM[1..12] -> 7..18 */
> +		8, 9, 10, 11
> +	}
> +};
> +
> +/* and 2 loop channels: Mix1, Mix2 */
> +static const char * const s8i6_texts[] = {
> +	txtOff, /* 'off' == 0xff */
> +	txtPcm1, txtPcm2, txtPcm3, txtPcm4,
> +	txtPcm5, txtPcm6, txtPcm7, txtPcm8,
> +	txtPcm9, txtPcm10, txtPcm11, txtPcm12,
> +	txtAnlg1, txtAnlg2, txtAnlg3, txtAnlg4,
> +	txtSpdif1, txtSpdif2,
> +	txtMix1, txtMix2, txtMix3, txtMix4,
> +	txtMix5, txtMix6
> +};
> +
> +/*  untested...  */
> +static const struct scarlett_device_info s8i6_info = {
> +	.matrix_in = 18,
> +	.matrix_out = 6,
> +	.input_len = 8,
> +	.output_len = 6,
> +
> +	.pcm_start = 0,
> +	.analog_start = 12,
> +	.spdif_start = 16,
> +	.adat_start = 18,
> +	.mix_start = 18,
> +
> +	.opt_master = {
> +		.start = -1,
> +		.len = 25,
> +		.texts = s8i6_texts
> +	},
> +
> +	.opt_matrix = {
> +		.start = -1,
> +		.len = 19,
> +		.texts = s8i6_texts
> +	},
> +
> +	.controls_fn = scarlet_s8i6_controls,
> +	.matrix_mux_init = {
> +		12, 13, 14, 15,                 /* Analog -> 1..4 */
> +		16, 17,                          /* SPDIF -> 5,6 */
> +		0, 1, 2, 3, 4, 5, 6, 7,     /* PCM[1..12] -> 7..18 */
> +		8, 9, 10, 11
> +	}
> +};
> +
> +static const char * const s18i6_texts[] = {
> +	txtOff, /* 'off' == 0xff */
> +	txtPcm1, txtPcm2, txtPcm3, txtPcm4,
> +	txtPcm5, txtPcm6,
> +	txtAnlg1, txtAnlg2, txtAnlg3, txtAnlg4,
> +	txtAnlg5, txtAnlg6, txtAnlg7, txtAnlg8,
> +	txtSpdif1, txtSpdif2,
> +	txtAdat1, txtAdat2, txtAdat3, txtAdat4,
> +	txtAdat5, txtAdat6, txtAdat7, txtAdat8,
> +	txtMix1, txtMix2, txtMix3, txtMix4,
> +	txtMix5, txtMix6
> +};
> +
> +static const struct scarlett_device_info s18i6_info = {
> +	.matrix_in = 18,
> +	.matrix_out = 6,
> +	.input_len = 18,
> +	.output_len = 6,
> +
> +	.pcm_start = 0,
> +	.analog_start = 6,
> +	.spdif_start = 14,
> +	.adat_start = 16,
> +	.mix_start = 24,
> +
> +	.opt_master = {
> +		.start = -1,
> +		.len = 31,
> +		.texts = s18i6_texts
> +	},
> +
> +	.opt_matrix = {
> +		.start = -1,
> +		.len = 25,
> +		.texts = s18i6_texts
> +	},
> +
> +	.controls_fn = scarlet_s18i6_controls,
> +	.matrix_mux_init = {
> +		 6,  7,  8,  9, 10, 11, 12, 13, /* Analog -> 1..8 */
> +		16, 17, 18, 19, 20, 21,     /* ADAT[1..6] -> 9..14 */
> +		14, 15,                          /* SPDIF -> 15,16 */
> +		0, 1                          /* PCM[1,2] -> 17,18 */
> +	}
> +};
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

Here, and in some other occasions, ARRAY_SIZE() should be used.

> +	.opt_matrix = {
> +		.start = -1,
> +		.len = 27,
> +		.texts = s18i8_texts
> +	},

Same here.

> +static const struct scarlett_device_info s18i20_info = {
> +	.matrix_in = 18,
> +	.matrix_out = 8,
> +	.input_len = 18,
> +	.output_len = 20,
> +
> +	.pcm_start = 0,
> +	.analog_start = 20,
> +	.spdif_start = 28,
> +	.adat_start = 30,
> +	.mix_start = 38,
> +
> +	.opt_master = {
> +		.start = -1,
> +		.len = 47,
> +		.texts = s18i20_texts
> +	},

Dito

> +
> +	.opt_matrix = {
> +		.start = -1,
> +		.len = 39,
> +		.texts = s18i20_texts
> +	},

Dito

> +
> +	.controls_fn = scarlet_s18i20_controls,
> +	.matrix_mux_init = {
> +		20, 21, 22, 23, 24, 25, 26, 27, /* Analog -> 1..8 */
> +		30, 31, 32, 33, 34, 35,     /* ADAT[1..6] -> 9..14 */
> +		28, 29,                          /* SPDIF -> 15,16 */
> +		0, 1                          /* PCM[1,2] -> 17,18 */
> +	}
> +};
> +
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

Should be removed, or get a real implementation.
