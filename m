From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Clean up ALC299 init code
Date: Wed, 27 Dec 2017 09:04:51 +0100
Message-ID: <20171227080451.1491-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A748266EAD
 for <alsa-devel@alsa-project.org>; Wed, 27 Dec 2017 09:04:53 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EC7C0AB9A
 for <alsa-devel@alsa-project.org>; Wed, 27 Dec 2017 08:04:52 +0000 (UTC)
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

ALC299 is compatible with ALC225/295, thus it doesn't have to assign
its own model.  Merge together with ALC225/295 code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8fd2d9c62c96..b2037131eed9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6923,12 +6923,9 @@ static int patch_alc269(struct hda_codec *codec)
 		break;
 	case 0x10ec0225:
 	case 0x10ec0295:
-		spec->codec_variant = ALC269_TYPE_ALC225;
-		spec->gen.mixer_nid = 0; /* no loopback on ALC225 ALC295 */
-		break;
 	case 0x10ec0299:
 		spec->codec_variant = ALC269_TYPE_ALC225;
-		spec->gen.mixer_nid = 0; /* no loopback on ALC299 */
+		spec->gen.mixer_nid = 0; /* no loopback on ALC225, ALC295 and ALC299 */
 		break;
 	case 0x10ec0234:
 	case 0x10ec0274:
-- 
2.15.1
