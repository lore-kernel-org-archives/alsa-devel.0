From: Damien Zammit <damien.zammit@gmail.com>
Subject: [PATCH 0/2 v3] Digidesign Mbox 1 enhancements
Date: Mon, 10 Nov 2014 18:46:50 +1100
Message-ID: <1415605612-2977-1-git-send-email-damien@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
 [209.85.192.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 637EF260610
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 08:47:16 +0100 (CET)
Received: by mail-pd0-f171.google.com with SMTP id r10so7325832pdi.2
 for <alsa-devel@alsa-project.org>; Sun, 09 Nov 2014 23:47:15 -0800 (PST)
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
Cc: tiwai@suse.de, Damien Zammit <damien@zamaudio.com>, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

This is the third patchset to provide mixer control and duplex mode.
Was rebased on top of 85a8181329a and tested on the hardware.

Damien Zammit (2):
  ALSA: usb-audio: Add mixer control for Digidesign mbox 1 clock source
  ALSA: usb-audio: Add duplex mode for Digidesign Mbox 1 and enable
    mixer

 sound/usb/mixer_maps.c   |   9 +++
 sound/usb/mixer_quirks.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks-table.h |  43 ++++++++++----
 3 files changed, 184 insertions(+), 10 deletions(-)

-- 
1.9.1
