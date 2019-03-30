From: Shuah Khan <shuah@kernel.org>
Subject: [PATCH v14 0/6] Media Device Allocator API
Date: Fri, 29 Mar 2019 19:53:55 -0600
Message-ID: <cover.1553909892.git.shuah@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mchehab@kernel.org, perex@perex.cz, tiwai@suse.com, hverkuil@xs4all.nl
Cc: Shuah Khan <shuah@kernel.org>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

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

The primary focus for testing The patch series is making sure media
device is released when both drivers release the media device with
a series of unbind/binds on both drivers.

- both au0828 and snd-usb-aduio as built-in
- both au0828 and snd-usb-aduio as modules
- au0828 as module and snd-usb-aduio as built-in
- au0828 as built-in and snd-usb-aduio as module

Test results can be found at:

https://docs.google.com/document/d/1RMF8Rwj7xHJEoOx6_K2f-REgZJ63BMeAVEf-CV-0HsM/edit?usp=sharing

Changes since v13:
- Minor changes to variable names and other minor changes to copyright
  and typos suggested by Hans Verkuil.

Changes since v12:
- Patch 1: Fixed prototype warns from media_dev_allocator.c. Removed
  dependency on find_module() by adding struct module to input args.
  Still need module name to pass into media_device API.
- Patch 2 & 4: Update media dev allocator api calls to pass in struct module
  pointer.
- No changes to Patches 3 & 5.
- Added patch 6 with a test. It can go in separately.

Changes since v11:
- Patch 1: Add CONFIG_MODULES dependency in media_dev_allocator files.
  to fix compile errors when CONFIG_MODULES is disabled.
- Patch 2, 3: No changes.
- Patch 4: Fix sparse error reported by Dan Carpenter.
- Patch 5: Fix warns found by Hans Verkuil.
- v11 was tested on 5.0-rc7 and addresses comments on v10 series from
  Hans Verkuil. Fixed problems found in resource sharing logic in au0828
  adding a patch 5 to this series. The test plan used for testing resource
  sharing could serve as a regression test plan and the test results can be
  found at:
- v10 was tested on 5.0-rc3 and addresses comments on v9 series from
  Hans Verkuil.

Changes since v10:
- Patch 1: Fixed SPDX tag and removed redundant IS_ENABLED(CONFIG_USB)
           around media_device_usb_allocate() - Sakari Ailus's review
           comment.
- Patch 2 and 3: No changes
- Patch 4: Fixed SPDX tag - Sakari Ailus's review comment.
- Carried Reviewed-by tag from Takashi Iwai for the sound from v9.
- Patch 5: This is a new patch added to fix resource sharing
           inconsistencies and problem found during testing using Han's
           tests.

Changes since v9:
- Patch 1: Fix mutex assert warning from find_module() calls. This
  code was written before the change to find_module() that requires
  callers to hold module_mutex. I missed this during my testing on
  4.20-rc6. Hans Verkuil reported the problem.
- Patch 4: sound/usb: Initializes all the entities it can before
  registering the device based on comments from Hans Verkuil
- Carried Reviewed-by tag from Takashi Iwai for the sound from v9.
- No changes to Patches 2 and 3.

References:
https://lkml.org/lkml/2018/11/2/169
https://www.mail-archive.com/linux-media@vger.kernel.org/msg105854.html

Shuah Khan (6):
  media: Media Device Allocator API
  media: change au0828 to use Media Device Allocator API
  media: media.h: Enable ALSA MEDIA_INTF_T* interface types
  sound/usb: Use Media Controller API to share media resources
  au0828: fix enable and disable source audio and video inconsistencies
  selftests: media_dev_allocator api test

 Documentation/media/kapi/mc-core.rst          |  41 +++
 drivers/media/Makefile                        |   6 +
 drivers/media/media-dev-allocator.c           | 135 ++++++++
 drivers/media/usb/au0828/Kconfig              |   2 +
 drivers/media/usb/au0828/au0828-core.c        | 195 ++++++++---
 drivers/media/usb/au0828/au0828.h             |   6 +-
 include/media/media-dev-allocator.h           |  63 ++++
 include/uapi/linux/media.h                    |  25 +-
 sound/usb/Kconfig                             |   4 +
 sound/usb/Makefile                            |   2 +
 sound/usb/card.c                              |  14 +
 sound/usb/card.h                              |   3 +
 sound/usb/media.c                             | 327 ++++++++++++++++++
 sound/usb/media.h                             |  74 ++++
 sound/usb/mixer.h                             |   3 +
 sound/usb/pcm.c                               |  29 +-
 sound/usb/quirks-table.h                      |   1 +
 sound/usb/stream.c                            |   2 +
 sound/usb/usbaudio.h                          |   6 +
 .../media_tests/media_dev_allocator.sh        |  85 +++++
 20 files changed, 962 insertions(+), 61 deletions(-)
 create mode 100644 drivers/media/media-dev-allocator.c
 create mode 100644 include/media/media-dev-allocator.h
 create mode 100644 sound/usb/media.c
 create mode 100644 sound/usb/media.h
 create mode 100755 tools/testing/selftests/media_tests/media_dev_allocator.sh

-- 
2.17.1
