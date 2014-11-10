From: Damien Zammit <damien.zammit@gmail.com>
Subject: [PATCH 0/2 v5] Digidesign Mbox 1 enhancements
Date: Mon, 10 Nov 2014 21:17:53 +1100
Message-ID: <1415614675-6792-1-git-send-email-damien@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 841D0260586
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 11:18:09 +0100 (CET)
Received: by mail-pa0-f47.google.com with SMTP id kx10so7960711pab.20
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 02:18:08 -0800 (PST)
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

This is revision 5.  I made a mistake interpreting your reviews, sorry guys.

Damien Zammit (2):
  ALSA: usb-audio: Add mixer control for Digidesign mbox 1 clock source
  ALSA: usb-audio: Add duplex mode for Digidesign Mbox 1 and enable
    mixer

 sound/usb/mixer_maps.c   |   9 +++
 sound/usb/mixer_quirks.c | 140 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks-table.h |  43 +++++++++++----
 3 files changed, 182 insertions(+), 10 deletions(-)

-- 
1.9.1
