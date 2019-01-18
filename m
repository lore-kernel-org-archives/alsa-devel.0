From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v9 4/4] sound/usb: Use Media Controller API to share media
 resources
Date: Fri, 18 Jan 2019 09:36:11 +0100
Message-ID: <b2fddc47-94c6-b7b3-8304-55905a3e278d@xs4all.nl>
References: <cover.1545154777.git.shuah@kernel.org>
 <2fb40852e4035b2a58010ce7416448918f12804f.1545154778.git.shuah@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2fb40852e4035b2a58010ce7416448918f12804f.1545154778.git.shuah@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: shuah@kernel.org, mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/18/18 6:59 PM, shuah@kernel.org wrote:
> From: Shuah Khan <shuah@kernel.org>
> 
> Media Device Allocator API to allows multiple drivers share a media device.
> This API solves a very common use-case for media devices where one physical
> device (an USB stick) provides both audio and video. When such media device
> exposes a standard USB Audio class, a proprietary Video class, two or more
> independent drivers will share a single physical USB bridge. In such cases,
> it is necessary to coordinate access to the shared resource.
> 
> Using this API, drivers can allocate a media device with the shared struct
> device as the key. Once the media device is allocated by a driver, other
> drivers can get a reference to it. The media device is released when all
> the references are released.
> 
> Change the ALSA driver to use the Media Controller API to share media
> resources with DVB, and V4L2 drivers on a AU0828 media device.
> 
> The Media Controller specific initialization is done after sound card is
> registered. ALSA creates Media interface and entity function graph nodes
> for Control, Mixer, PCM Playback, and PCM Capture devices.
> 
> snd_usb_hw_params() will call Media Controller enable source handler
> interface to request the media resource. If resource request is granted,
> it will release it from snd_usb_hw_free(). If resource is busy, -EBUSY is
> returned.
> 
> Media specific cleanup is done in usb_audio_disconnect().
> 
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  sound/usb/Kconfig        |   4 +
>  sound/usb/Makefile       |   2 +
>  sound/usb/card.c         |  14 ++
>  sound/usb/card.h         |   3 +
>  sound/usb/media.c        | 321 +++++++++++++++++++++++++++++++++++++++
>  sound/usb/media.h        |  74 +++++++++
>  sound/usb/mixer.h        |   3 +
>  sound/usb/pcm.c          |  29 +++-
>  sound/usb/quirks-table.h |   1 +
>  sound/usb/stream.c       |   2 +
>  sound/usb/usbaudio.h     |   6 +
>  11 files changed, 455 insertions(+), 4 deletions(-)
>  create mode 100644 sound/usb/media.c
>  create mode 100644 sound/usb/media.h
> 

<snip>

> +int snd_media_device_create(struct snd_usb_audio *chip,
> +			struct usb_interface *iface)
> +{
> +	struct media_device *mdev;
> +	struct usb_device *usbdev = interface_to_usbdev(iface);
> +	int ret;
> +
> +	/* usb-audio driver is probed for each usb interface, and
> +	 * there are multiple interfaces per device. Avoid calling
> +	 * media_device_usb_allocate() each time usb_audio_probe()
> +	 * is called. Do it only once.
> +	 */
> +	if (chip->media_dev)
> +		goto snd_mixer_init;
> +
> +	mdev = media_device_usb_allocate(usbdev, KBUILD_MODNAME);
> +	if (!mdev)
> +		return -ENOMEM;
> +
> +	if (!media_devnode_is_registered(mdev->devnode)) {

It looks like you missed my comment for v8:

"You should first configure the media device before registering it."

In other words, first create the media entities, and only then do you
register the media device. Otherwise it will come up without any alsa
entities, which are then added. So an application that immediately
opens the media device upon creation will see a topology that is still
in flux.

> +		/* register media_device */
> +		ret = media_device_register(mdev);
> +		if (ret) {
> +			media_device_delete(mdev, KBUILD_MODNAME);
> +			dev_err(&usbdev->dev,
> +				"Couldn't register media device. Error: %d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	/* save media device - avoid lookups */
> +	chip->media_dev = mdev;
> +
> +snd_mixer_init:
> +	/* Create media entities for mixer and control dev */
> +	ret = snd_media_mixer_init(chip);
> +	if (ret) {
> +		dev_err(&usbdev->dev,
> +			"Couldn't create media mixer entities. Error: %d\n",
> +			ret);
> +
> +		/* clear saved media_dev */
> +		chip->media_dev = NULL;
> +
> +		return ret;
> +	}
> +	return 0;
> +}

I'll do some testing of this series on Monday.

Regards,

	Hans
