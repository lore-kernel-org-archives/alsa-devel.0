From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Tests of the hda-jack branch
Date: Wed, 30 Nov 2011 10:10:04 +0800
Message-ID: <CAN8cciYpPX0MrjngyTecWXX-8UtTzVBjLNQ_pT16aZdk4OoJfg@mail.gmail.com>
References: <4ED535CA.1080108@canonical.com>
	<4ED545E1.3040409@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BEAC0103991
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 03:10:04 +0100 (CET)
Received: by bkat8 with SMTP id t8so145430bka.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 18:10:04 -0800 (PST)
In-Reply-To: <4ED545E1.3040409@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/11/30 Clemens Ladisch <clemens@ladisch.de>:
> David Henningsson wrote:
>> ... two patches - one adds a "device index" for mapping against pcm
>> devices on HDMI,
>
>> + =A0 =A0 kctl->id.device =3D device;
>
> In the general case, there is not always a 1:1 mapping between jacks and
> PCM devices, so I fear that a jack belonging to device 0 cannot be
> distinguished from a jack that has no specific device.
>
> There is a convention that id.device is a valid PCM device number if and
> only if id.iface is IFACE_PCM. =A0However, it might be useful to map
> controls with IFACE_MIXER to PCM devices, so I'd propose a new TLV, like
> in the incomplete patch below.
>
>
> Regards,
> Clemens
>
>
> --- a/include/sound/tlv.h
> +++ b/include/sound/tlv.h
> @@ -37,6 +37,7 @@
> =A0#define SNDRV_CTL_TLVT_DB_RANGE 3 =A0 =A0 =A0/* dB range container */
> =A0#define SNDRV_CTL_TLVT_DB_MINMAX 4 =A0 =A0 /* dB scale with min/max */
> =A0#define SNDRV_CTL_TLVT_DB_MINMAX_MUTE 5 =A0 =A0 =A0 =A0/* dB scale wit=
h min/max with mute */
> +#define SNDRV_CTL_TLVT_PCM_DEVICE 6 =A0 =A0/* jack (or other control?) m=
aps to this device */
>
> =A0#define _TLV_ITEM(type, ...) \
> =A0 =A0 =A0 =A0(type), _TLV_LENGTH(__VA_ARGS__), __VA_ARGS__
> @@ -81,4 +82,9 @@
>
> =A0#define TLV_DB_GAIN_MUTE =A0 =A0 =A0 -9999999
>
> +#define TLB_PCM_DEVICE_NUMBER_ITEM(devno) \
> + =A0 =A0 =A0 SNDRV_CTL_TLVT_PCM_DEVICE, 1 * sizeof(unsigned int), (devno)
> +#define DECLARE_TLV_PCM_DEVICE_NUMBER(name, devno) \
> + =A0 =A0 =A0 unsigned int name[] =3D { TLV_PCM_DEVICE_NUMBER_ITEM(devno)=
 }
> +
> =A0#endif /* __SOUND_TLV_H */
> --- a/sound/pci/hda/hda_jack.c
> +++ b/sound/pci/hda/hda_jack.c
> @@ -15,6 +15,7 @@
> =A0#include <sound/core.h>
> =A0#include <sound/control.h>
> =A0#include <sound/jack.h>
> +#include <sound/tlv.h>
> =A0#include "hda_codec.h"
> =A0#include "hda_local.h"
> =A0#include "hda_jack.h"
> @@ -210,7 +211,7 @@ EXPORT_SYMBOL_HDA(snd_hda_jack_report_sync);
> =A0* will have the given name and index.
> =A0*/
> =A0int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *name, int i=
dx)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *name, int i=
dx, int device)
> =A0{
> =A0 =A0 =A0 =A0struct hda_jack_tbl *jack;
> =A0 =A0 =A0 =A0struct snd_kcontrol *kctl;
> @@ -223,6 +224,11 @@ int snd_hda_jack_add_kctl(struct hda_codec *codec, h=
da_nid_t nid,
> =A0 =A0 =A0 =A0kctl =3D snd_kctl_jack_new(name, idx, codec);
> =A0 =A0 =A0 =A0if (!kctl)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> + =A0 =A0 =A0 jack->tlv[0] =3D SNDRV_CTL_TLVT_PCM_DEVICE;
> + =A0 =A0 =A0 jack->tlv[1] =3D 1 * sizeof(unsigned int);
> + =A0 =A0 =A0 jack->tlv[2] =3D device;
> + =A0 =A0 =A0 kctl->tlv.p =3D jack->tlv;
> + =A0 =A0 =A0 kctl->access |=3D SNDRV_CTL_ELEM_ACCESS_TLV_READ;
> =A0 =A0 =A0 =A0if (snd_hda_ctl_add(codec, nid, kctl) < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> =A0 =A0 =A0 =A0jack->kctl =3D kctl;
> @@ -249,7 +255,7 @@ static int add_jack_kctl(struct hda_codec *codec, hda=
_nid_t nid,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0snd_hda_get_pin_label(codec, nid, cfg, name, sizeof(name),=
 &idx);
> - =A0 =A0 =A0 err =3D snd_hda_jack_add_kctl(codec, nid, name, idx);
> + =A0 =A0 =A0 err =3D snd_hda_jack_add_kctl(codec, nid, name, idx, 0);
> =A0 =A0 =A0 =A0if (err < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
> =A0 =A0 =A0 =A0return snd_hda_jack_detect_enable(codec, nid, 0);
> --- a/sound/pci/hda/hda_jack.h
> +++ b/sound/pci/hda/hda_jack.h
> @@ -22,6 +22,7 @@ struct hda_jack_tbl {
> =A0 =A0 =A0 =A0unsigned int jack_detect:1; =A0 =A0 /* capable of jack-det=
ection? */
> =A0 =A0 =A0 =A0unsigned int jack_dirty:1; =A0 =A0 =A0/* needs to update? =
*/
> =A0 =A0 =A0 =A0struct snd_kcontrol *kctl; =A0 =A0 =A0/* assigned kctl for=
 jack-detection */
> + =A0 =A0 =A0 unsigned int tlv[3];
> =A0#ifdef CONFIG_SND_HDA_INPUT_JACK
> =A0 =A0 =A0 =A0int type;
> =A0 =A0 =A0 =A0struct snd_jack *jack;
> @@ -76,7 +77,7 @@ static inline bool is_jack_detectable(struct hda_codec =
*codec, hda_nid_t nid)
> =A0}
>
> =A0int snd_hda_jack_add_kctl(struct hda_codec *codec, hda_nid_t nid,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *name, int i=
dx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *name, int i=
dx, int device);
> =A0int snd_hda_jack_add_kctls(struct hda_codec *codec,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct auto_pin=
_cfg *cfg);
>

Does this solve the problem of selecting the correct capture source
when the codec have more than one adc

1) realek codec with two adc , capture and alt_capture device

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 2: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Internal Mic' 'Line'
  Item0: 'Internal Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Internal Mic' 'Line'
  Item0: 'Mic'


2) ad198x codec with 3 adc and 3 capture subdevices

Line-Out Front Jack
Line-Out Surround Jack
Line-Out CLFE Jack
Line-Out Side Jack
Front Headphone Jack
Front Mic Jack
Rear Mic Jack
Line Jack

card 1: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 3/3
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2


Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mix' 'Front Mic' 'Rear Mic' 'Line' 'CD'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mix' 'Front Mic' 'Rear Mic' 'Line' 'CD'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',2
  Capabilities: cenum
  Items: 'Mix' 'Front Mic' 'Rear Mic' 'Line' 'CD'
  Item0: 'Line'
