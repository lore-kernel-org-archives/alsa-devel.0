From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v13 2/6] media: change au0828 to use Media Device
 Allocator API
Date: Fri, 29 Mar 2019 09:27:58 +0100
Message-ID: <693a4487-b4dd-b3e0-953e-22c342708f1f@xs4all.nl>
References: <cover.1553814518.git.shuah@kernel.org>
 <05ec250a56d9eaa868e7c8cf6376d6f8e29bb102.1553814518.git.shuah@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <05ec250a56d9eaa868e7c8cf6376d6f8e29bb102.1553814518.git.shuah@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuah@kernel.org>, mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 3/29/19 1:04 AM, Shuah Khan wrote:
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
> Change au0828 to use Media Device Allocator API to allocate media device
> with the parent usb struct device as the key, so it can be shared with the
> snd_usb_audio driver.
> 
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  drivers/media/usb/au0828/Kconfig       |  2 ++
>  drivers/media/usb/au0828/au0828-core.c | 13 +++++--------
>  drivers/media/usb/au0828/au0828.h      |  1 +
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/usb/au0828/Kconfig b/drivers/media/usb/au0828/Kconfig
> index 65fc067eb864..98de6e24329e 100644
> --- a/drivers/media/usb/au0828/Kconfig
> +++ b/drivers/media/usb/au0828/Kconfig
> @@ -2,6 +2,8 @@
>  config VIDEO_AU0828
>  	tristate "Auvitek AU0828 support"
>  	depends on I2C && INPUT && DVB_CORE && USB && VIDEO_V4L2
> +	select MEDIA_CONTROLLER
> +	select MEDIA_CONTROLLER_DVB

Is it required to select MEDIA_CONTROLLER_DVB? Does something fail to work
if this is unset?

Regards,

	Hans

>  	select I2C_ALGOBIT
>  	select VIDEO_TVEEPROM
>  	select VIDEOBUF2_VMALLOC if VIDEO_V4L2
> diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
> index 3f8c92a70116..4f8ba6f64d3c 100644
> --- a/drivers/media/usb/au0828/au0828-core.c
> +++ b/drivers/media/usb/au0828/au0828-core.c
> @@ -155,9 +155,7 @@ static void au0828_unregister_media_device(struct au0828_dev *dev)
>  	dev->media_dev->disable_source = NULL;
>  	mutex_unlock(&mdev->graph_mutex);
>  
> -	media_device_unregister(dev->media_dev);
> -	media_device_cleanup(dev->media_dev);
> -	kfree(dev->media_dev);
> +	media_device_delete(dev->media_dev, KBUILD_MODNAME, THIS_MODULE);
>  	dev->media_dev = NULL;
>  #endif
>  }
> @@ -210,14 +208,10 @@ static int au0828_media_device_init(struct au0828_dev *dev,
>  #ifdef CONFIG_MEDIA_CONTROLLER
>  	struct media_device *mdev;
>  
> -	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
> +	mdev = media_device_usb_allocate(udev, KBUILD_MODNAME, THIS_MODULE);
>  	if (!mdev)
>  		return -ENOMEM;
>  
> -	/* check if media device is already initialized */
> -	if (!mdev->dev)
> -		media_device_usb_init(mdev, udev, udev->product);
> -
>  	dev->media_dev = mdev;
>  #endif
>  	return 0;
> @@ -480,6 +474,9 @@ static int au0828_media_device_register(struct au0828_dev *dev,
>  		/* register media device */
>  		ret = media_device_register(dev->media_dev);
>  		if (ret) {
> +			media_device_delete(dev->media_dev, KBUILD_MODNAME,
> +					    THIS_MODULE);
> +			dev->media_dev = NULL;
>  			dev_err(&udev->dev,
>  				"Media Device Register Error: %d\n", ret);
>  			return ret;
> diff --git a/drivers/media/usb/au0828/au0828.h b/drivers/media/usb/au0828/au0828.h
> index 425c35d16057..57b00de8d3f2 100644
> --- a/drivers/media/usb/au0828/au0828.h
> +++ b/drivers/media/usb/au0828/au0828.h
> @@ -31,6 +31,7 @@
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-fh.h>
>  #include <media/media-device.h>
> +#include <media/media-dev-allocator.h>
>  
>  /* DVB */
>  #include <media/demux.h>
> 
