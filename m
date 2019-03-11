From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH v11 0/5] Media Device Allocator API
Date: Mon, 11 Mar 2019 14:53:31 +0100
Message-ID: <2cff0450-7f48-b685-56c4-ae494cb67f14@xs4all.nl>
References: <cover.1550804023.git.shuah@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1550804023.git.shuah@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuah@kernel.org>, mchehab@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2/22/19 6:28 PM, Shuah Khan wrote:
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

While doing the final compile tests for the pull request I encountered the
following sparse warnings:

sparse: WARNINGS
/home/hans/work/build/media-git/drivers/media/usb/au0828/au0828-core.c:282:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
SPARSE:/home/hans/work/build/media-git/drivers/media/media-dev-allocator.c
/home/hans/work/build/media-git/drivers/media/media-dev-allocator.c:94:21:  warning: symbol 'media_device_usb_allocate' was not declared.
Should it be static?
SPARSE:/home/hans/work/build/media-git/drivers/media/media-dev-allocator.c
/home/hans/work/build/media-git/drivers/media/media-dev-allocator.c:120:6:  warning: symbol 'media_device_delete' was not declared. Should
it be static?
/home/hans/work/build/media-git/drivers/media/media-dev-allocator.c:94:22: warning: no previous prototype for 'media_device_usb_allocate'
[-Wmissing-prototypes]
/home/hans/work/build/media-git/drivers/media/media-dev-allocator.c:120:6: warning: no previous prototype for 'media_device_delete'
[-Wmissing-prototypes]

Can you fix these issues and post a v12?

Thanks!

	Hans

> 
> - This patch series in rested on 5.0-rc7 and addresses comments on
>   v10 series from Hans Verkuil. Fixed problems found in resource
>   sharing logic in au0828 adding a patch 5 to this series.
> - I am sharing the test plan used for testing resource sharing which
>   could serve as a regression test plan. Test results can be found at:
> 
> https://docs.google.com/document/d/1XMs3HYgLiHby6xVIvIxv75KSXAAN3F4uUpw2uLuD9c4/edit?usp=sharing
> 
> - v10 was tested on 5.0-rc3 and addresses comments on v9 series from
>   Hans Verkuil.
> - v9 was tested on 4.20-rc6.
> - Tested sharing resources with kaffeine, vlc, xawtv, tvtime, and
>   arecord. When analog is streaming, digital and audio user-space
>   applications detect that the tuner is busy and exit. When digital
>   is streaming, analog and audio applications detect that the tuner is
>   busy and exit. When arecord is owns the tuner, digital and analog
>   detect that the tuner is busy and exit.
> - Tested media device allocator API with bind/unbind testing on
>   snd-usb-audio and au0828 drivers to make sure /dev/mediaX is released
>   only when the last driver is unbound.
> - Addressed review comments from Hans on the RFC v8 (rebased on 4.19)
> - Updated change log to describe the use-case more clearly.
> - No changes to 0001,0002 code since the v7 referenced below.
> - 0003 is a new patch to enable ALSA defines that have been
>   disabled for kernel between 4.9 and 4.19.
> - Minor merge conflict resolution in 0004.
> - Added SPDX to new files.
> 
> Changes since v10:
> - Patch 1: Fixed SPDX tag and removed redundant IS_ENABLED(CONFIG_USB)
>            around media_device_usb_allocate() - Sakari Ailus's review
>            comment.
> - Patch 2 and 3: No changes
> - Patch 4: Fixed SPDX tag - Sakari Ailus's review comment.
> - Carried Reviewed-by tag from Takashi Iwai for the sound from v9.
> - Patch 5: This is a new patch added to fix resource sharing
> 	   inconsistencies and problem found during testing using Han's
> 	   tests.
> Changes since v9:
> - Patch 1: Fix mutex assert warning from find_module() calls. This
>   code was written before the change to find_module() that requires
>   callers to hold module_mutex. I missed this during my testing on
>   4.20-rc6. Hans Verkuil reported the problem.
> - Patch 4: sound/usb: Initializes all the entities it can before
>   registering the device based on comments from Hans Verkuil
> - Carried Reviewed-by tag from Takashi Iwai for the sound from v9.
> - No changes to Patches 2 and 3.
> 
> References:
> https://lkml.org/lkml/2018/11/2/169
> https://www.mail-archive.com/linux-media@vger.kernel.org/msg105854.html
> 
> Shuah Khan (5):
>   media: Media Device Allocator API
>   media: change au0828 to use Media Device Allocator API
>   media: media.h: Enable ALSA MEDIA_INTF_T* interface types
>   sound/usb: Use Media Controller API to share media resources
>   au0828: fix enable and disable source audio and video inconsistencies
> 
>  Documentation/media/kapi/mc-core.rst   |  41 ++++
>  drivers/media/Makefile                 |   4 +
>  drivers/media/media-dev-allocator.c    | 142 +++++++++++
>  drivers/media/usb/au0828/au0828-core.c | 190 ++++++++++----
>  drivers/media/usb/au0828/au0828.h      |   6 +-
>  include/media/media-dev-allocator.h    |  53 ++++
>  include/uapi/linux/media.h             |  25 +-
>  sound/usb/Kconfig                      |   4 +
>  sound/usb/Makefile                     |   2 +
>  sound/usb/card.c                       |  14 ++
>  sound/usb/card.h                       |   3 +
>  sound/usb/media.c                      | 327 +++++++++++++++++++++++++
>  sound/usb/media.h                      |  74 ++++++
>  sound/usb/mixer.h                      |   3 +
>  sound/usb/pcm.c                        |  29 ++-
>  sound/usb/quirks-table.h               |   1 +
>  sound/usb/stream.c                     |   2 +
>  sound/usb/usbaudio.h                   |   6 +
>  18 files changed, 865 insertions(+), 61 deletions(-)
>  create mode 100644 drivers/media/media-dev-allocator.c
>  create mode 100644 include/media/media-dev-allocator.h
>  create mode 100644 sound/usb/media.c
>  create mode 100644 sound/usb/media.h
> 
