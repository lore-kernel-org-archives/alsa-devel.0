From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda - fix a fixup value for codec alc293
	in the pin_quirk table
Date: Fri, 13 Jun 2014 09:23:10 +0800
Message-ID: <1402622590-28675-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f48.google.com (mail-pa0-f48.google.com
 [209.85.220.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B898260845
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 03:25:39 +0200 (CEST)
Received: by mail-pa0-f48.google.com with SMTP id et14so259535pad.21
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 18:25:38 -0700 (PDT)
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

The fixup value for codec alc293 was set to
ALC269_FIXUP_DELL1_MIC_NO_PRESENCE by a mistake, if we don't fix it,
the Dock mic will be overwriten by the headset mic, this will make
the Dock mic can't work.

Cc: David Henningsson <david.henningsson@canonical.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 9c095fa..06d6063 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5159,7 +5159,7 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 			{0x1d, 0x40700001},
 			{0x1e, 0x411111f0},
 		},
-		.value = ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+		.value = ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 	},
 	{}
 };
-- 
1.8.1.2
