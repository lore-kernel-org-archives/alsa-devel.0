From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Applied "ASoC: rt5514: expose Hotword Model
 control" to the asoc tree
Date: Thu, 14 Sep 2017 12:54:56 +0900
Message-ID: <d9e62043-fa21-7159-c310-86c962ffb8e0@sakamocchi.jp>
References: <E1dkpi0-0000rj-Vu@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 9CA4B266986
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 05:54:59 +0200 (CEST)
In-Reply-To: <E1dkpi0-0000rj-Vu@debutante>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Hsin-Yu Chao <hychao@chromium.org>
Cc: oder_chiou@realtek.com, dgreid@chromium.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

As the subject notes, please revert the commit including the below lines.

On Aug 24 2017 19:49, Mark Brown wrote:
> +static int rt5514_hotword_model_put(struct snd_kcontrol *kcontrol,
> +		const unsigned int __user *bytes, unsigned int size)
> +{
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +	struct rt5514_priv *rt5514 = snd_soc_component_get_drvdata(component);
> +	struct snd_soc_codec *codec = rt5514->codec;
> +	int ret = 0;
> +
> +	if (rt5514->model_buf || rt5514->model_len < size) {
> +		if (rt5514->model_buf)
> +			devm_kfree(codec->dev, rt5514->model_buf);
> +		rt5514->model_buf = devm_kmalloc(codec->dev, size, GFP_KERNEL);
> +		if (!rt5514->model_buf) {
> +			ret = -ENOMEM;
> +			goto done;
> +		}
> +	}
> +
> +	/* Skips the TLV header. */
> +	bytes += 2;
> +
> +	if (copy_from_user(rt5514->model_buf, bytes, size))
> +		ret = -EFAULT;
> +done:
> +	rt5514->model_len = (ret ? 0 : size);
> +	return ret;
> +}
> +
>   static const struct snd_kcontrol_new rt5514_snd_controls[] = {
>   	SOC_DOUBLE_TLV("MIC Boost Volume", RT5514_ANA_CTRL_MICBST,
>   		RT5514_SEL_BSTL_SFT, RT5514_SEL_BSTR_SFT, 8, 0, bst_tlv),
> @@ -363,6 +413,8 @@ static const struct snd_kcontrol_new rt5514_snd_controls[] = {
>   		adc_vol_tlv),
>   	SOC_SINGLE_EXT("DSP Voice Wake Up", SND_SOC_NOPM, 0, 1, 0,
>   		rt5514_dsp_voice_wake_up_get, rt5514_dsp_voice_wake_up_put),
> +	SND_SOC_BYTES_TLV("Hotword Model", 0x8504,
> +		NULL, rt5514_hotword_model_put),
>   };

Current implementation of 'SND_SOC_BYTES_TLV' in ALSA SoC part includes
an abuse of TLV feature of ALSA control interface. Developers are
discouraged to use it for newer code to prevent developers for userspace
applications from confusion or to prevent userspace applications from
disorder, unless ASoC developers fix the abuse.

Apparently, this patch includes a bug about the size of buffer in user
space.

Again, please don't use 'SND_SOC_BYTES_TLV' when you have enough care of
userspace applications. Here, I describe the reason.


## Design of the TLV feature of ALSA control interface

At first, I describe common design of the TLV feature of ALSA control
interface. Next, I address to an issue about application of the feature
to ALSA SoC framework (ASoC).

The most of ALSA interface was defined around 2000, while TLV feature of
ALSA control interface was introduced in 2006, enough later.

In 2015-2017, in ALSA upstream, I've documented this feature[1]. 
Essentially,
this feature is designed to transfer arbitrary data between drivers and
applications as a shape of Type/Length/Value.

A packet of this data is described as 'struct snd_ctl_tlv'[3].

```
struct snd_ctl_tlv {
     unsigned int numid;     /* control element numeric identification */
     unsigned int length;    /* in bytes aligned to 4 */
     unsigned int tlv[0];    /* first TLV */
};
```

When userspace applications execute ioctl(2) with some of TLV 
commands[3] and
a buffer, the buffer is filled with the structured data.

```
     struct snd_ctl_tlv *packet;
     unsigned int *payload;
     int fd;

     fd = open("/dev/snd/controlC0", O_RDONLY);

     packet = malloc(sizeof(struct snd_ctl_tlv) + 512);
     packet->numid = 0;      /* Here, I select the first element. */
     packet->length = 512;   /* The length of payload. */

     ioctl(fd, SNDRV_CTL_IOCTL_TLV_COMMAND, &container);
     payload = packet->tlv;
     /* payload has the structured data. */
```

Shape of the payload is expected to be with header and content for each
type. A series of the basic type is described as 'SNDRV_CTL_TLVT_XXX' in
UAPI header[4]. You can see a sample program for it as an application of
user-defined control element sets in alsa-lib[5].

[1] ALSA project - the C library reference: Control interface
http://www.alsa-project.org/alsa-doc/alsa-lib/control.html
[2] struct snd_ctl_tlv
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/asound.h#n948
[3] SNDRV_CTL_IOCTL_TLV_READ and SNDRV_CTL_IOCTL_TLV_COMMAND
[4] include/uapi/sound/tlv.h
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/tlv.h
[5] user-ctl-element-set.c
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=test/user-ctl-element-set.c

## Driver inteface for TLV feature of ALSA control interface

In kernel land, each driver can add control element sets with some
control elements. The driver can register own data or operation to the
control element set for the TLV feature[1].

```
typedef int (snd_kcontrol_tlv_rw_t)(struct snd_kcontrol *kcontrol,
				    int op_flag, /* SNDRV_CTL_TLV_OP_XXX */
				    unsigned int size,
				    unsigned int __user *tlv);

struct snd_kcontrol {
     ...
     union {
         snd_kcontrol_tlv_rw_t *c;
         const unsigned int *p;
     } tlv;
     ...
};
```

When using 'struct snd_kcontrol.tlv.p', the driver just support read
operation. For example, 'sound/soc/codecs/stac9766.c' has such codes.

When using another, the driver can support read, write and command
operation. For example, control elements for PCM channel map in
'sound/core/pcm_lib.c' is implemented by this way.

In both ways, drivers should be implemented with enough care about
format of the payload not to confuse userspace applications. The
format of payload is described in UAPI header for TLV feature[2].

```
/*
  * TLV structure is right behind the struct snd_ctl_tlv:
  *   unsigned int type     - see SNDRV_CTL_TLVT_*
  *   unsigned int length
  *   .... data aligned to sizeof(unsigned int), use
  *        block_length = (length + (sizeof(unsigned int) - 1)) &
  *                       ~(sizeof(unsigned int) - 1)) ....
  */
```

The first 32bit field has one of SNDRV_CTL_TLVT_xxx macro, and the
second 32bit field has length of included data in byte unit. The rest
is for the data.

For example, payload with 'SNDRV_CTL_TLVT_DB_MINMAX' should have below
content:

```
[0] 4 (= SNDRV_CTL_TLVT_DB_MINMAX)
[1] 2 (= ARRAY_SIZE(unsigned int[2]))
[2] min dB
[3] max dB
```

Content of the payload can have nested data field with
'SNDRV_CTL_TLVT_CONTAINER'. For example:

```
[0] 0 (= SNDRV_CTL_TLVT_CONTAINER)
[1] 8 (= length of data)
[2] 1 (= SNDRV_CTL_TLVT_DB_SCALE)
[3] 2 (= ARRAY_SIZE(unsigned int[2]))
[4] min
[5] step | mute
[6] 1 (= SNDRV_CTL_TLVT_DB_LINEAR)
[7] 2 (= ARRAY_SIZE(unsigned int [2]))
[8] min dB
[9] max dB
```

In any basic type, the first two members of payload represents the type 
of data and the
length of data. This is an important point for the issue.

[1] include/sound/control.c
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/include/sound/control.h
[2] include/uapi/sound/tlv.h
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/tlv.h

## Abuse of TLV feature of ALSA control interface in ALSA SoC part

As I described, control element set should have two members in the
beginning of payload of data for TLV feature; type and length.
Additionally, when new type is added into ALSA stuffs, it's better
to add it in UAPI header for applications[1]. Current implementation
of 'bytes_ext' via TLV operation is completely against this
basic principle.

Here, I review history of the 'bytes_ext'.

May 2014, Intel developer introduced the 'bytes_ext' into ASoC to
transfer data with arbitrary length from userspace to hardware.

```
(include/sound/soc.h)
struct soc_bytes_ext {
     int max;
     struct snd_soc_dobj dobj;

     /* used for TLV byte control */
     int (*get)(struct snd_kcontrol *kcontrol, unsigned int __user *bytes,
                unsigned int size);
     int (*put)(struct snd_kcontrol *kcontrol, const unsigned int __user 
*bytes,
                unsigned int size);
};
```

The 'bytes_ext' is implemented with SNDRV_CTL_IOCTL_ELEM_WRITE
command and 'struct snd_ctl_elem_value'. However, there's a
limitation of maximum length of data for the transmission due to
design of the 'struct snd_ctl_elem_value'.

```
(include/uapi/sound/asound.h)
struct snd_ctl_elem_value {
     ...
     union {
         ...
         union {
             unsigned char data[512];
             ...
         } bytes;
         ...
     } value;
     ...
};
```

Nov 2013, Intel developers introduced their next idea to purge
the limitation[3]. In this state, their idea focuses on extension of
control element structure ('struct snd_ctl_elem'). They were
discouraged with an advice to use ALSA HwDep interface for this
purpose. But their intension is to utilize alsactl application
to load/store status of control element automatically and they had
less care of the advice.

Jul 2014, Intel developers post next idea to use 'bytes_ext' via TLV
feature with a focus on the nature; userspace application and drivers
communicate with an arbitrary length of data via TLV feature[4].
This idea is applied to ASoC repository without enough
discussions about userspace breakage.

[1] include/uapi/sound/tlv.h
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/tlv.h

[2] [alsa-devel] [PATCH] ASoC: add SND_SOC_BYTES_EXT
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-May/076155.html

[3] [alsa-devel] [RFC] ALSA: add new alsa control byte extended
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-November/069483.html

[4] [alsa-devel] [RFC v2] ASoC: core: add a helper for extended byte 
controls using TLV
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-July/078962.html


Regards

Takashi Sakamoto
