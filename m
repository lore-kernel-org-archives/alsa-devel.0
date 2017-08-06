From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 0/7] constify ALSA usb_device_id.
Date: Sun,  6 Aug 2017 12:18:52 +0530
Message-ID: <1502002139-10787-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, zonque@gmail.com, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

usb_device_id are not supposed to change at runtime. All functions
working with usb_device_id provided by <linux/usb.h> work with
const usb_device_id. So mark the non-const structs as const.

Arvind Yadav (7):
  [PATCH 1/7] ALSA: 6fire: constify usb_device_id.
  [PATCH 2/7] ALSA: bcd2000: constify usb_device_id.
  [PATCH 3/7] ALSA: snd-usb-caiaq: constify usb_device_id.
  [PATCH 4/7] ALSA: usb-audio: constify usb_device_id.
  [PATCH 5/7] ALSA: ua101: constify usb_device_id.
  [PATCH 6/7] ALSA: us122l: constify usb_device_id.
  [PATCH 7/7] ALSA: usbusx2y: constify usb_device_id.

 sound/usb/6fire/chip.c      | 2 +-
 sound/usb/bcd2000/bcd2000.c | 2 +-
 sound/usb/caiaq/device.c    | 2 +-
 sound/usb/card.c            | 4 ++--
 sound/usb/misc/ua101.c      | 2 +-
 sound/usb/usx2y/us122l.c    | 2 +-
 sound/usb/usx2y/usbusx2y.c  | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.7.4
