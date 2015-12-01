From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Correct codec names for
	14f1:50f1 and 14f1:50f3
Date: Tue,  1 Dec 2015 07:03:50 +0100
Message-ID: <1448949831-8608-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AD8AF2659E2
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 07:03:56 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 28A44AC68
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 06:03:55 +0000 (UTC)
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

The numbers aren't always linear, just like in the real world.
Correct to the right numbers stated in the datasheet (although we
can't trust the datasheet as well).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index c8b8ef5246a6..89d9e8ccea51 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -972,9 +972,9 @@ static const struct hda_device_id snd_hda_id_conexant[] = {
 	HDA_CODEC_ENTRY(0x14f150ac, "CX20652", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f150b8, "CX20664", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f150b9, "CX20665", patch_conexant_auto),
-	HDA_CODEC_ENTRY(0x14f150f1, "CX20721", patch_conexant_auto),
+	HDA_CODEC_ENTRY(0x14f150f1, "CX21722", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f150f2, "CX20722", patch_conexant_auto),
-	HDA_CODEC_ENTRY(0x14f150f3, "CX20723", patch_conexant_auto),
+	HDA_CODEC_ENTRY(0x14f150f3, "CX21724", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f150f4, "CX20724", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f1510f, "CX20751/2", patch_conexant_auto),
 	HDA_CODEC_ENTRY(0x14f15110, "CX20751/2", patch_conexant_auto),
-- 
2.6.3
