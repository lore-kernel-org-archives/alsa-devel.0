From: "Shih-Yuan Lee (FourDollars)" <sylee@canonical.com>
Subject: [PATCH] ALSA: hda/realtek - Fix typo
Date: Mon,  3 Jul 2017 14:13:29 +0800
Message-ID: <1499062409-24069-1-git-send-email-sylee@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D1DD2669F3
 for <alsa-devel@alsa-project.org>; Mon,  3 Jul 2017 08:13:33 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id e199so24634255pfh.0
 for <alsa-devel@alsa-project.org>; Sun, 02 Jul 2017 23:13:33 -0700 (PDT)
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
Cc: Kailang Yang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The PIN number for Dell headset mode of ALC3271 is wrong.

Signed-off-by: Shih-Yuan Lee (FourDollars) <sylee@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c39bc49..d0cf1f3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6553,7 +6553,7 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0299, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		ALC225_STANDARD_PINS,
 		{0x12, 0xb7a60130},
-		{0x13, 0xb8a60140},
+		{0x13, 0xb8a61140},
 		{0x17, 0x90170110}),
 	{}
 };
-- 
2.7.4
