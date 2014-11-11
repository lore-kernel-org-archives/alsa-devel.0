From: Damien Zammit <damien.zammit@gmail.com>
Subject: [PATCH 0/2 v7] Digidesign Mbox 1 enhancements
Date: Wed, 12 Nov 2014 01:09:53 +1100
Message-ID: <1415714995-20669-1-git-send-email-damien@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id A4F472606B4
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 15:10:15 +0100 (CET)
Received: by mail-pd0-f178.google.com with SMTP id fp1so10215864pdb.9
 for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2014 06:10:12 -0800 (PST)
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

Revision 7.

Damien Zammit (2):
  ALSA: usb-audio: Add mixer control for Digidesign Mbox 1 clock source
  ALSA: usb-audio: Add duplex mode for Digidesign Mbox 1 and enable
    mixer

 sound/usb/mixer_maps.c   |   9 ++++
 sound/usb/mixer_quirks.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/usb/quirks-table.h |  41 +++++++++++----
 3 files changed, 170 insertions(+), 9 deletions(-)

-- 
1.9.1
