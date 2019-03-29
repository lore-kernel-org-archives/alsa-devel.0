From: shuah <shuah@kernel.org>
Subject: Re: [PATCH v13 2/6] media: change au0828 to use Media Device
 Allocator API
Date: Fri, 29 Mar 2019 08:14:24 -0600
Message-ID: <232cd798-4c0a-78d2-5eac-4c2870b4d6eb@kernel.org>
References: <cover.1553814518.git.shuah@kernel.org>
 <05ec250a56d9eaa868e7c8cf6376d6f8e29bb102.1553814518.git.shuah@kernel.org>
 <693a4487-b4dd-b3e0-953e-22c342708f1f@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <693a4487-b4dd-b3e0-953e-22c342708f1f@xs4all.nl>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, shuah <shuah@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 3/29/19 2:27 AM, Hans Verkuil wrote:
> On 3/29/19 1:04 AM, Shuah Khan wrote:
>> Media Device Allocator API to allows multiple drivers share a media device.
>> This API solves a very common use-case for media devices where one physical
>> device (an USB stick) provides both audio and video. When such media device
>> exposes a standard USB Audio class, a proprietary Video class, two or more
>> independent drivers will share a single physical USB bridge. In such cases,
>> it is necessary to coordinate access to the shared resource.
>>
>> Using this API, drivers can allocate a media device with the shared struct
>> device as the key. Once the media device is allocated by a driver, other
>> drivers can get a reference to it. The media device is released when all
>> the references are released.
>>
>> Change au0828 to use Media Device Allocator API to allocate media device
>> with the parent usb struct device as the key, so it can be shared with the
>> snd_usb_audio driver.
>>
>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>> ---
>>   drivers/media/usb/au0828/Kconfig       |  2 ++
>>   drivers/media/usb/au0828/au0828-core.c | 13 +++++--------
>>   drivers/media/usb/au0828/au0828.h      |  1 +
>>   3 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/media/usb/au0828/Kconfig b/drivers/media/usb/au0828/Kconfig
>> index 65fc067eb864..98de6e24329e 100644
>> --- a/drivers/media/usb/au0828/Kconfig
>> +++ b/drivers/media/usb/au0828/Kconfig
>> @@ -2,6 +2,8 @@
>>   config VIDEO_AU0828
>>   	tristate "Auvitek AU0828 support"
>>   	depends on I2C && INPUT && DVB_CORE && USB && VIDEO_V4L2
>> +	select MEDIA_CONTROLLER
>> +	select MEDIA_CONTROLLER_DVB
> 
> Is it required to select MEDIA_CONTROLLER_DVB? Does something fail to work
> if this is unset?
> 

Need this enabled for dvb driver to use media controller. api.

e.g dvb_register_media_device() does all its media controller code
when MEDIA_CONTROLLER_DVB is enabled.

See drivers/media/dvb-core/dvbdev.c

The config still says experimental:

config MEDIA_CONTROLLER_DVB
         bool "Enable Media controller for DVB (EXPERIMENTAL)"
         depends on MEDIA_CONTROLLER && DVB_CORE
         ---help---
           Enable the media controller API support for DVB.

           This is currently experimental.

Is that still accurate? Should be updated?

thanks,
-- Shuah
