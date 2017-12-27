From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix missing COEF init for
	ALC225/295/299
Date: Wed, 27 Dec 2017 09:03:28 +0100
Message-ID: <20171227080328.1325-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DEBB1266EAD
 for <alsa-devel@alsa-project.org>; Wed, 27 Dec 2017 09:03:32 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E5148AB22
 for <alsa-devel@alsa-project.org>; Wed, 27 Dec 2017 08:03:31 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

There was a long-standing problem on HP Spectre X360 with Kabylake
where it lacks of the front speaker output in some situations.  Also
there are other products showing the similar behavior.  The culprit
seems to be the missing COEF setup on ALC codecs, ALC225/295/299,
which are all compatible.

This patch adds the proper COEF setup (to initialize idx 0x67 / bits
0x3000) for addressing the issue.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195457
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1522ba31e16d..8fd2d9c62c96 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -324,8 +324,12 @@ static void alc_fill_eapd_coef(struct hda_codec *codec)
 	case 0x10ec0292:
 		alc_update_coef_idx(codec, 0x4, 1<<15, 0);
 		break;
-	case 0x10ec0215:
 	case 0x10ec0225:
+	case 0x10ec0295:
+	case 0x10ec0299:
+		alc_update_coef_idx(codec, 0x67, 0xf000, 0x3000);
+		/* fallthrough */
+	case 0x10ec0215:
 	case 0x10ec0233:
 	case 0x10ec0236:
 	case 0x10ec0255:
@@ -336,10 +340,8 @@ static void alc_fill_eapd_coef(struct hda_codec *codec)
 	case 0x10ec0286:
 	case 0x10ec0288:
 	case 0x10ec0285:
-	case 0x10ec0295:
 	case 0x10ec0298:
 	case 0x10ec0289:
-	case 0x10ec0299:
 		alc_update_coef_idx(codec, 0x10, 1<<9, 0);
 		break;
 	case 0x10ec0275:
-- 
2.15.1
