From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH v2 0/2] Update ALSA driver to use media
	controller API
Date: Wed,  3 Jun 2015 09:12:52 -0600
Message-ID: <cover.1433298842.git.shuahkh@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from resqmta-po-10v.sys.comcast.net (resqmta-po-10v.sys.comcast.net
 [96.114.154.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 742252606B7
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 17:13:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mchehab@osg.samsung.com, hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com, tiwai@suse.de, perex@perex.cz, agoode@google.com, pierre-louis.bossart@linux.intel.com, gtmkramer@xs4all.nl, clemens@ladisch.de, vladcatoi@gmail.com, damien@zamaudio.com, chris.j.arges@canonical.com, takamichiho@gmail.com, misterpib@gmail.com, daniel@zonque.org, pmatilai@laiskiainen.org, jussi@sonarnerd.net, normalperson@yhbt.net, fisch602@gmail.com, joe@oampo.co.uk
Cc: alsa-devel@alsa-project.org, Shuah Khan <shuahkh@osg.samsung.com>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch series updates ALSA driver to use media controller
API to share tuner with DVB and V4L2 drivers that control AU0828
media device. Two new interfaces are added to media controller
API to enable creating media device as a device resource. This
allows creating media device as a device resource on the main
struct device that is common to all drivers that control a single
media hardware and share resources on it. Drivers then can find
the common media device to register entities and manage links,
and pipelines.

Tested with and without CONFIG_MEDIA_CONTROLLER enabled.
Tested tuner entity doesn't exist case as au0828 v4l2
driver is the one that will create the tuner when it gets
updated to use media controller API.

Please note that au0828 updates media controller are necessary
before the resource sharing can work across ALSA and au0828
dvb and v4l2 drivers. This work is in progress and another
developer is working on it.

Changes since v1:
- Moved media specific code into new header and source file
- Created a new structure for media controller specific fields
- Added a new define USE_MEDIA_CONTROLLER to add media specific
  code. This new define is defined only when Media Controller
  support is enabled. New media specific code is active only
  when this define is defined.
- Moved media_deviced_delete() check under !was_shutdown block
- Removed return check for media_device_init()
- Changed new Media Controller interface names for clarity. Now
  they are named media_device_get_devres() and
  media_device_find_devres().
- Calling media_entity_pipeline_stop() on a pipe that isn't active
  appears to be safe. This needs further testing once AU0828
  media controller patches are ready.

Shuah Khan (2):
  media: new media controller API for device resource support
  sound/usb: Update ALSA driver to use media controller API

 drivers/media/media-device.c |  33 ++++++++
 include/media/media-device.h |   2 +
 sound/usb/Makefile           |   3 +-
 sound/usb/card.c             |   5 ++
 sound/usb/card.h             |   1 +
 sound/usb/media.c            | 181 +++++++++++++++++++++++++++++++++++++++++++
 sound/usb/media.h            |  40 ++++++++++
 sound/usb/pcm.c              |  10 ++-
 sound/usb/quirks-table.h     |   1 +
 sound/usb/quirks.c           |   9 ++-
 sound/usb/stream.c           |   3 +
 sound/usb/usbaudio.h         |   1 +
 12 files changed, 286 insertions(+), 3 deletions(-)
 create mode 100644 sound/usb/media.c
 create mode 100644 sound/usb/media.h

-- 
2.1.4
