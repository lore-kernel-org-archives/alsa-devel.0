From: damien.zammit@gmail.com
Subject: [PATCH 0/2 v2] Digidesign Mbox 1 clock source and
	duplex mode
Date: Sun,  9 Nov 2014 11:37:06 +1100
Message-ID: <1415493428-31653-1-git-send-email-damien.zammit@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 83B782604BF
 for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2014 01:37:49 +0100 (CET)
Received: by mail-pa0-f49.google.com with SMTP id lj1so5843331pab.36
 for <alsa-devel@alsa-project.org>; Sat, 08 Nov 2014 16:37:48 -0800 (PST)
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
Cc: Damien Zammit <damien@zamaudio.com>
List-Id: alsa-devel@alsa-project.org

From: Damien Zammit <damien@zamaudio.com>

This is a cleaned up patchset version 2.

Damien Zammit (2):
  ALSA: usb-audio: Add mixer control for Digidesign mbox 1 clock source
  ALSA: usb-audio: Add duplex mode for Digidesign Mbox 1 and enable
    mixer

 sound/usb/card.h         |   5 ++
 sound/usb/mixer_maps.c   |   9 ++++
 sound/usb/mixer_quirks.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks-table.h |  73 +++++++++++++++++---------
 sound/usb/quirks.c       |  30 +++++++++++
 sound/usb/usbaudio.h     |   1 +
 6 files changed, 227 insertions(+), 24 deletions(-)

-- 
1.9.1
