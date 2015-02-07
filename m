From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH v2 0/3] More Line 6 cleanup
Date: Sat,  7 Feb 2015 10:43:16 -0600
Message-ID: <1423327399-12619-1-git-send-email-chris@rorvick.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rorvick <chris@rorvick.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

Changes in v2:

  * return true/false instead of 1/0
  * do not include spaces in driver name
  * drop patch altering struct names (unnecessary)

Chris Rorvick (3):
  ALSA: line6: Add toneport_has_source_select()
  ALSA: line6: Pass toneport pointer to toneport_has_led()
  ALSA: line6: Pass driver name to line6_probe()

 sound/usb/line6/driver.c   |  3 ++-
 sound/usb/line6/driver.h   |  3 +--
 sound/usb/line6/pod.c      |  2 +-
 sound/usb/line6/podhd.c    |  2 +-
 sound/usb/line6/toneport.c | 53 +++++++++++++++++++++++++---------------------
 sound/usb/line6/variax.c   |  2 +-
 6 files changed, 35 insertions(+), 30 deletions(-)

-- 
2.1.0
