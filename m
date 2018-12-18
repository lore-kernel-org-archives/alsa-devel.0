From: shuah@kernel.org
Subject: [PATCH v9 0/4] Media Device Allocator API
Date: Tue, 18 Dec 2018 10:59:35 -0700
Message-ID: <cover.1545154777.git.shuah@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mchehab@kernel.org, perex@perex.cz, tiwai@suse.com, hverkuil@xs4all.nl
Cc: Shuah Khan <shuah@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Shuah Khan <shuah@kernel.org>

Media Device Allocator API to allows multiple drivers share a media device.
This API solves a very common use-case for media devices where one physical
device (an USB stick) provides both audio and video. When such media device
exposes a standard USB Audio class, a proprietary Video class, two or more
independent drivers will share a single physical USB bridge. In such cases,
it is necessary to coordinate access to the shared resource.

Using this API, drivers can allocate a media device with the shared struct
device as the key. Once the media device is allocated by a driver, other
drivers can get a reference to it. The media device is released when all
the references are released.

- Tested sharing resources with kaffeine, vlc, xawtv, tvtime, and
  arecord. When analog is streaming, digital and audio user-space
  applications detect that the tuner is busy and exit. When digital
  is streaming, analog and audio applications detect that the tuner is
  busy and exit. When arecord is owns the tuner, digital and analog
  detect that the tuner is busy and exit.
- Tested media device allocator API with bind/unbind testing on
  snd-usb-audio and au0828 drivers to make sure /dev/mediaX is released
  only when the last driver is unbound.
- This patch series is tested on 4.20-rc6
- Addressed review comments from Hans on the RFC v8 (rebased on 4.19)
- Updated change log to describe the use-case more clearly.
- No changes to 0001,0002 code since the v7 referenced below.
- 0003 is a new patch to enable ALSA defines that have been
  disabled for kernel between 4.9 and 4.19.
- Minor merge conflict resolution in 0004.
- Added SPDX to new files.

References:
https://lkml.org/lkml/2018/11/2/169
https://www.mail-archive.com/linux-media@vger.kernel.org/msg105854.html

Shuah Khan (4):
  media: Media Device Allocator API
  media: change au0828 to use Media Device Allocator API
  media: media.h: Enable ALSA MEDIA_INTF_T* interface types
  sound/usb: Use Media Controller API to share media resources

 Documentation/media/kapi/mc-core.rst   |  41 ++++
 drivers/media/Makefile                 |   4 +
 drivers/media/media-dev-allocator.c    | 132 ++++++++++
 drivers/media/usb/au0828/au0828-core.c |  12 +-
 drivers/media/usb/au0828/au0828.h      |   1 +
 include/media/media-dev-allocator.h    |  53 ++++
 include/uapi/linux/media.h             |  25 +-
 sound/usb/Kconfig                      |   4 +
 sound/usb/Makefile                     |   2 +
 sound/usb/card.c                       |  14 ++
 sound/usb/card.h                       |   3 +
 sound/usb/media.c                      | 321 +++++++++++++++++++++++++
 sound/usb/media.h                      |  74 ++++++
 sound/usb/mixer.h                      |   3 +
 sound/usb/pcm.c                        |  29 ++-
 sound/usb/quirks-table.h               |   1 +
 sound/usb/stream.c                     |   2 +
 sound/usb/usbaudio.h                   |   6 +
 18 files changed, 705 insertions(+), 22 deletions(-)
 create mode 100644 drivers/media/media-dev-allocator.c
 create mode 100644 include/media/media-dev-allocator.h
 create mode 100644 sound/usb/media.c
 create mode 100644 sound/usb/media.h

-- 
2.17.1
