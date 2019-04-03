From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: [GIT PULL FOR v5.2] Media Device Allocator API
Date: Wed, 3 Apr 2019 09:32:15 +0200
Message-ID: <30de419f-5dac-71a1-9255-d334d6025a0d@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb3-smtp-cloud7.xs4all.net (lb3-smtp-cloud7.xs4all.net
 [194.109.24.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE22EF8068A
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2019 09:32:20 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: alsa-devel@alsa-project.org, Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

Hi Mauro,

After five (!) years of work, this is finally ready to go in.

Thank you Shuah for your perseverance!

Regards,

	Hans

The following changes since commit 1c3ec30bb23023d738b538e64ac3028902d53692:

  media: index.rst: exclude Indexes section from latex/pdf output (2019-03-30 09:42:35 -0400)

are available in the Git repository at:

  git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.2c3

for you to fetch changes up to 5ea25de43fd59a319136cf5b2e547ca315cfb212:

  au0828: stop video streaming only when last user stops (2019-04-03 09:01:15 +0200)

----------------------------------------------------------------
Tag branch

----------------------------------------------------------------
Hans Verkuil (1):
      au0828: stop video streaming only when last user stops

Shuah Khan (8):
      media: Media Device Allocator API
      media: change au0828 to use Media Device Allocator API
      media: media.h: Enable ALSA MEDIA_INTF_T* interface types
      sound/usb: Use Media Controller API to share media resources
      au0828: fix enable and disable source audio and video inconsistencies
      selftests: media_dev_allocator api test
      au0828: Fix NULL pointer dereference in au0828_analog_stream_enable()
      media: Clear devnode->media_dev holding media_devnode_lock

 Documentation/media/kapi/mc-core.rst                       |  41 ++++++
 drivers/media/Makefile                                     |   6 +
 drivers/media/media-dev-allocator.c                        | 135 +++++++++++++++++
 drivers/media/media-devnode.c                              |   3 +-
 drivers/media/usb/au0828/Kconfig                           |   2 +
 drivers/media/usb/au0828/au0828-core.c                     | 196 ++++++++++++++++++------
 drivers/media/usb/au0828/au0828-video.c                    |  16 +-
 drivers/media/usb/au0828/au0828.h                          |   6 +-
 include/media/media-dev-allocator.h                        |  63 ++++++++
 include/uapi/linux/media.h                                 |  25 ++--
 sound/usb/Kconfig                                          |   4 +
 sound/usb/Makefile                                         |   2 +
 sound/usb/card.c                                           |  14 ++
 sound/usb/card.h                                           |   3 +
 sound/usb/media.c                                          | 327 +++++++++++++++++++++++++++++++++++++++++
 sound/usb/media.h                                          |  74 ++++++++++
 sound/usb/mixer.h                                          |   3 +
 sound/usb/pcm.c                                            |  29 +++-
 sound/usb/quirks-table.h                                   |   1 +
 sound/usb/stream.c                                         |   2 +
 sound/usb/usbaudio.h                                       |   6 +
 tools/testing/selftests/media_tests/media_dev_allocator.sh |  85 +++++++++++
 22 files changed, 976 insertions(+), 67 deletions(-)
 create mode 100644 drivers/media/media-dev-allocator.c
 create mode 100644 include/media/media-dev-allocator.h
 create mode 100644 sound/usb/media.c
 create mode 100644 sound/usb/media.h
 create mode 100755 tools/testing/selftests/media_tests/media_dev_allocator.sh
