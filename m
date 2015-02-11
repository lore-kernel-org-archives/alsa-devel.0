From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 0/6] Cleanup reads/writes to Line 6 device memory
Date: Tue, 10 Feb 2015 23:03:11 -0600
Message-ID: <1423630997-25464-1-git-send-email-chris@rorvick.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Rorvick <chris@rorvick.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: alsa-devel@alsa-project.org

The primary fix here is to throttle the requests for status after a
read or write operation.  In some cases I was seeing more than 1000
before the device was ready with a response.

The remainder are smaller improvements related to the read/write logic.
All of this seems pretty straightforward with the possible exception of
changing the returned error from EINVAL to EIO.  The EINVAL seems wrong
to me but maybe not?

Regards,

Chris

Chris Rorvick (6):
  ALSA: line6: Improve line6_read/write_data() interfaces
  ALSA: line6: Add delay before reading status
  ALSA: line6: Return error if device not responding
  ALSA: line6: Return EIO if read/write not successful
  ALSA: line6: Use explicit type for serial number
  ALSA: line6: toneport: Use explicit type for firmware version

 sound/usb/line6/driver.c   | 51 +++++++++++++++++++++++++++++++++-------------
 sound/usb/line6/driver.h   | 10 ++++-----
 sound/usb/line6/pod.c      |  4 ++--
 sound/usb/line6/toneport.c |  4 ++--
 4 files changed, 46 insertions(+), 23 deletions(-)

-- 
2.1.0
