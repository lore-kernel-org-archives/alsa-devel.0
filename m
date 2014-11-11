From: Damien Zammit <damien.zammit@gmail.com>
Subject: [PATCH 0/2 v6] Digidesign Mbox 1 enhancements
Date: Tue, 11 Nov 2014 11:20:15 +1100
Message-ID: <1415665217-7748-1-git-send-email-damien@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id E6C4D261537
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 01:20:35 +0100 (CET)
Received: by mail-pd0-f172.google.com with SMTP id r10so8880515pdi.17
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 16:20:34 -0800 (PST)
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

Revision 6.

Damien Zammit (2):
  ALSA: usb-audio: Add mixer control for Digidesign Mbox 1 clock source
  ALSA: usb-audio: Add duplex mode for Digidesign Mbox 1 and enable
    mixer

 sound/usb/mixer_maps.c   |   9 ++++
 sound/usb/mixer_quirks.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks-table.h |  43 ++++++++++++----
 3 files changed, 171 insertions(+), 10 deletions(-)

-- 
1.9.1
