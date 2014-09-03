From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 0/8] move some existing quirks to pin quirks
Date: Wed,  3 Sep 2014 11:31:03 +0800
Message-ID: <1409715071-12262-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D8C9265587
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 05:31:40 +0200 (CEST)
Received: by mail-pd0-f175.google.com with SMTP id ft15so10007685pdb.20
 for <alsa-devel@alsa-project.org>; Tue, 02 Sep 2014 20:31:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: hui.wang@canonical.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

These changes are based on the alsa-info.txt we have, if an existing
quirk shows up in the quirk table more than 3 times, I tried to move
it. After this change, we can avoid repeatly adding items in the old
quirk table.

Hui Wang (8):
  ALSA: hda/realtek - move DELL2_MIC_NO_PRESENCE quirk for alc292
  ALSA: hda/realtek - move DELL1_MIC_NO_PRESENCE quirk for alc283
  ALSA: hda/realtek - move DELL1_MIC_NO_PRESENCE quirk for alc255
  ALSA: hda/realtek - move DELL2_MIC_NO_PRESENCE quirk for alc255
  ALSA: hda/realtek - move HP_MUTE_LED_MIC1 quirk for alc282
  ALSA: hda/realtek - move HP_MUTE_LED_MIC1 quirk for alc290
  ALSA: hda/realtek - move HP_LINE1_MIC1_LED quirk for alc282
  ALSA: hda/realtek - move HP_GPIO_MIC1_LED quirk for alc280

 sound/pci/hda/patch_realtek.c | 305 ++++++++++++++++++++++++++++++------------
 1 file changed, 216 insertions(+), 89 deletions(-)

-- 
1.9.1
