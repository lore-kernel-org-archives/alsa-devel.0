From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 22/22] sound/usb: Use Media Controller
	API to share media resources
Date: Tue, 01 Mar 2016 21:53:28 +0200
Message-ID: <2166908.Ghbrb0Anbr@avalon>
References: <1456725482-4849-1-git-send-email-shuahkh@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from galahad.ideasonboard.com (galahad.ideasonboard.com
 [185.26.127.97])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D009261537
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 20:53:19 +0100 (CET)
In-Reply-To: <1456725482-4849-1-git-send-email-shuahkh@osg.samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: klock.android@gmail.com, k.kozlowski@samsung.com, clemens@ladisch.de, alsa-devel@alsa-project.org, ruchandani.tina@gmail.com, prabhakar.csengg@gmail.com, normalperson@yhbt.net, bert@huitsing.nl, ricardo.ribalda@gmail.com, elfring@users.sourceforge.net, m.szyprowski@samsung.com, pierre-louis.bossart@linux.intel.com, pawel@osciak.com, corbet@lwn.net, misterpib@gmail.com, chehabrafael@gmail.com, al@alsa-project.org, javier@osg.samsung.com, crope@iki.fi, hans.verkuil@cisco.com, linuxbugs@vittgam.net, takamichiho@gmail.com, jh1009.sung@samsung.com, dan.carpenter@oracle.com, linux-media@vger.kernel.org, julian@jusst.de, ricard.wanderlof@axis.com, p.zabel@pengutronix.de, arnd@arndb.de, mchehab@osg.samsung.com, tvboxspy@gmail.com, linux-kernel@vger.kernel.org, inki.dae@samsung.com, geliangtang@163.com, nenggun.kim@samsung.com, joe@oampo.co.uk, dominic.sacre@gmx.de, j.anaszewski@
List-Id: alsa-devel@alsa-project.org

Hi Shuah,

Thank you for the patch.

On Sunday 28 February 2016 22:58:01 Shuah Khan wrote:
> Change ALSA driver to use Media Controller API to
> share media resources with DVB and V4L2 drivers
> on a AU0828 media device. Media Controller specific
> initialization is done after sound card is registered.
> ALSA creates Media interface and entity function graph
> nodes for Control, Mixer, PCM Playback, and PCM Capture
> devices.
> 
> snd_usb_hw_params() will call Media Controller enable
> source handler interface to request the media resource.
> If resource request is granted, it will release it from
> snd_usb_hw_free(). If resource is busy, -EBUSY is returned.
> 
> Media specific cleanup is done in usb_audio_disconnect().
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
> 
> Changes since v3:
> - Fixed Kconfig to handle the following
> 1. CONFIG_MEDIA_SUPPORT and CONFIG_SND_USB_AUDIO are
>    both modules
>    CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER is selected
> 
> 2. CONFIG_MEDIA_SUPPORT=y and CONFIG_SND_USB_AUDIO=m
>    CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER is selected
> 
> 3. CONFIG_MEDIA_SUPPORT=y and CONFIG_SND_USB_AUDIO=y
>    CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER is selected
> 
> 4. CONFIG_MEDIA_SUPPORT=m and CONFIG_SND_USB_AUDIO=y
>    This is when we don't want
>    CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER selected
> 
>  sound/usb/Kconfig        |   4 +
>  sound/usb/Makefile       |   2 +
>  sound/usb/card.c         |  14 +++
>  sound/usb/card.h         |   3 +
>  sound/usb/media.c        | 318 +++++++++++++++++++++++++++++++++++++++++++
>  sound/usb/media.h        |  72 +++++++++++
>  sound/usb/mixer.h        |   3 +
>  sound/usb/pcm.c          |  28 ++++-
>  sound/usb/quirks-table.h |   1 +
>  sound/usb/stream.c       |   2 +
>  sound/usb/usbaudio.h     |   6 +
>  11 files changed, 448 insertions(+), 5 deletions(-)
>  create mode 100644 sound/usb/media.c
>  create mode 100644 sound/usb/media.h

[snip]

> diff --git a/sound/usb/media.h b/sound/usb/media.h
> new file mode 100644
> index 0000000..f66b4d7
> --- /dev/null
> +++ b/sound/usb/media.h
> @@ -0,0 +1,72 @@
> +/*
> + * media.h - Media Controller specific ALSA driver code
> + *
> + * Copyright (c) 2016 Shuah Khan <shuahkh@osg.samsung.com>
> + * Copyright (c) 2016 Samsung Electronics Co., Ltd.
> + *
> + * This file is released under the GPLv2.
> + */
> +
> +/*
> + * This file adds Media Controller support to ALSA driver
> + * to use the Media Controller API to share tuner with DVB
> + * and V4L2 drivers that control media device. Media device
> + * is created based on existing quirks framework. Using this
> + * approach, the media controller API usage can be added for
> + * a specific device.
> +*/
> +#ifndef __MEDIA_H
> +
> +#ifdef CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER
> +
> +#include <media/media-device.h>
> +#include <media/media-entity.h>
> +#include <sound/asound.h>
> +
> +struct media_ctl {
> +	struct media_device *media_dev;
> +	struct media_entity media_entity;
> +	struct media_intf_devnode *intf_devnode;
> +	struct media_link *intf_link;
> +	struct media_pad media_pad;
> +	struct media_pipeline media_pipe;
> +};
> +
> +/*
> + * One source pad each for SNDRV_PCM_STREAM_CAPTURE and
> + * SNDRV_PCM_STREAM_PLAYBACK. One for sink pad to link
> + * to AUDIO Source
> +*/
> +#define MEDIA_MIXER_PAD_MAX    (SNDRV_PCM_STREAM_LAST + 2)
> +
> +struct media_mixer_ctl {
> +	struct media_device *media_dev;
> +	struct media_entity media_entity;
> +	struct media_intf_devnode *intf_devnode;
> +	struct media_link *intf_link;
> +	struct media_pad media_pad[MEDIA_MIXER_PAD_MAX];
> +	struct media_pipeline media_pipe;
> +};
> +
> +int media_device_create(struct snd_usb_audio *chip,
> +			struct usb_interface *iface);
> +void media_device_delete(struct snd_usb_audio *chip);
> +int media_stream_init(struct snd_usb_substream *subs, struct snd_pcm *pcm,
> +			int stream);
> +void media_stream_delete(struct snd_usb_substream *subs);
> +int media_start_pipeline(struct snd_usb_substream *subs);
> +void media_stop_pipeline(struct snd_usb_substream *subs);

As this API is sound-specific, would it make sense to call the functions 
media_snd_* or something similar ? The names are very generic now, and could 
clash with core media code.

> +#else
> +static inline int media_device_create(struct snd_usb_audio *chip,
> +				      struct usb_interface *iface)
> +						{ return 0; }
> +static inline void media_device_delete(struct snd_usb_audio *chip) { }
> +static inline int media_stream_init(struct snd_usb_substream *subs,
> +					struct snd_pcm *pcm, int stream)
> +						{ return 0; }
> +static inline void media_stream_delete(struct snd_usb_substream *subs) { }
> +static inline int media_start_pipeline(struct snd_usb_substream *subs)
> +					{ return 0; }
> +static inline void media_stop_pipeline(struct snd_usb_substream *subs) { }
> +#endif
> +#endif /* __MEDIA_H */

-- 
Regards,

Laurent Pinchart
