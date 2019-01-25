From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v10 0/4] Media Device Allocator API
Date: Fri, 25 Jan 2019 17:28:36 +0200
Message-ID: <20190125152836.njwepezj2xf4xp22@valkosipuli.retiisi.org.uk>
References: <cover.1548360791.git.shuah@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hillosipuli.retiisi.org.uk (nblzone-211-213.nblnetworks.fi
 [83.145.211.213])
 by alsa0.perex.cz (Postfix) with ESMTP id 456262673DD
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2019 16:29:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cover.1548360791.git.shuah@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shuah Khan <shuah@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, hverkuil@xs4all.nl, mchehab@kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Shuah,

On Thu, Jan 24, 2019 at 01:32:37PM -0700, Shuah Khan wrote:
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

Thanks for the update. I have to apologise I haven't ended up reviewing the
set for some time. After taking a look at the current version, I'm happy to
see that a number of issues recognised during earlier review rounds have
been addressed.

Would you happen to have a media graph (media-ctl --print-dot and media-ctl
-p) from the device? That'd help understanding the device a bit better for
those who are not familiar with it.

> 
> - This patch series is tested on 5.0-rc3 and addresses comments on
>   v9 series from Hans Verkuil.
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
> Shuah Khan (4):
>   media: Media Device Allocator API
>   media: change au0828 to use Media Device Allocator API
>   media: media.h: Enable ALSA MEDIA_INTF_T* interface types
>   sound/usb: Use Media Controller API to share media resources
> 
>  Documentation/media/kapi/mc-core.rst   |  41 ++++
>  drivers/media/Makefile                 |   4 +
>  drivers/media/media-dev-allocator.c    | 144 +++++++++++
>  drivers/media/usb/au0828/au0828-core.c |  12 +-
>  drivers/media/usb/au0828/au0828.h      |   1 +
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
>  18 files changed, 723 insertions(+), 22 deletions(-)
>  create mode 100644 drivers/media/media-dev-allocator.c
>  create mode 100644 include/media/media-dev-allocator.h
>  create mode 100644 sound/usb/media.c
>  create mode 100644 sound/usb/media.h
> 

-- 
Kind regards,

Sakari Ailus
