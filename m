From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/5] Trivial cleanups
Date: Tue, 26 May 2015 14:41:47 +0200
Message-ID: <1432644112-16543-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E73432612D1
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 14:41:53 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B439CACC1
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 12:41:53 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

Hi,

here is a series of patches to clean up / fix the issues spotted
by sparse.


Takashi

===

Takashi Iwai (5):
  ALSA: dummy: make local data static
  ALSA: lx6464es: Fix duplicated SSID entries
  ALSA: lx6464es: Use NULL for pointers
  ALSA: bcd2000: Make local data static
  sound: sound_firmware: Fix invalid use of vfs_read()

 sound/drivers/dummy.c         | 14 +++++++-------
 sound/pci/lx6464es/lx6464es.c | 16 ++++++++--------
 sound/sound_firmware.c        |  4 +---
 sound/usb/bcd2000/bcd2000.c   |  2 +-
 4 files changed, 17 insertions(+), 19 deletions(-)

-- 
2.4.1
