From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/9] sound: Add sanity checks for invalid EPs
Date: Tue, 10 Oct 2017 15:38:10 +0200
Message-ID: <20171010133819.10567-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A481266DCF
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 15:38:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Andrey Konovalov <andreyknvl@google.com>, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is a patchset to cover the codes that may submit URBs containing
invalid EPs without validation, which result in the kernel warning
from the USB core.  The first patch adds a new helper for simplifying
the EP check, and the rest applies it at needed places.

USB devs: could you check the first patch?  I tried
usb_find_common_endpoints() and friends at first, but it made the code
more complex in the end, because we're dealing with the fixed
endpoints and the validation is required for them.

The original issues were spotted by syzkaller, and I put a few others
for covering more similar cases.

thanks,

Takashi

===

Takashi Iwai (9):
  usb: core: Add a helper function to check the validity of EP type in
    URB
  ALSA: bcd2000: Add a sanity check for invalid EPs
  ALSA: caiaq: Add a sanity check for invalid EPs
  ALSA: line6: Add a sanity check for invalid EPs
  ALSA: usb-audio: Add sanity checks for invalid EPs
  ALSA: usx2y: Add sanity checks for invalid EPs
  ALSA: hiface: Add sanity checks for invalid EPs
  ALSA: caiaq: Add yet more sanity checks for invalid EPs
  ALSA: line6: Add yet more sanity checks for invalid EPs

 drivers/usb/core/urb.c          | 28 +++++++++++++++++++++++++---
 include/linux/usb.h             |  2 ++
 sound/usb/bcd2000/bcd2000.c     |  7 +++++++
 sound/usb/caiaq/device.c        |  7 +++++++
 sound/usb/caiaq/input.c         |  9 +++++++++
 sound/usb/hiface/pcm.c          |  9 +++++++--
 sound/usb/line6/driver.c        | 30 ++++++++++++++++++++++--------
 sound/usb/line6/midi.c          | 17 +++++++++++------
 sound/usb/midi.c                | 38 ++++++++++++++++++++++++++++++--------
 sound/usb/usx2y/usbusx2y.c      |  8 ++++++++
 sound/usb/usx2y/usbusx2yaudio.c |  3 +++
 11 files changed, 131 insertions(+), 27 deletions(-)

-- 
2.14.2
