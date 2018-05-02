From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: hda/ca0132: fix build failure when a
	local macro is defined
Date: Wed,  2 May 2018 22:48:16 +0900
Message-ID: <20180502134816.11542-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f67.google.com (mail-pg0-f67.google.com [74.125.83.67])
 by alsa0.perex.cz (Postfix) with ESMTP id AF016266C1C
 for <alsa-devel@alsa-project.org>; Wed,  2 May 2018 15:48:45 +0200 (CEST)
Received: by mail-pg0-f67.google.com with SMTP id p9-v6so7782734pgc.9
 for <alsa-devel@alsa-project.org>; Wed, 02 May 2018 06:48:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, conmanx360@gmail.com
List-Id: alsa-devel@alsa-project.org

DECLARE_TLV_DB_SCALE (alias of SNDRV_CTL_TLVD_DECLARE_DB_SCALE) is used but
tlv.h is not included. This causes build failure when local macro is
defined by comment-out.

This commit fixes the bug. At the same time, the alias macro is replaced
with a destination macro added at a commit 46e860f76804 ("ALSA: rename
TLV-related macros so that they're friendly to user applications")

Reported-by: Connor McAdams <conmanx360@gmail.com>
Fixes: 44f0c9782cc6 ('ALSA: hda/ca0132: Add tuning controls')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/pci/hda/patch_ca0132.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 768ea8651993..84261ef02c93 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -39,6 +39,10 @@
 /* Enable this to see controls for tuning purpose. */
 /*#define ENABLE_TUNING_CONTROLS*/
 
+#ifdef ENABLE_TUNING_CONTROLS
+#include <sound/tlv.h>
+#endif
+
 #define FLOAT_ZERO	0x00000000
 #define FLOAT_ONE	0x3f800000
 #define FLOAT_TWO	0x40000000
@@ -3068,8 +3072,8 @@ static int equalizer_ctl_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
-static const DECLARE_TLV_DB_SCALE(voice_focus_db_scale, 2000, 100, 0);
-static const DECLARE_TLV_DB_SCALE(eq_db_scale, -2400, 100, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(voice_focus_db_scale, 2000, 100, 0);
+static const SNDRV_CTL_TLVD_DECLARE_DB_SCALE(eq_db_scale, -2400, 100, 0);
 
 static int add_tuning_control(struct hda_codec *codec,
 				hda_nid_t pnid, hda_nid_t nid,
-- 
2.14.1
