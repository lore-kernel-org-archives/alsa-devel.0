From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] Another round of line6 cleanup
Date: Mon, 26 Jan 2015 13:48:40 +0100
Message-ID: <1422276523-14336-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E43DC26056A
 for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2015 13:48:44 +0100 (CET)
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

Hi,

here is yet another series of cleanup patches for line6 drivers.
This time, the extra allocation for struct usb_line6 was removed by
using snd_card_new()'s allocation feature.  In addition to that, a few
trivial cleanups.

The test/line6 branch of sound git tree was updated with these patches,
too.

Takashi

===

Takashi Iwai (3):
  ALSA: line6: Drop interface argument from private_init and disconnect
    callbacks
  ALSA: line6: Let snd_card_new() allocate private data
  ALSA: line6: Minor tidy up in line6_probe()

 sound/usb/line6/driver.c   | 52 ++++++++++++++++++++--------------------------
 sound/usb/line6/driver.h   |  8 ++++---
 sound/usb/line6/pod.c      | 21 +++++++------------
 sound/usb/line6/podhd.c    | 13 ++++--------
 sound/usb/line6/toneport.c | 21 +++++++------------
 sound/usb/line6/variax.c   | 19 ++++++-----------
 6 files changed, 54 insertions(+), 80 deletions(-)

-- 
2.2.2
