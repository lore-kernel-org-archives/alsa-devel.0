From: Damien Zammit <damien.zammit@gmail.com>
Subject: [PATCH 0/3 v4] Digidesign Mbox 1 enhancements
Date: Mon, 10 Nov 2014 20:40:34 +1100
Message-ID: <1415612437-5557-1-git-send-email-damien@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 230E3260550
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 10:40:56 +0100 (CET)
Received: by mail-pa0-f46.google.com with SMTP id lf10so7839060pab.5
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 01:40:55 -0800 (PST)
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

This is fourth revision based on all reviews/tweaks so far.  

Damien Zammit (3):
  ALSA: usb-audio: Move mutex define to more general location
  ALSA: usb-audio: Add mixer control for Digidesign mbox 1 clock source
  ALSA: usb-audio: Add duplex mode for Digidesign Mbox 1 and enable
    mixer

 sound/usb/card.c         |   1 -
 sound/usb/mixer_maps.c   |   9 +++
 sound/usb/mixer_quirks.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks-table.h |  43 ++++++++++----
 sound/usb/usbaudio.h     |   2 +
 5 files changed, 188 insertions(+), 11 deletions(-)

-- 
1.9.1
