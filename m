From: Damien Zammit <damien.zammit@gmail.com>
Subject: [PATCH 0/2] Digidesign Mbox 1 duplex mode and mixer
Date: Tue,  4 Nov 2014 11:06:35 +1100
Message-ID: <1415059597-18344-1-git-send-email-damien@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
 [209.85.220.41])
 by alsa0.perex.cz (Postfix) with ESMTP id B8E33260561
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 01:06:58 +0100 (CET)
Received: by mail-pa0-f41.google.com with SMTP id rd3so13181681pab.14
 for <alsa-devel@alsa-project.org>; Mon, 03 Nov 2014 16:06:57 -0800 (PST)
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

Takashi asked me to rewrite the patches and send them without
attachments.  I hope this email series works and they can be
reviewed.

These two patches provide the following for Digidesign Mbox 1:
 o Mixer control for clock source selection: Internal/SPDIF
 o Duplex mode (playback and capture)

Damien Zammit (2):
  snd-usb-audio: Add mixer control for Digidesign Mbox 1 clock source
  snd-usb-audio: Add duplex mode for Digidesign Mbox 1 and enable mixer

 sound/usb/card.h         |   5 ++
 sound/usb/mixer_maps.c   |   9 +++
 sound/usb/mixer_quirks.c | 177 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks-table.h |  73 ++++++++++++-------
 sound/usb/quirks.c       |  30 ++++++++
 sound/usb/usbaudio.h     |   1 +
 6 files changed, 271 insertions(+), 24 deletions(-)

-- 
1.9.1
